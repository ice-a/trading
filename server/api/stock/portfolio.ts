/**
 * /api/stock/portfolio —— 持仓账本（user + key 隔离）。
 *
 *   GET  ?user=&key=                     → 记录 + 推导出的持仓 + 汇率
 *   GET  ?user=&key=&history=1           → 只返回搜索历史
 *   POST { user, key, action, ... }      → add / update / delete / fx / clearHistory
 *
 * key 只用于校验，库里存的是 sha256 哈希。
 * 首次 POST 某 user 时会"认领"该 user（之后的 key 必须一致），避免别人抢占。
 */
import {
  addTrade,
  buildPositions,
  claimLedger,
  clearSearchHistory,
  clearTrades,
  deleteTrade,
  fxMap,
  listFxRates,
  listSearchHistory,
  listTrades,
  saveFxRate,
  updateTrade,
  verifyLedger,
  type Currency,
  type TradeInput
} from '../../utils/portfolio'

export default defineEventHandler(async (event) => {
  const method = getMethod(event)

  /* ---------- 读取 ---------- */
  if (method === 'GET') {
    const q = getQuery(event)
    const user = String(q.user || '').trim()
    const key = String(q.key || '').trim()

    if (!user || !key) {
      setResponseStatus(event, 400)
      return { ok: false, error: '缺少 user 或 key' }
    }

    const valid = await verifyLedger(user, key)
    if (!valid) {
      setResponseStatus(event, 403)
      return { ok: false, error: 'key 不匹配，或该 user 还没有账本' }
    }

    if (q.history) {
      return { ok: true, history: await listSearchHistory(user) }
    }

    const [trades, rates] = await Promise.all([listTrades(user), listFxRates()])
    return {
      ok: true,
      user,
      trades,
      positions: buildPositions(trades),
      fx: rates
    }
  }

  /* ---------- 写入 ---------- */
  if (method !== 'POST') {
    setResponseStatus(event, 405)
    return { ok: false, error: '仅支持 GET / POST' }
  }

  const body = (await readBody(event).catch(() => ({}))) as Record<string, unknown>
  const user = String(body.user || '').trim()
  const key = String(body.key || '').trim()
  const action = String(body.action || 'add')

  if (!user || !key) {
    setResponseStatus(event, 400)
    return { ok: false, error: '缺少 user 或 key' }
  }

  // 认领 / 校验
  const claim = await claimLedger(user, key)
  if (!claim.ok) {
    setResponseStatus(event, 403)
    return { ok: false, error: claim.error }
  }

  try {
    switch (action) {
      case 'add': {
        const input = body.trade as TradeInput | undefined
        if (!input?.code || !input?.tradeDate) {
          setResponseStatus(event, 400)
          return { ok: false, error: '缺少 code 或 tradeDate' }
        }
        const trade = await addTrade(user, {
          ...input,
          quantity: Number(input.quantity) || 0,
          price: Number(input.price) || 0,
          fee: Number(input.fee) || 0
        })
        return { ok: true, trade }
      }

      case 'update': {
        const id = Number(body.id)
        if (!id) {
          setResponseStatus(event, 400)
          return { ok: false, error: '缺少 id' }
        }
        const ok = await updateTrade(user, id, (body.trade ?? {}) as TradeInput)
        if (!ok) {
          setResponseStatus(event, 404)
          return { ok: false, error: '记录不存在' }
        }
        return { ok: true }
      }

      case 'delete': {
        const id = Number(body.id)
        if (!id) {
          setResponseStatus(event, 400)
          return { ok: false, error: '缺少 id' }
        }
        const ok = await deleteTrade(user, id)
        return ok ? { ok: true } : { ok: false, error: '记录不存在' }
      }

      case 'fx': {
        const currency = String(body.currency || '').toUpperCase() as Currency
        const rate = Number(body.cnyRate)
        if (!['CNY', 'HKD', 'USD'].includes(currency) || !(rate > 0)) {
          setResponseStatus(event, 400)
          return { ok: false, error: 'currency 或 cnyRate 不合法' }
        }
        await saveFxRate(currency, rate)
        return { ok: true, fx: await listFxRates(), rates: await fxMap() }
      }

      case 'clearHistory': {
        await clearSearchHistory(user)
        return { ok: true }
      }

      case 'clearAll': {
        await clearTrades(user)
        return { ok: true }
      }

      default:
        setResponseStatus(event, 400)
        return { ok: false, error: `未知 action：${action}` }
    }
  } catch (err) {
    setResponseStatus(event, 500)
    return { ok: false, error: err instanceof Error ? err.message : String(err) }
  }
})