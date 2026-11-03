/**
 * GET /api/stock/search?q=xxx&count=10
 *
 * 统一搜索：A股 / 港股 / 美股 / 国内基金 / 指数。
 *
 * 缓存策略：
 *   · 搜索结果本身是**公共内容**（同词同结果），落库缓存 10 分钟
 *   · 搜索历史是**私有内容**（按 user），永不缓存、写入时也跳过缓存
 *   · 命中缓存时不再打上游，也不重复写历史（历史只在冷路径写，但去重了幂等）
 */
import { withDbCache } from '../../utils/cache'
import { searchSecurities } from '../../utils/stock'
import { saveSearchHistory } from '../../utils/portfolio'

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const keyword = String(q.q || '').trim()
  const count = Math.min(Math.max(Number(q.count) || 10, 1), 30)
  const user = String(q.user || '').trim()

  if (!keyword) {
    setResponseStatus(event, 400)
    return { ok: false, error: '请输入关键词', items: [] }
  }

  setHeader(event, 'Cache-Control', 'public, max-age=300, stale-while-revalidate=900')

  try {
    const payload = await withDbCache(
      `stock:search:${keyword.toLowerCase()}:${count}`,
      10 * 60_000,
      async () => {
        const items = await searchSecurities(keyword, count)
        return {
          ok: true,
          keyword,
          total: items.length,
          items,
          // 前端据此决定：点击后是看 K 线还是看基金持仓
          groups: {
            stock: items.filter((i) => i.market === 'A' || i.market === 'HK' || i.market === 'US'),
            fund: items.filter((i) => i.market === 'FUND'),
            index: items.filter((i) => i.market === 'INDEX'),
            other: items.filter((i) => i.market === 'OTHER')
          },
          updatedAt: new Date().toISOString()
        }
      }
    )

    // 历史写入放在缓存之外：缓存命中时也要记（用户的确搜了这次），失败不影响主流程
    if (user) await saveSearchHistory(user, keyword).catch(() => void 0)

    return payload
  } catch (err) {
    setResponseStatus(event, 502)
    return {
      ok: false,
      error: err instanceof Error ? err.message : String(err),
      items: []
    }
  }
})