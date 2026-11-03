/**
 * 行情数据源（东方财富公开接口）。
 *
 * 实测结论（2026-11）——这决定了实现方式：
 *   ✅ searchapi/suggest/get        搜索：A股 / 港股 / 美股 / 基金 / 指数 全支持
 *   ✅ push2/qt/stock/get           单只报价：A股 / 港股 / 美股 都可
 *   ✅ push2his/qt/stock/kline      日/周/月 K 线
 *   ✅ push2/qt/clist/get           A股涨幅榜、板块列表（需带 UA）
 *   ✅ fundf10/FundArchivesDatas   基金持仓（HTML 片段，需解析）
 *   ❌ ulist.np/get / clist 美股港股  批量/列表接口返回空
 *   ➜ 美股/港股热门榜只能逐只并发查 stock/get（我们给固定候选池）
 *
 * secid 前缀：沪 1.、深 0.、港股 116.、美股 105.、板块 90.BKxxxx、基金 0.xxxxxx
 *
 * ⚠️ 必须用 http:// 而不是 https://
 *   实测（Windows / Node 24）：这些域名的 https 在 Node 的 fetch 下直接
 *   UND_ERR_SOCKET（TLS 握手被 CDN 拒绝），但 curl 正常、http:// 正常。
 *   同类问题在 Vercel 上不一定复现，但用 http 是两边都稳的选择（内容都是公开行情）。
 */

import { httpFetch } from './http'

const UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/131.0.0.0 Safari/537.36'
const HEADERS: Record<string, string> = {
  'User-Agent': UA,
  Referer: 'https://quote.eastmoney.com/',
  Accept: '*/*'
}

/** 东财公开的搜索 token（网页端固定值，不是密钥） */
const SEARCH_TOKEN = 'D43BF722C8E33BDC906FB84D85E326E8'

export type Market = 'A' | 'HK' | 'US' | 'FUND' | 'INDEX' | 'OTHER'

export interface SearchItem {
  code: string
  name: string
  market: Market
  /** 可直接用于 quote/kline 的 secid，如 1.600519 / 116.00700 / 105.AAPL */
  secid: string
  typeName: string
}

export interface Quote {
  code: string
  name: string
  secid: string
  /** 最新价 */
  price: number
  /** 涨跌幅 % */
  changePct: number
  /** 涨跌额 */
  changeAmt: number
  /** 昨收 */
  prevClose: number
  open: number
  high: number
  low: number
  volume: number
  amount: number
  market: Market
}

export interface KlinePoint {
  date: string
  open: number
  close: number
  high: number
  low: number
  volume: number
}

export interface Sector {
  code: string
  name: string
  changePct: number
  upCount: number
  downCount: number
}

/** 市场 → secid 前缀；搜索接口给的是完整 QuoteID，这里只用于兜底 */
function marketOf(classify: string): Market {
  switch (classify) {
    case 'AStock':
      return 'A'
    case 'HK':
      return 'HK'
    case 'UsStock':
      return 'US'
    case 'Fund':
      return 'FUND'
    case 'Index':
      return 'INDEX'
    default:
      return 'OTHER'
  }
}

/**
 * 东财的定点数按 f59（小数位数）缩放，不能一律除以 100。
 *   实测：A股 f59=2（600519 → 144870 = 1448.70）
 *        港股 f59=3（00700 → 400800 = 400.800）
 *        美股 f59=3（AAPL  → 338320 = 338.320）
 */
function price(raw: unknown, decimals = 2): number {
  const n = Number(raw)
  if (!Number.isFinite(n)) return 0
  const d = Number.isFinite(decimals) ? Math.max(0, Math.min(6, decimals)) : 2
  return n / 10 ** d
}

/** 搜索：A股 / 港股 / 美股 / 基金 / 指数 统一入口 */
export async function searchSecurities(input: string, count = 10): Promise<SearchItem[]> {
  const kw = input.trim()
  if (!kw) return []

  const url =
    `http://searchapi.eastmoney.com/api/suggest/get?input=${encodeURIComponent(kw)}` +
    `&type=14&token=${SEARCH_TOKEN}&count=${count}`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) throw new Error(`搜索接口 ${res.status}`)

  const json = (await res.json()) as {
    QuotationCodeTable?: { Data?: Array<Record<string, unknown>> }
  }

  const rows = json.QuotationCodeTable?.Data ?? []
  return rows
    .map((r) => ({
      code: String(r.Code ?? ''),
      name: String(r.Name ?? ''),
      market: marketOf(String(r.Classify ?? '')),
      secid: String(r.QuoteID ?? ''),
      typeName: String(r.SecurityTypeName ?? '')
    }))
    .filter((r) => r.code && r.secid)
}

