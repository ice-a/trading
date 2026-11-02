import { getDayRepos, listDays } from '../utils/store'
import { dayKeyOf, humanDay, isValidDayKey, relativeTime } from '../utils/date'
import type { Bucket, TrendingRepoView, TrendingPeriod } from '../utils/types'

/**
 * GET /api/trending-bundle?date=YYYY-MM-DD&pageSize=10
 *
 * 一次返回 daily / weekly / monthly 三个周期的完整榜单。
 *
 * 为什么要这个接口：首页切换日/周/月时，原来每切一次都要发一次 SSR 请求 + 查一次库，
 * 部署在 Serverless 上还会叠加冷启动，表现为「切换很卡」。
 * 三个周期加起来也就 40~60 条记录（几十 KB），一次取全、前端本地切换，切换就没有等待了。
 *
 * SQLite 版：三条按 (date, period) 主键前缀的查询 + 一条日期列表，共 4 次往返。
 */
const PERIODS = ['daily', 'weekly', 'monthly'] as const
type P = (typeof PERIODS)[number]

export default defineEventHandler(async (event) => {
  const cfg = appConfig()
  const query = getQuery(event)

  const today = dayKeyOf(new Date(), cfg.timezone)
  const date = isValidDayKey(query.date) ? query.date : today

  const rawPageSize = Number(query.pageSize)
  const pageSize = Math.min(
    Math.max(Number.isFinite(rawPageSize) && rawPageSize > 0 ? Math.floor(rawPageSize) : cfg.pageSize, 1),
    50
  )

  setHeader(event, 'Cache-Control', 'public, max-age=60, stale-while-revalidate=300')

  return withCache(`trending-bundle:${date}:${pageSize}`, 10 * 60_000, async () => {
    const [daily, weekly, monthly, days] = await Promise.all([
      getDayRepos(date, 'daily'),
      getDayRepos(date, 'weekly'),
      getDayRepos(date, 'monthly'),
      listDays(60)
    ])

    const grouped: Record<string, typeof daily> = { daily, weekly, monthly }

    const build = (p: P) => {
      const docs = grouped[p] ?? []
      const topCount = docs.filter((d) => d.bucket === 0).length
      const latest = docs.reduce<number>((max, d) => Math.max(max, d.lastSeenAt?.getTime() ?? 0), 0)
      const updatedAt = latest ? new Date(latest) : null
      return {
        date,
        period: p,
        humanDate: humanDay(date, cfg.timezone),
        isToday: date === today,
        page: 1,
        pageSize,
        total: docs.length,
        totalPages: Math.max(1, Math.ceil(topCount / pageSize)),
        updatedAt: updatedAt ? updatedAt.toISOString() : null,
        updatedAgo: updatedAt ? relativeTime(updatedAt) : '暂无数据',
        topN: cfg.topN,
        days,
        stats: {
          tracked: docs.length,
          topCount,
          droppedCount: docs.filter((d) => d.dropped).length,
          totalTodayStars: docs.reduce((s, d) => s + (d.todayStars || 0), 0)
        },
        items: docs
          .filter((d) => d.bucket === 0)
          .slice(0, pageSize)
          .map(toView)
      }
    }

    return {
      date,
      humanDate: humanDay(date, cfg.timezone),
      isToday: date === today,
      pageSize,
      daily: build('daily'),
      weekly: build('weekly'),
      monthly: build('monthly')
    }
  })
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
