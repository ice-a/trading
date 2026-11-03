<script setup lang="ts">
/**
 * /stack —— 行情台：热门板块 + 热门股票 + 搜索 + K线 + 基金持仓 + 我的持仓。
 *
 * 数据来自东方财富公开接口（见 server/utils/stock.ts 的实测结论）：
 *   · A股涨幅榜 / 行业板块 —— 上游 clist 列表接口
 *   · 港股 / 美股热门      —— 上游批量不可用，服务端用固定候选池并发查单只
 *   · K线                  —— push2his kline
 *   · 基金持仓             —— fundf10（HTML 片段，服务端解析）
 */
interface Quote {
  code: string
  name: string
  symbol: string
  price: number
  changePct: number
  changeAmt: number
  market: string
}

interface Sector {
  code: string
  name: string
  changePct: number
  upCount: number
  downCount: number
}

interface SearchItem {
  code: string
  name: string
  market: 'A' | 'HK' | 'US' | 'FUND' | 'INDEX' | 'OTHER'
  symbol: string
  typeName: string
}

interface KlinePoint {
  date: string
  open: number
  close: number
  high: number
  low: number
  volume: number
}

interface Holding {
  code: string
  name: string
  ratio: string
}

interface Trade {
  id: number
  code: string
  name: string
  market: string
  side: 'buy' | 'sell'
  venue: string
  tradeDate: string
  quantity: number
  price: number
  fee: number
  currency: string
  note: string
}

interface Position {
  code: string
  name: string
  market: string
  currency: string
  quantity: number
  avgCost: number
  totalCost: number
  realized: number
  totalFee: number
  trades: number
  lastDate: string
  /** 后端附带的实时字段 */
  symbol?: string
  price?: number | null
  changePct?: number | null
  marketValue?: number | null
  unrealized?: number | null
  unrealizedCny?: number | null
  marketValueCny?: number | null
  unrealizedPct?: number | null
  quoteMissing?: boolean
}

interface CurrencyBucket {
  currency: string
  cost: number
  marketValue: number
  unrealized: number
  unrealizedPct: number
  realized: number
  holdingCount: number
  pricedCount: number
}

interface PortfolioSummary {
  totalCostCny: number
  totalMarketValueCny: number
  totalUnrealizedCny: number
  totalUnrealizedPct: number
  pricedCount: number
  holdingCount: number
  realizedCny: number
}

interface FxRate {
  currency: string
  cnyRate: number
}

/* ---------- 页面状态 ---------- */
type Tab = 'A' | 'HK' | 'US' | 'MINE'

const tab = ref<Tab>('A')
const loading = ref(true)
const errMsg = ref('')

const gainers = ref<Quote[]>([])
const sectors = ref<Sector[]>([])
const hkList = ref<Quote[]>([])
const usList = ref<Quote[]>([])

/** 搜索 */
const keyword = ref('')
const searching = ref(false)
const searchResults = ref<SearchItem[]>([])
const searchError = ref('')

/** K线弹层 */
const detail = ref<{
  symbol: string
  title: string
  period: 'day' | 'week' | 'month'
  quote: Quote | null
  points: KlinePoint[]
} | null>(null)
const klineLoading = ref(false)

/** 基金持仓弹层 */
const fund = ref<{ code: string; name: string; holdings: Holding[]; reportDate: string; error: string | null } | null>(null)
const fundLoading = ref(false)

/** 我的持仓 */
const userName = ref('')
const userKey = ref('')
const unlocked = ref(false)
const positions = ref<Position[]>([])
const trades = ref<Trade[]>([])
const fxRates = ref<FxRate[]>([])
const portfolioError = ref('')
const portfolioNote = ref('')
const summary = ref<PortfolioSummary | null>(null)
const byCurrency = ref<CurrencyBucket[]>([])

/** 币种符号与名称 */
const CUR_SIGN: Record<string, string> = { CNY: '¥', HKD: 'HK$', USD: 'US$' }
const CUR_NAME: Record<string, string> = { CNY: '人民币', HKD: '港币', USD: '美元' }
const history = ref<string[]>([])

/** 新增记录表单 */
const form = reactive({
  code: '',
  name: '',
  market: 'A' as 'A' | 'HK' | 'US' | 'FUND',
  side: 'buy' as 'buy' | 'sell',
  venue: '',
  tradeDate: new Date().toISOString().slice(0, 10),
  quantity: 0,
  price: 0,
  fee: 0,
  currency: 'CNY' as 'CNY' | 'HKD' | 'USD',
  note: ''
})
const submitting = ref(false)

/* ---------- 本地保存凭据 ---------- */
const LS_USER = 'stock:user'
const LS_KEY = 'stock:key'

onMounted(() => {
  userName.value = localStorage.getItem(LS_USER) || ''
  userKey.value = localStorage.getItem(LS_KEY) || ''
  void loadForTab(tab.value)
})

/* ---------- 拉取首页数据 ---------- */
/** 浏览器侧缓存：切 Tab / 刷新页面前不会重复打接口 */
const HOT_TTL = 3 * 60_000 // 3 分钟
const hotCache = {
  at: 0,
  data: null as null | { gainers: Quote[]; sectors: Sector[]; err: string }
}
const listCache = {
  hk: { at: 0, items: [] as Quote[] },
  us: { at: 0, items: [] as Quote[] }
}

/**
 * 只拉当前 Tab 需要的那一块。
 *   A 股  → hot（涨幅榜 + 板块）
 *   港股  → list?market=hk
 *   美股  → list?market=us
 *   我的持仓 → 什么都不拉
 * 切 Tab 时若本地缓存还有效就直接用，不再请求。
 */
