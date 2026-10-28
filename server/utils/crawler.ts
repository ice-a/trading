import { fetchTrendingRepos } from './trending'
import { saveDailySnapshot, logCrawlRun, touchMeta } from './store'
import { acquireLock, releaseLock } from './lock'
import { dayKeyOf } from './date'
import type { CrawlRunDoc } from './types'

/**
 * 一次抓取任务的完整编排：加锁 → 抓取 → 解析 → upsert 入库 → 写日志。
 */

export interface CrawlOutcome {
  ok: boolean
  trigger: CrawlRunDoc['trigger']
  date: string
  fetched: number
  upserted: number
  modified: number
  dropped: number
  tracked: number
  durationMs: number
  startedAt: string
  finishedAt: string
  error: string | null
  skipped?: boolean
}

interface CrawlState {
  running: boolean
  last: CrawlOutcome | null
  nextRunAt: number | null
  intervalMinutes: number
  startedAt: number | null
  totalRuns: number
  failStreak: number
}

const globalKey = '__github_trending_crawl_state__'

export function crawlState(): CrawlState {
  const g = globalThis as Record<string, unknown>
  if (!g[globalKey]) {
    g[globalKey] = {
      running: false,
      last: null,
      nextRunAt: null,
      intervalMinutes: appConfig().updateIntervalMinutes,
      startedAt: null,
      totalRuns: 0,
      failStreak: 0
    } satisfies CrawlState
  }
  return g[globalKey] as CrawlState
}

const LOCK_NAME = 'github-trending-crawl'
/**
 * 锁 TTL 必须远小于抓取间隔：
 * 一次抓取通常 3~10 秒，5 分钟足够覆盖慢网络；同时保证进程被 kill 后
 * 最长 5 分钟就能自动恢复，而不是被残留锁阻塞一整个周期。
 */
const LOCK_TTL_MS = 5 * 60_000

export async function runCrawl(trigger: CrawlRunDoc['trigger'] = 'schedule'): Promise<CrawlOutcome> {
  const cfg = appConfig()
  const state = crawlState()
  const startedAt = new Date()

  // 进程内并发保护
  if (state.running) {
    return {
      ok: false,
      skipped: true,
      trigger,
      date: dayKeyOf(startedAt, cfg.timezone),
      fetched: 0,
      upserted: 0,
      modified: 0,
      dropped: 0,
      tracked: 0,
      durationMs: 0,
      startedAt: startedAt.toISOString(),
      finishedAt: startedAt.toISOString(),
      error: '上一次抓取仍在进行中，本次跳过'
    }
  }

  state.running = true

  // 跨实例保护（本地单机也走一遍，逻辑统一）
  const lockToken = await acquireLock(LOCK_NAME, LOCK_TTL_MS)
  if (!lockToken) {
    state.running = false
    return {
      ok: false,
      skipped: true,
      trigger,
      date: dayKeyOf(startedAt, cfg.timezone),
      fetched: 0,
      upserted: 0,
      modified: 0,
      dropped: 0,
      tracked: 0,
      durationMs: Date.now() - startedAt.getTime(),
      startedAt: startedAt.toISOString(),
      finishedAt: new Date().toISOString(),
      error: '另一个实例正在抓取（分布式锁未释放）'
    }
  }

  let outcome: CrawlOutcome

  try {
    // 一次抓三个周期（日 / 周 / 月），各自入库存一份，前端可按 period 切换
    const periods: TrendingPeriod[] = ['daily', 'weekly', 'monthly']
    let saved: Awaited<ReturnType<typeof saveDailySnapshot>> | null = null
    let totalFetched = 0
    let totalUpserted = 0
    let totalModified = 0
    let totalDropped = 0

    // 三个周期并行抓：串行要 8~9s，并行约 3s，避免撞上 Serverless 函数超时
    const results = await Promise.all(
      periods.map(async (period) => {
        const repos = await fetchTrendingRepos({ since: period, language: cfg.trendingLanguage })
        return saveDailySnapshot({ repos, topN: cfg.topN, period })
      })
    )

    for (const one of results) {
      saved = one
      totalFetched += one.fetched
      totalUpserted += one.upserted
      totalModified += one.modified
      totalDropped += one.dropped
    }

    const result = saved ?? { date: dayKeyOf(new Date(), cfg.timezone), tracked: 0 }

    // 新数据已入库，立刻让接口缓存失效（下次请求读新数据并重新缓存）
    invalidateCache('trending:')
    invalidateCache('history:')

    const finishedAt = new Date()

    outcome = {
      ok: true,
      trigger,
      date: result.date,
      fetched: totalFetched,
      upserted: totalUpserted,
      modified: totalModified,
      dropped: totalDropped,
      tracked: result.tracked,
      durationMs: finishedAt.getTime() - startedAt.getTime(),
      startedAt: startedAt.toISOString(),
      finishedAt: finishedAt.toISOString(),
      error: null
    }

    state.failStreak = 0

    await Promise.all([
      logCrawlRun({
        date: result.date,
        startedAt,
        finishedAt,
        durationMs: outcome.durationMs,
        source: 'github.com/trending?since=daily|weekly|monthly',
        fetched: totalFetched,
        upserted: totalUpserted,
        modified: totalModified,
        dropped: totalDropped,
        ok: true,
        error: null,
        trigger
      }),
      touchMeta({
        lastSuccessAt: finishedAt,
        lastDate: result.date,
        lastFetched: totalFetched,
        lastTracked: result.tracked,
        lastTrigger: trigger,
        intervalMinutes: cfg.updateIntervalMinutes
      })
    ])
  } catch (err) {
    const finishedAt = new Date()
    const message = err instanceof Error ? err.message : String(err)
    outcome = {
      ok: false,
      trigger,
      date: dayKeyOf(finishedAt, cfg.timezone),
      fetched: 0,
      upserted: 0,
      modified: 0,
      dropped: 0,
      tracked: 0,
      durationMs: finishedAt.getTime() - startedAt.getTime(),
      startedAt: startedAt.toISOString(),
      finishedAt: finishedAt.toISOString(),
      error: message
    }

    state.failStreak += 1
    console.error('[crawl] 抓取失败:', message)

    await Promise.all([
      logCrawlRun({
        date: outcome.date,
        startedAt,
        finishedAt,
        durationMs: outcome.durationMs,
        source: `github.com/trending?since=${cfg.trendingSince}`,
        fetched: 0,
        upserted: 0,
        modified: 0,
        dropped: 0,
        ok: false,
        error: message,
        trigger
      }),
      touchMeta({
        lastErrorAt: finishedAt,
        lastError: message,
        lastTrigger: trigger,
        intervalMinutes: cfg.updateIntervalMinutes
      })
    ])
  } finally {
    await releaseLock(LOCK_NAME, lockToken)
    state.running = false
  }

  state.last = outcome
  state.totalRuns += 1
  state.nextRunAt = Date.now() + state.intervalMinutes * 60_000
  return outcome
}
