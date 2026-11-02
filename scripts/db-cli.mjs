#!/usr/bin/env node
/**
 * 数据库运维 CLI —— 同时支持本地 SQLite 文件与远程 libSQL（Turso）。
 *
 *   node scripts/db-cli.mjs init     建表（幂等）
 *   node scripts/db-cli.mjs seed     灌示例数据（幂等）
 *   node scripts/db-cli.mjs info     表行数 / 文件大小 / 连接模式
 *   node scripts/db-cli.mjs reset    删库重建（file 模式，需 FORCE=1）
 *   node scripts/db-cli.mjs shell    打印常用查询
 *
 * 模式由环境变量决定（与 server/utils/db.ts 完全一致）：
 *   TURSO_DATABASE_URL 有值 → 远程 libSQL（脚本自动读 .env）
 *   否则                    → DB_PATH（默认 data/app.db）
 */
import { existsSync, mkdirSync, readFileSync, rmSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'

/* ---------- 读 .env（与 server/utils/env.ts 同规则：已存在的变量不覆盖） ---------- */
const envFile = resolve(process.cwd(), '.env')
if (existsSync(envFile)) {
  for (const line of readFileSync(envFile, 'utf8').split(/\r?\n/)) {
    const t = line.trim()
    if (!t || t.startsWith('#')) continue
    const eq = t.indexOf('=')
    if (eq <= 0) continue
    const k = t.slice(0, eq).trim()
    if (process.env[k] !== undefined) continue
    let v = t.slice(eq + 1).trim()
    if (v.length >= 2 && ((v[0] === '"' && v.at(-1) === '"') || (v[0] === "'" && v.at(-1) === "'"))) v = v.slice(1, -1)
    process.env[k] = v
  }
}

const REMOTE_URL = process.env.TURSO_DATABASE_URL || ''
const REMOTE = Boolean(REMOTE_URL)
const DB_PATH = resolve(process.env.DB_PATH || 'data/app.db')
const cmd = process.argv[2] || 'info'

/* ---------- 两个后端统一成一套小接口 ---------- */
async function openDb() {
  if (REMOTE) {
    const { createClient } = await import('@libsql/client/web')
    const client = createClient({ url: REMOTE_URL, authToken: process.env.TURSO_AUTH_TOKEN || undefined })
    return {
      mode: 'remote',
      label: `libSQL ${REMOTE_URL.replace(/\/\/[^@]*@/, '//')}`,
      execFile: async (file) => {
        for (const stmt of splitSql(readFileSync(file, 'utf8'))) {
          await client.execute({ sql: stmt, args: [] })
        }
      },
      rows: async (sql) => (await client.execute({ sql, args: [] })).rows,
      close: () => {}
    }
  }

  const { DatabaseSync } = await import('node:sqlite')
  mkdirSync(dirname(DB_PATH), { recursive: true })
  const db = new DatabaseSync(DB_PATH)
  db.exec('PRAGMA journal_mode = WAL; PRAGMA synchronous = NORMAL; PRAGMA busy_timeout = 5000;')
  return {
    mode: 'file',
    label: DB_PATH,
    execFile: async (file) => db.exec(readFileSync(file, 'utf8')),
    rows: async (sql) => db.prepare(sql).all(),
    close: () => db.close()
  }
}

/** 够用于我们自己的 schema/seed：按分号切，跳过字符串里的分号与 -- 注释 */
function splitSql(text) {
  const out = []
  let buf = ''
  let inString = false
  for (let i = 0; i < text.length; i++) {
    const ch = text[i]
    if (ch === "'") {
      if (inString && text[i + 1] === "'") {
        buf += "''"
        i++
        continue
      }
      inString = !inString
      buf += ch
      continue
    }
    if (ch === '-' && text[i + 1] === '-' && !inString) {
      while (i < text.length && text[i] !== '\n') i++
      continue
    }
    if (ch === ';' && !inString) {
      const s = buf.trim()
      if (s) out.push(s)
      buf = ''
      continue
    }
    buf += ch
  }
  const tail = buf.trim()
  if (tail) out.push(tail)
  return out
}

async function info(db) {
  console.log(`模式：${db.mode}`)
  console.log(`目标：${db.label}`)
  if (db.mode === 'file') {
    const parts = ['', '-wal', '-shm']
      .map((s) => (existsSync(DB_PATH + s) ? `${s || '.db'} ${(statSync(DB_PATH + s).size / 1024).toFixed(1)}KB` : null))
      .filter(Boolean)
    console.log(`大小：${parts.join(' · ') || '0KB'}`)
  }

  const tables = (await db.rows("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name")).map(
    (r) => r.name
  )
  console.log('\n表行数：')
  for (const t of tables) {
    const n = (await db.rows(`select count(*) as n from ${t}`))[0]?.n ?? 0
    console.log(`  ${String(t).padEnd(18)} ${n}`)
  }

  const days = await db.rows(
    'select date, period, count(*) as n from trending_repos group by date, period order by date desc limit 6'
  )
  if (days.length) {
    console.log('\n最近榜单：')
    for (const d of days) console.log(`  ${d.date} ${d.period} ${d.n} 行`)
  }
}

const db = await openDb()

switch (cmd) {
  case 'init':
    console.log(`→ 模式 ${db.mode}（${db.label}）`)
    await db.execFile('db/schema.sql')
    console.log('✓ schema 已应用')
    await info(db)
    break

  case 'seed':
    console.log(`→ 模式 ${db.mode}（${db.label}）`)
    await db.execFile('db/seed.sql')
    console.log('✓ seed 已应用')
    await info(db)
    break

  case 'info':
    await info(db)
    break

  case 'reset':
    if (db.mode === 'remote') {
      console.error('远程库不支持 reset（防止误删线上数据）。请手动 drop 表后重新 init。')
      process.exit(1)
    }
    if (process.env.FORCE !== '1') {
      console.error('这会删除现有数据。确认后执行：FORCE=1 npm run db:reset')
      process.exit(1)
    }
    for (const s of ['', '-wal', '-shm']) if (existsSync(DB_PATH + s)) rmSync(DB_PATH + s)
    console.log(`已删除 ${DB_PATH}`)
    await db.execFile('db/schema.sql')
    await db.execFile('db/seed.sql')
    await info(db)
    break

  case 'shell':
    console.log('常用查询：')
    console.log('  select date, period, count(*) from trending_repos group by 1,2 order by 1 desc limit 10;')
    console.log('  select started_at, ok, fetched, dropped, duration_ms from crawl_runs order by started_at desc limit 10;')
    console.log(`  本地：sqlite3 ${DB_PATH}`)
    console.log('  远程：turso db shell <db-name>')
    break

  default:
    console.error(`未知命令：${cmd}\n可用：init | seed | info | reset | shell`)
    process.exit(1)
}

db.close()