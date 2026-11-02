import { runCrawl } from '../utils/crawler'
import { appConfig } from '../utils/config'
import { invalidateCache } from '../utils/cache'

/**
 * /api/crawl —— 强制抓取一次（运维 / 外部 cron / 手动）。
 *
 * 功能裁剪后只抓 GitHub Trending（日/周/月三榜一次抓完），
 * 60s 聚合端点那部分已随 /v2 页面一起删除。
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

  const startedAt = Date.now()
  const github = await runCrawl('manual')
  invalidateCache('')

  setResponseStatus(event, github.ok ? 200 : github.skipped ? 429 : 500)

  return {
    ok: github.ok,
    wallMs: Date.now() - startedAt,
    github
  }
})