/**
 * 进程内缓存：Map + TTL + 上限淘汰。
 *
 * 单机部署后只剩一层 —— 同一进程里的内存。之前的边缘 Cache API 层已删除：
 *   · 单机只有一个进程，跨 isolate 失效问题根本不存在
 *   · 数据每小时才变一次，进程内缓存已能把重复查询压到微秒级
 *   · 少一层网络调用，1C1G 上更省
 *
 * 语义：
 *   - 命中且未过期 → 直接返回
 *   - 未命中或已过期 → 执行 fn，写回缓存
 *   - 写库（抓取 / 后台改数据）后调用 invalidateCache 让新数据立刻可见
 */

interface Entry {
  at: number
  data: unknown
}

const store = new Map<string, Entry>()

/** 条目上限：超了就按插入顺序淘汰最旧的（Map 保持插入序，近似 LRU） */
const MAX_ENTRIES = 300

function evictIfNeeded(): void {
  if (store.size <= MAX_ENTRIES) return
  const drop = Math.ceil(MAX_ENTRIES / 4)
  let i = 0
  for (const key of store.keys()) {
    store.delete(key)
    if (++i >= drop) break
  }
}

export function cacheGet<T>(key: string): T | undefined {
  const hit = store.get(key)
  if (!hit) return undefined
  // 访问即刷新顺序
  store.delete(key)
  store.set(key, hit)
  return hit.data as T
}

export function cacheSet(key: string, data: unknown): void {
  if (store.has(key)) store.delete(key)
  store.set(key, { at: Date.now(), data })
  evictIfNeeded()
}

/** 取缓存，未命中或过期则执行并写回 */
export async function withCache<T>(key: string, ttlMs: number, fn: () => Promise<T>): Promise<T> {
  const hit = store.get(key)
  if (hit && Date.now() - hit.at < ttlMs) {
    store.delete(key)
    store.set(key, hit)
    return hit.data as T
  }
  if (hit) store.delete(key)

  const data = await fn()
  cacheSet(key, data)
  return data
}

export function cacheStats(): { size: number; max: number; keys: string[] } {
  return { size: store.size, max: MAX_ENTRIES, keys: [...store.keys()] }
}

/** 按前缀失效；不传前缀清空全部 */
export function invalidateCache(prefix = ''): number {
  let n = 0
  for (const key of [...store.keys()]) {
    if (!prefix || key.startsWith(prefix)) {
      store.delete(key)
      n++
    }
  }
  return n
}
/* ------------------------------------------------------------------
 * 跨实例持久缓存（落数据库）
 *
 * 为什么需要：Vercel 每个请求可能落在不同实例上，进程内 Map 的命中率接近 0，
 * 于是 /api/repos、/api/github-search 每次都真的去打 GitHub（1~4 秒 + 限流）。
 * 把结果写进 response_cache 表后，任何实例都能命中，同一 query 只付一次网络代价。
 * ------------------------------------------------------------------ */

import { sqlFirst, sqlRun } from './db'

interface CacheRow {
  value: string
  expires_at: string
}

/** 从数据库读缓存（过期即视为未命中） */
export async function dbCacheGet<T>(key: string): Promise<T | undefined> {
  try {
    const row = await sqlFirst<CacheRow>('select value, expires_at from response_cache where key = ?', [key])
    if (!row) return undefined
    if (row.expires_at <= new Date().toISOString()) return undefined
    return JSON.parse(row.value) as T
  } catch {
    return undefined
  }
}

async function dbCacheSet(key: string, data: unknown, ttlMs: number): Promise<void> {
  const now = new Date()
  const expires = new Date(now.getTime() + ttlMs).toISOString()
  try {
    await sqlRun(
      `insert into response_cache (key, value, expires_at, updated_at) values (?,?,?,?)
       on conflict (key) do update set value = excluded.value,
         expires_at = excluded.expires_at, updated_at = excluded.updated_at`,
      [key, JSON.stringify(data), expires, now.toISOString()]
    )
  } catch {
    /* 缓存写失败不影响主流程 */
  }
}

/**
 * 两级缓存：进程内 Map → 数据库 → 数据源。
 * 进程内那层给同实例的连续请求省一次库查询；数据库那层才是真正的跨实例命中。
 */
export async function withDbCache<T>(key: string, ttlMs: number, fn: () => Promise<T>): Promise<T> {
  const memHit = store.get(key)
  if (memHit && Date.now() - memHit.at < ttlMs) {
    store.delete(key)
    store.set(key, memHit)
    return memHit.data as T
  }

  const dbHit = await dbCacheGet<T>(key)
  if (dbHit !== undefined) {
    cacheSet(key, dbHit)
    return dbHit
  }

  const data = await fn()
  cacheSet(key, data)
  await dbCacheSet(key, data, ttlMs)
  return data
}

/** 清理已过期的缓存行（挂在抓取后顺手跑一次即可） */
export async function pruneDbCache(): Promise<void> {
  try {
    await sqlRun('delete from response_cache where expires_at <= ?', [new Date().toISOString()])
  } catch {
    /* 忽略 */
  }
}
