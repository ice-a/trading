/**
 * 进程内缓存：Map + TTL + 上限淘汰。
 *
 * 单机只有一个进程，进程内 Map 就够用；数据每小时才变一次，
 * 缓存能把重复查询压到微秒级，且少一次库查询。写库后调用
 * invalidateCache 让新数据立刻可见。
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
