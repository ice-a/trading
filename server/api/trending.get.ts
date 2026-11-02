import { getDayRepos } from '../utils/store'
import { dayKeyOf, isValidDayKey, humanDay, relativeTime } from '../utils/date'
import { listDays } from '../utils/store'
import type { Bucket, TrendingRepoView, TrendingResponse, TrendingPeriod } from '../utils/types'

/**
 * GET /api/trending?date=YYYY-MM-DD&page=1&pageSize=10&period=daily
 *
 * - 不传 date → 今日（时区取 APP_TIMEZONE）
 * - 第 1 页只返回今日前 N 名（bucket=0）
 * - 往后的页返回当日榜内剩余 + 已掉榜的保留记录（bucket=1 / bucket=2）
 *
 * SQLite 版：一天一个周期最多 ~40 行，整取后内存分页，一次查询搞定
 * （不再需要 Mongo 时代的 $facet 合并技巧）。
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
    65 * 60_000,
    async () => {
      const [docs, days] = await Promise.all([getDayRepos(date, period), listDays(60, period)])

      const total = docs.length
      const topCount = docs.filter((d) => d.bucket === 0).length
      const droppedCount = docs.filter((d) => d.dropped).length
      const totalTodayStars = docs.reduce((s, d) => s + (d.todayStars || 0), 0)

      const latest = docs.reduce<number>((max, d) => Math.max(max, d.lastSeenAt?.getTime() ?? 0), 0)
      const updatedAt = latest ? new Date(latest) : null

      const items: TrendingRepoView[] = docs
        .slice((page - 1) * pageSize, page * pageSize)
        .map(toView)

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

  if (payload.total === 0) {
    setHeader(event, 'X-Trending-Empty', '1')
  }

  return payload
})

function toView(doc: Awaited<ReturnType<typeof getDayRepos>>[number]): TrendingRepoView {
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
