/**
 * GET /api/github-search?q=关键词&sort=stars&order=desc&page=1&perPage=30
 *
 * GitHub 全站仓库搜索（Search API）。
 *
 * 注意限流：
 *   · 未配置 GITHUB_TOKEN → 10 次/分钟
 *   · 配置了 → 30 次/分钟
 * 所以这里做了 5 分钟缓存，同一关键词短时间内重复搜索不会再打上游。
 */
interface SearchRepo {
  full_name: string
  name: string
  owner: { login: string; avatar_url: string }
  html_url: string
  description: string | null
  language: string | null
  stargazers_count: number
  forks_count: number
  pushed_at: string
  updated_at: string
  topics?: string[]
  archived?: boolean
  fork?: boolean
  open_issues_count?: number
}

interface SearchResponse {
  total_count: number
  incomplete_results?: boolean
  items?: SearchRepo[]
}

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const keyword = String(q.q || '').trim()
  const sort = ['stars', 'forks', 'updated', 'help-wanted-issues'].includes(String(q.sort))
    ? String(q.sort)
    : 'stars'
  const order = String(q.order) === 'asc' ? 'asc' : 'desc'
  const page = Math.max(1, Number(q.page) || 1)
  const perPage = Math.min(Math.max(Number(q.perPage) || 30, 1), 50)

  if (!keyword) {
    setResponseStatus(event, 400)
    return { ok: false, error: '请输入搜索关键词', total: 0, items: [] }
  }

  setHeader(event, 'Cache-Control', 'public, max-age=120, stale-while-revalidate=600')

  return withCache(`gh-search:${keyword}:${sort}:${order}:${page}:${perPage}`, 5 * 60_000, async () => {
    const headers: Record<string, string> = {
      Accept: 'application/vnd.github+json',
      'User-Agent': 'liaowangtai/1.0'
    }
    const token = process.env.GITHUB_TOKEN
    if (token) headers.Authorization = `Bearer ${token}`

    const url =
      'https://api.github.com/search/repositories?q=' +
      encodeURIComponent(keyword) +
      `&sort=${sort}&order=${order}&page=${page}&per_page=${perPage}`

    try {
      const res = await httpFetch(url, {
        headers,
        redirect: 'follow',
        signal: AbortSignal.timeout(15_000)
      })

      if (res.status === 403 || res.status === 429) {
        return {
          ok: false,
          error: 'GitHub 搜索接口已达限流上限，请稍后再试（或配置 GITHUB_TOKEN 提高配额）',
          total: 0,
          keyword,
          items: []
        }
      }

      if (!res.ok) {
        return { ok: false, error: `GitHub 返回 HTTP ${res.status}`, total: 0, keyword, items: [] }
      }

      const json = (await res.json()) as SearchResponse
      const items = (json.items ?? []).filter((r) => !r.archived)

      return {
        ok: true,
        error: null,
        keyword,
        total: json.total_count ?? 0,
        page,
        perPage,
        incomplete: Boolean(json.incomplete_results),
        items: items.map((r) => {
          const owner = r.owner?.login || r.full_name.split('/')[0] || ''
          const name = r.name || r.full_name.split('/')[1] || ''
          return {
            name,
            fullName: `${owner}/${name}`,
            url: r.html_url,
            desc: r.description || '',
            language: r.language || '',
            stars: r.stargazers_count ?? 0,
            forks: r.forks_count ?? 0,
            fork: Boolean(r.fork),
            pushedAt: r.pushed_at || r.updated_at || '',
            topics: (r.topics || []).slice(0, 4)
          }
        })
      }
    } catch (err) {
      return {
        ok: false,
        error: err instanceof Error ? err.message : String(err),
        total: 0,
        keyword,
        items: []
      }
    }
  })
})
