/**
 * 单机数据层：本地 SQLite 单文件，走 Node 内置 node:sqlite —— 零编译、零依赖。
 *
 * 目标机器 512M/1G：常驻单进程、有真实磁盘，直接用 node:sqlite 最省资源。
 * 数据库只用 DB_PATH（默认 data/app.db）指定，不再有远程分支。
 */

import { mkdirSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { env } from './env'
import { SCHEMA_DDL } from './schema'

export interface SqlStmt {
  sql: string
  params?: unknown[]
}

export interface SqlRunResult {
  changes: number
  lastInsertRowid: number
}

/** node:sqlite 的最小接口（只声明用到的部分，避免依赖其完整类型） */
interface FileStmt {
  all: (...params: unknown[]) => unknown[]
  get: (...params: unknown[]) => unknown
  run: (...params: unknown[]) => unknown
}
interface FileDb {
  prepare: (sql: string) => FileStmt
  exec: (sql: string) => void
  close: () => void
}

/* ---------- 单例句柄 ---------- */

// eslint-disable-next-line @typescript-eslint/no-explicit-any
let fileDb: any = null
let filePath = ''
const statements = new Map<string, unknown>()
const MAX_STATEMENTS = 256

/** 建表只做一次（每进程一次） */
let schemaReady = false
let schemaPromise: Promise<void> | null = null

function fileDbPath(): string {
  if (!filePath) filePath = resolve(process.cwd(), env('DB_PATH', 'data/app.db'))
  return filePath
}

async function getFile(): Promise<FileDb> {
  if (fileDb) return fileDb

  const { DatabaseSync } = (await import('node:sqlite')) as unknown as {
    DatabaseSync: new (path: string) => FileDb
  }

  const path = fileDbPath()
  mkdirSync(dirname(path), { recursive: true })

  const db = new DatabaseSync(path)
  db.exec(`
    PRAGMA journal_mode = WAL;
    PRAGMA synchronous = NORMAL;
    PRAGMA busy_timeout = 5000;
    PRAGMA foreign_keys = ON;
    PRAGMA temp_store = MEMORY;
  `)
  fileDb = db
  console.log(`[db] SQLite 文件 · ${path}`)
  return fileDb
}

function prepareFile(db: FileDb, sql: string): FileStmt {
  const cached = statements.get(sql) as FileStmt | undefined
  if (cached) return cached
  const stmt = db.prepare(sql)
  if (statements.size >= MAX_STATEMENTS) statements.clear()
  statements.set(sql, stmt)
  return stmt
}

/**
 * 确保表存在（空库自愈）。全部 DDL 都是 CREATE ... IF NOT EXISTS，
 * 已有表时纯空转（几十 ms，且只在首次执行）。
 */
export async function ensureSchema(): Promise<void> {
  if (schemaReady) return
  if (schemaPromise) return schemaPromise

  schemaPromise = (async () => {
    for (const ddl of SCHEMA_DDL) {
      await sqlRun(ddl)
    }
    schemaReady = true
  })()

  try {
    await schemaPromise
  } catch (err) {
    schemaPromise = null
    throw err
  }
}

/* ---------- 对外接口 ---------- */

export async function sqlAll<T>(sql: string, params: unknown[] = []): Promise<T[]> {
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as { all: (...p: unknown[]) => unknown[] }
  return stmt.all(...params) as T[]
}

export async function sqlFirst<T>(sql: string, params: unknown[] = []): Promise<T | null> {
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as { get: (...p: unknown[]) => unknown }
  return ((await stmt.get(...params)) as T) ?? null
}

export async function sqlRun(sql: string, params: unknown[] = []): Promise<SqlRunResult> {
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as {
    run: (...p: unknown[]) => { changes: number | bigint; lastInsertRowid: number | bigint }
  }
  const r = stmt.run(...params)
  return { changes: Number(r.changes ?? 0), lastInsertRowid: Number(r.lastInsertRowid ?? 0) }
}

/** 一个 BEGIN IMMEDIATE 事务包住批量写入（几百条 upsert 只 fsync 一次） */
export async function sqlBatch(stmts: SqlStmt[]): Promise<void> {
  if (!stmts.length) return
  const db = await getFile()
  db.exec('BEGIN IMMEDIATE')
  try {
    for (const s of stmts) {
      const stmt = prepareFile(db, s.sql) as unknown as { run: (...p: unknown[]) => unknown }
      stmt.run(...(s.params ?? []))
    }
    db.exec('COMMIT')
  } catch (err) {
    try {
      db.exec('ROLLBACK')
    } catch {
      /* 回滚失败交给上层报错 */
    }
    throw err
  }
}

/** 建表 / 灌种子（运维脚本用） */
export async function execScript(sqlText: string): Promise<void> {
  const db = await getFile()
  db.exec(sqlText)
  statements.clear()
}

/* ---------- 诊断 ---------- */

export interface DbInfo {
  mode: 'file'
  path: string
  bytes: number
  statements: number
}

export function dbInfo(): DbInfo {
  let bytes = 0
  try {
    bytes = statSync(filePath || fileDbPath()).size
  } catch {
    bytes = 0
  }
  return { mode: 'file', path: filePath || fileDbPath(), bytes, statements: statements.size }
}

export async function pingDb(): Promise<{ ok: boolean; latencyMs: number; error?: string }> {
  const t0 = Date.now()
  try {
    await sqlFirst('select 1 as ok')
    return { ok: true, latencyMs: Date.now() - t0 }
  } catch (err) {
    return {
      ok: false,
      latencyMs: Date.now() - t0,
      error: err instanceof Error ? err.message : String(err)
    }
  }
}
