/**
 * GET /api/repos?user=ice-a&sort=pushed&q=keyword
 *
 * 拉取某个 GitHub 用户的公开仓库。
 * 没有 Token 时 GitHub 限流 60 次/小时，所以这里加了 10 分钟缓存；
 * 如果配置了 GITHUB_TOKEN 环境变量，会自动带上以提高配额。
 */
interface GithubRepo {
  name: string
  full_name: string
  html_url: string
  description: string | null
  language: string | null
  stargazers_count: number
  forks_count: number
  updated_at: string
  pushed_at: string
  fork: boolean
  archived: boolean
  topics?: string[]
}

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const user = String(q.user || 'ice-a').trim()
  const keyword = String(q.q || '').trim().toLowerCase()
  const sort = ['pushed', 'updated', 'stars', 'name'].includes(String(q.sort)) ? String(q.sort) : 'pushed'

  setHeader(event, 'Cache-Control', 'public, max-age=300, stale-while-revalidate=600')

  return withCache(`repos:${user}:${sort}`, 10 * 60_000, async () => {
    const headers: Record<string, string> = {
      Accept: 'application/vnd.github+json',
      'User-Agent': 'github-trending-daily'
    }
    const token = process.env.GITHUB_TOKEN
    if (token) headers.Authorization = `Bearer ${token}`

    let repos: GithubRepo[] = []
    let error: string | null = null

    try {
      const res = await httpFetch(
        `https://api.github.com/users/${encodeURIComponent(user)}/repos?per_page=100&sort=${sort}`,
        { headers } as RequestInit
      )
      if (res.ok) {
        repos = (await res.json()) as GithubRepo[]
      } else if (res.status === 403 || res.status === 429) {
        error = 'GitHub API 已达限流上限，请配置 GITHUB_TOKEN 或稍后再试'
      } else {
        error = `GitHub API 返回 ${res.status}`
      }
    } catch (err) {
      error = err instanceof Error ? err.message : String(err)
    }

    let list = repos.filter((r) => !r.archived)

    if (keyword) {
      list = list.filter(
        (r) =>
          r.name.toLowerCase().includes(keyword) ||
          (r.description || '').toLowerCase().includes(keyword) ||
          (r.language || '').toLowerCase().includes(keyword) ||
          (r.topics || []).some((t) => t.toLowerCase().includes(keyword))
      )
    }

    if (sort === 'stars') list = [...list].sort((a, b) => b.stargazers_count - a.stargazers_count)

    return {
      user,
      total: list.length,
      error,
      items: list.map((r) => ({
        name: r.name,
        fullName: r.full_name,
        url: r.html_url,
        desc: r.description || '',
        language: r.language || '',
        stars: r.stargazers_count,
        forks: r.forks_count,
        fork: r.fork,
        pushedAt: r.pushed_at,
        topics: (r.topics || []).slice(0, 4)
      }))
    }
  })
})
