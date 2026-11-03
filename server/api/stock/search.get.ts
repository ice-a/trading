/**
 * GET /api/stock/search?q=xxx&count=10
 *
 * 统一搜索：A股 / 港股 / 美股 / 国内基金 / 指数。
 * 带 ?user= 时顺手记一条搜索历史（供"热门搜索"用）。
 */
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

  setHeader(event, 'Cache-Control', 'public, max-age=120, stale-while-revalidate=600')

  try {
    const items = await searchSecurities(keyword, count)

    // 搜索历史：只记有 user 的请求，失败不影响主流程
    if (user) await saveSearchHistory(user, keyword).catch(() => void 0)

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
      }
    }
  } catch (err) {
    setResponseStatus(event, 502)
    return {
      ok: false,
      error: err instanceof Error ? err.message : String(err),
      items: []
    }
  }
})