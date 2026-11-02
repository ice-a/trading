import { runCrawl } from '../utils/crawler'
import { invalidateCache } from '../utils/cache'
import { env } from '../utils/env'

/**
 * GET /api/cron —— Vercel Cron 专用入口。
 *
 * Vercel 的 Cron 不支持自定义 header，但它会在请求里带上
 *   Authorization: Bearer $CRON_SECRET
 * （前提：在 Vercel 项目里配置了 CRON_SECRET 环境变量）。
 *
 * Hobby（免费）计划限制：**cron 每天只能触发一次**，表达式必须是「每天某点」。
 * 想要小时级更新，用外部免费 cron（cron-job.org / UptimeRobot）打
 *   POST /api/crawl?token=<CRON_TOKEN>
 * 或者 GitHub Actions 定时 curl。
 */
export default defineEventHandler(async (event) => {
  const secret = (env('CRON_SECRET', '') || env('CRON_TOKEN', '')).trim()

  if (secret) {
    const auth = String(getHeader(event, 'authorization') || '')
    const provided = auth.toLowerCase().startsWith('bearer ') ? auth.slice(7).trim() : ''
    if (!provided || provided !== secret) {
      setResponseStatus(event, 401)
      return { ok: false, error: '令牌无效' }
    }
  }

  const started = Date.now()
  const gh = await runCrawl('schedule')
  invalidateCache('')

  return {
    ok: Boolean(gh?.ok),
    durationMs: Date.now() - started,
    github: gh && { fetched: gh.fetched, dropped: gh.dropped, skipped: Boolean(gh.skipped), error: gh.error }
  }
})