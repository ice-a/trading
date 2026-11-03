/**
 * 持仓账本：按 (user, key) 隔离，支持买卖记录、手续费、本位币折算。
 *
 * 设计要点：
 *   · user + key 组成一个"账本"的凭据，客户端用它读写自己的数据
 *   · 一条记录 = 一次买入或卖出，不预设计算好的持仓
 *   · 持仓/成本/盈亏全部由记录**实时推导**，避免两份数据不一致
 *   · 汇率单独存一张表，允许手工维护（不依赖外部 fx 接口的可用性）
 *   · key 存哈希不存明文：DB 泄露也拿不到别人账本
 */

import { createHash, randomBytes } from 'node:crypto'
import { sqlAll, sqlFirst, sqlRun, sqlBatch, type SqlStmt } from './db'

export type TradeSide = 'buy' | 'sell'
export type Currency = 'CNY' | 'HKD' | 'USD'

export interface Trade {
  id: number
  user: string
  /** 标的代码（A股 6 位 / 港股 5 位 / 美股字母 / 基金 6 位） */
  code: string
  name: string
  market: 'A' | 'HK' | 'US' | 'FUND'
  side: TradeSide
  /** 交易所/券商 */
  venue: string
  /** 成交日期 YYYY-MM-DD */
  tradeDate: string
  /** 数量（股/份） */
  quantity: number
  /** 成交价（标的原币） */
  price: number
  /** 手续费（标的原币） */
  fee: number
  /** 成交币种 */
  currency: Currency
  note: string
  createdAt: string
  updatedAt: string
}

export interface TradeInput {
  code: string
  name?: string
  market: Trade['market']
  side: TradeSide
  venue?: string
  tradeDate: string
  quantity: number
  price: number
  fee?: number
  currency?: Currency
  note?: string
}

/** 持仓聚合结果（由记录推导，不落库） */
export interface Position {
  code: string
  name: string
  market: Trade['market']
  currency: Currency
  /** 当前持有数量（卖光则为 0） */
  quantity: number
  /** 加权平均成本（原币/股） */
  avgCost: number
  /** 累计投入成本（含手续费，原币） */
  totalCost: number
  /** 累计已实现盈亏（原币） */
  realized: number
  /** 累计手续费（原币） */
  totalFee: number
  /** 记录笔数 */
  trades: number
  /** 最后一次成交日期 */
  lastDate: string
}

const KEY_SALT = 'liaowangtai-portfolio'

/** key 的存储形态：sha256(user:key)，不可反推 */
export function hashKey(user: string, key: string): string {
  return createHash('sha256').update(`${KEY_SALT}:${user}:${key}`).digest('hex')
}

/** 生成一个随机 key，方便用户第一次使用时直接领取 */
export function generateKey(): string {
  return randomBytes(16).toString('hex')
}

/* ---------- 汇率 ---------- */

export interface FxRate {
  currency: Currency
  /** 1 单位该币种 = cnyRate 人民币 */
  cnyRate: number
  updatedAt: string
}

const DEFAULT_FX: Record<Currency, number> = {
  CNY: 1,
  HKD: 0.92,
  USD: 7.2
}

export async function listFxRates(): Promise<FxRate[]> {
  const rows = await sqlAll<{ currency: string; cny_rate: number; updated_at: string }>(
    'select currency, cny_rate, updated_at from fx_rates order by currency asc'
  )
  if (!rows.length) {
    return (['CNY', 'HKD', 'USD'] as Currency[]).map((c) => ({
      currency: c,
      cnyRate: DEFAULT_FX[c],
      updatedAt: ''
    }))
  }
  return rows.map((r) => ({
    currency: r.currency as Currency,
    cnyRate: Number(r.cny_rate),
    updatedAt: r.updated_at
  }))
}

export async function fxMap(): Promise<Record<Currency, number>> {
  const list = await listFxRates()
  const out: Record<Currency, number> = { ...DEFAULT_FX }
  for (const r of list) {
    if (r.cnyRate > 0) out[r.currency] = r.cnyRate
  }
  return out
}

export async function saveFxRate(currency: Currency, cnyRate: number): Promise<void> {
  const now = new Date().toISOString()
  await sqlRun(
    `insert into fx_rates (currency, cny_rate, updated_at) values (?,?,?)
     on conflict (currency) do update set cny_rate = excluded.cny_rate, updated_at = excluded.updated_at`,
    [currency, cnyRate, now]
  )
}