async function loadForTab(t: Tab, force = false) {
  if (t === 'MINE') return

  const now = Date.now()

  // A 股：一个接口拿两块
  if (t === 'A') {
    if (!force && hotCache.data && now - hotCache.at < HOT_TTL) {
      gainers.value = hotCache.data.gainers
      sectors.value = hotCache.data.sectors
      errMsg.value = hotCache.data.err
      loading.value = false
      return
    }
    loading.value = !hotCache.data
    errMsg.value = ''
    try {
      const res = await $fetch<{
        gainers: Quote[]
        sectors: Sector[]
        gainersError: string | null
        sectorsError: string | null
      }>('/api/stock/hot', { query: { limit: 12 } })
      hotCache.at = Date.now()
      hotCache.data = {
        gainers: res.gainers ?? [],
        sectors: res.sectors ?? [],
        err: res.gainersError || res.sectorsError || ''
      }
      gainers.value = hotCache.data.gainers
      sectors.value = hotCache.data.sectors
      errMsg.value = hotCache.data.err
    } catch (e) {
      errMsg.value = e instanceof Error ? e.message : String(e)
    } finally {
      loading.value = false
    }
    return
  }

  // 港 / 美股
  const side = t === 'HK' ? 'hk' : 'us'
  const slot = listCache[side]
  if (!force && slot.items.length && now - slot.at < HOT_TTL) {
    if (t === 'HK') hkList.value = slot.items
    else usList.value = slot.items
    loading.value = false
    return
  }

  loading.value = !slot.items.length
  errMsg.value = ''
  try {
    const res = await $fetch<{ items: Quote[] }>('/api/stock/list', { query: { market: side } })
    slot.at = Date.now()
    slot.items = res.items ?? []
    if (t === 'HK') hkList.value = slot.items
    else usList.value = slot.items
  } catch (e) {
    errMsg.value = e instanceof Error ? e.message : String(e)
  } finally {
    loading.value = false
  }
}

/** 切 Tab（缓存命中则零请求） */
function switchTab(t: Tab) {
  if (tab.value === t) return
  tab.value = t
  void loadForTab(t)
}

/** 手动刷新当前 Tab（强制绕过缓存） */
const refreshing = ref(false)
async function refreshCurrent() {
  refreshing.value = true
  try {
    await loadForTab(tab.value, true)
  } finally {
    refreshing.value = false
  }
}

/* ---------- 搜索 ---------- */
async function doSearch() {
  const kw = keyword.value.trim()
  if (!kw) return
  searching.value = true
  searchError.value = ''
  try {
    const res = await $fetch<{ ok: boolean; items: SearchItem[]; error?: string }>('/api/stock/search', {
      query: { q: kw, count: 20, user: userName.value || undefined }
    })
    searchResults.value = res.items ?? []
    if (!res.ok) searchError.value = res.error || '搜索失败'
    if (userName.value) void loadHistory()
  } catch (e) {
    searchError.value = e instanceof Error ? e.message : String(e)
    searchResults.value = []
  } finally {
    searching.value = false
  }
}

function pickResult(item: SearchItem) {
  if (item.market === 'FUND') {
    void openFund(item.code, item.name)
  } else {
    void openDetail(item.symbol, item.name, item.market)
  }
}

/* ---------- K线 ---------- */
async function openDetail(symbol: string, name: string, market = 'A', period: 'day' | 'week' | 'month' = 'day') {
  detail.value = { symbol, title: name || symbol, period, quote: null, points: [] }
  klineLoading.value = true
  try {
    const res = await $fetch<{
      ok: boolean
      quote: Quote | null
      points: KlinePoint[]
      error?: string
    }>('/api/stock/kline', { query: { symbol, period, limit: 120 } })
    if (detail.value) {
      detail.value.quote = res.quote ?? null
      detail.value.points = res.points ?? []
      if (!res.ok && res.error) searchError.value = res.error
    }
  } catch (e) {
    if (detail.value) detail.value.points = []
    searchError.value = e instanceof Error ? e.message : String(e)
  } finally {
    klineLoading.value = false
  }
}

async function switchPeriod(p: 'day' | 'week' | 'month') {
  if (!detail.value) return
  const d = detail.value
  await openDetail(d.symbol, d.title, d.quote?.market ?? 'A', p)
}

/* ---------- 基金持仓 ---------- */
async function openFund(code: string, name = '') {
  fund.value = { code, name, holdings: [], reportDate: '', error: null }
  fundLoading.value = true
  try {
    const res = await $fetch<{
      ok: boolean
      name: string
      holdings: Holding[]
      reportDate: string
      error: string | null
    }>('/api/stock/fund', { query: { code } })
    fund.value = {
      code,
      name: res.name || name || code,
      holdings: res.holdings ?? [],
      reportDate: res.reportDate ?? '',
      error: res.error ?? null
    }
  } catch (e) {
    if (fund.value) fund.value.error = e instanceof Error ? e.message : String(e)
  } finally {
    fundLoading.value = false
  }
}

/* ---------- 我的持仓 ---------- */
function saveCredentials() {
  localStorage.setItem(LS_USER, userName.value.trim())
  localStorage.setItem(LS_KEY, userKey.value.trim())
}

async function unlock() {
  portfolioError.value = ''
  saveCredentials()
  try {
    const res = await $fetch<{
      ok: boolean
      created?: boolean
      trades?: Trade[]
      positions?: Position[]
      fx?: FxRate[]
      summary?: PortfolioSummary
      byCurrency?: CurrencyBucket[]
      error?: string
    }>('/api/stock/portfolio', { query: { user: userName.value.trim(), key: userKey.value.trim() } })
    if (!res.ok) {
      portfolioError.value = res.error || '读取失败'
      unlocked.value = false
      return
    }
    trades.value = res.trades ?? []
    positions.value = res.positions ?? []
    fxRates.value = res.fx ?? []
    summary.value = res.summary ?? null
    byCurrency.value = res.byCurrency ?? []
    unlocked.value = true

    // 首次进入自动建账本，给个确认提示（否则用户不知道自己已经"开户"了）
    if (res.created) {
      portfolioNote.value = '已为你创建账本，密钥已记住本机，下次打开自动进入'
      window.setTimeout(() => (portfolioNote.value = ''), 5000)
    }

    void loadHistory()
  } catch (e) {
    portfolioError.value = e instanceof Error ? e.message : String(e)
  }
}

async function loadHistory() {
  if (!userName.value || !userKey.value) return
  try {
    const res = await $fetch<{ ok: boolean; history: string[] }>('/api/stock/portfolio', {
      query: { user: userName.value.trim(), key: userKey.value.trim(), history: 1 }
    })
    history.value = res.history ?? []
  } catch {
    history.value = []
  }
}

async function post(body: Record<string, unknown>) {
  return $fetch<{ ok: boolean; error?: string }>('/api/stock/portfolio', {
    method: 'POST',
    body: { user: userName.value.trim(), key: userKey.value.trim(), ...body }
  })
}

/**
 * 代码 → 名称自动带出。
 *
 * 用户只需要敲代码（600519 / 00700 / AAPL / 161131），这里用搜索接口反查名称，
 * 同时把市场与币种一并推断出来（省得手选）。
 * 防抖 600ms，避免每敲一个字符都打一次接口。
 */
const resolving = ref(false)
const resolveError = ref('')
let resolveTimer: ReturnType<typeof setTimeout> | null = null

