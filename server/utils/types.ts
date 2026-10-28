/**
 * 数据模型：一条文档 = 「某天 + 某个仓库」。
 *
 * 设计要点（对应需求）：
 * - 按日期分区：date 字段（YYYY-MM-DD，时区由 APP_TIMEZONE 决定）
 * - 每次更新做 upsert：同一个 (date, repoKey) 只更新指标，不新增重复行
 * - 掉出前 10 不删除：bucket 由 0 降级为 1（仍在榜）或 2（已掉榜），文档永久保留，
 *   只有翻页时才被前端读到
 * - snapshots 记录每小时的时间序列，方便以后画曲线
 */

/** 榜单分区：0 = 今日前 N 名；1 = 当日榜内但不在前 N；2 = 当日已掉榜的历史记录 */
export type Bucket = 0 | 1 | 2

/** 榜单周期：日 / 周 / 月 */
export type TrendingPeriod = 'daily' | 'weekly' | 'monthly'

export const TRENDING_PERIODS: TrendingPeriod[] = ['daily', 'weekly', 'monthly']

export const PERIOD_LABELS: Record<TrendingPeriod, string> = {
  daily: '日榜',
  weekly: '周榜',
  monthly: '月榜'
}

export interface TrendingRepoDoc {
  /** 分区键：YYYY-MM-DD */
  date: string
  /** 榜单周期，默认 daily */
  period: TrendingPeriod
  /** 唯一键：owner/name（小写） */
  repoKey: string
  owner: string
  name: string
  /** 展示用全名 owner/name（保留原始大小写） */
  fullName: string
  url: string
  description: string
  language: string
  languageColor: string
  /** 总 Star */
  totalStars: number
  /** 总 Fork */
  forks: number
  /** 今日新增 Star（GitHub trending 页面上的 "N stars today"） */
  todayStars: number
  /** 最近一次抓取时的榜内名次（掉榜后置 null） */
  rank: number | null
  /** 历史最高名次 */
  bestRank: number | null
  /** 排序分区 */
  bucket: Bucket
  /** 是否已掉出当日榜单 */
  dropped: boolean
  droppedAt: Date | null
  /** 当日第一次被记录到的时间 */
  firstSeenAt: Date
  /** 最近一次被记录到的时间 */
  lastSeenAt: Date
  /** 时间序列（最近 48 个采样点：{at, todayStars, totalStars, rank}） */
  snapshots: RepoSnapshot[]
  createdAt: Date
  updatedAt: Date
}

export interface RepoSnapshot {
  at: Date
  todayStars: number
  totalStars: number
  rank: number | null
}

/** 抓取日志 */
export interface CrawlRunDoc {
  date: string
  startedAt: Date
  finishedAt: Date
  durationMs: number
  source: string
  fetched: number
  upserted: number
  modified: number
  dropped: number
  ok: boolean
  error: string | null
  trigger: 'boot' | 'schedule' | 'manual'
}

/** 抓取器解析出的单条结果（尚未入库） */
export interface ParsedRepo {
  owner: string
  name: string
  repoKey: string
  fullName: string
  url: string
  description: string
  language: string
  languageColor: string
  totalStars: number
  forks: number
  todayStars: number
  rank: number
}

/** API 返回给前端的行 */
export interface TrendingRepoView {
  rank: number | null
  owner: string
  name: string
  fullName: string
  url: string
  description: string
  language: string
  languageColor: string
  totalStars: number
  forks: number
  todayStars: number
  bucket: Bucket
  dropped: boolean
  firstSeenAt: string | null
  lastSeenAt: string | null
}

export interface TrendingResponse {
  date: string
  humanDate: string
  isToday: boolean
  page: number
  pageSize: number
  total: number
  totalPages: number
  updatedAt: string | null
  updatedAgo: string
  topN: number
  items: TrendingRepoView[]
  days: DayOption[]
  stats: {
    tracked: number
    topCount: number
    droppedCount: number
    totalTodayStars: number
  }
}

export interface DayOption {
  date: string
  count: number
  isToday: boolean
}
