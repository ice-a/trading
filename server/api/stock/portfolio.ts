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
  type Currency,
  type TradeInput
} from '../../utils/portfolio'
import { fetchQuotes, symbolForPosition } from '../../utils/stock'
import { withDbCache } from '../../utils/cache'

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

    /**
     * 读写统一走 claimLedger：
     *   账本不存在 → 首次访问自动创建（否则新用户永远 403）
     *   账本已存在 → 校验 key 是否匹配
     * 这样「进入账本」和「记录一笔」的鉴权行为一致，不会出现“先点进去被拒”的死循环。
     */
    const claim = await claimLedger(user, key)
    if (!claim.ok) {
      setResponseStatus(event, 403)
      return { ok: false, error: claim.error || 'key 与已有账本不匹配' }
    }

    if (q.history) {
      return { ok: true, history: await listSearchHistory(user) }
    }

    const [trades, rates] = await Promise.all([listTrades(user), listFxRates()])
    const positions = buildPositions(trades)

    /**
     * 实时浮动盈亏：现价 × 数量 − 成本。
     *
     * 用 withDbCache 的报价缓存（30 秒）批量取现价，一次请求拿全部持仓标的，
     * 不额外增加往返；拿不到价格的标的（停牌/退市/代码错）标记 quoteMissing，
     * 前端显示"暂无报价"而不是直接算成 0 亏损。
     */
    const held = positions.filter((p) => p.quantity > 0)
    const quoteMap = new Map<string, { price: number; changePct: number; name: string }>()

    if (held.length) {
      const symbols = held
        .map((p) => symbolForPosition(p.market, p.code))
        .filter((s): s is string => Boolean(s))

      if (symbols.length) {
        try {
          const quoteItems = await withDbCache(
            `stock:quotes:${symbols.join(',')}`,
            30_000,
            () => fetchQuotes(symbols.map((symbol) => ({ symbol })))
          )
          for (const q of quoteItems) {
            quoteMap.set(q.symbol.toLowerCase(), { price: q.price, changePct: q.changePct, name: q.name })
          }
        } catch {
          /* 报价失败不影响持仓展示，只是没有浮盈 */
        }
      }
    }

    const fx = rates.reduce<Record<string, number>>((acc, r) => {
      acc[r.currency] = r.cnyRate
      return acc
    }, { CNY: 1 })

    /**
     * 分币种汇总：人民币 / 港币 / 美元各自独立统计，不混算。
     * 跨币种可比时再看 summary.cny（全部折人民币）。
     */
    const byCurrency: Record<
      string,
      {
        currency: string
        cost: number
        marketValue: number
        unrealized: number
        unrealizedPct: number
        realized: number
        holdingCount: number
        pricedCount: number
      }
    > = {}

    const bucket = (c: string) => {
      if (!byCurrency[c]) {
        byCurrency[c] = {
          currency: c,
          cost: 0,
          marketValue: 0,
          unrealized: 0,
          unrealizedPct: 0,
          realized: 0,
          holdingCount: 0,
          pricedCount: 0
        }
      }
      return byCurrency[c]!
    }

    const rows = positions.map((p) => {
      const symbol = symbolForPosition(p.market, p.code)
      const quote = symbol ? quoteMap.get(symbol.toLowerCase()) : undefined
      const price = quote?.price ?? null
      const rate = fx[p.currency] ?? 1

      // 浮动盈亏只在有现价且仍持仓时才有意义
      const marketValue = price !== null ? price * p.quantity : null
      const unrealized = price !== null ? (price * p.quantity - p.totalCost) : null

      return {
        ...p,
        symbol: symbol ?? '',
        price,
        changePct: quote?.changePct ?? null,
        /** 现价市值（原币） */
        marketValue,
        /** 浮动盈亏（原币） */
        unrealized,
        /** 浮动盈亏（人民币，方便跨币种汇总） */
        unrealizedCny: unrealized !== null ? unrealized * rate : null,
        /** 现价市值折人民币 */
        marketValueCny: marketValue !== null ? marketValue * rate : null,
        /** 浮盈率 % */
        unrealizedPct:
          unrealized !== null && p.totalCost > 0 ? (unrealized / p.totalCost) * 100 : null,
        quoteMissing: quote === undefined
      }
    })

    for (const r of rows) {
      const b = bucket(r.currency)
      b.cost += r.totalCost
      b.realized += r.realized
      b.holdingCount++
      if (r.marketValue !== null && r.unrealized !== null) {
        b.marketValue += r.marketValue
        b.unrealized += r.unrealized
        b.pricedCount++
      }
    }
    for (const b of Object.values(byCurrency)) {
      b.unrealizedPct = b.cost > 0 ? (b.unrealized / b.cost) * 100 : 0
    }

    // 汇总（只统计能拿到报价的标的，另给出覆盖数量便于前端提示）
    const priced = rows.filter((r) => r.unrealizedCny !== null)
    const totalUnrealizedCny = priced.reduce((s, r) => s + (r.unrealizedCny ?? 0), 0)
    const totalMarketValueCny = priced.reduce((s, r) => s + (r.marketValueCny ?? 0), 0)
    const totalCostCny = rows.reduce((s, r) => s + r.totalCost * (fx[r.currency] ?? 1), 0)

    return {
      ok: true,
      user,
      created: Boolean(claim.created),
      trades,
      positions: rows,
      fx: rates,
      summary: {
        totalCostCny,
        totalMarketValueCny,
        totalUnrealizedCny,
        totalUnrealizedPct: totalCostCny > 0 ? (totalUnrealizedCny / totalCostCny) * 100 : 0,
        pricedCount: priced.length,
        holdingCount: rows.length,
        /** 已实现盈亏折人民币 */
        realizedCny: rows.reduce((s, r) => s + r.realized * (fx[r.currency] ?? 1), 0)
      },
      /** 分币种明细：人民币 / 港币 / 美元各算各的 */
      byCurrency: Object.values(byCurrency).sort((a, b) => b.cost - a.cost)
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