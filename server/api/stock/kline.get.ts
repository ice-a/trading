/**
 * GET /api/stock/kline?secid=1.600519&period=day|week|month&limit=120
 *
 * 点进某只股票后的 K 线数据。secid 由搜索接口给出（如 1.600519 / 116.00700 / 105.AAPL）。
 * 同时返回最新报价，前端可省一次请求。
 */
import { withDbCache } from '../../utils/cache'
import { fetchKline, fetchQuote } from '../../utils/stock'

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const secid = String(q.secid || '').trim()
  const periodRaw = String(q.period || 'day').toLowerCase()
  const period = (['day', 'week', 'month'].includes(periodRaw) ? periodRaw : 'day') as 'day' | 'week' | 'month'
  const limit = Math.min(Math.max(Number(q.limit) || 120, 20), 400)

  if (!secid) {
    setResponseStatus(event, 400)
    return { ok: false, error: '缺少 secid' }
  }

  setHeader(event, 'Cache-Control', 'public, max-age=120, stale-while-revalidate=600')

  try {
    return await withDbCache(`stock:kline:${secid}:${period}:${limit}`, 5 * 60_000, async () => {
      const [points, quote] = await Promise.all([fetchKline(secid, period, limit), fetchQuote(secid)])

      if (!points.length && !quote) {
        return { ok: false, secid, period, points: [], quote: null, error: '该标的暂无数据' }
      }

      return {
        ok: true,
        secid,
        period,
        quote,
        points,
        // 简单统计，前端画图可以直接用
        summary: points.length
          ? {
              first: points[0]?.close ?? 0,
              last: points[points.length - 1]?.close ?? 0,
              high: Math.max(...points.map((p) => p.high)),
              low: Math.min(...points.map((p) => p.low))
            }
          : null
      }
    })
  } catch (err) {
    setResponseStatus(event, 502)
    return { ok: false, error: err instanceof Error ? err.message : String(err), points: [], quote: null }
  }
})