/** 单只报价（A股/港股/美股通用） */
export async function fetchQuote(secid: string, market: Market = 'A'): Promise<Quote | null> {
  const url =
    `http://push2.eastmoney.com/api/qt/stock/get?secid=${encodeURIComponent(secid)}` +
    `&fields=f43,f44,f45,f46,f47,f48,f57,f58,f59,f60,f169,f170,f168`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) return null

  const json = (await res.json()) as {
    data?: Record<string, unknown> | null
  }
  const d = json.data
  if (!d) return null

  // f59 = 价格小数位数；美元/港币常见 3 位，A股 2 位
  const dec = Number(d.f59 ?? 2)

  return {
    code: String(d.f57 ?? ''),
    name: String(d.f58 ?? ''),
    secid,
    price: price(d.f43, dec),
    prevClose: price(d.f60, dec),
    open: price(d.f46, dec),
    high: price(d.f44, dec),
    low: price(d.f45, dec),
    volume: Number(d.f47 ?? 0),
    amount: Number(d.f48 ?? 0),
    // f170 是涨跌幅（百分比的百分之一，0.01% 单位）
    changePct: Number(d.f170 ?? 0) / 100,
    changeAmt: price(d.f169, dec),
    market
  }
}

/** 批量报价：给的是固定候选池，并发逐只查（批量接口对港美股不可用） */
export async function fetchQuotes(items: Array<{ secid: string; market: Market }>): Promise<Quote[]> {
  const settled = await Promise.allSettled(items.map((it) => fetchQuote(it.secid, it.market)))
  return settled
    .filter((s): s is PromiseFulfilledResult<Quote | null> => s.status === 'fulfilled')
    .map((s) => s.value)
    .filter((q): q is Quote => q !== null)
}

/** K 线：klt 101=日 102=周 103=月；fqt 1=前复权 */
export async function fetchKline(
  secid: string,
  period: 'day' | 'week' | 'month' = 'day',
  limit = 120
): Promise<KlinePoint[]> {
  const klt = period === 'day' ? 101 : period === 'week' ? 102 : 103

  /**
   * 必须给 beg 一个具体日期，不能用 beg=0。
   * 实测：beg=0 会让上游返回全部历史（2500+ 条），且前复权基准被算到很早的年份，
   *       导致最近的数据出现负值（600519 出现 -312.68）。
   *       给一个近几年的 beg 后完全正常。
   */
  const yearsBack = period === 'day' ? 2 : period === 'week' ? 5 : 10
  const beg = `${new Date().getFullYear() - yearsBack}0101`

  const url =
    `http://push2his.eastmoney.com/api/qt/stock/kline/get?secid=${encodeURIComponent(secid)}` +
    `&klt=${klt}&fqt=1&beg=${beg}&end=20500101&lmt=${limit}&fields1=f1,f2,f3,f4,f5,f6` +
    `&fields2=f51,f52,f53,f54,f55,f56`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 10_000 })
  if (!res.ok) throw new Error(`K线接口 ${res.status}`)

  const json = (await res.json()) as { data?: { klines?: string[] } | null }
  const lines = json.data?.klines ?? []

  return lines
    .map((line) => {
      const [date, open, close, high, low, volume] = line.split(',')
      return {
        date: String(date),
        open: Number(open),
        close: Number(close),
        high: Number(high),
        low: Number(low),
        volume: Number(volume)
      }
    })
    .filter((p) => Number.isFinite(p.close) && p.close > 0)
}

/** A股涨幅榜 */
export async function fetchGainers(limit = 12): Promise<Quote[]> {
  const url =
    `http://push2.eastmoney.com/api/qt/clist/get?pn=1&pz=${limit}&po=1&np=1&fltt=2&invt=2` +
    `&fid=f3&fs=m:0+t:6,m:0+t:80,m:1+t:2,m:1+t:23&fields=f12,f13,f14,f2,f3,f4,f5,f6,f15,f16,f17,f18`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) throw new Error(`涨幅榜接口 ${res.status}`)

  const json = (await res.json()) as {
    data?: { diff?: Array<Record<string, unknown>> } | null
  }
  const rows = json.data?.diff ?? []

  return rows.map((r) => ({
    code: String(r.f12 ?? ''),
    name: String(r.f14 ?? ''),
    secid: `${r.f13 ?? 0}.${r.f12 ?? ''}`,
    price: Number(r.f2 ?? 0),
    changePct: Number(r.f3 ?? 0),
    changeAmt: Number(r.f4 ?? 0),
    prevClose: Number(r.f18 ?? 0),
    open: Number(r.f17 ?? 0),
    high: Number(r.f15 ?? 0),
    low: Number(r.f16 ?? 0),
    volume: Number(r.f5 ?? 0),
    amount: Number(r.f6 ?? 0),
    market: 'A' as Market
  }))
}

