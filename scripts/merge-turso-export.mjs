#!/usr/bin/env node
/**
 * 一次性迁移：把 Turso 导出的 SQLite（devops.db）里的 trending_repos
 * 合并进 public/data/bundle.json。
 *
 * - Turso 是更完整的来源（14 天 / 692 行），作为历史基准
 * - 现有 bundle 里 Turso 没有的日期（如 11-16）保留
 * - 同一日期以 Turso 为准覆盖
 *
 * 用法：node scripts/merge-turso-export.mjs [导出.db 路径]
 */
import { DatabaseSync } from 'node:sqlite'
import { existsSync, readFileSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'

const DB_PATH = resolve(process.argv[2] || 'devops.db')
const BUNDLE = resolve('public/data/bundle.json')
const TZ = process.env.APP_TIMEZONE || 'Asia/Shanghai'
const TOP_N = Number(process.env.TOP_N || 10)
const PAGE_SIZE = Number(process.env.PAGE_SIZE || 10)
const PERIODS = ['daily', 'weekly', 'monthly']

if (!existsSync(DB_PATH)) {
  console.error(`找不到导出文件：${DB_PATH}`)
  process.exit(1)
}

function humanDay(key) {
  const d = new Date(`${key}T12:00:00Z`)
  const w = new Intl.DateTimeFormat('zh-CN', { timeZone: TZ, weekday: 'short' }).format(d)
  const [y, m, dd] = key.split('-')
  return `${y}年${Number(m)}月${Number(dd)}日 ${w}`
}

function rowToView(r) {
  return {
    rank: r.rank ?? null,
    owner: r.owner,
    name: r.name,
    fullName: r.full_name,
    url: r.url,
    description: r.description || '',
    language: r.language || 'Unknown',
    languageColor: r.language_color || '#8b949e',
    totalStars: r.total_stars || 0,
    forks: r.forks || 0,
    todayStars: r.today_stars || 0,
    bucket: r.bucket || 0,
    dropped: Boolean(r.dropped),
    firstSeenAt: r.first_seen_at || null,
    lastSeenAt: r.last_seen_at || null
  }
}

function buildResponse(date, period, rows, dayOptions) {
  const items = rows.map(rowToView)
  const topCount = items.filter((d) => d.bucket === 0).length
  const droppedCount = items.filter((d) => d.dropped).length
  const totalTodayStars = items.reduce((s, d) => s + (d.todayStars || 0), 0)
  const latest = items.reduce((m, d) => Math.max(m, d.lastSeenAt ? new Date(d.lastSeenAt).getTime() : 0), 0)
  const isToday = date === new Intl.DateTimeFormat('en-CA', {
    timeZone: TZ, year: 'numeric', month: '2-digit', day: '2-digit'
  }).format(new Date())
  return {
    date,
    period,
    humanDate: humanDay(date),
    isToday,
    page: 1,
    pageSize: PAGE_SIZE,
    total: items.length,
    totalPages: Math.max(1, Math.ceil(items.length / PAGE_SIZE)),
    updatedAt: latest ? new Date(latest).toISOString() : null,
    updatedAgo: latest ? `${Math.max(1, Math.floor((Date.now() - latest) / 60000))} 分钟前` : '暂无数据',
    topN: TOP_N,
    items,
    days: dayOptions,
    stats: { tracked: items.length, topCount, droppedCount, totalTodayStars }
  }
}

/* ---------- 读取现有 bundle ---------- */
const bundle = existsSync(BUNDLE)
  ? JSON.parse(readFileSync(BUNDLE, 'utf8'))
  : { generatedAt: null, meta: {}, days: [] }

/* ---------- 从 Turso 导出读所有日期 ---------- */
const db = new DatabaseSync(DB_PATH, { readOnly: true })
const tursoDates = db
  .prepare('select distinct date from trending_repos order by date')
  .all()
  .map((r) => r.date)
console.log(`[merge] Turso 导出含 ${tursoDates.length} 个日期：${tursoDates[0]} ~ ${tursoDates.at(-1)}`)

// 用 Map 管理，Turso 覆盖现有
const byDate = new Map(bundle.days.map((d) => [d.date, d]))

for (const date of tursoDates) {
  const day = { date, humanDate: humanDay(date), isToday: false, periods: {} }
  for (const period of PERIODS) {
    const rows = db
      .prepare(
        'select * from trending_repos where date = ? and period = ? ' +
        'order by bucket asc, rank asc, today_stars desc'
      )
      .all(date, period)
    if (rows.length) day.periods[period] = { __rows: rows }
  }
  byDate.set(date, day)
}
db.close()

/* ---------- 重排 + 生成统一 dayOptions ---------- */
const allDates = [...byDate.keys()].sort((a, b) => b.localeCompare(a))
const today = allDates[0]
const dayOptions = allDates.map((date) => {
  const d = byDate.get(date)
  const count = Math.max(
    ...PERIODS.map((p) => {
      const raw = d.periods[p]
      return raw?.__rows?.length ?? raw?.items?.length ?? 0
    })
  )
  return { date, count, isToday: date === today }
})

bundle.days = allDates.map((date) => {
  const d = byDate.get(date)
  d.isToday = date === today
  for (const period of PERIODS) {
    const raw = d.periods[period]
    if (!raw) continue
    if (raw.__rows) {
      d.periods[period] = buildResponse(date, period, raw.__rows, dayOptions)
    } else {
      raw.days = dayOptions
      raw.isToday = date === today
    }
  }
  return d
})

bundle.generatedAt = new Date().toISOString()
bundle.meta = {
  ...bundle.meta,
  topN: TOP_N,
  pageSize: PAGE_SIZE,
  timezone: TZ,
  today,
  source: 'turso-export + github-actions'
}

writeFileSync(BUNDLE, JSON.stringify(bundle))
const bytes = Buffer.byteLength(JSON.stringify(bundle))
console.log(`[merge] ✓ 写入 ${BUNDLE}`)
console.log(`[merge] 共 ${bundle.days.length} 天（${(bytes / 1024).toFixed(1)}KB）：${allDates.join(', ')}`)
