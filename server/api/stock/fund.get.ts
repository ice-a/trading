/**
 * GET /api/stock/fund?code=161131&topline=10 —— 基金持仓（前十重仓股）。
 */
import { withDbCache } from '../../utils/cache'
import { fetchFundHoldings, fetchQuote, searchSecurities } from '../../utils/stock'

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const code = String(q.code || '').trim()
  const topline = Math.min(Math.max(Number(q.topline) || 10, 5), 20)

  if (!/^\d{5,6}$/.test(code)) {
    setResponseStatus(event, 400)
    return { ok: false, error: '基金代码应为 5~6 位数字' }
  }

  setHeader(event, 'Cache-Control', 'public, max-age=300, stale-while-revalidate=900')

  try {
    return await withDbCache(`stock:fund:${code}:${topline}`, 30 * 60_000, async () => {
      const [holdings, quote, basic] = await Promise.all([
        fetchFundHoldings(code, topline),
        fetchQuote(`0.${code}`, 'FUND').catch(() => null),
        searchSecurities(code, 3).catch(() => [])
      ])

      const fundName = basic.find((b) => b.code === code)?.name ?? ''

      return {
        ok: holdings.length > 0,
        code,
        name: fundName,
        quote,
        holdings,
        reportDate: holdings[0]?.reportDate ?? '',
        error: holdings.length ? null : '未取到该基金的持仓明细（可能是债券/货币基金，或代码不存在）'
      }
    })
  } catch (err) {
    setResponseStatus(event, 502)
    return { ok: false, error: err instanceof Error ? err.message : String(err), holdings: [] }
  }
})