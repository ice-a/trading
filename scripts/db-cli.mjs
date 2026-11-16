#!/usr/bin/env node
/**
 * 数据库运维 CLI —— 单机 SQLite 文件（node:sqlite，无需额外依赖）。
 *
 *   node scripts/db-cli.mjs init     建表（幂等）
 *   node scripts/db-cli.mjs seed     灌示例数据（幂等）
 *   node scripts/db-cli.mjs info     表行数 / 文件大小
 *   node scripts/db-cli.mjs reset    删库重建（需 FORCE=1）
 *   node scripts/db-cli.mjs shell    打印常用查询
 *
 * 数据库位置由 DB_PATH 指定（默认 data/app.db，脚本自动读 .env）。
 */
import { existsSync, mkdirSync, readFileSync, rmSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'

/* ---------- 读 .env（已存在的变量不覆盖） ---------- */
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

const DB_PATH = resolve(process.env.DB_PATH || 'data/app.db')
const cmd = process.argv[2] || 'info'

const { DatabaseSync } = await import('node:sqlite')
mkdirSync(dirname(DB_PATH), { recursive: true })
const db = new DatabaseSync(DB_PATH)
db.exec('PRAGMA journal_mode = WAL; PRAGMA synchronous = NORMAL; PRAGMA busy_timeout = 5000;')

const execFile = (file) => db.exec(readFileSync(file, 'utf8'))
const rows = (sql) => db.prepare(sql).all()

async function info() {
  console.log(`目标：${DB_PATH}`)
  const parts = ['', '-wal', '-shm']
    .map((s) => (existsSync(DB_PATH + s) ? `${s || '.db'} ${(statSync(DB_PATH + s).size / 1024).toFixed(1)}KB` : null))
    .filter(Boolean)
  console.log(`大小：${parts.join(' · ') || '0KB'}`)

  const tables = rows("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name").map(
    (r) => r.name
  )
  console.log('\n表行数：')
  for (const t of tables) {
    const n = rows(`select count(*) as n from ${t}`)[0]?.n ?? 0
    console.log(`  ${String(t).padEnd(18)} ${n}`)
  }

  const days = rows(
    'select date, period, count(*) as n from trending_repos group by date, period order by date desc limit 6'
  )
  if (days.length) {
    console.log('\n最近榜单：')
    for (const d of days) console.log(`  ${d.date} ${d.period} ${d.n} 行`)
  }
}

switch (cmd) {
  case 'init':
    execFile('db/schema.sql')
    console.log('✓ schema 已应用')
    await info()
    break

  case 'seed':
    execFile('db/seed.sql')
    console.log('✓ seed 已应用')
    await info()
    break

  case 'info':
    await info()
    break

  case 'reset':
    if (process.env.FORCE !== '1') {
      console.error('这会删除现有数据。确认后执行：FORCE=1 npm run db:reset')
      process.exit(1)
    }
    for (const s of ['', '-wal', '-shm']) if (existsSync(DB_PATH + s)) rmSync(DB_PATH + s)
    console.log(`已删除 ${DB_PATH}`)
    execFile('db/schema.sql')
    execFile('db/seed.sql')
    await info()
    break

  case 'shell':
    console.log('常用查询：')
    console.log('  select date, period, count(*) from trending_repos group by 1,2 order by 1 desc limit 10;')
    console.log('  select started_at, ok, fetched, dropped, duration_ms from crawl_runs order by started_at desc limit 10;')
    console.log(`  本地：sqlite3 ${DB_PATH}`)
    break

  default:
    console.error(`未知命令：${cmd}\n可用：init | seed | info | reset | shell`)
    process.exit(1)
}

db.close()
