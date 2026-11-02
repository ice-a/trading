import { runCrawl } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { appConfig } from '../utils/config'
import { invalidateCache } from '../utils/cache'

/**
 * /api/crawl —— 强制抓取一次（运维 / 外部 cron / 手动）。
 *
 * 单机部署后没有平台差异：这台机器上直接抓，抓完写 SQLite。
 * 想用系统 cron 代替内置定时器时，只要 `ENABLE_SCHEDULER=false` 再让 cron 打这个接口。
 *
 * 鉴权（满足任一即可；CRON_TOKEN 未配置时不校验，仅适合本机调试）：
 *   Authorization: Bearer <CRON_TOKEN>
 *   x-cron-token: <CRON_TOKEN>
 *   ?token=<CRON_TOKEN>
 */
export default defineEventHandler(async (event) => {
  const method = getMethod(event)
  if (method !== 'GET' && method !== 'POST') {
    setResponseStatus(event, 405)
    return { ok: false, error: '仅支持 GET / POST' }
  }

  const cfg = appConfig()
  const secret = cfg.cronToken
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
  const target = (['github', 'feeds', 'all'].includes(targetRaw) ? targetRaw : 'all') as
    | 'github'
    | 'feeds'
    | 'all'

  const startedAt = Date.now()
  const [github, feeds] = await Promise.all([
    target === 'feeds' ? Promise.resolve(null) : runCrawl('manual'),
    target === 'github' || !cfg.feedsEnabled ? Promise.resolve(null) : collectFeeds()
  ])

  invalidateCache('')

  const ok = (github?.ok ?? true) && (feeds ? feeds.failed < feeds.total : true)
  setResponseStatus(event, ok ? 200 : github?.skipped ? 429 : 500)

  return {
    ok,
    wallMs: Date.now() - startedAt,
    github,
    feeds,
    target
  }
})