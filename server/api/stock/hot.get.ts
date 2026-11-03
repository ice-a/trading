/**
 * GET /api/stock/hot —— 首页概览：A股涨幅榜 + 行业板块。
 *
 * 港美股热门由 /api/stock/list?market=hk|us 单独拉，避免一次请求串行查 20 只。
 */
import { withDbCache } from '../../utils/cache'
import { fetchGainers, fetchSectors } from '../../utils/stock'

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const limit = Math.min(Math.max(Number(q.limit) || 10, 5), 20)

  setHeader(event, 'Cache-Control', 'public, max-age=60, stale-while-revalidate=300')

  /**
   * 两块内容变化频率不同，但一次请求拿两样，取较短的那个：
   *   板块    —— 日内变化慢，5 分钟足够
   *   涨幅榜 —— 变化快，2 分钟
   * 合并 TTL 取 2 分钟，既保证涨幅榜不失真，也避免每次刷新都打上游。
   */
  return withDbCache(`stock:hot:${limit}`, 2 * 60_000, async () => {
    const [gainers, sectors] = await Promise.allSettled([fetchGainers(limit), fetchSectors(limit)])

    return {
      gainers: gainers.status === 'fulfilled' ? gainers.value : [],
      gainersError: gainers.status === 'rejected' ? String(gainers.reason) : null,
      sectors: sectors.status === 'fulfilled' ? sectors.value : [],
      sectorsError: sectors.status === 'rejected' ? String(sectors.reason) : null,
      updatedAt: new Date().toISOString()
    }
  })
})