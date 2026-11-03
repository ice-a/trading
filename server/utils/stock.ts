/**
 * 行情数据源：腾讯财经（主） + 新浪财经（榜单/板块兜底）。
 *
 * ⚠️ 为什么不用东方财富
 *   实测（2026-11）：push2 / push2his / searchapi / fundf10 四个域名的 https
 *   在 Node 的 fetch 下直接 UND_ERR_SOCKET（TLS 被 CDN 拒绝）；换成 http 后本机可用，
 *   但**部署到 Vercel 后**全部请求在 9 秒超时（境外到东财的链路不通/挂起）。
 *   线上实测证据：/api/stock/hot 与 /api/stock/list 均返回
 *   "TimeoutError: The operation was aborted due to timeout"。
 *   因此整体切到腾讯（qt.gtimg.cn / ifzq.gtimg.cn / smartbox.gtimg.cn）
 *   与新浪（vip.stock.finance.sina.com.cn），两者在国内与境外响应都正常。
 *
 * 数据源分工：
 *   搜索      → smartbox.gtimg.cn/s3      返回 market~symbol~name~pinyin~type，Unicode 转义
 *   实时报价  → qt.gtimg.cn/q=            GBK 编码，~ 分隔的定长字段表
 *   K 线      → web.ifzq.gtimg.cn         返回 JSON，字段 [date,open,close,high,low,volume]
 *   涨幅榜    → 新浪 Market_Center.getHQNodeData（直接给 changepercent，比腾讯省一次解析）
 *   板块      → 腾讯 proxy.finance.qq.com 的 getRank?board_type=hy
 *   基金持仓  → 天天基金 FundArchivesDatas（HTML 片段；这个域名的 https 仍然可用）
 *
 * 腾讯符号规则（重要，别写反）：
 *   A股   沪 sh600519 / 深 sz000001 / 北 bj920xxx
 *   港股  hk00700（5 位）
 *   美股  usAAPL（**不加后缀**；实测 usAAPL.OQ、usAAPL.N 都返回 none_match）
 *   基金  sz161131（场内基金用深/沪前缀）
 */

import { httpFetch } from './http'

const HEADERS: Record<string, string> = {
  'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
  Referer: 'https://gu.qq.com/',
  Accept: '*/*'
}

/** 解码 GBK 响应（腾讯实时报价是 GBK，直接当 UTF-8 读会乱码） */
async function textOf(res: Response, gbk = false): Promise<string> {
  const buf = await res.arrayBuffer()
  if (!gbk) return new TextDecoder('utf-8').decode(buf)
  // Node 自带 ICU，TextDecoder 支持 gbk
  try {
    return new TextDecoder('gbk').decode(buf)
  } catch {
    return new TextDecoder('utf-8').decode(buf)
  }
}

export type Market = 'A' | 'HK' | 'US' | 'FUND' | 'INDEX' | 'OTHER'

export interface SearchItem {
  code: string
  name: string
  market: Market
  /** 腾讯符号，可直接用于 quote/kline，如 sh600519 / hk00700 / usAAPL */
  symbol: string
  typeName: string
}

export interface Quote {
  code: string
  name: string
  symbol: string
  price: number
  changePct: number
  changeAmt: number
  prevClose: number
  open: number
  high: number
  low: number
  volume: number
  amount: number
  market: Market
  /** 交易币种（腾讯字段里带，A股 CNY / 港股 HKD / 美股 USD） */
  currency: string
}

/**
 * 美股符号在「报价」和「K 线」两个接口里要求不同（实测）：
 *   报价  qt.gtimg.cn/q=usAAPL             ✅
 *   K 线  ...?param=usAAPL,day,,,10,qfq    ❌ 只返回 2 条 2011 年的老数据
 *         ...?param=usAAPL.OQ,day,,,10,qfq ✅ 返回 10 条最新数据
 * 后缀代表交易所：.OQ 纳斯达克 / .N 纽交所 / .PK 粉单。
 * 搜索接口返回的正是带后缀的形式（如 aapl.oq），我们把它保留下来供 K 线用。
 */
