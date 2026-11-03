/**
 * GET /api/stock/list?market=hk|us —— 港股 / 美股热门。
 *
 * 上游的 clist / ulist 批量接口对港美股返回空，只有单只 stock/get 可用，
 * 所以这里用固定候选池并发查询（10 只，约 300~800ms）。
 */
import { withDbCache } from '../../utils/cache'
import { fetchQuotes, HK_HOT, US_HOT } from '../../utils/stock'

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const market = String(q.market || 'hk').toLowerCase() === 'us' ? 'US' : 'HK'

  setHeader(event, 'Cache-Control', 'public, max-age=60, stale-while-revalidate=300')

  // 3 分钟：报价变化快，但热门榜不需要秒级；与 K 线里的报价缓存分开（后者 30 秒）
  return withDbCache(`stock:list:${market}`, 3 * 60_000, async () => {
    const pool = market === 'HK' ? HK_HOT : US_HOT
    const items = await fetchQuotes(pool.map((symbol) => ({ symbol, market })))
    return { market, items, total: items.length, updatedAt: new Date().toISOString() }
  })
})