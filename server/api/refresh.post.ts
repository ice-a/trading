import { runCrawl } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { readMeta, touchMeta } from '../utils/store'
import { appConfig } from '../utils/config'
import { invalidateCache } from '../utils/cache'

/**
 * POST /api/refresh —— 按需刷新（页面打开 / 点刷新 / 每小时轮询共用）。
 *
 * 单机部署后这里是「真的抓」：没有流水线、没有令牌、不用等 CI。
 * 抓取耗时 3~20 秒，所以请求返回就代表数据已经是新的。
 *
 * 节流：默认 1 小时内不重复抓，避免多标签页把 GitHub 抓挂；`?force=1` 无条件抓。
 * 目标：`?target=all|github|feeds` 只刷其中一批。
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
  const targetRaw = String(q.target || 'all')
  const target = (['all', 'github', 'feeds'].includes(targetRaw) ? targetRaw : 'all') as 'all' | 'github' | 'feeds'

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
  const cfg = appConfig()

  const [github, feeds] = await Promise.allSettled([
    target === 'feeds' ? Promise.resolve(null) : runCrawl(force ? 'manual' : 'schedule'),
    target === 'github' || !cfg.feedsEnabled ? Promise.resolve(null) : collectFeeds()
  ])

  await touchMeta({ lastAutoCrawlAt: new Date().toISOString() })
  invalidateCache('')

  const gh = github.status === 'fulfilled' ? github.value : null
  const fd = feeds.status === 'fulfilled' ? feeds.value : null
  const reasonOf = (r: PromiseSettledResult<unknown>): string | null =>
    r.status === 'rejected' ? (r.reason instanceof Error ? r.reason.message : String(r.reason)) : null

  // ok 按 target 判定：只抓 feeds 时 github 本来就是 null，不能算失败
  const ghOk = target === 'feeds' ? true : Boolean(gh?.ok)
  const fdOk = target === 'github' ? true : fd !== null && fd.failed < fd.total

  return {
    ok: ghOk && fdOk && !reasonOf(github) && !reasonOf(feeds),
    crawled: true,
    target,
    durationMs: Date.now() - started,
    github: gh && { fetched: gh.fetched, dropped: gh.dropped, skipped: Boolean(gh.skipped), error: gh.error },
    githubError: reasonOf(github),
    feeds: fd && { total: fd.total, ok: fd.ok, failed: fd.failed },
    feedsError: reasonOf(feeds)
  }
})