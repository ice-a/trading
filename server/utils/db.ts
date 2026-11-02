/**
 * 唯一数据层，两种后端共用一个接口：
 *
 *   file   （默认）本地 SQLite 单文件，走 Node 内置 node:sqlite —— 零编译、零依赖，
 *          适合本地开发与 1C1G 自建（进程常驻、有真实磁盘）。
 *
 *   remote 远程 libSQL（Turso / sqld），走 HTTP —— 适合 Vercel 这类
 *          serverless：函数没有持久磁盘，/tmp 不跨实例，写不进本地文件。
 *
 * 选择只看环境变量：
 *   配了 TURSO_DATABASE_URL（+ 可选 TURSO_AUTH_TOKEN）→ remote
 *   否则读 DB_PATH（默认 data/app.db）              → file
 *
 * 两个驱动都用**动态 import**：
 *   · Vercel 的 Node 版本可能没开 --experimental-sqlite，静态 import node:sqlite 会炸
 *   · 自建机器不需要把 libsql 客户端打进产物
 * 这样各环境只加载自己需要的那个。
 */

import { mkdirSync, statSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { env } from './env'

export interface SqlStmt {
  sql: string
  params?: unknown[]
}

export type DbMode = 'file' | 'remote'
export interface SqlRunResult {
  changes: number
  lastInsertRowid: number
}

/** node:sqlite 的最小接口（只声明我们用到的部分，避免依赖其完整类型） */
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

/* ---------- 驱动句柄（懒加载，各环境只初始化一个） ---------- */

// eslint-disable-next-line @typescript-eslint/no-explicit-any
let fileDb: any = null
// eslint-disable-next-line @typescript-eslint/no-explicit-any
let remoteDb: any = null
let filePath = ''
const statements = new Map<string, unknown>()
const MAX_STATEMENTS = 256

export function dbMode(): DbMode {
  return env('TURSO_DATABASE_URL', '') ? 'remote' : 'file'
}

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
  console.log(`[db] file 模式 · ${path}`)
  return fileDb
}

async function getRemote(): Promise<{
  execute: (args: { sql: string; args: unknown[] }) => Promise<{
    rows: unknown[]
    rowsAffected: number
    lastInsertRowid?: bigint | number
  }>
  batch: (
    stmts: Array<{ sql: string; args: unknown[] }>,
    mode?: 'write'
  ) => Promise<unknown>
}> {
  if (remoteDb) return remoteDb

  const { createClient } = (await import('@libsql/client/web')) as unknown as {
    createClient: (opts: { url: string; authToken?: string }) => never
  }

  remoteDb = createClient({
    url: env('TURSO_DATABASE_URL', ''),
    authToken: env('TURSO_AUTH_TOKEN', '') || undefined
  })
  console.log('[db] remote 模式 · libSQL')
  return remoteDb
}

function prepareFile(db: FileDb, sql: string): FileStmt {
  const cached = statements.get(sql) as FileStmt | undefined
  if (cached) return cached
  const stmt = db.prepare(sql)
  if (statements.size >= MAX_STATEMENTS) statements.clear()
  statements.set(sql, stmt)
  return stmt
}

/* ---------- 对外接口（调用方不关心后端） ---------- */

export async function sqlAll<T>(sql: string, params: unknown[] = []): Promise<T[]> {
  if (dbMode() === 'remote') {
    const client = await getRemote()
    const rs = await client.execute({ sql, args: params })
    return rs.rows as T[]
  }
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as { all: (...p: unknown[]) => unknown[] }
  return stmt.all(...params) as T[]
}

export async function sqlFirst<T>(sql: string, params: unknown[] = []): Promise<T | null> {
  if (dbMode() === 'remote') {
    const rows = await sqlAll<T>(sql, params)
    return rows[0] ?? null
  }
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as { get: (...p: unknown[]) => unknown }
  return ((await stmt.get(...params)) as T) ?? null
}

export async function sqlRun(sql: string, params: unknown[] = []): Promise<SqlRunResult> {
  if (dbMode() === 'remote') {
    const client = await getRemote()
    const rs = await client.execute({ sql, args: params })
    return { changes: rs.rowsAffected, lastInsertRowid: Number(rs.lastInsertRowid ?? 0) }
  }
  const db = await getFile()
  const stmt = prepareFile(db, sql) as unknown as {
    run: (...p: unknown[]) => { changes: number | bigint; lastInsertRowid: number | bigint }
  }
  const r = stmt.run(...params)
  return { changes: Number(r.changes ?? 0), lastInsertRowid: Number(r.lastInsertRowid ?? 0) }
}

/**
 * 批量写入。
 * file  ：一个 BEGIN IMMEDIATE 事务包住（几百条 upsert 只 fsync 一次）
 * remote：libSQL 的 batch 本身在事务里执行
 */
export async function sqlBatch(stmts: SqlStmt[]): Promise<void> {
  if (!stmts.length) return

  if (dbMode() === 'remote') {
    const client = await getRemote()
    await client.batch(
      stmts.map((s) => ({ sql: s.sql, args: s.params ?? [] })),
      'write'
    )
    return
  }

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

/** 建表 / 灌种子（运维脚本用；远程模式下同样走 HTTP） */
export async function execScript(sqlText: string): Promise<void> {
  if (dbMode() === 'remote') {
    const client = await getRemote()
    // libSQL 的 execute 一次只能跑一条语句，按分号切分（避开字符串里的分号）
    for (const chunk of splitSql(sqlText)) {
      await client.execute({ sql: chunk, args: [] })
    }
    return
  }
  const db = await getFile()
  db.exec(sqlText)
  statements.clear()
}

/** 简易 SQL 切分：够用于我们自己的 schema/seed（无 $$ 块、无存储过程） */
function splitSql(text: string): string[] {
  const out: string[] = []
  let buf = ''
  let inString = false
  for (let i = 0; i < text.length; i++) {
    const ch = text[i]
    if (ch === "'") {
      // 处理 '' 转义
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
      // 跳过行注释
      while (i < text.length && text[i] !== '\n') i++
      continue
    }
    if (ch === ';' && !inString) {
      const stmt = buf.trim()
      if (stmt) out.push(stmt)
      buf = ''
      continue
    }
    buf += ch
  }
  const tail = buf.trim()
  if (tail) out.push(tail)
  return out
}

/* ---------- 诊断 ---------- */

export interface DbInfo {
  mode: DbMode
  path?: string
  bytes?: number
  url?: string
  statements?: number
}

export function dbInfo(): DbInfo {
  if (dbMode() === 'remote') {
    const url = env('TURSO_DATABASE_URL', '')
    // 隐藏 token 类片段，只留主机名
    return { mode: 'remote', url: url.replace(/\/\/[^@]*@/, '//') }
  }
  let bytes = 0
  try {
    bytes = statSync(filePath || fileDbPath()).size
  } catch {
    bytes = 0
  }
  return { mode: 'file', path: filePath || fileDbPath(), bytes, statements: statements.size }
}

export async function pingDb(): Promise<{ ok: boolean; latencyMs: number; mode: DbMode; error?: string }> {
  const mode = dbMode()
  const t0 = Date.now()
  try {
    await sqlFirst('select 1 as ok')
    return { ok: true, latencyMs: Date.now() - t0, mode }
  } catch (err) {
    return {
      ok: false,
      latencyMs: Date.now() - t0,
      mode,
      error: err instanceof Error ? err.message : String(err)
    }
  }
}