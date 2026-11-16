/**
 * GitHub API 直连客户端 —— 静态站没有后端代理，浏览器直接打 GitHub 官方 API。
 *
 * 配额：匿名 60 次/小时（repos）、10 次/分钟（search）；
 *       用户在页面里填的 token 存 localStorage，只在本次请求里带上（不落库、不写日志）。
 */

export interface GithubRepoView {
  name: string
  fullName: string
  url: string
  desc: string
  language: string
  stars: number
  forks: number
  fork: boolean
  pushedAt: string
  topics: string[]
}

export interface ReposResponse {
  user: string
  total: number
  error: string | null
  items: GithubRepoView[]
}

export interface SearchResult {
  ok: boolean
  error: string | null
  keyword: string
  total: number
  items: GithubRepoView[]
}

interface RawRepo {
  name: string
  full_name: string
  html_url: string
  description: string | null
  language: string | null
  stargazers_count: number
  forks_count: number
  fork: boolean
  archived: boolean
  pushed_at: string
  updated_at: string
  topics?: string[]
}

function toView(r: RawRepo): GithubRepoView {
  return {
    name: r.name,
    fullName: r.full_name,
    url: r.html_url,
    desc: r.description || '',
    language: r.language || '',
    stars: r.stargazers_count ?? 0,
    forks: r.forks_count ?? 0,
    fork: Boolean(r.fork),
    pushedAt: r.pushed_at || r.updated_at || '',
    topics: (r.topics || []).slice(0, 4)
  }
}

function authHeaders(token: string): Record<string, string> {
  const headers: Record<string, string> = {
    Accept: 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28'
  }
  if (token) headers.Authorization = `Bearer ${token}`
  return headers
}

/** 用户公开仓库 */
export async function fetchUserRepos(user: string, sort: string, token = ''): Promise<ReposResponse> {
  let error: string | null = null
  let list: GithubRepoView[] = []
  try {
    const res = await $fetch<RawRepo[]>(
      `https://api.github.com/users/${encodeURIComponent(user)}/repos`,
      {
        query: { per_page: 100, sort },
        headers: authHeaders(token),
        timeout: 15000
      }
    )
    list = res.filter((r) => !r.archived).map(toView)
  } catch (err) {
    error = err instanceof Error ? err.message : String(err)
    if (/403|429|rate limit/i.test(error)) {
      error = 'GitHub API 已达限流上限（匿名 60 次/小时）。建议在上方填入自己的 Token。'
    }
  }
  return { user, total: list.length, error, items: list }
}

/** 全站仓库搜索 */
export async function searchRepos(keyword: string, token = ''): Promise<SearchResult> {
  try {
    const json = await $fetch<{ total_count: number; items?: RawRepo[] }>(
      'https://api.github.com/search/repositories',
      {
        query: { q: keyword, sort: 'stars', order: 'desc', per_page: 30 },
        headers: authHeaders(token),
        timeout: 15000
      }
    )
    const items = (json.items ?? []).filter((r) => !r.archived).map(toView)
    return { ok: true, error: null, keyword, total: json.total_count ?? 0, items }
  } catch (err) {
    let message = err instanceof Error ? err.message : String(err)
    if (/403|429|rate limit/i.test(message)) {
      message = 'GitHub 搜索配额已用尽（匿名 10 次/分钟）。填入自己的 Token 可提升到 30 次/分钟。'
    }
    return { ok: false, error: message, keyword, total: 0, items: [] }
  }
}
