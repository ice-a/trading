import { crawlState } from '../utils/crawler'
import { readMeta } from '../utils/store'
import { runsCol } from '../utils/mongo'

/** GET /api/status —— 抓取调度状态、最近若干次运行记录 */
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
    const col = await runsCol()
    const docs = await col.find({}).sort({ startedAt: -1 }).limit(12).toArray()
    recent = docs.map((d) => ({
      startedAt: new Date(d.startedAt).toISOString(),
      date: d.date,
      ok: d.ok,
      fetched: d.fetched,
      dropped: d.dropped,
      durationMs: d.durationMs,
      trigger: d.trigger,
      error: d.error
    }))
    meta = (await readMeta()) as Record<string, unknown> | null
  } catch (err) {
    // 数据库没连上时也返回调度器自身状态
    meta = { error: err instanceof Error ? err.message : String(err) }
  }

  return {
    scheduler: {
      intervalMinutes: cfg.updateIntervalMinutes,
      cronOnBoot: cfg.crawlOnBoot,
      running: state.running,
      totalRuns: state.totalRuns,
      failStreak: state.failStreak,
      startedAt: state.startedAt ? new Date(state.startedAt).toISOString() : null,
      nextRunAt: state.nextRunAt ? new Date(state.nextRunAt).toISOString() : null,
      last: state.last
    },
    config: {
      timezone: cfg.timezone,
      database: cfg.mongoDb,
      since: cfg.trendingSince,
      language: cfg.trendingLanguage || '(全部)',
      topN: cfg.topN,
      pageSize: cfg.pageSize
    },
    meta,
    recent
  }
})
