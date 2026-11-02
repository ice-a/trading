import { sqlAll, dbInfo } from '../utils/db'
import { crawlState } from '../utils/crawler'
import { readMeta } from '../utils/store'
import { cacheStats } from '../utils/cache'

/** GET /api/status —— 调度状态、数据库信息、最近若干次抓取记录 */
export default defineEventHandler(async () => {
  const cfg = appConfig()
  const state = crawlState()

  let recent: Array<{
    startedAt: string
    date: string
    ok: boolean
    fetched: number
    dropped: number
    durationMs: number
    trigger: string
    error: string | null
  }> = []
  let meta: Record<string, unknown> | null = null

  try {
    const rows = await sqlAll<{
      started_at: string
      date: string
      ok: number
      fetched: number
      dropped: number
      duration_ms: number
      triggered_by: string
      error: string | null
    }>(
      'select started_at, date, ok, fetched, dropped, duration_ms, triggered_by, error from crawl_runs order by started_at desc limit 12'
    )
    recent = rows.map((d) => ({
      startedAt: d.started_at,
      date: d.date,
      ok: Boolean(d.ok),
      fetched: d.fetched,
      dropped: d.dropped,
      durationMs: d.duration_ms,
      trigger: d.triggered_by,
      error: d.error
    }))
    meta = (await readMeta()) as Record<string, unknown> | null
  } catch (err) {
    // 数据库不可用时也返回调度器自身状态
    meta = { error: err instanceof Error ? err.message : String(err) }
  }

  return {
    scheduler: {
      intervalMinutes: cfg.updateIntervalMinutes,
      running: state.running,
      totalRuns: state.totalRuns,
      failStreak: state.failStreak,
      startedAt: state.startedAt ? new Date(state.startedAt).toISOString() : null,
      nextRunAt: state.nextRunAt ? new Date(state.nextRunAt).toISOString() : null,
      last: state.last
    },
    config: {
      timezone: cfg.timezone,
      storage: 'sqlite',
      since: cfg.trendingSince,
      language: cfg.trendingLanguage || '(全部)',
      topN: cfg.topN,
      pageSize: cfg.pageSize,
      feedsEnabled: cfg.feedsEnabled
    },
    db: dbInfo(),
    cache: cacheStats(),
    process: {
      uptimeSec: Math.round(process.uptime()),
      rssMB: Math.round(process.memoryUsage().rss / 1_048_576)
    },
    meta,
    recent
  }
})