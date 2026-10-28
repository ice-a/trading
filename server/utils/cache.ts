/**
 * 两级缓存：内存 → 本地磁盘 → 数据源。
 *
 * 背景：数据库在远程 Atlas，跨洋链路建连约 4s、单次查询 250~800ms，
 * 而我们全部业务数据也就 500KB 出头。所以把结果额外落一份到本地磁盘，
 * 进程重启（冷启动）时直接读文件，不用重新连库。
 *
 * 语义：
 *   - 内存命中且未过期   → 直接返回（微秒级）
 *   - 磁盘命中且未过期   → 回填内存后返回（毫秒级）
 *   - 都未命中           → 执行 fn，写内存 + 写磁盘
 *
 * 磁盘缓存是纯加速层：目录不可写（Serverless 只读 / 权限不足）时自动降级，
 * 不影响任何功能正确性；写库后调用 invalidateCache 会同时清掉磁盘条目。
 */
import { mkdirSync, readFileSync, writeFileSync, unlinkSync, readdirSync } from 'node:fs'
import { join } from 'node:path'

interface Entry {
  at: number
  data: unknown
}

const store = new Map<string, Entry>()
const MAX_ENTRIES = 200

/** 磁盘缓存目录；可用 DISK_CACHE_DIR 覆盖（Serverless 建议指向 /tmp） */
const DISK_DIR = process.env.DISK_CACHE_DIR || '.cache'

/** 磁盘层总开关，设 DISK_CACHE=off 可关闭 */
const DISK_ENABLED = (process.env.DISK_CACHE || 'on').toLowerCase() !== 'off'

let diskReady = false

function diskAvailable(): boolean {
  if (!DISK_ENABLED) return false
  if (diskReady) return true
  try {
    mkdirSync(DISK_DIR, { recursive: true })
    diskReady = true
    return true
  } catch {
    return false
  }
}

/** 键名里含冒号/中文，落盘前转成安全文件名 */
function fileNameOf(key: string): string {
  let hash = 0
  for (let i = 0; i < key.length; i++) {
    hash = (hash * 31 + key.charCodeAt(i)) | 0
  }
  const safe = key.replace(/[^a-zA-Z0-9_-]/g, '_').slice(0, 40)
  return `${safe}__${(hash >>> 0).toString(36)}.json`
}

function diskRead<T>(key: string, ttlMs: number): T | undefined {
  if (!diskAvailable()) return undefined
  try {
    const raw = readFileSync(join(DISK_DIR, fileNameOf(key)), 'utf8')
    const parsed = JSON.parse(raw) as Entry
    if (!parsed || typeof parsed.at !== 'number') return undefined
    if (Date.now() - parsed.at >= ttlMs) return undefined
    return parsed.data as T
  } catch {
    return undefined
  }
}

function diskWrite(key: string, data: unknown): void {
  if (!diskAvailable()) return
  try {
    writeFileSync(
      join(DISK_DIR, fileNameOf(key)),
      JSON.stringify({ at: Date.now(), data }),
      'utf8'
    )
  } catch {
    /* 写失败就只靠内存，不影响功能 */
  }
}

function diskDelete(key: string): boolean {
  if (!diskAvailable()) return false
  try {
    unlinkSync(join(DISK_DIR, fileNameOf(key)))
    return true
  } catch {
    return false
  }
}

export function cacheGet<T>(key: string): T | undefined {
  const hit = store.get(key)
  if (!hit) return undefined
  return hit.data as T
}

export function cacheSet(key: string, data: unknown): void {
  if (store.size > MAX_ENTRIES) {
    const keys = [...store.keys()].slice(0, Math.floor(MAX_ENTRIES / 4))
    for (const k of keys) store.delete(k)
  }
  store.set(key, { at: Date.now(), data })
}

/** 取缓存（内存 → 磁盘），未命中则执行并写入两层 */
export async function withCache<T>(key: string, ttlMs: number, fn: () => Promise<T>): Promise<T> {
  const memHit = store.get(key)
  if (memHit && Date.now() - memHit.at < ttlMs) return memHit.data as T

  const diskHit = diskRead<T>(key, ttlMs)
  if (diskHit !== undefined) {
    cacheSet(key, diskHit)
    return diskHit
  }

  const data = await fn()
  cacheSet(key, data)
  diskWrite(key, data)
  return data
}

export function cacheStats(): {
  size: number
  keys: string[]
  disk: { enabled: boolean; dir: string; files: number }
} {
  let files = 0
  if (diskAvailable()) {
    try {
      files = readdirSync(DISK_DIR).filter((f) => f.endsWith('.json')).length
    } catch {
      files = 0
    }
  }
  return {
    size: store.size,
    keys: [...store.keys()],
    disk: { enabled: DISK_ENABLED && diskReady, dir: DISK_DIR, files }
  }
}

/**
 * 让某个前缀的缓存立即失效（内存 + 磁盘）。
 * 抓取任务写库完成后调用，保证新数据立刻可见，而不是等 TTL 过期。
 */
export function invalidateCache(prefix = ''): number {
  let n = 0

  if (!prefix) {
    n = store.size
    store.clear()
    if (diskAvailable()) {
      try {
        for (const f of readdirSync(DISK_DIR)) {
          if (f.endsWith('.json')) {
            try {
              unlinkSync(join(DISK_DIR, f))
              n++
            } catch {
              /* 单个删不掉忽略 */
            }
          }
        }
      } catch {
        /* 目录读不了忽略 */
      }
    }
    return n
  }

  for (const k of [...store.keys()]) {
    if (k.startsWith(prefix)) {
      store.delete(k)
      n++
    }
  }

  // 磁盘侧按文件名前缀匹配（fileNameOf 保留了 key 的可读前缀）
  if (diskAvailable()) {
    try {
      const safePrefix = prefix.replace(/[^a-zA-Z0-9_-]/g, '_')
      for (const f of readdirSync(DISK_DIR)) {
        if (f.endsWith('.json') && f.startsWith(safePrefix)) {
          try {
            unlinkSync(join(DISK_DIR, f))
            n++
          } catch {
            /* ignore */
          }
        }
      }
    } catch {
      /* ignore */
    }
  }

  return n
}
