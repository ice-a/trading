#!/usr/bin/env node
/**
 * 静态数据生成器 —— GitHub Pages 部署的数据源。
 *
 * 定时（GitHub Actions）运行：抓 GitHub Trending 三个周期 → 合并历史/掉榜语义
 * → 写出 public/data/bundle.json（前端直接 fetch 的静态文件）。
 *
 * 站点不再需要服务器：所有数据都来自这个 JSON，随构建一起发布到 Pages。
 *
 * 用法：
 *   node scripts/generate-static-data.mjs          # 抓当天三个周期并合并
 *   DRY_RUN=1 node scripts/generate-static-data.mjs  # 只解析不写文件
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { load } from 'cheerio/slim'

const TZ = process.env.APP_TIMEZONE || 'Asia/Shanghai'
const TOP_N = Number(process.env.TOP_N || 10)
const PAGE_SIZE = Number(process.env.PAGE_SIZE || 10)
const INTERVAL = Number(process.env.UPDATE_INTERVAL_MINUTES || 60)
const LANGUAGE = (process.env.TRENDING_LANGUAGE || '').trim()
const OUT = resolve(process.cwd(), 'public/data/bundle.json')
const MAX_DAYS = 180

/* ---------------- 日期 / 格式化（与 server/utils/date.ts 保持一致） ---------------- */
function dayKeyOf(date = new Date(), timeZone = TZ) {
  const fmt = new Intl.DateTimeFormat('en-CA', {
    timeZone, year: 'numeric', month: '2-digit', day: '2-digit'
  })
  const parts = fmt.formatToParts(date)
  const get = (t) => parts.find((p) => p.type === t)?.value ?? ''
  return `${get('year')}-${get('month')}-${get('day')}`
}
function humanDay(key) {
  const d = new Date(`${key}T12:00:00Z`)
  const weekday = new Intl.DateTimeFormat('zh-CN', { timeZone: TZ, weekday: 'short' }).format(d)
  const [y, m, dd] = key.split('-')
  return `${y}年${Number(m)}月${Number(dd)}日 ${weekday}`
}
function relativeTime(from, now = Date.now()) {
  const t = typeof from === 'number' ? from : new Date(from).getTime()
  const diff = Math.max(0, now - t)
  const min = Math.floor(diff / 60000)
  if (min < 1) return '刚刚'
  if (min < 60) return `${min} 分钟前`
  const h = Math.floor(min / 60)
  if (h < 24) return `${h} 小时前`
  return `${Math.floor(h / 24)} 天前`
}

/* ---------------- HTML 解析（与 server/utils/trending.ts 保持一致） ---------------- */
const BASE = 'https://github.com'
const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'

