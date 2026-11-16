import { runCrawl } from '../utils/crawler'
import { invalidateCache } from '../utils/cache'
import { env } from '../utils/env'

/**
 * GET /api/cron —— 外部定时触发抓取的入口（可选）。
 *
 * 单机默认靠进程内定时器抓取；如果你用 cron-job.org / UptimeRobot 之类的
 * 外部服务按小时触发，可以用这个接口，带 Authorization: Bearer <CRON_TOKEN>。
 */
export default defineEventHandler(async (event) => {
  const secret = env('CRON_TOKEN', '').trim()

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
