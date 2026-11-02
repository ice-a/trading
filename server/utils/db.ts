/**
 * 唯一数据层：本地 SQLite 单文件（node:sqlite，Node 内置模块，零外部依赖）。
 *
 * ── 为什么是 SQLite 而不是 JSON ─────────────────────────────
 * 榜单 + 聚合快照本质是关系型查询：按 date/period 过滤、按 bucket/rank 排序、
 * 翻页、union 统计、upsert 去重。JSON 方案这些操作都要全量 parse 进内存，
 * 数据量一涨（几个月的历史榜单 + 19 个端点快照）就会变成 CPU 与 GC 灾难。
 * SQLite 是单文件、有索引、WAL 支持并发读，1C1G 上完全够用。
 *
 * ── 为什么用 node:sqlite 而不是 better-sqlite3 ──────────────
 * better-sqlite3 要 node-gyp 编译（1C1G 上装一次很久，还得有 python/gcc）。
 * node:sqlite 是 Node 内置的同步驱动：
 *   - Node >= 23 默认可用
 *   - Node 22.5 ~ 22.x 需要 --experimental-sqlite
 *
 * ── 连接模型（部署时的重要约束）──────────────────────────────
 * 单进程、单连接、同步驱动。所以：
 *   - 只能跑**单实例**（systemd 一个进程 / pm2 fork 模式 1 个 worker）
 *   - 不要用 pm2 cluster 或多副本：SQLite 写锁会让进程互相等
 *   - 读多写少正好匹配 WAL：抓取写库不阻塞页面读
 */

import { mkdirSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { DatabaseSync, type StatementSync } from 'node:sqlite'
import { env } from './env'

export interface SqlStmt {
  sql: string
  params?: unknown[]
}

type SqlValue = string | number | bigint | null | Uint8Array

let connection: DatabaseSync | null = null
let connectionPath = ''

/** 预编译语句缓存：同样的 SQL 只编译一次（同步驱动下这是最划算的优化） */
const statements = new Map<string, StatementSync>()
const MAX_STATEMENTS = 256

function resolveDbPath(): string {
  const raw = env('DB_PATH', 'data/app.db')
  return resolve(process.cwd(), raw)
}

function prepare(sql: string): StatementSync {
  const cached = statements.get(sql)
  if (cached) return cached

  const db = getDb()
  const stmt = db.prepare(sql)
  if (statements.size >= MAX_STATEMENTS) statements.clear()
  statements.set(sql, stmt)
  return stmt
}

export function getDb(): DatabaseSync {
  if (connection) return connection

  const path = resolveDbPath()
  mkdirSync(dirname(path), { recursive: true })

  const db = new DatabaseSync(path)
  // WAL：写不阻塞读；synchronous=NORMAL：断电最多丢最后一次事务，性能显著更好
  db.exec(`
    PRAGMA journal_mode = WAL;
    PRAGMA synchronous = NORMAL;
    PRAGMA busy_timeout = 5000;
    PRAGMA foreign_keys = ON;
    PRAGMA temp_store = MEMORY;
  `)

  connection = db
  connectionPath = path
  console.log(`[db] SQLite 已打开：${path}`)
  return db
}

export function hasDb(): boolean {
  try {
    getDb()
    return true
  } catch {
    return false
  }
}

/** 建表 / 灌种子（运维脚本与启动时使用） */
export function execScript(sql: string): void {
  getDb().exec(sql)
  statements.clear()
}

export async function sqlAll<T>(sql: string, params: unknown[] = []): Promise<T[]> {
  return prepare(sql).all(...(params as SqlValue[])) as T[]
}

export async function sqlFirst<T>(sql: string, params: unknown[] = []): Promise<T | null> {
  const row = prepare(sql).get(...(params as SqlValue[]))
  return (row as T) ?? null
}

export async function sqlRun(sql: string, params: unknown[] = []): Promise<{ changes: number; lastInsertRowid: number }> {
  const r = prepare(sql).run(...(params as SqlValue[]))
  return {
    changes: Number(r.changes ?? 0),
    lastInsertRowid: Number(r.lastInsertRowid ?? 0)
  }
}

/**
 * 批量写入：一个事务包住所有语句。
 * 抓取时一次几百条 upsert，事务化能把耗时从「每条一次 fsync」压到「一次 fsync」，
 * 对 1C1G 的小盘尤其重要。
 */
export async function sqlBatch(stmts: SqlStmt[]): Promise<void> {
  if (!stmts.length) return
  const db = getDb()
  db.exec('BEGIN IMMEDIATE')
  try {
    for (const s of stmts) {
      prepare(s.sql).run(...((s.params ?? []) as SqlValue[]))
    }
    db.exec('COMMIT')
  } catch (err) {
    try {
      db.exec('ROLLBACK')
    } catch {
      /* 回滚失败（连接已坏）时交给上层报错 */
    }
    throw err
  }
}

/** 健康检查 */
export async function pingDb(): Promise<{
  ok: boolean
  latencyMs: number
  path: string
  error?: string
}> {
  const t0 = Date.now()
  try {
    getDb().prepare('select 1 as ok').get()
    return { ok: true, latencyMs: Date.now() - t0, path: connectionPath }
  } catch (err) {
    return {
      ok: false,
      latencyMs: Date.now() - t0,
      path: connectionPath || resolveDbPath(),
      error: err instanceof Error ? err.message : String(err)
    }
  }
}

/** 库文件信息（status 页显示用） */
export function dbInfo(): { path: string; bytes: number; statements: number } {
  let bytes = 0
  try {
    bytes = statSync(connectionPath).size
  } catch {
    bytes = 0
  }
  return { path: connectionPath, bytes, statements: statements.size }
}

export function closeDb(): void {
  statements.clear()
  connection?.close()
  connection = null
}