/* ---------- 账本鉴权 ---------- */

/**
 * 校验 user+key 是否属于同一个账本。
 * 首次写入时自动"认领"（该 user 名下还没有 key 就绑定这个 key 的哈希）。
 */
export async function claimLedger(user: string, key: string): Promise<{ ok: boolean; error?: string }> {
  const u = user.trim()
  const k = key.trim()
  if (!u || !k) return { ok: false, error: 'user 和 key 都不能为空' }
  if (u.length > 40) return { ok: false, error: 'user 最长 40 字符' }
  if (k.length < 6) return { ok: false, error: 'key 至少 6 个字符' }

  const keyHash = hashKey(u, k)
  const existing = await sqlFirst<{ key_hash: string }>('select key_hash from portfolios where user = ?', [u])

  if (existing) {
    if (existing.key_hash !== keyHash) return { ok: false, error: 'key 与已有账本不匹配' }
    return { ok: true }
  }

  await sqlRun(
    'insert into portfolios (user, key_hash, created_at, updated_at) values (?,?,?,?)',
    [u, keyHash, new Date().toISOString(), new Date().toISOString()]
  )
  return { ok: true }
}

/** 读取时只校验，不自动认领（避免别人抢先占你的 user） */
export async function verifyLedger(user: string, key: string): Promise<boolean> {
  const existing = await sqlFirst<{ key_hash: string }>('select key_hash from portfolios where user = ?', [
    user.trim()
  ])
  if (!existing) return false
  return existing.key_hash === hashKey(user.trim(), key.trim())
}

/* ---------- 交易记录 ---------- */

interface TradeRow {
  id: number
  user_name: string
  code: string
  name: string
  market: string
  side: string
  venue: string
  trade_date: string
  quantity: number
  price: number
  fee: number
  currency: string
  note: string
  created_at: string
  updated_at: string
}

function toTrade(r: TradeRow): Trade {
  return {
    id: r.id,
    user: r.user_name,
    code: r.code,
    name: r.name,
    market: r.market as Trade['market'],
    side: r.side as TradeSide,
    venue: r.venue,
    tradeDate: r.trade_date,
    quantity: Number(r.quantity),
    price: Number(r.price),
    fee: Number(r.fee),
    currency: r.currency as Currency,
    note: r.note,
    createdAt: r.created_at,
    updatedAt: r.updated_at
  }
}

export async function listTrades(user: string): Promise<Trade[]> {
  const rows = await sqlAll<TradeRow>(
    'select * from portfolio_trades where user_name = ? order by trade_date desc, id desc',
    [user.trim()]
  )
  return rows.map(toTrade)
}