function toNumber(raw) {
  if (!raw) return 0
  const cleaned = String(raw).replace(/,/g, '').replace(/\s+/g, '')
  const m = cleaned.match(/([\d.]+)\s*([kmKM]?)/)
  if (!m) return 0
  let n = Number.parseFloat(m[1] ?? '')
  if (!Number.isFinite(n)) return 0
  const unit = (m[2] || '').toLowerCase()
  if (unit === 'k') n *= 1000
  if (unit === 'm') n *= 1000000
  return Math.round(n)
}
function parseTodayStars(text) {
  const t = (text || '').replace(/\s+/g, ' ').trim()
  if (!t) return 0
  const m = t.match(/([\d.,]+\s*[kmKM]?)\s*stars?\s+(today|this week|this month)/i)
  if (m) return toNumber(m[1])
  const fallback = t.match(/([\d.,]+)/)
  return fallback ? toNumber(fallback[1]) : 0
}
function parseLangColor(style) {
  if (!style) return '#8b949e'
  const m = style.match(/#([0-9a-fA-F]{3,8})/)
  return m ? `#${m[1]}` : '#8b949e'
}
function parseTrendingHtml(html) {
  const $ = load(html)
  const out = []
  const seen = new Set()
  $('article.Box-row').each((_i, el) => {
    const $row = $(el)
    const href = $row.find('h2 a').first().attr('href') || ''
    const path = href.trim().replace(/^\/+/, '')
    if (!path || !path.includes('/')) return
    const parts = path.split('/')
    if (parts.length < 2) return
    const owner = parts[0] ?? ''
    const name = parts[1] ?? ''
    const repoKey = `${owner}/${name}`.toLowerCase()
    if (seen.has(repoKey)) return
    seen.add(repoKey)
    const description = $row.find('p').first().text().replace(/\s+/g, ' ').trim()
    const language = $row.find('[itemprop="programmingLanguage"]').first().text().trim()
    const languageColor = parseLangColor($row.find('.repo-language-color').first().attr('style'))
    const totalStars = toNumber($row.find('a[href$="/stargazers"]').first().text().trim())
    const forks = toNumber($row.find('a[href$="/forks"]').first().text().trim())
    let todayText = $row.find('span.d-inline-block.float-sm-right').first().text().trim()
    if (!todayText) {
      const rowText = $row.text().replace(/\s+/g, ' ')
      const m = rowText.match(/[\d.,]+\s*[kmKM]?\s*stars?\s+(today|this week|this month)/i)
      todayText = m ? m[0] : ''
    }
    out.push({
      repoKey,
      owner,
      name,
      fullName: `${owner}/${name}`,
      url: `${BASE}/${owner}/${name}`,
      description,
      language: language || 'Unknown',
      languageColor,
      totalStars,
      forks,
      todayStars: parseTodayStars(todayText)
    })
  })
  return out
}

async function fetchPeriod(period) {
  const url = new URL(LANGUAGE ? `${BASE}/trending/${encodeURIComponent(LANGUAGE)}` : `${BASE}/trending`)
  url.searchParams.set('since', period)
  const res = await fetch(url.toString(), {
    headers: {
      'User-Agent': UA,
      Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9,zh-CN;q=0.8',
      'Cache-Control': 'no-cache'
    },
    redirect: 'follow',
    signal: AbortSignal.timeout(20000)
  })
  if (!res.ok) throw new Error(`HTTP ${res.status} ${period}`)
  const repos = parseTrendingHtml(await res.text())
  if (!repos.length) throw new Error(`未解析到仓库（${period}，结构可能变化）`)
  return repos
}

/* ---------------- 合并与构建 ---------------- */
function toView(r) {
  return {
    rank: r.rank ?? null,
    owner: r.owner,
    name: r.name,
    fullName: r.fullName,
    url: r.url,
    description: r.description || '',
    language: r.language || 'Unknown',
    languageColor: r.languageColor || '#8b949e',
    totalStars: r.totalStars ?? 0,
    forks: r.forks ?? 0,
    todayStars: r.todayStars ?? 0,
    bucket: r.bucket ?? 0,
    dropped: Boolean(r.dropped),
    firstSeenAt: r.firstSeenAt || null,
    lastSeenAt: r.lastSeenAt || null
  }
}

function buildResponse(date, period, items, dayOptions) {
  const topCount = items.filter((d) => d.bucket === 0).length
  const droppedCount = items.filter((d) => d.dropped).length
  const totalTodayStars = items.reduce((s, d) => s + (d.todayStars || 0), 0)
  const latest = items.reduce((m, d) => Math.max(m, d.lastSeenAt ? new Date(d.lastSeenAt).getTime() : 0), 0)
  return {
    date,
    period,
    humanDate: humanDay(date),
    isToday: date === dayKeyOf(),
    page: 1,
    pageSize: PAGE_SIZE,
    total: items.length,
    totalPages: Math.max(1, Math.ceil(items.length / PAGE_SIZE)),
    updatedAt: latest ? new Date(latest).toISOString() : null,
    updatedAgo: latest ? relativeTime(latest) : '暂无数据',
    topN: TOP_N,
    items: items.map(toView),
    days: dayOptions,
    stats: { tracked: items.length, topCount, droppedCount, totalTodayStars }
  }
}

async function main() {
  const today = dayKeyOf()
  const nowIso = new Date().toISOString()

  // 读取已有数据（保留历史 + 掉榜）
  let bundle = { generatedAt: null, meta: {}, days: [] }
  if (existsSync(OUT)) {
    try {
      const parsed = JSON.parse(readFileSync(OUT, 'utf8'))
      if (Array.isArray(parsed.days)) bundle = parsed
    } catch {
      console.warn('[gen] 现有 bundle.json 解析失败，重新开始')
    }
  }

  let day = bundle.days.find((d) => d.date === today)
  if (!day) {
    day = { date: today, humanDate: humanDay(today), periods: {} }
    bundle.days.unshift(day)
  }
  day.humanDate = humanDay(today)

  const periods = ['daily', 'weekly', 'monthly']
  for (const period of periods) {
    let fresh
    try {
      fresh = await fetchPeriod(period)
      console.log(`[gen] ${period}: 抓到 ${fresh.length} 个仓库`)
    } catch (err) {
      if (day.periods[period]) {
        console.warn(`[gen] ${period} 抓取失败，沿用旧数据：${err.message}`)
        continue
      }
      throw err
    }

    const prev = day.periods[period]?.items ?? []
    const prevMap = new Map(prev.map((r) => [`${r.owner}/${r.name}`.toLowerCase(), r]))
    const incoming = new Set(fresh.map((r) => r.repoKey))

    const items = fresh.map((r, i) => {
      const p = prevMap.get(r.repoKey)
      return {
        ...r,
        rank: i + 1,
        bucket: i + 1 <= TOP_N ? 0 : 1,
        dropped: false,
        firstSeenAt: p?.firstSeenAt || nowIso,
        lastSeenAt: nowIso
      }
    })

    // 本次没抓到但库里有的 → 保留并标记掉榜
    for (const p of prev) {
      const key = `${p.owner}/${p.name}`.toLowerCase()
      if (incoming.has(key) || p.dropped) continue
      items.push({ ...p, bucket: 2, rank: null, dropped: true, lastSeenAt: p.lastSeenAt || nowIso })
    }

    items.sort((a, b) => {
      const ab = a.bucket - b.bucket
      if (ab) return ab
      const ar = a.rank ?? 1e9
      const br = b.rank ?? 1e9
      if (ar !== br) return ar - br
      return (b.todayStars || 0) - (a.todayStars || 0)
    })

    day.periods[period] = { __items: items }
  }

  // 日期选项（所有有数据的日期）
  const dayOptions = bundle.days.map((d) => ({
    date: d.date,
    count: Math.max(
      ...periods.map((p) => d.periods[p]?.__items?.length ?? d.periods[p]?.items?.length ?? 0)
    ),
    isToday: d.date === today
  }))

  // 把内部 __items 转成最终 response；已有日期刷新 days / isToday 元信息
  for (const d of bundle.days) {
    d.isToday = d.date === today
    for (const period of periods) {
      const raw = d.periods[period]
      if (!raw) continue
      if (raw.__items) {
        d.periods[period] = buildResponse(d.date, period, raw.__items, dayOptions)
      } else {
        raw.days = dayOptions
        raw.isToday = d.date === today
      }
    }
  }

  bundle.days = bundle.days.slice(0, MAX_DAYS)
  bundle.generatedAt = nowIso
  bundle.meta = { topN: TOP_N, pageSize: PAGE_SIZE, intervalMinutes: INTERVAL, timezone: TZ, language: LANGUAGE || '全部', today }

  if (process.env.DRY_RUN === '1') {
    console.log(`[gen] DRY_RUN，共 ${bundle.days.length} 天，最新 ${bundle.days[0]?.date}`)
    return
  }

  mkdirSync(dirname(OUT), { recursive: true })
  writeFileSync(OUT, JSON.stringify(bundle))
  const bytes = Buffer.byteLength(JSON.stringify(bundle))
  console.log(`[gen] ✓ 写入 ${OUT}（${(bytes / 1024).toFixed(1)}KB，${bundle.days.length} 天）`)
}

main().catch((err) => {
  console.error('[gen] 生成失败：', err instanceof Error ? err.message : err)
  process.exit(1)
})
