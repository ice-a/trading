import { listCreators } from '../utils/site'

/**
 * GET /api/creators —— 热门 GitHub 用户
 *
 * 名单来自 MongoDB（github_creators），头像是 GitHub 的公开头像地址，不需要 API Token。
 */
export default defineEventHandler(async (event) => {
  setHeader(event, 'Cache-Control', 'public, max-age=300, stale-while-revalidate=600')

  return withCache('creators', 10 * 60_000, async () => {
    const creators = await listCreators()
    return {
      total: creators.length,
      items: creators.map((c) => ({
        login: c.login,
        note: c.note || '',
        avatar: c.avatar || `https://github.com/${encodeURIComponent(c.login)}.png?size=160`,
        url: `https://github.com/${encodeURIComponent(c.login)}`
      }))
    }
  })
})
