import { randomUUID } from 'node:crypto'
import { getDb, COLLECTIONS } from './mongo'

/**
 * MongoDB 分布式锁：多实例部署时，同一时刻只允许一个进程去抓 GitHub。
 * TTL 索引会自动清理过期锁；另外对"进程被 kill 留下的僵尸锁"做一次判定：
 * 持有时间超过 staleMs（默认 TTL 的一半）即视为失效，允许接管。
 */
export async function acquireLock(
  name: string,
  ttlMs = 5 * 60_000,
  staleMs = Math.floor(ttlMs / 2)
): Promise<string | null> {
  const db = await getDb()
  const col = db.collection<{ _id: string; token: string; expiresAt: Date; createdAt: Date }>(
    COLLECTIONS.locks
  )
  const token = randomUUID()
  const now = new Date()
  const expiresAt = new Date(Date.now() + ttlMs)

  try {
    await col.insertOne({ _id: name, token, expiresAt, createdAt: now })
    return token
  } catch {
    // 已存在：判断是否过期 / 是否是僵尸锁
    const current = await col.findOne({ _id: name })
    if (!current) {
      // TTL 刚好清掉了，重抢一次
      try {
        await col.insertOne({ _id: name, token, expiresAt, createdAt: now })
        return token
      } catch {
        return null
      }
    }

    const expired = current.expiresAt.getTime() <= Date.now()
    const zombie = Date.now() - current.createdAt.getTime() > staleMs

    if (expired || zombie) {
      const res = await col.updateOne(
        { _id: name, token: current.token },
        { $set: { token, expiresAt, createdAt: now } }
      )
      if (res.modifiedCount === 1) {
        console.warn(`[lock] 接管失效锁 ${name}（${expired ? '已过期' : '疑似僵尸锁'}）`)
        return token
      }
    }
    return null
  }
}

export async function releaseLock(name: string, token: string): Promise<void> {
  try {
    const db = await getDb()
    const col = db.collection(COLLECTIONS.locks)
    await col.deleteOne({ _id: name as never, token } as never)
  } catch {
    /* ignore */
  }
}