function klineSymbolOf(symbol: string): string {
  const sym = symbol.trim()
  if (!/^us/i.test(sym)) return sym
  // 已经带后缀就直接用
  if (/\.(OQ|N|PK|OB|AM|TS|TO)$/i.test(sym)) return sym
  const base = sym.slice(2).toUpperCase()
  // 默认按纳斯达克处理（多数热门美股在 OQ）；错了也只是少几条数据，不影响报价
  return `us${base}.OQ`
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

/* ------------------------------------------------------------------ */
/*  符号与市场映射                                                      */
/* ------------------------------------------------------------------ */

/** 腾讯搜索的 market 前缀 → 我们的 Market */
function marketOf(prefix: string): Market {
  switch (prefix) {
    case 'sh':
    case 'sz':
    case 'bj':
      return 'A'
    case 'hk':
      return 'HK'
    case 'us':
      return 'US'
    case 'jj':
    case 'fund':
      return 'FUND'
    default:
      return 'OTHER'
  }
}

/** 根据代码 + 市场推断腾讯符号（用户手动输入代码时用） */
export function symbolOf(code: string, market: Market): string {
  const c = code.trim()
  if (market === 'HK') return `hk${c.padStart(5, '0')}`
  if (market === 'US') return `us${c.toUpperCase()}`
  if (market === 'FUND') return c.startsWith('1') ? `sz${c}` : `sh${c}`
  // A股：6 开头沪、0/3 开头深、8/9 开头北
  if (/^6/.test(c)) return `sh${c}`
  if (/^[03]/.test(c)) return `sz${c}`
  if (/^[89]/.test(c)) return `bj${c}`
  return `sh${c}`
}

/**
 * 持仓记录（market + code）→ 腾讯符号。
 * 持仓里存的是纯代码（600519 / 00700 / AAPL），这里转成可报价的符号。
 */
export function symbolForPosition(market: string, code: string): string | null {
  const c = code.trim()
  if (!c) return null

  switch (market) {
    case 'HK':
      return `hk${c.padStart(5, '0')}`
    case 'US':
      return `us${c.toUpperCase()}`
    case 'FUND':
      // 场内基金：1 开头走深市，5 开头走沪市
      return c.startsWith('5') ? `sh${c}` : `sz${c}`
    case 'A':
      return symbolOf(c, 'A')
    default:
      return null
  }
}

/** 从腾讯符号反推代码（sh600519 → 600519） */
function codeOfSymbol(symbol: string): { code: string; market: Market } {
  const m = symbol.match(/^([a-z]{2})(.+)$/i)
  if (!m) return { code: symbol, market: 'OTHER' }
  const prefix = (m[1] ?? '').toLowerCase()
  const code = m[2] ?? ''
  return { code, market: marketOf(prefix) }
}

/* ------------------------------------------------------------------ */
/*  搜索                                                               */
/* ------------------------------------------------------------------ */

/** 腾讯搜索返回的 v_hint 里中文是 \uXXXX，需要还原 */
function unescapeUnicode(s: string): string {
  return s.replace(/\\u([0-9a-fA-F]{4})/g, (_, hex) => String.fromCharCode(Number.parseInt(hex, 16)))
}

/**
 * 搜索：A股 / 港股 / 美股 / 基金 / 指数统一入口。
 * 返回格式：v_hint="sh~600519~贵州茅台~gzmt~GP-A^hk~00700~腾讯控股~txkg~GP^..."
 */
export async function searchSecurities(input: string, count = 10): Promise<SearchItem[]> {
  const kw = input.trim()
  if (!kw) return []

  const url = `https://smartbox.gtimg.cn/s3/?v=2&q=${encodeURIComponent(kw)}&t=all`
  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) throw new Error(`搜索接口 ${res.status}`)

  const text = unescapeUnicode(await textOf(res))
  const m = text.match(/v_hint="([^"]*)"/)
  if (!m || !m[1]) return []

  const parts = m[1].split('^').filter(Boolean)
  const out: SearchItem[] = []

  for (const p of parts) {
    const [prefix, symbol, name, , typeCode] = p.split('~')
    if (!prefix || !symbol) continue

    const market = marketOf(prefix)
    // 指数等不提供 K 线的类型先收进来，前端会按 market 分流
    const typeName =
      typeCode === 'ZS' ? '指数' : market === 'FUND' ? '基金' : market === 'HK' ? '港股' : market === 'US' ? '美股' : 'A股'

    /**
     * 腾讯搜索里的美股符号是 "aapl.oq"（带交易所后缀），但实时接口只认 "usAAPL"。
     * 同理港股搜索给 "00700"，实时接口要 "hk00700"。
     * 统一在这里规整成可直接使用的符号。
     */
    const cleanSymbol =
      market === 'US'
        ? `us${symbol.split('.')[0]?.toUpperCase() ?? symbol.toUpperCase()}`
        : market === 'HK'
          ? `hk${symbol.padStart(5, '0')}`
          : `${prefix}${symbol}`

    out.push({
      code: symbol.split('.')[0]?.toUpperCase() ?? symbol,
      name: name || symbol,
      market,
      symbol: cleanSymbol,
      typeName
    })
    if (out.length >= count) break
  }
  return out
}

