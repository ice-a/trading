import { runCrawl } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { runtimeKind, isServerless } from '../utils/platform'

/**
 * /api/crawl —— 手动或外部定时器触发一次抓取。
 *
 * 一次调用同时刷新两批数据：
 *   · GitHub Trending 日榜
 *   · 60s 聚合接口（热搜 / 资讯 / 生活服务…）
 * 用 ?target=github|feeds|all 可以只刷其中一批（默认 all）。
 *
 * 故意同时支持 GET 和 POST，因为各平台的 cron 习惯不同：
 *   · Vercel Cron → GET，并自动带上 Authorization: Bearer $CRON_SECRET
 *   · Cloudflare Cron → 走 scheduled 事件（不经过 HTTP），这里也能手动 GET
 *   · GitHub Actions / 任意 cron → curl -X POST
 *
 * 鉴权（满足任一即可）：
 *   Authorization: Bearer <CRON_SECRET 或 CRON_TOKEN>
 *   x-cron-token: <CRON_SECRET 或 CRON_TOKEN>
 *   ?token=<CRON_SECRET 或 CRON_TOKEN>
 * 两个变量都没配置时不校验（仅适合本地调试）。
 */
export default defineEventHandler(async (event) => {
  const method = getMethod(event)
  if (method !== 'GET' && method !== 'POST') {
    setResponseStatus(event, 405)
    return { ok: false, error: '仅支持 GET / POST' }
  }

  const cfg = appConfig()
  const secret = cfg.cronToken || process.env.CRON_SECRET || ''
  const query = getQuery(event)

  if (secret) {
    const auth = getHeader(event, 'authorization') || ''
    const bearer = auth.toLowerCase().startsWith('bearer ') ? auth.slice(7).trim() : ''
    const provided = String(getHeader(event, 'x-cron-token') || bearer || query.token || '')
    if (provided !== secret) {
      setResponseStatus(event, 401)
      return { ok: false, error: '令牌无效' }
    }
  }

  const targetRaw = String(query.target || 'all')
  const target = ['github', 'feeds', 'all'].includes(targetRaw) ? targetRaw : 'all'
  const startedAt = Date.now()

  const [github, feeds] = await Promise.all([
    target === 'feeds' ? Promise.resolve(null) : runCrawl('manual'),
    target === 'github' || !cfg.feedsEnabled ? Promise.resolve(null) : collectFeeds()
  ])

  const ok = (github?.ok ?? true) && (feeds ? feeds.failed < feeds.total : true)

  setResponseStatus(event, ok ? 200 : github?.skipped ? 429 : 500)

  return {
    ok,
    runtime: runtimeKind(),
    serverless: isServerless(),
    wallMs: Date.now() - startedAt,
    github,
    feeds,
    target
  }
})
