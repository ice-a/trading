import { reposCol } from '../utils/mongo'
import { dayKeyOf, isValidDayKey, humanDay, relativeTime } from '../utils/date'
import { listDays } from '../utils/store'
import type { Bucket, TrendingRepoDoc, TrendingRepoView, TrendingResponse, TrendingPeriod } from '../utils/types'

/**
 * GET /api/trending?date=YYYY-MM-DD&page=1&pageSize=10
 *
 * - 不传 date → 今日（时区取 APP_TIMEZONE）
 * - 第 1 页只返回今日前 N 名（bucket=0）
 * - 往后的页返回当日榜内剩余 + 已掉榜的保留记录（bucket=1 / bucket=2）
 * - 数据全部来自 MongoDB，前端不直接碰 GitHub
 *
 * 结果做 60 秒内存缓存：榜单每小时才更新，导航/刷新没必要每次都往返 Atlas。
 */
export default defineEventHandler(async (event): Promise<TrendingResponse> => {
  const cfg = appConfig()
  const query = getQuery(event)

  const today = dayKeyOf(new Date(), cfg.timezone)
  const date = isValidDayKey(query.date) ? query.date : today

  const rawPage = Number(query.page)
  const page = Number.isFinite(rawPage) && rawPage >= 1 ? Math.floor(rawPage) : 1

  const periodRaw = String(query.period || 'daily').toLowerCase()
  const period: TrendingPeriod = (['daily', 'weekly', 'monthly'] as string[]).includes(periodRaw)
    ? (periodRaw as TrendingPeriod)
    : 'daily'

  const rawPageSize = Number(query.pageSize)  
  const pageSize = Math.min(
    Math.max(Number.isFinite(rawPageSize) && rawPageSize > 0 ? Math.floor(rawPageSize) : cfg.pageSize, 1),
    50
  )

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  const payload = await withCache<TrendingResponse>(
    `trending:${date}:${period}:${page}:${pageSize}`,
    // 数据只在抓取时变化，TTL 略大于抓取间隔；抓取完成后会主动失效
    65 * 60_000,
    async () => {
      const col = await reposCol()

      /**
       * 一次 $facet 聚合拿到「当前页 + 全量统计 + 最近更新时间」。
       *
       * 为什么要合并：原来这里是 7 个并发查询（find / 3×count / find+sort / aggregate），
       * 在 Cloudflare Workers（workerd）下多路并发 socket 会互相拖死导致请求挂起；
       * 合并成单次聚合后并发降到 1，Node 下也少了 5 次网络往返。
       */
      const [faceted] = await col
        .aggregate<{
          items: TrendingRepoDoc[]
          stats: Array<{ total: number; topCount: number; droppedCount: number; totalTodayStars: number }>
          latest: Array<{ lastSeenAt: Date }>
        }>([
          { $match: { date, period } },
          {
            $facet: {
              items: [
                // bucket 0 → 1 → 2；桶内先按名次，再按今日增长
                { $sort: { bucket: 1, rank: 1, todayStars: -1 } },
                { $skip: (page - 1) * pageSize },
                { $limit: pageSize },
                { $project: { snapshots: 0 } }
              ],
              stats: [
                {
                  $group: {
                    _id: null,
                    total: { $sum: 1 },
                    topCount: { $sum: { $cond: [{ $eq: ['$bucket', 0] }, 1, 0] } },
                    droppedCount: { $sum: { $cond: ['$dropped', 1, 0] } },
                    totalTodayStars: { $sum: '$todayStars' }
                  }
                }
              ],
              latest: [{ $sort: { lastSeenAt: -1 } }, { $limit: 1 }, { $project: { lastSeenAt: 1 } }]
            }
          }
        ])
        .toArray()

      const docs = faceted?.items ?? []
      const stats = faceted?.stats?.[0]
      const total = stats?.total ?? 0
      const topCount = stats?.topCount ?? 0
      const droppedCount = stats?.droppedCount ?? 0
      const totalTodayStars = stats?.totalTodayStars ?? 0

      // 日期列表跨天聚合，单独一次（数据量小）
      const days = await listDays(60, period)

      const updatedAt = faceted?.latest?.[0]?.lastSeenAt ? new Date(faceted.latest[0].lastSeenAt) : null
      const items: TrendingRepoView[] = docs.map(toView)

      return {
        date,
        period,
        humanDate: humanDay(date, cfg.timezone),
        isToday: date === today,
        page,
        pageSize,
        total,
        totalPages: Math.max(1, Math.ceil(total / pageSize)),
        updatedAt: updatedAt ? updatedAt.toISOString() : null,
        updatedAgo: updatedAt ? relativeTime(updatedAt) : '暂无数据',
        topN: cfg.topN,
        items,
        days,
        stats: {
          tracked: total,
          topCount,
          droppedCount,
          totalTodayStars
        }
      } satisfies TrendingResponse
    }
  )

  // 空库引导：第一次部署还没抓到数据时给前端一个明确提示
  if (payload.total === 0) {
    setHeader(event, 'X-Trending-Empty', '1')
  }

  return payload
})

function toView(doc: TrendingRepoDoc): TrendingRepoView {
  return {
    rank: doc.rank ?? null,
    owner: doc.owner,
    name: doc.name,
    fullName: doc.fullName,
    url: doc.url,
    description: doc.description || '',
    language: doc.language || 'Unknown',
    languageColor: doc.languageColor || '#8b949e',
    totalStars: doc.totalStars ?? 0,
    forks: doc.forks ?? 0,
    todayStars: doc.todayStars ?? 0,
    bucket: (doc.bucket ?? 0) as Bucket,
    dropped: Boolean(doc.dropped),
    firstSeenAt: doc.firstSeenAt ? new Date(doc.firstSeenAt).toISOString() : null,
    lastSeenAt: doc.lastSeenAt ? new Date(doc.lastSeenAt).toISOString() : null
  }
}
