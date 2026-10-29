/**
 * GET /api/github-search?q=关键词&sort=stars&order=desc&page=1&perPage=30
 *
 * GitHub 全站仓库搜索（Search API）。
 *
 * 配额策略（按优先级）：
 *   1. 用户在页面里填的自己的 token（请求头 x-github-token）→ 用他的配额，30 次/分钟
 *   2. 服务端环境变量 GITHUB_TOKEN                          → 共用配额，30 次/分钟
 *   3. 都没有                                              → 匿名，10 次/分钟
 *
 * 限流时**不直接报错**，而是按 x-ratelimit-reset 等待后重试（所有人一起等）。
 * 但 Serverless 函数最长 10s，所以最多等 ~8s，超时才返回提示。
 *
 * 安全：用户的 token 只在本次请求里用，不落库、不写日志。
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
}

interface SearchResponse {
  total_count: number
  incomplete_results?: boolean
  items?: SearchRepo[]
}

const MAX_WAIT_MS = 4000
const MAX_ATTEMPTS = 3

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms))

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const keyword = String(q.q || '').trim()
  const sort = ['stars', 'forks', 'updated'].includes(String(q.sort)) ? String(q.sort) : 'stars'
  const order = String(q.order) === 'asc' ? 'asc' : 'desc'
  const page = Math.max(1, Number(q.page) || 1)
  const perPage = Math.min(Math.max(Number(q.perPage) || 30, 1), 50)

  if (!keyword) {
    setResponseStatus(event, 400)
    return { ok: false, error: '请输入搜索关键词', total: 0, items: [] }
  }

  // 用户自带的 token 优先（页面输入框填的那个）
  const userToken = String(getHeader(event, 'x-github-token') || '').trim()
  const serverToken = String(process.env.GITHUB_TOKEN || '').trim()
  let token = userToken || serverToken
  let tokenSource: 'user' | 'server' | 'anonymous' = userToken ? 'user' : serverToken ? 'server' : 'anonymous'

  setHeader(event, 'Cache-Control', 'public, max-age=120, stale-while-revalidate=600')

  // 结果与 token 无关，共用同一份缓存
  return withCache(`gh-search:${keyword}:${sort}:${order}:${page}:${perPage}`, 5 * 60_000, async () => {
    const url =
      'https://api.github.com/search/repositories?q=' +
      encodeURIComponent(keyword) +
      `&sort=${sort}&order=${order}&page=${page}&per_page=${perPage}`

    const headers: Record<string, string> = {
      Accept: 'application/vnd.github+json',
      'User-Agent': 'liaowangtai/1.0'
    }
    const applyAuth = () => {
      if (token) headers.Authorization = `Bearer ${token}`
      else delete headers.Authorization
    }
    applyAuth()

    let lastRes: Response | null = null
    let waited = 0

    for (let attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
      try {
        const res = await httpFetch(url, {
          headers,
          redirect: 'follow',
          signal: AbortSignal.timeout(12_000)
        })

        if (res.ok) {
          const json = (await res.json()) as SearchResponse
          const items = (json.items ?? []).filter((r) => !r.archived)
          return {
            ok: true,
            error: null,
            keyword,
            total: json.total_count ?? 0,
            page,
            perPage,
            tokenSource,
            waitedMs: waited,
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
        }

        lastRes = res

        // 用户填的 token 无效（401/403）→ 降级到服务端 token 或匿名，再试一次
        if ((res.status === 401 || res.status === 403) && tokenSource === 'user') {
          token = serverToken
          tokenSource = serverToken ? 'server' : 'anonymous'
          applyAuth()
          if (attempt < MAX_ATTEMPTS) {
            await sleep(300)
            continue
          }
        }

        const isRateLimit = res.status === 403 || res.status === 429
        if (!isRateLimit) {
          return {
            ok: false,
            error: `GitHub 返回 HTTP ${res.status}`,
            total: 0,
            keyword,
            items: [],
            tokenSource
          }
        }

        if (attempt === MAX_ATTEMPTS) break

        // 按 x-ratelimit-reset 算要等多久，封顶 MAX_WAIT_MS
        const resetSec = Number(res.headers.get('x-ratelimit-reset') || 0)
        const untilReset = resetSec ? resetSec * 1000 - Date.now() : 0
        const waitMs = Math.min(Math.max(untilReset, 1200), MAX_WAIT_MS)

        waited += waitMs
        await sleep(waitMs)
      } catch (err) {
        if (attempt === MAX_ATTEMPTS) {
          return {
            ok: false,
            error: err instanceof Error ? err.message : String(err),
            total: 0,
            keyword,
            items: [],
            tokenSource
          }
        }
        await sleep(1200)
        waited += 1200
      }
    }

    const resetSec = Number(lastRes?.headers.get('x-ratelimit-reset') || 0)
    const resetIn = resetSec ? Math.max(0, Math.round((resetSec * 1000 - Date.now()) / 1000)) : null

    return {
      ok: false,
      error: token
        ? 'GitHub 搜索配额已用尽，稍后再试'
        : 'GitHub 匿名搜索配额已用尽（10 次/分钟）。填入自己的 GitHub Token 可提升到 30 次/分钟，或稍后再试',
      total: 0,
      keyword,
      items: [],
      tokenSource,
      waitedMs: waited,
      resetIn
    }
  })
})