export async function addTrade(user: string, input: TradeInput): Promise<Trade> {
  const now = new Date().toISOString()
  const currency: Currency = input.currency ?? 'CNY'

  const res = await sqlRun(
    `insert into portfolio_trades
       (user_name, code, name, market, side, venue, trade_date, quantity, price, fee, currency, note, created_at, updated_at)
     values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    [
      user.trim(),
      input.code,
      input.name ?? '',
      input.market,
      input.side,
      input.venue ?? '',
      input.tradeDate,
      input.quantity,
      input.price,
      input.fee ?? 0,
      currency,
      input.note ?? '',
      now,
      now
    ]
  )

  const row = await sqlFirst<TradeRow>('select * from portfolio_trades where id = ?', [res.lastInsertRowid])
  if (!row) throw new Error('写入后读取失败')
  return toTrade(row)
}

export async function updateTrade(user: string, id: number, input: Partial<TradeInput>): Promise<boolean> {
  const existing = await sqlFirst<TradeRow>('select * from portfolio_trades where id = ? and user_name = ?', [
    id,
    user.trim()
  ])
  if (!existing) return false

  const merged = {
    code: input.code ?? existing.code,
    name: input.name ?? existing.name,
    market: input.market ?? existing.market,
    side: input.side ?? existing.side,
    venue: input.venue ?? existing.venue,
    tradeDate: input.tradeDate ?? existing.trade_date,
    quantity: input.quantity ?? Number(existing.quantity),
    price: input.price ?? Number(existing.price),
    fee: input.fee ?? Number(existing.fee),
    currency: input.currency ?? existing.currency,
    note: input.note ?? existing.note
  }

  await sqlRun(
    `update portfolio_trades set
       code = ?, name = ?, market = ?, side = ?, venue = ?, trade_date = ?,
       quantity = ?, price = ?, fee = ?, currency = ?, note = ?, updated_at = ?
     where id = ? and user_name = ?`,
    [
      merged.code,
      merged.name,
      merged.market,
      merged.side,
      merged.venue,
      merged.tradeDate,
      merged.quantity,
      merged.price,
      merged.fee,
      merged.currency,
      merged.note,
      new Date().toISOString(),
      id,
      user.trim()
    ]
  )
  return true
}

export async function deleteTrade(user: string, id: number): Promise<boolean> {
  const res = await sqlRun('delete from portfolio_trades where id = ? and user_name = ?', [id, user.trim()])
  return res.changes > 0
}

/**
 * 由记录推导持仓（移动加权平均成本法）。
 *   buy：成本 += 数量×价格 + 手续费
 *   sell：按当前均价结转已实现盈亏，成本按卖出数量同比例减少
 */
export function buildPositions(trades: Trade[]): Position[] {
  const byCode = new Map<string, Position>()
  // 按时间正序回放
  const asc = [...trades].sort((a, b) =>
    a.tradeDate === b.tradeDate ? a.id - b.id : a.tradeDate.localeCompare(b.tradeDate)
  )

  for (const t of asc) {
    const key = `${t.market}:${t.code}`
    let pos = byCode.get(key)
    if (!pos) {
      pos = {
        code: t.code,
        name: t.name,
        market: t.market,
        currency: t.currency,
        quantity: 0,
        avgCost: 0,
        totalCost: 0,
        realized: 0,
        totalFee: 0,
        trades: 0,
        lastDate: t.tradeDate
      }
      byCode.set(key, pos)
    }

    pos.name = t.name || pos.name
    pos.currency = t.currency
    pos.trades++
    pos.lastDate = t.tradeDate
    pos.totalFee += t.fee

    if (t.side === 'buy') {
      pos.totalCost += t.quantity * t.price + t.fee
      pos.quantity += t.quantity
      pos.avgCost = pos.quantity > 0 ? pos.totalCost / pos.quantity : 0
    } else {
      const sellQty = Math.min(t.quantity, pos.quantity)
      const proceeds = sellQty * t.price - t.fee
      const costOut = sellQty * pos.avgCost
      pos.realized += proceeds - costOut
      pos.totalCost -= costOut
      pos.quantity -= sellQty
      pos.avgCost = pos.quantity > 0 ? pos.totalCost / pos.quantity : 0
      if (pos.quantity <= 0) {
        pos.quantity = 0
        pos.avgCost = 0
        pos.totalCost = 0
      }
    }
  }

  return [...byCode.values()].sort((a, b) => b.totalCost - a.totalCost)
}

/** 批量删除同一 user 的记录（清空账本用） */
export async function clearTrades(user: string): Promise<void> {
  await sqlRun('delete from portfolio_trades where user_name = ?', [user.trim()])
}

/** 存搜索历史（去重、只留最近 N 条） */
export async function saveSearchHistory(user: string, keyword: string, limit = 20): Promise<void> {
  const kw = keyword.trim()
  if (!kw) return
  const now = new Date().toISOString()
  const stmts: SqlStmt[] = [
    {
      sql: `insert into stock_search_history (user_name, keyword, created_at) values (?,?,?)
            on conflict (user_name, keyword) do update set created_at = excluded.created_at`,
      params: [user.trim(), kw, now]
    }
  ]
  await sqlBatch(stmts)

  // 只留最近的 limit 条
  await sqlRun(
    `delete from stock_search_history where user_name = ? and keyword not in (
       select keyword from stock_search_history where user_name = ? order by created_at desc limit ?
     )`,
    [user.trim(), user.trim(), limit]
  )
}

export async function listSearchHistory(user: string, limit = 20): Promise<string[]> {
  const rows = await sqlAll<{ keyword: string }>(
    'select keyword from stock_search_history where user_name = ? order by created_at desc limit ?',
    [user.trim(), limit]
  )
  return rows.map((r) => r.keyword)
}

export async function clearSearchHistory(user: string): Promise<void> {
  await sqlRun('delete from stock_search_history where user_name = ?', [user.trim()])
}