/** 行业板块涨幅榜 */
export async function fetchSectors(limit = 12): Promise<Sector[]> {
  const url =
    `http://push2.eastmoney.com/api/qt/clist/get?pn=1&pz=${limit}&po=1&np=1&fltt=2&invt=2` +
    `&fid=f3&fs=m:90+t:2&fields=f12,f14,f3,f104,f105`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) throw new Error(`板块接口 ${res.status}`)

  const json = (await res.json()) as {
    data?: { diff?: Array<Record<string, unknown>> } | null
  }
  const rows = json.data?.diff ?? []

  return rows.map((r) => ({
    code: String(r.f12 ?? ''),
    name: String(r.f14 ?? ''),
    changePct: Number(r.f3 ?? 0),
    upCount: Number(r.f104 ?? 0),
    downCount: Number(r.f105 ?? 0)
  }))
}

/**
 * 港股 / 美股热门：批量接口不可用，改为固定候选池并发查单只。
 * 候选池是长期稳定的龙头 + 中概，不追求实时"最热"，但保证有数据。
 */
export const HK_HOT = [
  '116.00700', // 腾讯
  '116.09988', // 阿里
  '116.03690', // 美团
  '116.01810', // 小米
  '116.09618', // 京东
  '116.09888', // 百度
  '116.02020', // 安踏
  '116.00941', // 中国移动
  '116.01299', // 友邦
  '116.00388' // 港交所
]

export const US_HOT = [
  '105.AAPL',
  '105.MSFT',
  '105.NVDA',
  '105.TSLA',
  '105.GOOGL',
  '105.AMZN',
  '105.META',
  '105.AVGO',
  '105.AMD',
  '105.NFLX'
]

/** 基金持仓（天天基金 HTML 片段 → 解析成结构化） */
export interface FundHolding {
  code: string
  name: string
  ratio: string
  shares: string
  value: string
  reportDate: string
}

export async function fetchFundHoldings(fundCode: string, topline = 10): Promise<FundHolding[]> {
  const url =
    `http://fundf10.eastmoney.com/FundArchivesDatas.aspx?type=jjcc` +
    `&code=${encodeURIComponent(fundCode)}&topline=${topline}&year=&month=`

  const res = await httpFetch(url, {
    headers: { ...HEADERS, Referer: 'http://fundf10.eastmoney.com/' },
    timeoutMs: 10_000
  })
  if (!res.ok) throw new Error(`基金持仓接口 ${res.status}`)

  const text = await res.text()

  // 报告期：<font class='px12'>2026-09-30</font>
  const dateMatch = text.match(/截止至：<font class='px12'>([^<]+)</)
  const reportDate = dateMatch?.[1] ?? ''

  // 每行：<td>序号</td><td><a ...>000001</a></td><td><a ...>股票名</a></td>...<td>占比</td>
  const rows = [...text.matchAll(/<tr[^>]*>([\s\S]*?)<\/tr>/g)]

  const out: FundHolding[] = []
  for (const row of rows) {
    const rowHtml = row[1] ?? ''
    const cells = [...rowHtml.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/g)].map((c) =>
      (c[1] ?? '')
        .replace(/<[^>]+>/g, '')
        .replace(/&nbsp;/g, ' ')
        .trim()
    )
    // 需要至少 序号/代码/名称 三列，且代码是 5-6 位数字
    if (cells.length < 3) continue
    const code = cells[1] ?? ''
    if (!/^\d{5,6}$/.test(code)) continue

    out.push({
      code,
      name: cells[2] ?? '',
      ratio: cells.find((c) => c.endsWith('%')) ?? '',
      shares: cells.find((c) => /万股|亿股/.test(c)) ?? '',
      value: cells.find((c) => /万元|亿元/.test(c)) ?? '',
      reportDate
    })
    if (out.length >= topline) break
  }
  return out
}