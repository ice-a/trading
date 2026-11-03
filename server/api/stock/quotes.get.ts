/**
 * GET /api/stock/quotes?symbols=sh600519,hk00700,usAAPL
 *
 * 批量报价：持仓浮盈、K 线弹层、任何需要"现价"的地方都走这里。
 *
 * 设计要点：
 *   · 只接受腾讯符号（sh/hk/us/sz/bj 前缀），调用方从搜索或持仓里拿到的就是这种形式
 *   · 腾讯支持一次查多只（逗号分隔），所以 N 只股票只需 1 次上游请求
 *   · 报价 30 秒缓存，与 /api/stock/kline 里的 quote 共用同一个 key 前缀，
 *     避免同一只股票在两处各打一次上游
 *   · 只返回能拿到的，拿不到的静默跳过（持仓里可能有退市/停牌标的）
 */
import { withDbCache } from '../../utils/cache'
import { fetchQuotes } from '../../utils/stock'

const SYMBOL_RE = /^(sh|sz|bj|hk|us)[A-Za-z0-9.]{1,12}$/i

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const raw = String(q.symbols || '').trim()

  if (!raw) {
    setResponseStatus(event, 400)
    return { ok: false, error: '缺少 symbols', items: [] }
  }

  const symbols = raw
    .split(',')
    .map((s) => s.trim())
    .filter((s) => SYMBOL_RE.test(s))
    .slice(0, 80)

  if (!symbols.length) {
    setResponseStatus(event, 400)
    return { ok: false, error: 'symbols 格式不对（应形如 sh600519,hk00700,usAAPL）', items: [] }
  }

  // 浏览器/边缘也能缓存 30 秒，减少函数调用
  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=90')

  try {
    // 先用单只缓存键读一批（命中就不打上游），未命中的合并成一次请求
    const result = await withDbCache(
      `stock:quotes:${symbols.join(',')}`,
      30_000,
      async () => {
        const items = await fetchQuotes(symbols.map((symbol) => ({ symbol })))
        return { items, updatedAt: new Date().toISOString() }
      }
    )

    return { ok: true, total: result.items.length, ...result }
  } catch (err) {
    setResponseStatus(event, 502)
    return { ok: false, error: err instanceof Error ? err.message : String(err), items: [] }
  }
})