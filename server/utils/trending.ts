import * as cheerio from 'cheerio'
import type { ParsedRepo } from './types'
import { httpFetch } from './http'

/**
 * GitHub Trending 抓取 + 解析。
 *
 * 数据来源：https://github.com/trending（HTML 页面，无需 token）
 * 解析字段：仓库全名、简介、语言+语言色、总 Star、Fork、今日新增 Star、榜内名次。
 */

const BASE = 'https://github.com'

const HEADERS: Record<string, string> = {
  'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
  Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language': 'en-US,en;q=0.9,zh-CN;q=0.8',
  'Cache-Control': 'no-cache',
  Pragma: 'no-cache'
}

export interface FetchOptions {
  since?: 'daily' | 'weekly' | 'monthly'
  language?: string
  timeoutMs?: number
  retries?: number
}

/** "36,600" / "36.6k" / "1.2m" → 数字 */
export function toNumber(raw: string | undefined | null): number {
  if (!raw) return 0
  const cleaned = String(raw).replace(/,/g, '').replace(/\s+/g, '')
  const m = cleaned.match(/([\d.]+)\s*([kmKM]?)/)
  if (!m) return 0
  let n = Number.parseFloat(m[1])
  if (!Number.isFinite(n)) return 0
  const unit = (m[2] || '').toLowerCase()
  if (unit === 'k') n *= 1_000
  if (unit === 'm') n *= 1_000_000
  return Math.round(n)
}

/** 从 "2,244 stars today" 里抠出增长数 */
function parseTodayStars(text: string): number {
  const t = (text || '').replace(/\s+/g, ' ').trim()
  if (!t) return 0
  const m = t.match(/([\d.,]+\s*[kmKM]?)\s*stars?\s+(today|this week|this month)/i)
  if (m) return toNumber(m[1])
  const fallback = t.match(/([\d.,]+)/)
  return fallback ? toNumber(fallback[1]) : 0
}

/** 从 style="background-color: #3178c6" 里拿语言色 */
function parseLangColor(style: string | undefined): string {
  if (!style) return '#8b949e'
  const m = style.match(/#([0-9a-fA-F]{3,8})/)
  return m ? `#${m[1]}` : '#8b949e'
}

export function buildTrendingUrl(opts: FetchOptions = {}): string {
  const since = opts.since ?? 'daily'
  const lang = (opts.language || '').trim().replace(/^\/+|\/+$/g, '')
  const path = lang ? `${BASE}/trending/${encodeURIComponent(lang)}` : `${BASE}/trending`
  const url = new URL(path)
  url.searchParams.set('since', since)
  return url.toString()
}

/** 核心解析：把 trending 页面 HTML 变成结构化数组（返回顺序即榜内名次） */
export function parseTrendingHtml(html: string): ParsedRepo[] {
  const $ = cheerio.load(html)
  const out: ParsedRepo[] = []
  const seen = new Set<string>()

  $('article.Box-row').each((_i, el) => {
    const $row = $(el)

    // --- 仓库名 / 链接 ---
    const href = $row.find('h2 a').first().attr('href') || ''
    const path = href.trim().replace(/^\/+/, '')
    if (!path || !path.includes('/')) return
    const parts = path.split('/')
    if (parts.length < 2) return
    const owner = parts[0]
    const name = parts[1]
    const repoKey = `${owner}/${name}`.toLowerCase()
    if (seen.has(repoKey)) return
    seen.add(repoKey)

    // --- 简介 ---
    const description = $row
      .find('p')
      .first()
      .text()
      .replace(/\s+/g, ' ')
      .trim()

    // --- 语言与颜色 ---
    const language = $row.find('[itemprop="programmingLanguage"]').first().text().trim()
    const languageColor = parseLangColor($row.find('.repo-language-color').first().attr('style'))

    // --- 总 Star / Fork ---
    const starsText = $row.find('a[href$="/stargazers"]').first().text().trim()
    const forksText = $row.find('a[href$="/forks"]').first().text().trim()
    const totalStars = toNumber(starsText)
    const forks = toNumber(forksText)

    // --- 今日新增 ---
    let todayText = $row.find('span.d-inline-block.float-sm-right').first().text().trim()
    if (!todayText) {
      // 兜底：结构改版时，直接扫整行文本里的 "N stars today"
      const rowText = $row.text().replace(/\s+/g, ' ')
      const m = rowText.match(/[\d.,]+\s*[kmKM]?\s*stars?\s+(today|this week|this month)/i)
      todayText = m ? m[0] : ''
    }
    const todayStars = parseTodayStars(todayText)

    out.push({
      owner,
      name,
      repoKey,
      fullName: `${owner}/${name}`,
      url: `${BASE}/${owner}/${name}`,
      description,
      language: language || 'Unknown',
      languageColor,
      totalStars,
      forks,
      todayStars,
      rank: out.length + 1
    })
  })

  return out
}

/** 带重试与超时的抓取 */
export async function fetchTrendingRepos(opts: FetchOptions = {}): Promise<ParsedRepo[]> {
  const url = buildTrendingUrl(opts)
  const timeoutMs = opts.timeoutMs ?? 20_000
  const retries = opts.retries ?? 2
  let lastErr: unknown = null

  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await httpFetch(url, {
        headers: HEADERS,
        redirect: 'follow',
        signal: AbortSignal.timeout(timeoutMs)
      })

      if (!res.ok) {
        throw new Error(`GitHub Trending 返回 HTTP ${res.status} ${res.statusText}`)
      }

      const html = await res.text()
      const repos = parseTrendingHtml(html)

      if (repos.length === 0) {
        // 页面结构变化或被风控页拦截
        throw new Error('未解析到任何仓库（页面结构可能变化或被限流）')
      }

      return repos
    } catch (err) {
      lastErr = err
      if (attempt < retries) {
        await new Promise((r) => setTimeout(r, 800 * (attempt + 1)))
      }
    }
  }

  throw new Error(
    `抓取 GitHub Trending 失败：${lastErr instanceof Error ? lastErr.message : String(lastErr)}`
  )
}
