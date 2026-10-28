import { reposCol } from '../utils/mongo'
import { dayKeyOf, humanDay, isValidDayKey, relativeTime } from '../utils/date'
import { listDays } from '../utils/store'

/**
 * GET /api/trending-bundle?date=YYYY-MM-DD&pageSize=10
 *
 * 一次返回 daily / weekly / monthly 三个周期的完整榜单。
 *
 * 为什么要这个接口：首页切换日/周/月时，原来每切一次都要发一次 SSR 请求 + 查一次库，
 * 部署在 Serverless 上还会叠加冷启动，表现为「切换很卡」。
 * 三个周期加起来也就 40~60 条文档（几十 KB），一次取全、前端本地切换，切换就没有等待了。
 *
 * 实现上用 4 个简单查询（1 次 find + 3 次 count），不用 $facet ——
 * $facet 在跨洋链路上容易踩到执行计划退化，直接把请求拖到超时。
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
    const col = await reposCol()

    // 1) 三个周期各自的前 pageSize 名（bucket=0），一次 find 拿回来
    const rows = await col
      .find(
        { date, period: { $in: [...PERIODS] }, bucket: 0 },
        { projection: { snapshots: 0 } }
      )
      .sort({ period: 1, rank: 1 })
      .toArray()

    const grouped: Record<string, Array<Record<string, unknown>>> = { daily: [], weekly: [], monthly: [] }
    for (const r of rows) {
      const d = r as unknown as Record<string, unknown>
      const p = String(d.period || 'daily')
      if (!grouped[p]) grouped[p] = []
      if (grouped[p].length < pageSize) grouped[p].push(d)
    }

    // 2) 三个周期的总数 / 掉榜数（走 (date, period) 前缀索引，很快）
    const statsMap = new Map<P, { total: number; top: number; dropped: number; stars: number }>()
    await Promise.all(
      PERIODS.map(async (p) => {
        const [total, dropped] = await Promise.all([
          col.countDocuments({ date, period: p }),
          col.countDocuments({ date, period: p, dropped: true })
        ])
        statsMap.set(p, { total, top: grouped[p]?.length ?? 0, dropped, stars: 0 })
      })
    )

    const days = await listDays(60)

    const latest = await col.find({ date }, { projection: { lastSeenAt: 1 } }).sort({ lastSeenAt: -1 }).limit(1).toArray()
    const updatedAt = latest[0]?.lastSeenAt ? new Date(latest[0].lastSeenAt as Date) : null

    const build = (p: P) => {
      const s = statsMap.get(p) ?? { total: 0, top: 0, dropped: 0, stars: 0 }
      return {
        date,
        period: p,
        humanDate: humanDay(date, cfg.timezone),
        isToday: date === today,
        page: 1,
        pageSize,
        total: s.total,
        totalPages: Math.max(1, Math.ceil(s.top / pageSize)),
        updatedAt: updatedAt ? updatedAt.toISOString() : null,
        updatedAgo: updatedAt ? relativeTime(updatedAt) : '暂无数据',
        topN: cfg.topN,
        days,
        stats: {
          tracked: s.total,
          topCount: s.top,
          droppedCount: s.dropped,
          totalTodayStars: s.stars
        },
        items: (grouped[p] ?? []).map((d) => ({
          rank: d.rank,
          repoKey: d.repoKey,
          owner: d.owner,
          name: d.name,
          fullName: d.fullName,
          url: d.url,
          description: d.description,
          language: d.language,
          languageColor: d.languageColor,
          totalStars: d.totalStars,
          forks: d.forks,
          todayStars: d.todayStars,
          bestRank: d.bestRank,
          bucket: d.bucket,
          dropped: d.dropped
        }))
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