/* ------------------------------------------------------------------ */
/*  实时报价                                                           */
/* ------------------------------------------------------------------ */

/**
 * 腾讯实时字段表（~ 分隔，索引从 0 开始）：
 *   0 未知  1 名称  2 代码  3 现价  4 昨收  5 今开  6 成交量(手)
 *   30 时间  31 涨跌额  32 涨跌幅%  33 最高  34 最低  35 价格/成交量/成交额
 *   36 成交量  37 成交额(万)  ...  最后一带有币种（A股 CNY、美股 USD）
 */
function parseTencentQuote(raw: string, symbol: string): Quote | null {
  const m = raw.match(/v_[^=]+="([^"]*)"/)
  if (!m || !m[1]) return null

  const f = m[1].split('~')
  if (f.length < 40) return null

  const { code, market } = codeOfSymbol(symbol)
  const name = f[1] ?? ''

  // 币种：A股在较后位置有 CNY，美股 USD，港股没有显式字段按 HKD
  const currency = market === 'US' ? 'USD' : market === 'HK' ? 'HKD' : 'CNY'

  /**
   * 成交额字段 f37 的单位随市场不同（实测）：
   *   A股   512269       → 万元（51.2 亿）
   *   港股   4335259642   → 元（43.35 亿）
   *   美股   21950929283  → 元（219.5 亿）
   * 所以只有 A股 需要乘 10000，港美直接用。
   */
  const amountRaw = Number(f[37] ?? 0)
  const amount = market === 'A' ? amountRaw * 10_000 : amountRaw

  return {
    code: f[2] || code,
    name,
    symbol,
    price: Number(f[3] ?? 0),
    prevClose: Number(f[4] ?? 0),
    open: Number(f[5] ?? 0),
    high: Number(f[33] ?? 0),
    low: Number(f[34] ?? 0),
    changeAmt: Number(f[31] ?? 0),
    changePct: Number(f[32] ?? 0),
    volume: Number(f[6] ?? 0),
    amount, // A股为万元（已换算），港美股本身是元
    market,
    currency
  }
}

/** 单只报价 */
export async function fetchQuote(symbol: string, market?: Market): Promise<Quote | null> {
  const sym = market && !symbol.match(/^(sh|sz|bj|hk|us)/i) ? symbolOf(symbol, market) : symbol
  const res = await httpFetch(`https://qt.gtimg.cn/q=${encodeURIComponent(sym)}`, {
    headers: HEADERS,
    timeoutMs: 8_000
  })
  if (!res.ok) return null

  const text = await textOf(res, true)
  if (/none_match/.test(text)) return null
  return parseTencentQuote(text, sym)
}

