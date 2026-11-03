/**
 * GET /api/stock/kline?secid=1.600519&period=day|week|month&limit=120
 *
 * 点开某只股票后的 K 线数据。secid 由搜索接口给出（如 1.600519 / 116.00700 / 105.AAPL）。
 * 同时返回最新报价，前端可省一次请求。
 *
 * 缓存分两层，因为两者变化频率差一个数量级：
 *   · K 线（历史数据）：日线 10 分钟、周/月线 30 分钟（当天不会变几次）
 *   · 报价（实时价格）：30 秒，与 /api/stock/list 共用同一个 key，
 *     这样打开 K 线弹层不会额外打一次上游
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

  // 周/月线当天几乎不变，TTL 放宽
  const klineTtl = period === 'day' ? 10 * 60_000 : 30 * 60_000

  try {
    const [points, quote] = await Promise.all([
      withDbCache(`stock:kline:${secid}:${period}:${limit}`, klineTtl, () => fetchKline(secid, period, limit)),
      // 与 list 接口共用报价缓存键，避免同一只股票多打一次上游
      withDbCache(`stock:quote:${secid}`, 30_000, () => fetchQuote(secid))
    ])

    if (!points.length && !quote) {
      return { ok: false, secid, period, points: [], quote: null, error: '该标的暂无数据' }
    }

    return {
      ok: true,
      secid,
      period,
      quote,
      points,
      summary: points.length
        ? {
            first: points[0]?.close ?? 0,
            last: points[points.length - 1]?.close ?? 0,
            high: Math.max(...points.map((p) => p.high)),
            low: Math.min(...points.map((p) => p.low))
          }
        : null
    }
  } catch (err) {
    setResponseStatus(event, 502)
    return { ok: false, error: err instanceof Error ? err.message : String(err), points: [], quote: null }
  }
})