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
/**
 * GitHub Search API 兜底。
 *
 * GitHub 官方**没有** Trending API（`GET /trending` 是 404），Trending 页面上那个
 * 「N stars today」是它自家算法算的，Search API 拿不到。
 * 所以正常路径永远是解析 Trending 页面；只有页面抓取失败（结构变更 / 被限流 / 超时）时，
 * 才用 Search API 拿「最近 N 天创建 + star 最多」的仓库顶上，保证榜单不至于空白。
 *
 * 注意：兜底数据没有「今日新增」，todayStars 会是 0，页面上显示为 0 而不是真实增量。
 */
interface SearchRepo {
  full_name: string
  name: string
  owner: { login: string }
  html_url: string
  description: string | null
  language: string | null
  stargazers_count: number
  forks_count: number
}

async function fetchViaSearchApi(opts: FetchOptions = {}): Promise<ParsedRepo[]> {
  const since = opts.since ?? 'daily'
  // 无 Trending 页面时，用「最近创建」近似：日榜 7 天、周榜 14 天、月榜 45 天
  const days = since === 'weekly' ? 14 : since === 'monthly' ? 45 : 7
  const from = new Date(Date.now() - days * 86_400_000).toISOString().slice(0, 10)

  const lang = (opts.language || '').trim()
  const q = `created:>${from}${lang ? ` language:${lang}` : ''}`
  const url = `https://api.github.com/search/repositories?q=${encodeURIComponent(q)}&sort=stars&order=desc&per_page=25`

  const headers: Record<string, string> = {
    Accept: 'application/vnd.github+json',
    'User-Agent': 'liaowangtai/1.0'
  }
  const token = process.env.GITHUB_TOKEN
  if (token) headers.Authorization = `Bearer ${token}`

  const res = await httpFetch(url, {
    headers,
    redirect: 'follow',
    signal: AbortSignal.timeout(opts.timeoutMs ?? 15_000)
  })

  if (!res.ok) {
    throw new Error(`GitHub Search API 返回 HTTP ${res.status}`)
  }

  const json = (await res.json()) as { items?: SearchRepo[] }
  const items = json.items ?? []

  return items.map((r, i) => {
    const owner = r.owner?.login || r.full_name.split('/')[0] || ''
    const name = r.name || r.full_name.split('/')[1] || ''
    return {
      owner,
      name,
      repoKey: `${owner}/${name}`.toLowerCase(),
      fullName: `${owner}/${name}`,
      url: r.html_url,
      description: r.description || '',
      language: r.language || '',
      languageColor: '',
      totalStars: r.stargazers_count ?? 0,
      forks: r.forks_count ?? 0,
      // Search API 没有「今日新增」，兜底时置 0
      todayStars: 0,
      rank: i + 1
    }
  })
}

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

  // 页面路径彻底失败 → 走 Search API 兜底（官方接口，稳定但指标不同）
  try {
    const fallback = await fetchViaSearchApi(opts)
    if (fallback.length) {
      console.warn(
        `[trending] 页面抓取失败，已用 Search API 兜底（${fallback.length} 条，今日新增不可用）：` +
          (lastErr instanceof Error ? lastErr.message : String(lastErr))
      )
      return fallback
    }
  } catch (fallbackErr) {
    console.error('[trending] Search API 兜底也失败：', fallbackErr instanceof Error ? fallbackErr.message : String(fallbackErr))
  }

  throw new Error(
    `抓取 GitHub Trending 失败：${lastErr instanceof Error ? lastErr.message : String(lastErr)}`
  )
}