/** 批量报价：腾讯本身就支持逗号分隔多只，一次请求即可 */
export async function fetchQuotes(items: Array<{ symbol: string; market?: Market }>): Promise<Quote[]> {
  if (!items.length) return []

  const syms = items.map((it) =>
    it.market && !it.symbol.match(/^(sh|sz|bj|hk|us)/i) ? symbolOf(it.symbol, it.market) : it.symbol
  )

  // 单次最多 60 只，超过则分批
  const CHUNK = 60
  const out: Quote[] = []

  for (let i = 0; i < syms.length; i += CHUNK) {
    const batch = syms.slice(i, i + CHUNK)
    try {
      const res = await httpFetch(`https://qt.gtimg.cn/q=${batch.map(encodeURIComponent).join(',')}`, {
        headers: HEADERS,
        timeoutMs: 10_000
      })
      if (!res.ok) continue
      const text = await textOf(res, true)

      for (const line of text.split(';')) {
        const q = parseTencentQuote(line, '')
        if (!q) continue
        // 从行内 v_ 前缀取真实符号
        const sm = line.match(/v_([^=]+)=/)
        const sym = sm?.[1] ?? ''
        const fixed = sym ? parseTencentQuote(line, sym) : q
        if (fixed) out.push(fixed)
      }
    } catch {
      /* 单批失败跳过，不影响其它批 */
    }
  }

  // 按请求顺序回填（腾讯返回顺序与请求一致，但分批后仍以符号为准）
  const map = new Map(out.map((q) => [q.symbol, q]))
  return items
    .map((it, idx) => map.get(syms[idx] ?? '') ?? null)
    .filter((q): q is Quote => q !== null)
}

/* ------------------------------------------------------------------ */
/*  K 线                                                              */
/* ------------------------------------------------------------------ */

/**
 * 腾讯 K 线：
 *   https://web.ifzq.gtimg.cn/appstock/app/fqkline/get?param=sh600519,day,,,30,qfq
 *   返回 data[symbol].qfqday 或 .day，元素 [date, open, close, high, low, volume]
 *
 * 注意：这里不需要像东财那样传 beg；给数量（第 5 段）即可，且从一开始就不返回负值。
 */
export async function fetchKline(
  symbol: string,
  period: 'day' | 'week' | 'month' = 'day',
  limit = 120
): Promise<KlinePoint[]> {
  const p = period === 'day' ? 'day' : period === 'week' ? 'week' : 'month'
  const qsym = klineSymbolOf(symbol)
  // 前复权：qfq；指数/基金没有复权概念时腾讯会自动回落到 day
  const url =
    `https://web.ifzq.gtimg.cn/appstock/app/fqkline/get` +
    `?param=${encodeURIComponent(qsym)},${p},,,${limit},qfq`

  const res = await httpFetch(url, { headers: { ...HEADERS, Referer: 'https://gu.qq.com/' }, timeoutMs: 10_000 })
  if (!res.ok) throw new Error(`K线接口 ${res.status}`)

  const json = (await res.json()) as {
    data?: Record<string, Record<string, unknown>>
  }

  // 上游返回的键可能是去后缀的形式（usAAPL.OQ → 有时键是 usAAPL）
  const node = json.data?.[qsym] ?? json.data?.[symbol]
  if (!node) return []

  // day 图可能落在 qfqday / qfqweek / day / week 等键上，取第一个非空
  const keys = [`qfq${p}`, p, `qfq${p}`]
  let rows: unknown[] = []
  for (const k of keys) {
    const v = node[k]
    if (Array.isArray(v) && v.length) {
      rows = v
      break
    }
  }
  // 指数会落到 "day" 而非 qfqday，兜底再扫一遍所有数组
  if (!rows.length) {
    for (const v of Object.values(node)) {
      if (Array.isArray(v) && v.length && Array.isArray(v[0])) {
        rows = v
        break
      }
    }
  }

  return (rows as string[][])
    .map((r) => ({
      date: String(r[0] ?? ''),
      open: Number(r[1] ?? 0),
      close: Number(r[2] ?? 0),
      high: Number(r[3] ?? 0),
      low: Number(r[4] ?? 0),
      volume: Number(r[5] ?? 0)
    }))
    .filter((p2) => Number.isFinite(p2.close) && p2.close > 0)
}

/* ------------------------------------------------------------------ */
/*  榜单 / 板块                                                        */
/* ------------------------------------------------------------------ */

