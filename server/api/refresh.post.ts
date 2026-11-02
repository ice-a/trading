import { runCrawl } from '../utils/crawler'
import { readMeta, touchMeta } from '../utils/store'
import { invalidateCache } from '../utils/cache'

/**
 * POST /api/refresh —— 按需刷新（页面打开 / 点刷新 / 每小时轮询共用）。
 *
 * 只抓 GitHub Trending：请求返回即代表数据已更新（本地 3~5 秒，Vercel 上 <10 秒）。
 *
 * 节流：默认 1 小时内不重复抓，避免多标签页把 GitHub 抓挂；`?force=1` 无条件抓。
 */

const MIN_INTERVAL_MS = 60 * 60_000

interface RefreshMeta {
  lastAutoCrawlAt?: string
  lastTriggeredAt?: string
}

export default defineEventHandler(async (event) => {
  const method = getMethod(event)
  if (method !== 'POST' && method !== 'GET') {
    setResponseStatus(event, 405)
    return { ok: false, error: '仅支持 POST / GET' }
  }

  const q = getQuery(event)
  const force = q.force === '1' || q.force === 'true'

  const meta = (await readMeta<RefreshMeta>()) || {}
  const lastAt = Math.max(
    meta.lastAutoCrawlAt ? new Date(meta.lastAutoCrawlAt).getTime() : 0,
    meta.lastTriggeredAt ? new Date(meta.lastTriggeredAt).getTime() : 0
  )
  const elapsed = Date.now() - lastAt
  const due = force || elapsed >= MIN_INTERVAL_MS

  if (!due) {
    return {
      ok: true,
      crawled: false,
      reason: '距离上次抓取不足 1 小时',
      remainingMs: Math.max(0, MIN_INTERVAL_MS - elapsed)
    }
  }

  const started = Date.now()
  const github = await runCrawl(force ? 'manual' : 'schedule')

  await touchMeta({ lastAutoCrawlAt: new Date().toISOString() })
  invalidateCache('')

  return {
    ok: Boolean(github.ok),
    crawled: true,
    durationMs: Date.now() - started,
    github: {
      fetched: github.fetched,
      dropped: github.dropped,
      skipped: Boolean(github.skipped),
      error: github.error
    }
  }
})