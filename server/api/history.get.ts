import { reposCol } from '../utils/mongo'
import { dayKeyOf, humanDay } from '../utils/date'

/**
 * GET /api/history —— 历史数据总览
 *
 * 返回每个有数据的日期 + 当天摘要（仓库数、掉榜数、今日增长合计、当天第一名），
 * 供 /history 页面做日期导航。一次聚合搞定，避免 N+1 查询。
 */
export default defineEventHandler(async (event) => {
  const cfg = appConfig()
  const today = dayKeyOf(new Date(), cfg.timezone)

  const q = getQuery(event)
  const periodRaw = String(q.period || 'daily').toLowerCase()
  const period = (['daily', 'weekly', 'monthly'] as string[]).includes(periodRaw) ? periodRaw : 'daily'

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  // 数据只在抓取时变化，TTL 略大于抓取间隔；抓取完成后会主动失效
  return withCache('history:overview:' + period, 65 * 60_000, async () => {
    const col = await reposCol()

    const rows = await col
      .aggregate<{
        _id: string
        count: number
        droppedCount: number
        totalTodayStars: number
        topRepo: string
        topStars: number
        pit: Date
      }>([
        // 先按周期过滤，再全局排序：同一天里 bucket 0 在前面、按名次升序
        { $match: { period } },
        { $sort: { date: -1, bucket: 1, rank: 1, todayStars: -1 } },
        {
          $group: {
            _id: '$date',
            count: { $sum: 1 },
            droppedCount: { $sum: { $cond: ['$dropped', 1, 0] } },
            totalTodayStars: { $sum: '$todayStars' },
            topRepo: { $first: '$fullName' },
            topStars: { $first: '$todayStars' },
            pit: { $max: '$lastSeenAt' }
          }
        },
        { $sort: { _id: -1 } },
        { $limit: 180 }
      ])
      .toArray()

    const days = rows.map((r) => ({
      date: r._id,
      label: humanDay(r._id, cfg.timezone),
      isToday: r._id === today,
      count: r.count ?? 0,
      droppedCount: r.droppedCount ?? 0,
      totalTodayStars: r.totalTodayStars ?? 0,
      topRepo: r.topRepo || '',
      topStars: r.topStars ?? 0,
      lastSeenAt: r.pit ? new Date(r.pit).toISOString() : null
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