/** 从代码形态推断市场（用户没选时用） */
function guessMarket(code: string): 'A' | 'HK' | 'US' | 'FUND' {
  const c = code.trim().toUpperCase()
  if (/^[A-Z]{1,5}([.][A-Z])?$/.test(c)) return 'US' // AAPL / BRK.B
  if (/^\d{5}$/.test(c)) return 'HK' // 00700
  if (/^\d{6}$/.test(c)) return 'A' // 600519 / 000001
  return 'A'
}

/** 市场 → 默认币种 */
const CURRENCY_OF: Record<string, 'CNY' | 'HKD' | 'USD'> = {
  A: 'CNY',
  FUND: 'CNY',
  HK: 'HKD',
  US: 'USD'
}

async function resolveName() {
  const code = form.code.trim()
  if (!code) return

  // 代码变化后先按形态猜市场/币种，用户仍可手动改
  if (!form.market || form.market === 'A') {
    const g = guessMarket(code)
    form.market = g
    form.currency = CURRENCY_OF[g] ?? 'CNY'
  }

  resolving.value = true
  resolveError.value = ''
  try {
    const res = await $fetch<{ ok: boolean; items: SearchItem[] }>('/api/stock/search', {
      query: { q: code, count: 5 }
    })
    const items = res.items ?? []
    // 优先精确匹配代码，其次第一条
    const hit =
      items.find((i) => i.code.replace(/^0+/, '') === code.replace(/^0+/, '')) ?? items[0]

    if (hit) {
      form.name = hit.name
      // 搜索比形态猜测更准，以它为准
      if (hit.market === 'A' || hit.market === 'HK' || hit.market === 'US' || hit.market === 'FUND') {
        form.market = hit.market
        form.currency = CURRENCY_OF[hit.market] ?? 'CNY'
      }
    } else {
      resolveError.value = '没找到该代码，请确认后重试（可手动填写名称）'
      form.name = ''
    }
  } catch {
    resolveError.value = '查询名称失败，可手动填写'
  } finally {
    resolving.value = false
  }
}

/** 输入时防抖触发 */
function onCodeInput() {
  if (resolveTimer) clearTimeout(resolveTimer)
  resolveTimer = setTimeout(() => void resolveName(), 600)
}

/** 手选市场时把币种一起带过去，避免「美股记成人民币」这种脏数据 */
function onMarketChange(m: string) {
  form.market = m as typeof form.market
  form.currency = CURRENCY_OF[m] ?? 'CNY'
}

/** 失焦立即查（不等防抖） */
function onCodeBlur() {
  if (resolveTimer) clearTimeout(resolveTimer)
  if (form.code.trim() && !form.name.trim()) void resolveName()
}

async function addTrade() {
  portfolioError.value = ''
  if (!form.code || !form.tradeDate || form.quantity <= 0 || form.price <= 0) {
    portfolioError.value = '代码、日期、数量、价格都要填'
    return
  }
  submitting.value = true
  try {
    const res = await post({ action: 'add', trade: { ...form } })
    if (!res.ok) {
      portfolioError.value = res.error || '保存失败'
      return
    }
    // 重置关键字段，保留市场/币种方便连续录入
    form.code = ''
    form.name = ''
    form.quantity = 0
    form.price = 0
    form.fee = 0
    form.note = ''
    await unlock()
  } finally {
    submitting.value = false
  }
}

async function removeTrade(id: number) {
  const res = await post({ action: 'delete', id })
  if (res.ok) await unlock()
  else portfolioError.value = res.error || '删除失败'
}

async function saveFx(currency: string, rate: number) {
  const res = await post({ action: 'fx', currency, cnyRate: rate })
  if (res.ok) await unlock()
  else portfolioError.value = res.error || '保存汇率失败'
}

/* ---------- 计算 ---------- */
const fxOf = (c: string) => fxRates.value.find((r) => r.currency === c)?.cnyRate ?? 1

/** 持仓折算人民币（用当前价；拿不到价就用成本价） */
function marketValueCny(p: Position): number {
  return p.totalCost * fxOf(p.currency)
}

const totalCostCny = computed(() =>
  positions.value.reduce((s, p) => s + p.totalCost * fxOf(p.currency), 0)
)
const realizedCny = computed(() =>
  positions.value.reduce((s, p) => s + p.realized * fxOf(p.currency), 0)
)

/* ---------- 极简 K 线绘制（纯 SVG，无第三方库） ---------- */
const chart = computed(() => {
  const pts = detail.value?.points ?? []
  if (!pts.length) return null

  const W = 1000
  const H = 320
  const pad = 8
  const highs = pts.map((p) => p.high)
  const lows = pts.map((p) => p.low)
  const max = Math.max(...highs)
  const min = Math.min(...lows)
  const span = max - min || 1

  const x = (i: number) => pad + (i * (W - pad * 2)) / Math.max(1, pts.length - 1)
  const y = (v: number) => pad + ((max - v) * (H - pad * 2)) / span

  // 蜡烛：实体宽度按点数自适应
  const bw = Math.max(1.2, ((W - pad * 2) / pts.length) * 0.6)

  const candles = pts.map((p, i) => {
    const up = p.close >= p.open
    const cx = x(i)
    const top = y(Math.max(p.open, p.close))
    const bottom = y(Math.min(p.open, p.close))
    return {
      cx,
      w: bw,
      top,
      h: Math.max(1, bottom - top),
      wickTop: y(p.high),
      wickBottom: y(p.low),
      up
    }
  })

  // 收盘价折线
  const line = pts.map((p, i) => `${x(i).toFixed(1)},${y(p.close).toFixed(1)}`).join(' ')

  return { W, H, candles, line, max, min, first: pts[0]?.date, last: pts[pts.length - 1]?.date }
})

const fmt = (n: number, digits = 2) =>
  n.toLocaleString('zh-CN', { minimumFractionDigits: digits, maximumFractionDigits: digits })

const pctText = (n: number) => `${n > 0 ? '+' : ''}${n.toFixed(2)}%`

const cls = (n: number) => (n > 0 ? 'up' : n < 0 ? 'down' : 'flat')
</script>

