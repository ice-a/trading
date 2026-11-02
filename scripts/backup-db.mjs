#!/usr/bin/env node
/**
 * SQLite 在线备份（不锁库、不需要 sqlite3 CLI）。
 *
 * 原理：`VACUUM INTO` 生成一个一致性的快照文件，对 WAL 模式安全，
 * 抓取正在写也能备份。
 *
 * 用法：
 *   node scripts/backup-db.mjs                 # 备份到 data/backups/
 *   KEEP=14 node scripts/backup-db.mjs         # 只保留最近 14 份
 *   DB_PATH=/opt/liaowangtai/data/app.db node scripts/backup-db.mjs
 *
 * 建议放 crontab：
 *   0 4 * * * cd /opt/liaowangtai && /usr/bin/node scripts/backup-db.mjs >> data/backup.log 2>&1
 */
import { DatabaseSync } from 'node:sqlite'
import { mkdirSync, readdirSync, statSync, unlinkSync, existsSync } from 'node:fs'
import { dirname, join, resolve } from 'node:path'

const DB_PATH = resolve(process.env.DB_PATH || 'data/app.db')
const KEEP = Number(process.env.KEEP || 7)
const outDir = join(dirname(DB_PATH), 'backups')

if (!existsSync(DB_PATH)) {
  console.error(`✗ 找不到 ${DB_PATH}`)
  process.exit(1)
}

mkdirSync(outDir, { recursive: true })

const stamp = new Date()
  .toISOString()
  .replace(/[-:T]/g, '')
  .slice(0, 15) // YYYYMMDDHHMMSS
const target = join(outDir, `app-${stamp}.db`)

const db = new DatabaseSync(DB_PATH)
try {
  db.exec('PRAGMA busy_timeout = 5000')
  db.exec(`VACUUM INTO '${target.replace(/'/g, "''")}'`)
  const size = (statSync(target).size / 1024).toFixed(0)
  console.log(`✓ 备份完成：${target}（${size}KB）`)
} finally {
  db.close()
}

// 只保留最近 KEEP 份
const files = readdirSync(outDir)
  .filter((f) => f.startsWith('app-') && f.endsWith('.db'))
  .map((f) => ({ f, t: statSync(join(outDir, f)).mtimeMs }))
  .sort((a, b) => b.t - a.t)

for (const { f } of files.slice(KEEP)) {
  unlinkSync(join(outDir, f))
  console.log(`  清理旧备份：${f}`)
}