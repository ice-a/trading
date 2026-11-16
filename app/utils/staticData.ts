/**
 * 静态数据层 —— GitHub Pages 部署时用。
 *
 * 站点没有服务器，所有榜单数据来自构建期生成的 public/data/bundle.json。
 * 这里把 bundle 转成各页面原本从 /api/* 拿到的结构，页面几乎不用改渲染逻辑。
 */
import type { TrendingResponse, TrendingPeriod } from '~~/server/utils/types'

export interface BundleDay {
  date: string
  humanDate: string
  isToday: boolean
  periods: Record<TrendingPeriod, TrendingResponse>
}

export interface BundleData {
  generatedAt: string
  meta: {
    topN: number
    pageSize: number
    intervalMinutes: number
    timezone: string
    language: string
    today: string
  }
  days: BundleDay[]
}

export interface BundleResponse {
  date: string
  daily: TrendingResponse
  weekly: TrendingResponse
  monthly: TrendingResponse
}

export interface HistoryDay {
  date: string
  label: string
  isToday: boolean
  count: number
  droppedCount: number
  totalTodayStars: number
  topRepo: string
  topStars: number
  lastSeenAt: string | null
}

export interface HistoryOverview {
  today: string
  totalDays: number
  totalRepos: number
  days: HistoryDay[]
}

let cached: BundleData | null = null
let inflight: Promise<BundleData> | null = null

/** 带 baseURL 的静态资源地址（项目站 /trading/、自定义域名 /） */
export function staticUrl(path: string): string {
  const base = (useRuntimeConfig().app.baseURL || '/').replace(/\/$/, '')
  return `${base}${path}`
}

/** 加载 bundle（进程内缓存一次） */
export async function loadBundle(): Promise<BundleData> {
  if (cached) return cached
  if (inflight) return inflight
  inflight = $fetch<BundleData>(staticUrl('/data/bundle.json'))
    .then((data) => {
      cached = data
      return data
    })
    .finally(() => {
      inflight = null
    })
  return inflight
}

/** 清缓存（手动刷新按钮用：重新读一次 JSON，规避浏览器缓存） */
export function clearBundleCache(): void {
  cached = null
}

function paginate(r: TrendingResponse, page: number, pageSize: number): TrendingResponse {
  const size = Math.max(1, pageSize)
  return {
    ...r,
    page,
    pageSize: size,
    items: r.items.slice((page - 1) * size, page * size),
    totalPages: Math.max(1, Math.ceil(r.items.length / size))
  }
}

function emptyResponse(date: string, period: TrendingPeriod, pageSize: number): TrendingResponse {
  return {
    date,
    period,
    humanDate: date,
    isToday: date === new Date().toISOString().slice(0, 10),
    page: 1,
    pageSize,
    total: 0,
    totalPages: 1,
    updatedAt: null,
    updatedAgo: '暂无数据',
    topN: 10,
    items: [],
    days: [],
    stats: { tracked: 0, topCount: 0, droppedCount: 0, totalTodayStars: 0 }
  }
}

/** 首页：某天（不传取最新）的三周期 bundle */
export async function getBundle(date?: string, page = 1, pageSize = 10): Promise<BundleResponse> {
  const b = await loadBundle()
  const day = (date && b.days.find((d) => d.date === date)) || b.days[0]
  if (!day) {
    const today = b.meta?.today || new Date().toISOString().slice(0, 10)
    return { date: today, daily: emptyResponse(today, 'daily', pageSize), weekly: emptyResponse(today, 'weekly', pageSize), monthly: emptyResponse(today, 'monthly', pageSize) }
  }
  return {
    date: day.date,
    daily: paginate(day.periods.daily ?? emptyResponse(day.date, 'daily', pageSize), page, pageSize),
    weekly: paginate(day.periods.weekly ?? emptyResponse(day.date, 'weekly', pageSize), page, pageSize),
    monthly: paginate(day.periods.monthly ?? emptyResponse(day.date, 'monthly', pageSize), page, pageSize)
  }
}

/** 历史页总览 */
export async function getHistoryOverview(period: TrendingPeriod = 'daily'): Promise<HistoryOverview> {
  const b = await loadBundle()
  const today = b.meta?.today || b.days[0]?.date || ''
  const days: HistoryDay[] = b.days.map((d) => {
    const r = d.periods[period] ?? d.periods.daily
    const top = r?.items.find((i) => i.rank === 1)
    return {
      date: d.date,
      label: d.humanDate,
      isToday: d.date === today,
      count: r?.stats.tracked ?? 0,
      droppedCount: r?.stats.droppedCount ?? 0,
      totalTodayStars: r?.stats.totalTodayStars ?? 0,
      topRepo: top?.fullName ?? '',
      topStars: top?.todayStars ?? 0,
      lastSeenAt: r?.updatedAt ?? null
    }
  })
  return {
    today,
    totalDays: days.length,
    totalRepos: days.reduce((s, d) => s + d.count, 0),
    days
  }
}

/** 历史页某天的榜单明细（daily，原 /api/trending 默认周期） */
export async function getTrendingDetail(date: string, page = 1, pageSize = 10): Promise<TrendingResponse> {
  const b = await loadBundle()
  const day = b.days.find((d) => d.date === date) ?? b.days[0]
  if (!day) return emptyResponse(date, 'daily', pageSize)
  return paginate(day.periods.daily ?? emptyResponse(day.date, 'daily', pageSize), page, pageSize)
}

/** 更新间隔（顶栏「每 N 分钟自动更新」显示用） */
export async function getIntervalMinutes(): Promise<number> {
  const b = await loadBundle()
  return b.meta?.intervalMinutes ?? 60
}