<template>
  <PageShell
    icon="📊"
    title="行情"
    subtitle="A股 · 港股 · 美股 · 基金 —— 热门板块与个股，点开看 K 线"
  >
    <!-- 搜索框：固定位置，不随 tab 切换改变结构 -->
    <template #actions>
      <div class="search-row">
        <div class="search-box">
          <span class="ico">🔍</span>
          <input
            v-model="keyword"
            type="search"
            placeholder="搜股票/基金：600519、腾讯、AAPL、161131…"
            spellcheck="false"
            @keyup.enter="doSearch"
          />
          <button v-if="keyword" class="clear" @click="((keyword = ''), (searchResults = []))">×</button>
        </div>
        <button class="pill-btn primary" :disabled="searching" @click="doSearch">
          {{ searching ? '搜索中…' : '搜索' }}
        </button>
      </div>
    </template>

    <!-- 搜索结果（有关键词时才占据顶部） -->
    <div v-if="searchResults.length || searchError" class="search-panel">
      <div v-if="searchError" class="alert">{{ searchError }}</div>
      <div v-if="searchResults.length" class="result-grid">
        <button
          v-for="r in searchResults"
          :key="r.symbol + r.market"
          class="result"
          @click="pickResult(r)"
        >
          <span class="r-left">
            <span class="r-name">{{ r.name }}</span>
            <span class="r-code">{{ r.code }}</span>
          </span>
          <span class="r-right">
            <span class="r-tag" :class="r.market.toLowerCase()">{{ r.typeName || r.market }}</span>
            <span class="r-go">{{ r.market === 'FUND' ? '持仓' : 'K线' }} →</span>
          </span>
        </button>
      </div>
    </div>

    <!-- 搜索历史 -->
    <div v-if="history.length" class="history-row">
      <span class="h-label">最近搜索</span>
      <button v-for="h in history.slice(0, 8)" :key="h" class="h-chip" @click="((keyword = h), doSearch())">
        {{ h }}
      </button>
    </div>

    <div v-if="loading" class="skeleton-block">
      <div v-for="i in 6" :key="i" class="skeleton" />
    </div>

    <div v-else-if="errMsg" class="alert">{{ errMsg }}</div>

    <template v-else>
      <!-- Tab -->
      <div class="tabs">
        <button :class="{ on: tab === 'A' }" @click="switchTab('A')">A 股</button>
        <button :class="{ on: tab === 'HK' }" @click="switchTab('HK')">港股</button>
        <button :class="{ on: tab === 'US' }" @click="switchTab('US')">美股</button>
        <button :class="{ on: tab === 'MINE' }" @click="switchTab('MINE')">我的持仓</button>
        <span class="tab-spacer" />
        <button
          v-if="tab !== 'MINE'"
          class="refresh-btn"
          :disabled="refreshing"
          title="绕过缓存重新拉取"
          @click="refreshCurrent"
        >
          {{ refreshing ? '刷新中…' : '↻ 刷新' }}
        </button>
      </div>

      <!-- ========== A股 ========== -->
      <section v-if="tab === 'A'" class="panel-inner">
        <h3 class="sec-title">热门板块</h3>
        <div class="sector-grid">
          <div v-for="s in sectors" :key="s.code" class="sector" :class="cls(s.changePct)">
            <span class="s-name">{{ s.name }}</span>
            <span class="s-pct">{{ pctText(s.changePct) }}</span>
            <span class="s-counts">↑{{ s.upCount }} ↓{{ s.downCount }}</span>
          </div>
        </div>

        <h3 class="sec-title">涨幅榜</h3>
        <div class="quote-list">
          <button v-for="q in gainers" :key="q.symbol" class="quote-row" @click="openDetail(q.symbol, q.name, 'A')">
            <span class="q-left">
              <span class="q-name">{{ q.name }}</span>
              <span class="q-code">{{ q.code }}</span>
            </span>
            <span class="q-mid">
              <span class="q-price">{{ fmt(q.price) }}</span>
              <span class="q-pct" :class="cls(q.changePct)">{{ pctText(q.changePct) }}</span>
            </span>
            <span class="q-right">
              <span class="q-amt" :class="cls(q.changeAmt)">{{ q.changeAmt > 0 ? '+' : '' }}{{ fmt(q.changeAmt) }}</span>
              <span class="q-go">K线 →</span>
            </span>
          </button>
        </div>
      </section>

      <!-- ========== 港股 ========== -->
      <section v-else-if="tab === 'HK'" class="panel-inner">
        <h3 class="sec-title">港股热门 <span class="hint">上游批量接口不可用，展示固定龙头池</span></h3>
        <div class="quote-list">
          <button v-for="q in hkList" :key="q.symbol" class="quote-row" @click="openDetail(q.symbol, q.name, 'HK')">
            <span class="q-left">
              <span class="q-name">{{ q.name }}</span>
              <span class="q-code">{{ q.code }}</span>
            </span>
            <span class="q-mid">
              <span class="q-price">{{ fmt(q.price) }}</span>
              <span class="q-pct" :class="cls(q.changePct)">{{ pctText(q.changePct) }}</span>
            </span>
            <span class="q-right">
              <span class="q-amt" :class="cls(q.changeAmt)">{{ q.changeAmt > 0 ? '+' : '' }}{{ fmt(q.changeAmt) }}</span>
              <span class="q-go">K线 →</span>
            </span>
          </button>
        </div>
        <p v-if="!hkList.length" class="empty-hint">港股数据暂不可用，稍后再试</p>
      </section>

      <!-- ========== 美股 ========== -->
      <section v-else-if="tab === 'US'" class="panel-inner">
        <h3 class="sec-title">美股热门 <span class="hint">上游批量接口不可用，展示固定龙头池</span></h3>
        <div class="quote-list">
          <button v-for="q in usList" :key="q.symbol" class="quote-row" @click="openDetail(q.symbol, q.name, 'US')">
            <span class="q-left">
              <span class="q-name">{{ q.name }}</span>
              <span class="q-code">{{ q.code }}</span>
            </span>
            <span class="q-mid">
              <span class="q-price">{{ fmt(q.price) }}</span>
              <span class="q-pct" :class="cls(q.changePct)">{{ pctText(q.changePct) }}</span>
            </span>
            <span class="q-right">
              <span class="q-amt" :class="cls(q.changeAmt)">{{ q.changeAmt > 0 ? '+' : '' }}{{ fmt(q.changeAmt) }}</span>
              <span class="q-go">K线 →</span>
            </span>
          </button>
        </div>
        <p v-if="!usList.length" class="empty-hint">美股数据暂不可用，稍后再试</p>
      </section>

      <!-- ========== 我的持仓 ========== -->
      <section v-else class="panel-inner">
        <!-- 凭据 -->
        <div class="cred-row">
          <div class="cred-field">
            <label>用户</label>
            <input v-model="userName" placeholder="你的名字" @change="saveCredentials" />
          </div>
          <div class="cred-field">
            <label>密钥</label>
            <input v-model="userKey" type="password" placeholder="自定义密钥（≥6 位）" @change="saveCredentials" />
          </div>
          <button class="pill-btn primary" @click="unlock">{{ unlocked ? '刷新' : '进入账本' }}</button>
        </div>
        <p v-if="portfolioError" class="err">{{ portfolioError }}</p>
        <p v-if="portfolioNote" class="note">{{ portfolioNote }}</p>
        <p class="cred-hint">
          账本按「用户 + 密钥」隔离，密钥只在本机保存与校验（服务端存哈希）。首次进入会自动创建。
        </p>

        <template v-if="unlocked">
          <!-- ===== 分币种总览 ===== -->
          <div v-if="byCurrency.length" class="cur-board">
            <div v-for="b in byCurrency" :key="b.currency" class="cur-col" :class="cls(b.unrealized)">
              <header class="cur-head">
                <span class="cur-sign">{{ CUR_SIGN[b.currency] || b.currency }}</span>
                <span class="cur-name">{{ CUR_NAME[b.currency] || b.currency }}</span>
                <span class="cur-count">{{ b.holdingCount }} 只</span>
              </header>

              <div class="cur-main">
                <span class="cur-label">浮动盈亏</span>
                <span class="cur-pnl">
                  {{ b.unrealized > 0 ? '+' : '' }}{{ fmt(b.unrealized) }}
                  <em>{{ pctText(b.unrealizedPct) }}</em>
                </span>
              </div>

              <dl class="cur-detail">
                <div>
                  <dt>市值</dt>
                  <dd>{{ fmt(b.marketValue) }}</dd>
                </div>
                <div>
                  <dt>成本</dt>
                  <dd>{{ fmt(b.cost) }}</dd>
                </div>
                <div>
                  <dt>已实现</dt>
                  <dd :class="cls(b.realized)">{{ fmt(b.realized) }}</dd>
                </div>
              </dl>

              <p v-if="b.pricedCount < b.holdingCount" class="cur-warn">
                {{ b.holdingCount - b.pricedCount }} 只无报价
              </p>
            </div>
          </div>

          <!-- ===== 折算总览（跨币种可比） ===== -->
          <div v-if="summary" class="total-bar">
            <span class="tb-item">
              <em>合计成本</em>
              <b>¥ {{ fmt(summary.totalCostCny) }}</b>
            </span>
            <span class="tb-item">
              <em>合计市值</em>
              <b>¥ {{ fmt(summary.totalMarketValueCny) }}</b>
            </span>
            <span class="tb-item" :class="cls(summary.totalUnrealizedCny)">
              <em>合计浮盈</em>
              <b>
                {{ summary.totalUnrealizedCny > 0 ? '+' : '' }}{{ fmt(summary.totalUnrealizedCny) }}
                <i>{{ pctText(summary.totalUnrealizedPct) }}</i>
              </b>
            </span>
            <span class="tb-item" :class="cls(summary.realizedCny)">
              <em>已实现</em>
              <b>{{ summary.realizedCny > 0 ? '+' : '' }}{{ fmt(summary.realizedCny) }}</b>
            </span>
          </div>

          <!-- ===== 持仓明细 ===== -->
          <h3 class="sec-title">当前持仓</h3>
          <div v-if="positions.length" class="pos-table">
            <div class="pos-head">
              <span>标的</span>
              <span class="num">现价</span>
              <span class="num">数量</span>
              <span class="num">成本</span>
              <span class="num">市值</span>
              <span class="num">浮动盈亏</span>
            </div>
            <div v-for="p in positions" :key="p.code + p.market" class="pos-row">
              <span class="pos-name">
                <b>{{ p.name || p.code }}</b>
                <em class="pos-code">{{ p.code }} · {{ CUR_NAME[p.currency] || p.currency }}</em>
              </span>
              <span class="num pos-price">
                <template v-if="p.price != null">
                  <b>{{ fmt(p.price) }}</b>
                  <em :class="cls(p.changePct ?? 0)">{{ pctText(p.changePct ?? 0) }}</em>
                </template>
                <em v-else class="muted">—</em>
              </span>
              <span class="num">{{ p.quantity }}</span>
              <span class="num muted">{{ fmt(p.avgCost) }}</span>
              <span class="num">{{ fmt(p.marketValue ?? 0) }}</span>
              <span class="num pos-pnl" :class="cls(p.unrealized ?? 0)">
                <template v-if="p.unrealized != null">
                  <b>{{ p.unrealized > 0 ? '+' : '' }}{{ fmt(p.unrealized) }}</b>
                  <em>{{ pctText(p.unrealizedPct ?? 0) }}</em>
                </template>
                <em v-else class="muted">未报价</em>
              </span>
            </div>
          </div>
          <p v-else class="empty-hint">还没有记录。在下面新增一笔买入。</p>

          <!-- 新增记录 -->
          <h3 class="sec-title">记一笔</h3>
          <div class="form-grid">
            <label class="code-field">
              代码
              <input
                v-model="form.code"
                placeholder="600519 / 00700 / AAPL / 161131"
                spellcheck="false"
                @input="onCodeInput"
                @blur="onCodeBlur"
              />
              <span v-if="resolving" class="field-tip">查询中…</span>
              <span v-else-if="form.name" class="field-tip ok">✓ {{ form.name }}</span>
              <span v-else-if="resolveError" class="field-tip err">{{ resolveError }}</span>
            </label>
            <label>
              名称
              <input v-model="form.name" placeholder="输入代码后自动带出，可手改" />
            </label>
            <label>
              市场
              <select :value="form.market" @change="onMarketChange(($event.target as HTMLSelectElement).value)">
                <option value="A">A股（人民币）</option>
                <option value="HK">港股（港币）</option>
                <option value="US">美股（美元）</option>
                <option value="FUND">基金（人民币）</option>
              </select>
            </label>
            <label>
              方向
              <select v-model="form.side">
                <option value="buy">买入</option>
                <option value="sell">卖出</option>
              </select>
            </label>
            <label>交易所/券商<input v-model="form.venue" placeholder="如 华泰 / 富途 / IBKR" /></label>
            <label>日期<input v-model="form.tradeDate" type="date" /></label>
            <label>数量<input v-model.number="form.quantity" type="number" min="0" step="any" /></label>
            <label>成交价<input v-model.number="form.price" type="number" min="0" step="any" /></label>
            <label>
              手续费
              <input v-model.number="form.fee" type="number" min="0" step="any" />
            </label>
            <label>
              币种
              <select v-model="form.currency">
                <option value="CNY">人民币</option>
                <option value="HKD">港币</option>
                <option value="USD">美元</option>
              </select>
            </label>
            <label class="wide">备注<input v-model="form.note" placeholder="可选" /></label>
          </div>
          <div class="form-actions">
            <button class="pill-btn primary" :disabled="submitting" @click="addTrade">
              {{ submitting ? '保存中…' : '保存这笔' }}
            </button>
          </div>

          <!-- 汇率 -->
          <h3 class="sec-title">汇率（1 外币 = ? 人民币）</h3>
          <div class="fx-row">
            <label v-for="r in fxRates" :key="r.currency" class="fx-item">
              {{ r.currency }}
              <input
                :value="r.cnyRate"
                type="number"
                step="0.0001"
                min="0"
                @change="saveFx(r.currency, Number(($event.target as HTMLInputElement).value))"
              />
            </label>
          </div>

          <!-- 流水 -->
          <h3 class="sec-title">全部记录</h3>
          <div v-if="trades.length" class="trade-list">
            <div v-for="t in trades" :key="t.id" class="trade-row">
              <span class="t-date">{{ t.tradeDate }}</span>
              <span class="t-side" :class="t.side">{{ t.side === 'buy' ? '买入' : '卖出' }}</span>
              <span class="t-name">{{ t.name || t.code }}</span>
              <span class="t-num">{{ t.quantity }} × {{ fmt(t.price) }} {{ t.currency }}</span>
              <span class="t-fee">费 {{ fmt(t.fee) }}</span>
              <span class="t-venue">{{ t.venue || '—' }}</span>
              <button class="t-del" title="删除" @click="removeTrade(t.id)">×</button>
            </div>
          </div>
          <p v-else class="empty-hint">还没有任何买卖记录</p>
        </template>
      </section>
    </template>
  </PageShell>

  <!-- ========== K线弹层 ========== -->
  <Teleport to="body">
    <div v-if="detail" class="overlay" @click.self="detail = null">
      <div class="modal">
        <header class="m-head">
          <div>
            <h2>{{ detail.title }}</h2>
            <p class="m-sub">
              <span>{{ detail.symbol }}</span>
              <template v-if="detail.quote">
                <span class="m-price">{{ fmt(detail.quote.price) }}</span>
                <span :class="cls(detail.quote.changePct)">{{ pctText(detail.quote.changePct) }}</span>
              </template>
            </p>
          </div>
          <button class="m-close" @click="detail = null">×</button>
        </header>

        <div class="m-periods">
          <button :class="{ on: detail.period === 'day' }" @click="switchPeriod('day')">日</button>
          <button :class="{ on: detail.period === 'week' }" @click="switchPeriod('week')">周</button>
          <button :class="{ on: detail.period === 'month' }" @click="switchPeriod('month')">月</button>
        </div>

        <div v-if="klineLoading" class="m-loading">加载中…</div>
        <div v-else-if="chart" class="chart-wrap">
          <svg :viewBox="`0 0 ${chart.W} ${chart.H}`" preserveAspectRatio="none" class="chart">
            <line
              v-for="(c, i) in chart.candles"
              :key="`w${i}`"
              :x1="c.cx"
              :x2="c.cx"
              :y1="c.wickTop"
              :y2="c.wickBottom"
              stroke="#cbd5e1"
              stroke-width="0.6"
            />
            <rect
              v-for="(c, i) in chart.candles"
              :key="`b${i}`"
              :x="c.cx - c.w / 2"
              :y="c.top"
              :width="c.w"
              :height="c.h"
              :fill="c.up ? '#e5484d' : '#12a594'"
            />
            <polyline :points="chart.line" fill="none" stroke="#1f6feb" stroke-width="1.2" opacity="0.5" />
          </svg>
          <div class="chart-meta">
            <span>{{ chart.first }} → {{ chart.last }}</span>
            <span>最高 {{ fmt(chart.max) }} / 最低 {{ fmt(chart.min) }}</span>
          </div>
        </div>
        <p v-else class="empty-hint">暂无 K 线数据</p>
      </div>
    </div>
  </Teleport>

  <!-- ========== 基金持仓弹层 ========== -->
  <Teleport to="body">
    <div v-if="fund" class="overlay" @click.self="fund = null">
      <div class="modal narrow">
        <header class="m-head">
          <div>
            <h2>{{ fund.name || fund.code }}</h2>
            <p class="m-sub">
              <span>{{ fund.code }}</span>
              <span v-if="fund.reportDate">报告期 {{ fund.reportDate }}</span>
            </p>
          </div>
          <button class="m-close" @click="fund = null">×</button>
        </header>

        <div v-if="fundLoading" class="m-loading">加载中…</div>
        <div v-else-if="fund.holdings.length" class="holding-list">
          <div class="holding-head"><span>股票</span><span>占净值</span></div>
          <div v-for="h in fund.holdings" :key="h.code" class="holding-row">
            <span class="h-left">
              <span class="h-name">{{ h.name }}</span>
              <span class="h-code">{{ h.code }}</span>
            </span>
            <span class="h-ratio">{{ h.ratio || '—' }}</span>
          </div>
        </div>
        <p v-else class="empty-hint">{{ fund.error || '暂无持仓明细' }}</p>
      </div>
    </div>
  </Teleport>