/** A股涨幅榜（新浪直接给 changepercent，比解析腾讯字段稳） */
export async function fetchGainers(limit = 12): Promise<Quote[]> {
  const url =
    `https://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodeData` +
    `?page=1&num=${limit}&sort=changepercent&asc=0&node=hs_a&symbol=&_s_r_a=page`

  const res = await httpFetch(url, {
    headers: { ...HEADERS, Referer: 'https://vip.stock.finance.sina.com.cn/' },
    timeoutMs: 8_000
  })
  if (!res.ok) throw new Error(`涨幅榜接口 ${res.status}`)

  const rows = (await res.json()) as Array<Record<string, unknown>>
  if (!Array.isArray(rows)) return []

  return rows.map((r) => {
    const symbol = String(r.symbol ?? '')
    const { market } = codeOfSymbol(symbol)
    return {
      code: String(r.code ?? ''),
      name: String(r.name ?? ''),
      symbol,
      price: Number(r.trade ?? 0),
      prevClose: Number(r.settlement ?? 0),
      open: Number(r.open ?? 0),
      high: Number(r.high ?? 0),
      low: Number(r.low ?? 0),
      changePct: Number(r.changepercent ?? 0),
      changeAmt: Number(r.pricechange ?? 0),
      volume: Number(r.volume ?? 0),
      amount: Number(r.amount ?? 0),
      market,
      currency: 'CNY'
    }
  })
}

/**
 * 行业板块：腾讯 proxy 的 getRank。
 *   board_type=hy 行业 / gn 概念 / dy 地域
 */
export async function fetchSectors(limit = 12): Promise<Sector[]> {
  const url =
    `https://proxy.finance.qq.com/cgi/cgi-bin/rank/pt/getRank` +
    `?board_type=hy&sort_type=price&direct=down&offset=0&count=${limit}`

  const res = await httpFetch(url, { headers: HEADERS, timeoutMs: 8_000 })
  if (!res.ok) throw new Error(`板块接口 ${res.status}`)

  const json = (await res.json()) as {
    data?: { rank_list?: Array<Record<string, unknown>> }
  }
  const rows = json.data?.rank_list ?? []

  return rows.map((r) => ({
    code: String(r.code ?? ''),
    name: String(r.name ?? ''),
    changePct: Number(r.zdf ?? r.speed ?? 0),
    upCount: Number(r.zgb ?? 0),
    downCount: Number(r.xgb ?? 0)
  }))
}

/* ------------------------------------------------------------------ */
/*  港美股热门池                                                       */
/* ------------------------------------------------------------------ */

export const HK_HOT = ['hk00700', 'hk09988', 'hk03690', 'hk01810', 'hk09618', 'hk09888', 'hk02020', 'hk00941', 'hk01299', 'hk00388']

export const US_HOT = ['usAAPL', 'usMSFT', 'usNVDA', 'usTSLA', 'usGOOGL', 'usAMZN', 'usMETA', 'usAVGO', 'usAMD', 'usNFLX']

/* ------------------------------------------------------------------ */
/*  基金持仓                                                           */
/* ------------------------------------------------------------------ */

export interface FundHolding {
  code: string
  name: string
  ratio: string
  shares: string
  value: string
  reportDate: string
}

/** 基金持仓：天天基金的 HTML 片段（这个域名 https 仍可用，无需换源） */
export async function fetchFundHoldings(fundCode: string, topline = 10): Promise<FundHolding[]> {
  const url =
    `https://fundf10.eastmoney.com/FundArchivesDatas.aspx?type=jjcc` +
    `&code=${encodeURIComponent(fundCode)}&topline=${topline}&year=&month=`

  const res = await httpFetch(url, {
    headers: { ...HEADERS, Referer: 'https://fundf10.eastmoney.com/' },
    timeoutMs: 10_000
  })
  if (!res.ok) throw new Error(`基金持仓接口 ${res.status}`)

  const text = await textOf(res)

  const dateMatch = text.match(/截止至：<font class='px12'>([^<]+)</)
  const reportDate = dateMatch?.[1] ?? ''

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