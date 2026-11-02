import { sqlFirst, sqlRun } from './db'

/**
 * SQLite 抓取锁：多进程 / 多请求并发时，同一时刻只允许一个执行体去抓 GitHub。
 *
 * 实现：crawl_locks 表一行一个锁，expires_at 用 ISO 字符串比较；
 * 对「进程被 kill 留下的僵尸锁」做判定：持有超过 staleMs 即视为失效，允许接管。
 *
 * 要点：
 *   · 用全局 crypto.randomUUID()，不需要额外 import
 *   · sqlRun 能拿到 changes，但仍用「回读校验」确认 CAS 没被并发改走
 */
export async function acquireLock(
  name: string,
  ttlMs = 5 * 60_000,
  staleMs = Math.floor(ttlMs / 2)
): Promise<string | null> {
  const token = crypto.randomUUID()
  const now = new Date()
  const expiresAt = new Date(Date.now() + ttlMs).toISOString()
  const nowIso = now.toISOString()

  const current = await sqlFirst<{ token: string; expires_at: string; created_at: string }>(
    'select token, expires_at, created_at from crawl_locks where name = ?',
    [name]
  )

  if (!current) {
    try {
      await sqlRun('insert into crawl_locks (name, token, expires_at, created_at) values (?, ?, ?, ?)', [
        name,
        token,
        expiresAt,
        nowIso
      ])
      return token
    } catch {
      // 并发下别人先插入了
      return null
    }
  }

  const expired = current.expires_at <= nowIso
  const zombie = Date.now() - new Date(current.created_at).getTime() > staleMs

  if (expired || zombie) {
    await sqlRun(
      'update crawl_locks set token = ?, expires_at = ?, created_at = ? where name = ? and token = ?',
      [token, expiresAt, nowIso, name, current.token]
    )
    // sqlRun 拿不到 affected 行数，回读确认
    const after = await sqlFirst<{ token: string }>('select token from crawl_locks where name = ?', [name])
    if (after?.token === token) {
      console.warn(`[lock] 接管失效锁 ${name}（${expired ? '已过期' : '疑似僵尸锁'}）`)
      return token
    }
    return null
  }

  return null
}

export async function releaseLock(name: string, token: string): Promise<void> {
  try {
    await sqlRun('delete from crawl_locks where name = ? and token = ?', [name, token])
  } catch {
    /* 释放失败等 TTL 过期即可 */
  }
}