</template>

<style scoped>
/* ---------- 搜索 ---------- */
.search-row {
  display: flex;
  align-items: center;
  gap: 10px;
  width: 100%;
}

.search-box {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 7px 12px;
  border: 1px solid var(--line);
  border-radius: 9px;
  background: #fff;
}

.search-box input {
  flex: 1;
  border: 0;
  outline: 0;
  font-size: 13px;
  background: transparent;
}

.ico {
  font-size: 12px;
  opacity: 0.6;
}

.clear {
  border: 0;
  background: none;
  font-size: 16px;
  color: #98a2b3;
  cursor: pointer;
}

.search-panel {
  padding: 12px 16px;
  border-bottom: 1px solid var(--line);
  background: #fbfdff;
}

.result-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 8px;
}

.result {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  padding: 9px 12px;
  border: 1px solid var(--line);
  border-radius: 9px;
  background: #fff;
  cursor: pointer;
  text-align: left;
  transition: border-color 0.15s ease;
}

.result:hover {
  border-color: #b9d4f8;
}

.r-left {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.r-name {
  font-size: 13px;
  font-weight: 600;
  color: #101828;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.r-code {
  font-size: 11px;
  color: #98a2b3;
}

.r-right {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: none;
}

.r-tag {
  padding: 1px 6px;
  border-radius: 4px;
  font-size: 10px;
  background: #eef4ff;
  color: #1f6feb;
}

.r-tag.fund {
  background: #fff4e5;
  color: #b25e09;
}

.r-go {
  font-size: 11px;
  color: #98a2b3;
}

/* ---------- 搜索历史 ---------- */
.history-row {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
  padding: 10px 16px;
  border-bottom: 1px solid var(--line);
}

.h-label {
  font-size: 11px;
  color: #98a2b3;
}

.h-chip {
  padding: 3px 9px;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: #fff;
  font-size: 11px;
  color: #475467;
  cursor: pointer;
}

.h-chip:hover {
  border-color: #b9d4f8;
  color: #1f6feb;
}

/* ---------- Tabs ---------- */
.tabs {
  display: flex;
  gap: 6px;
  padding: 10px 16px;
  border-bottom: 1px solid var(--line);
}

.tabs button {
  padding: 5px 14px;
  border: 1px solid transparent;
  border-radius: 7px;
  background: #f2f4f7;
  font-size: 12.5px;
  color: #475467;
  cursor: pointer;
}

.tabs button.on {
  background: #1f6feb;
  color: #fff;
}

.panel-inner {
  padding: 14px 16px 18px;
}

.sec-title {
  margin: 16px 0 10px;
  font-size: 13px;
  font-weight: 700;
  color: #101828;
}

.sec-title:first-child {
  margin-top: 0;
}

.hint {
  margin-left: 6px;
  font-size: 11px;
  font-weight: 400;
  color: #98a2b3;
}

/* ---------- 板块 ---------- */
.sector-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 8px;
}

