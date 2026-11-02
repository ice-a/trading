#!/usr/bin/env node
/**
 * SQLite 数据库运维 CLI（不依赖 wrangler / Cloudflare，纯 Node 内置模块）。
 *
 *   node scripts/db-cli.mjs init     建表（幂等，可反复执行）
 *   node scripts/db-cli.mjs seed     灌基础数据（导航 / AI / 关注列表，幂等）
 *   node scripts/db-cli.mjs info     表行数、文件大小、WAL 状态
 *   node scripts/db-cli.mjs reset    删库重建（会二次确认）
 *   node scripts/db-cli.mjs shell    打印常用查询（没有交互式 shell，避免额外依赖）
 *
 * 库文件路径由 DB_PATH 决定，默认 data/app.db。
 */
import { DatabaseSync } from 'node:sqlite'
import { existsSync, mkdirSync, readFileSync, rmSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'

const DB_PATH = resolve(process.env.DB_PATH || 'data/app.db')
const cmd = process.argv[2] || 'info'

function open() {
  mkdirSync(dirname(DB_PATH), { recursive: true })
  const db = new DatabaseSync(DB_PATH)
  db.exec('PRAGMA journal_mode = WAL; PRAGMA synchronous = NORMAL; PRAGMA busy_timeout = 5000;')
  return db
}

function runFile(db, file) {
  const path = resolve(file)
  if (!existsSync(path)) {
    console.error(`✗ 找不到 ${file}`)
    process.exit(1)
  }
  const t0 = Date.now()
  db.exec(readFileSync(path, 'utf8'))
  console.log(`✓ 执行 ${file}（${Date.now() - t0}ms）`)
}

function tables(db) {
  return db
    .prepare("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name")
    .all()
    .map((r) => r.name)
}

function info(db) {
  console.log(`库文件：${DB_PATH}`)
  const sizes = ['', '-wal', '-shm']
    .map((s) => {
      const p = DB_PATH + s
      return existsSync(p) ? `${s || '.db'} ${(statSync(p).size / 1024).toFixed(1)}KB` : null
    })
    .filter(Boolean)
  console.log(`大小：${sizes.join(' · ')}`)

  const mode = db.prepare('PRAGMA journal_mode').get()
  console.log(`journal_mode：${mode.journal_mode}`)

  console.log('\n表行数：')
  for (const t of tables(db)) {
    const n = db.prepare(`select count(*) as n from ${t}`).get().n
    console.log(`  ${t.padEnd(18)} ${n}`)
  }

  const days = db
    .prepare('select date, period, count(*) as n from trending_repos group by date, period order by date desc limit 6')
    .all()
  if (days.length) {
    console.log('\n最近榜单：')
    for (const d of days) console.log(`  ${d.date} ${d.period} ${d.n} 行`)
  }
}

switch (cmd) {
  case 'init': {
    const db = open()
    runFile(db, 'db/schema.sql')
    info(db)
    db.close()
    break
  }
  case 'seed': {
    const db = open()
    runFile(db, 'db/seed.sql')
    info(db)
    db.close()
    break
  }
  case 'info': {
    if (!existsSync(DB_PATH)) {
      console.error(`✗ ${DB_PATH} 不存在，先跑 npm run db:init`)
      process.exit(1)
    }
    const db = open()
    info(db)
    db.close()
    break
  }
  case 'reset': {
    if (process.env.FORCE !== '1') {
      console.error('这会删除现有数据。确认后执行：FORCE=1 npm run db:reset')
      process.exit(1)
    }
    for (const s of ['', '-wal', '-shm']) {
      if (existsSync(DB_PATH + s)) rmSync(DB_PATH + s)
    }
    console.log(`已删除 ${DB_PATH}`)
    const db = open()
    runFile(db, 'db/schema.sql')
    runFile(db, 'db/seed.sql')
    info(db)
    db.close()
    break
  }
  case 'shell': {
    console.log(`用 sqlite3 交互查看（若无 sqlite3 可装 apt install sqlite3）：`)
    console.log(`  sqlite3 ${DB_PATH}\n`)
    console.log('常用查询：')
    console.log('  select date, period, count(*) from trending_repos group by 1,2 order by 1 desc limit 10;')
    console.log('  select key, ok, error, datetime(last_try_at) from feed_snapshots order by last_try_at desc;')
    console.log('  select started_at, ok, fetched, dropped, duration_ms from crawl_runs order by started_at desc limit 10;')
    break
  }
  default:
    console.error(`未知命令：${cmd}\n可用：init | seed | info | reset | shell`)
    process.exit(1)
}