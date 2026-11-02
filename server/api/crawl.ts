import { runCrawl } from '../utils/crawler'
import { appConfig } from '../utils/config'
import { invalidateCache, pruneDbCache } from '../utils/cache'

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
  // 服务端配置值也可能带空白（环境变量粘贴时残留），统一 trim 后再比较
  const secret = cfg.cronToken.trim()
  const query = getQuery(event)

  if (secret) {
    const auth = getHeader(event, 'authorization') || ''
    const bearer = auth.toLowerCase().startsWith('bearer ') ? auth.slice(7) : ''
    const provided = String(getHeader(event, 'x-cron-token') || bearer || query.token || '').trim()
    if (!provided || provided !== secret) {
      setResponseStatus(event, 401)
      // 回显长度与首尾字符的"有无空白"，便于对账，但不泄露内容
      return {
        ok: false,
        error: provided
          ? `令牌不匹配（服务端 ${secret.length} 字符，请求方 ${provided.length} 字符）`
          : '缺少令牌：请带 ?token= 或 Authorization: Bearer',
        expectedLen: secret.length,
        gotLen: provided.length
      }
    }
  }

  const startedAt = Date.now()
  const github = await runCrawl('manual')
  invalidateCache('')
  void pruneDbCache()

  setResponseStatus(event, github.ok ? 200 : github.skipped ? 429 : 500)

  return {
    ok: github.ok,
    wallMs: Date.now() - startedAt,
    github
  }
})