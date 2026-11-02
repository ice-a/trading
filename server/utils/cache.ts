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