.sector {
  display: flex;
  flex-direction: column;
  gap: 3px;
  padding: 9px 11px;
  border: 1px solid var(--line);
  border-radius: 9px;
  background: #fff;
}

.s-name {
  font-size: 12.5px;
  font-weight: 600;
  color: #101828;
}

.s-pct {
  font-size: 14px;
  font-weight: 700;
}

.s-counts {
  font-size: 10.5px;
  color: #98a2b3;
}

/* ---------- 报价列表 ---------- */
.quote-list {
  display: flex;
  flex-direction: column;
  border: 1px solid var(--line);
  border-radius: 9px;
  overflow: hidden;
}

.quote-row {
  display: grid;
  grid-template-columns: 1.4fr 1fr 0.8fr;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  border: 0;
  border-bottom: 1px solid #f2f4f7;
  background: #fff;
  cursor: pointer;
  text-align: left;
}

.quote-row:last-child {
  border-bottom: 0;
}

.quote-row:hover {
  background: #fafcff;
}

.q-left {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.q-name {
  font-size: 13px;
  font-weight: 600;
  color: #101828;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.q-code {
  font-size: 10.5px;
  color: #98a2b3;
}

.q-mid {
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.q-price {
  font-size: 14px;
  font-weight: 700;
  color: #101828;
}

.q-pct {
  font-size: 12px;
  font-weight: 600;
}

.q-right {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 8px;
}

.q-amt {
  font-size: 12px;
}

.q-go {
  font-size: 10.5px;
  color: #98a2b3;
}

/* ---------- 涨跌配色（A股习惯：红涨绿跌）---------- */
.up {
  color: #e5484d;
}

.down {
  color: #12a594;
}

.flat {
  color: #667085;
}

/* ---------- 我的持仓 ---------- */
.cred-row {
  display: flex;
  align-items: flex-end;
  gap: 10px;
  flex-wrap: wrap;
}

.cred-field {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.cred-field label {
  font-size: 11px;
  color: #667085;
}

.cred-field input {
  width: 170px;
  padding: 7px 10px;
  border: 1px solid var(--line);
  border-radius: 8px;
  font-size: 12.5px;
}

.cred-hint {
  margin: 8px 0 0;
  font-size: 11px;
  color: #98a2b3;
}

.err {
  margin: 8px 0 0;
  font-size: 12px;
  color: #e5484d;
}

/* ---------- 分币种总览 ---------- */
.cur-board {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 12px;
  margin: 16px 0 12px;
}

.cur-col {
  position: relative;
  padding: 14px 16px 12px;
  border: 1px solid var(--line);
  border-radius: 13px;
  background: #fff;
  box-shadow: 0 1px 3px rgba(16, 24, 40, 0.05);
  overflow: hidden;
}

/* 左侧状态色条：涨红 / 跌绿 */
.cur-col::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 3px;
  background: #d0d5dd;
}

.cur-col.up::before {
  background: #e5484d;
}

.cur-col.down::before {
  background: #12a594;
}

.cur-head {
  display: flex;
  align-items: center;
  gap: 7px;
  margin-bottom: 10px;
}

.cur-sign {
  display: grid;
  place-items: center;
  min-width: 24px;
  height: 24px;
  padding: 0 5px;
  border-radius: 7px;
  background: #f2f4f7;
  font-size: 12px;
  font-weight: 700;
  color: #475467;
}

.cur-name {
  font-size: 12px;
  color: #667085;
}

.cur-count {
  margin-left: auto;
  font-size: 11px;
  color: #98a2b3;
}

.cur-main {
  display: flex;
  flex-direction: column;
  gap: 2px;
  margin-bottom: 12px;
}

.cur-label {
  font-size: 11px;
  color: #98a2b3;
}

.cur-pnl {
  font-size: 22px;
  font-weight: 800;
  letter-spacing: -0.5px;
  color: #101828;
}

.cur-col.up .cur-pnl {
  color: #e5484d;
}

.cur-col.down .cur-pnl {
  color: #12a594;
}

.cur-pnl em {
  margin-left: 6px;
  font-size: 12px;
  font-style: normal;
  font-weight: 600;
  opacity: 0.85;
}

.cur-detail {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px;
  margin: 0;
  padding-top: 10px;
  border-top: 1px dashed #eaecf0;
}

.cur-detail div {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.cur-detail dt {
  font-size: 10.5px;
  color: #98a2b3;
}

.cur-detail dd {
  margin: 0;
  font-size: 12.5px;
  font-weight: 600;
  color: #344054;
  overflow: hidden;
  text-overflow: ellipsis;
}

.cur-warn {
  margin: 8px 0 0;
  font-size: 10.5px;
  color: #b54708;
}

/* ---------- 折算合计条 ---------- */
.total-bar {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 10px 24px;
  padding: 11px 16px;
  border: 1px solid var(--line);
  border-radius: 11px;
  background: #f8fafc;
}

.tb-item {
  display: flex;
  align-items: baseline;
  gap: 7px;
}

.tb-item em {
  font-size: 11px;
  font-style: normal;
  color: #667085;
}

.tb-item b {
  font-size: 13.5px;
  font-weight: 700;
  color: #101828;
}

.tb-item b i {
  margin-left: 4px;
  font-size: 11px;
  font-style: normal;
  font-weight: 600;
}

.tb-item.up b {
  color: #e5484d;
}

.tb-item.down b {
  color: #12a594;
}

/* ---------- 表单小提示 ---------- */
.code-field {
  position: relative;
}

.field-tip {
  font-size: 10.5px;
  color: #98a2b3;
}

.field-tip.ok {
  color: #12a594;
}

.field-tip.err {
  color: #e5484d;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 10px;
}

.form-grid label {
  display: flex;
  flex-direction: column;
  gap: 4px;
  font-size: 11px;
  color: #667085;
}

.form-grid input,
.form-grid select {
  padding: 7px 10px;
  border: 1px solid var(--line);
  border-radius: 8px;
  font-size: 12.5px;
  background: #fff;
}

.form-grid .wide {
  grid-column: 1 / -1;
}

.form-actions {
  margin-top: 12px;
}

.fx-row {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.fx-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #667085;
}

.fx-item input {
  width: 90px;
  padding: 6px 8px;
  border: 1px solid var(--line);
  border-radius: 7px;
  font-size: 12.5px;
}

.trade-list {
  border: 1px solid var(--line);
  border-radius: 9px;
  overflow: hidden;
}

.trade-row {
  display: grid;
  grid-template-columns: 90px 54px 1.3fr 1.3fr 80px 1fr 28px;
  gap: 8px;
  align-items: center;
  padding: 9px 12px;
  border-bottom: 1px solid #f2f4f7;
  font-size: 12px;
}

.trade-row:last-child {
  border-bottom: 0;
}

.t-date {
  color: #667085;
}

.t-side {
  padding: 1px 6px;
  border-radius: 4px;
  font-size: 10.5px;
  text-align: center;
}

.t-side.buy {
  background: #fdecec;
  color: #e5484d;
}

.t-side.sell {
  background: #e9f7f4;
  color: #12a594;
}

.t-name {
  font-weight: 600;
  color: #101828;
}

.t-num,
.t-fee {
  color: #475467;
}

.t-venue {
  color: #98a2b3;
  font-size: 11px;
}

.t-del {
  border: 0;
  background: none;
  color: #98a2b3;
  font-size: 15px;
  cursor: pointer;
}

.t-del:hover {
  color: #e5484d;
}

.empty-hint {
  margin: 10px 0;
  font-size: 12px;
  color: #98a2b3;
}

.skeleton-block {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 8px;
  padding: 16px;
}

.skeleton {
  height: 64px;
  border-radius: 9px;
  background: linear-gradient(90deg, #f2f4f7, #f9fafb, #f2f4f7);
  background-size: 200% 100%;
  animation: shimmer 1.2s infinite;
}

@keyframes shimmer {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}

.alert {
  margin: 12px 16px;
  padding: 10px 12px;
  border: 1px solid #fecdca;
  border-radius: 8px;
  background: #fef3f2;
  color: #b42318;
  font-size: 12px;
}

/* ---------- 弹层 ---------- */
.overlay {
  position: fixed;
  inset: 0;
  z-index: 80;
  display: grid;
  place-items: center;
  padding: 20px;
  background: rgba(16, 24, 40, 0.45);
}

.modal {
  width: min(960px, 100%);
  max-height: 88vh;
  overflow: auto;
  border-radius: 14px;
  background: #fff;
  box-shadow: 0 20px 48px rgba(16, 24, 40, 0.24);
}

.modal.narrow {
  width: min(520px, 100%);
}

.m-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
  padding: 16px 18px 10px;
  border-bottom: 1px solid var(--line);
}

.m-head h2 {
  margin: 0;
  font-size: 17px;
  font-weight: 700;
  color: #101828;
}

.m-sub {
  margin: 4px 0 0;
  display: flex;
  gap: 10px;
  align-items: baseline;
  font-size: 11.5px;
  color: #98a2b3;
}

.m-price {
  font-size: 14px;
  font-weight: 700;
  color: #101828;
}

.m-close {
  border: 0;
  background: none;
  font-size: 20px;
  line-height: 1;
  color: #98a2b3;
  cursor: pointer;
}

.m-periods {
  display: flex;
  gap: 6px;
  padding: 10px 18px;
}

.m-periods button {
  padding: 4px 12px;
  border: 1px solid var(--line);
  border-radius: 7px;
  background: #fff;
  font-size: 12px;
  color: #475467;
  cursor: pointer;
}

.m-periods button.on {
  background: #1f6feb;
  border-color: #1f6feb;
  color: #fff;
}

.chart-wrap {
  padding: 0 18px 16px;
}

.chart {
  width: 100%;
  height: 320px;
  display: block;
}

.chart-meta {
  display: flex;
  justify-content: space-between;
  margin-top: 6px;
  font-size: 11px;
  color: #98a2b3;
}

.m-loading {
  padding: 40px 18px;
  text-align: center;
  font-size: 12px;
  color: #98a2b3;
}

.holding-list {
  padding: 6px 18px 16px;
  font-size: 12.5px;
}

.holding-head,
.holding-row {
  display: grid;
  grid-template-columns: 1fr 90px;
  gap: 10px;
  padding: 9px 0;
  align-items: center;
}

.holding-head {
  font-size: 11px;
  color: #667085;
  border-bottom: 1px solid var(--line);
}

.holding-row {
  border-bottom: 1px solid #f2f4f7;
}

.h-name {
  font-weight: 600;
  color: #101828;
}

.h-code {
  margin-left: 6px;
  font-size: 11px;
  color: #98a2b3;
}

.h-ratio {
  text-align: right;
  font-weight: 600;
  color: #1f6feb;
}

@media (max-width: 720px) {
  .quote-row {
    grid-template-columns: 1.2fr 1fr 0.7fr;
  }

  .pos-head,
  .pos-row {
    grid-template-columns: 1.4fr 0.8fr 1fr;
  }

  .pos-head span:nth-child(n + 4),
  .pos-row span:nth-child(n + 4) {
    display: none;
  }

  .trade-row {
    grid-template-columns: 80px 46px 1fr 60px;
  }

  .trade-row .t-num,
  .trade-row .t-venue {
    display: none;
  }

  .chart {
    height: 220px;
  }
}
</style>