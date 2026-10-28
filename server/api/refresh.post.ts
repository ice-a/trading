import { runCrawl } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { readMeta, touchMeta } from '../utils/store'
import { FEEDS } from '../config/feeds'

/**
 * POST /api/refresh —— 按需刷新（替代定时任务）
 *
 * 三种调用方式：
 *   · 打开页面        POST /api/refresh            距上次抓取 ≥ 1h 才真的抓，否则直接返回
 *   · 点「刷新」      POST /api/refresh?force=1    无条件立刻抓
 *   · 定时轮询        POST /api/refresh            前端每 1h 打一次，同样受 1h 节流
 *
 * 抓取内容拆成两批，避免 Serverless 函数超时（Vercel Hobby 单次 10s）：
 *   target=trending  只抓 GitHub 日/周/月榜（约 5~8s，同步完成）
 *   target=feeds     抓热搜/资讯，用 shard 分片，每片 6 个端点（约 5~7s）
 *
 * 返回里带 nextCrawlAt，前端可以据此决定下次轮询时间。
 */

const SHARD_SIZE = 6
const MIN_INTERVAL_MS = 60 * 60 * 1000 // 1 小时

interface RefreshMeta {
  lastAutoCrawlAt?: string
  lastForceCrawlAt?: string
}

export default defineEventHandler(async (event) => {
  if (getMethod(event) !== 'POST' && getMethod(event) !== 'GET') {
    setResponseStatus(event, 405)
    return { ok: false, error: '仅支持 POST / GET' }
  }

  const q = getQuery(event)
  const force = q.force === '1' || q.force === 'true'
  const target = String(q.target || 'trending')
  const shard = Number(q.shard || 0)

  const meta = (await readMeta<RefreshMeta>()) || {}
  const lastAt = meta.lastAutoCrawlAt ? new Date(meta.lastAutoCrawlAt).getTime() : 0
  const elapsed = Date.now() - lastAt
  const due = force || elapsed >= MIN_INTERVAL_MS

  const nextCrawlAt = new Date((force ? Date.now() : lastAt + MIN_INTERVAL_MS)).toISOString()

  /* ---------- 还没到时间：直接返回，不抓 ---------- */
  if (!due) {
    return {
      ok: true,
      crawled: false,
      reason: '距离上次抓取不足 1 小时',
      lastCrawlAt: meta.lastAutoCrawlAt ?? null,
      nextCrawlAt,
      remainingMs: Math.max(0, MIN_INTERVAL_MS - elapsed)
    }
  }

  /* ---------- feeds 分片 ---------- */
  if (target === 'feeds') {
    const total = FEEDS.length
    const start = Math.max(0, Math.min(shard * SHARD_SIZE, total - 1))
    const slice = FEEDS.slice(start, start + SHARD_SIZE)

    const t0 = Date.now()
    const result = await collectFeeds({ only: slice.map((f) => f.key) }).catch((e) => ({
      total: 0,
      ok: 0,
      failed: 0,
      errors: [e instanceof Error ? e.message : String(e)]
    }))

    const nextShard = start + SHARD_SIZE < total ? shard + 1 : -1

    return {
      ok: true,
      crawled: true,
      target: 'feeds',
      shard,
      range: [start, start + slice.length - 1],
      total,
      nextShard,
      durationMs: Date.now() - t0,
      result,
      nextCrawlAt
    }
  }

  /* ---------- trending（默认）：同步抓完再返回 ---------- */
  const t0 = Date.now()
  const outcome = await runCrawl(force ? 'manual' : 'schedule').catch((e) => ({
    ok: false,
    error: e instanceof Error ? e.message : String(e),
    fetched: 0,
    durationMs: Date.now() - t0
  }))

  await touchMeta({
    lastAutoCrawlAt: new Date().toISOString(),
    lastTrigger: force ? 'force' : 'auto'
  })

  return {
    ok: true,
    crawled: true,
    target: 'trending',
    durationMs: Date.now() - t0,
    result: outcome,
    nextCrawlAt: new Date(Date.now() + MIN_INTERVAL_MS).toISOString()
  }
})
