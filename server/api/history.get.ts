import { withDbCache } from '../utils/cache'
import { sqlAll } from '../utils/db'
import { dayKeyOf, humanDay } from '../utils/date'

/**
 * GET /api/history?period=daily —— 历史数据总览（SQLite 版）
 *
 * 返回每个有数据的日期 + 当天摘要（仓库数、掉榜数、增长合计、当天第一名）。
 * 一条 GROUP BY 搞定；「第一名」用关联子查询取 bucket 最小、rank 最小的一行。
 */
export default defineEventHandler(async (event) => {
  const cfg = appConfig()
  const today = dayKeyOf(new Date(), cfg.timezone)

  const q = getQuery(event)
  const periodRaw = String(q.period || 'daily').toLowerCase()
  const period = (['daily', 'weekly', 'monthly'] as string[]).includes(periodRaw) ? periodRaw : 'daily'

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  return withDbCache('history:overview:' + period, 65 * 60_000, async () => {
    const rows = await sqlAll<{
      date: string
      count: number
      dropped_count: number
      total_today_stars: number
      top_repo: string | null
      top_stars: number | null
      last_seen: string | null
    }>(
      `select
         t.date,
         count(*) as count,
         sum(t.dropped) as dropped_count,
         sum(t.today_stars) as total_today_stars,
         max(t.last_seen_at) as last_seen,
         (select full_name from trending_repos x
            where x.date = t.date and x.period = t.period
            order by x.bucket asc, x.rank asc limit 1) as top_repo,
         (select today_stars from trending_repos x
            where x.date = t.date and x.period = t.period
            order by x.bucket asc, x.rank asc limit 1) as top_stars
       from trending_repos t
       where t.period = ?
       group by t.date, t.period
       order by t.date desc
       limit 180`,
      [period]
    )

    const days = rows.map((r) => ({
      date: r.date,
      label: humanDay(r.date, cfg.timezone),
      isToday: r.date === today,
      count: r.count ?? 0,
      droppedCount: r.dropped_count ?? 0,
      totalTodayStars: r.total_today_stars ?? 0,
      topRepo: r.top_repo || '',
      topStars: r.top_stars ?? 0,
      lastSeenAt: r.last_seen || null
    }))

    return {
      today,
      period,
      totalDays: days.length,
      totalRepos: days.reduce((s, d) => s + d.count, 0),
      days
    }
  })
})
