import { FEEDS, CATEGORIES, type FeedCategory, type FeedRender, type FeedSpec } from '../config/feeds'
import { getDb } from './mongo'
import { httpFetch } from './http'

/** 分类展示顺序（跟 config 里一致） */
const CATEGORY_ORDER = CATEGORIES.map((c) => c.key)

/**
 * 60s API 采集器。
 *
 * 上游 50 个端点返回结构各不相同，这里统一归一化成三种 payload：
 *   list   → 榜单/资讯列表
 *   fields → 键值对
 *   text   → 单段文本
 * 入库后前端只按这三种形态渲染，新增端点只需在 config/feeds.ts 里加一行。
 */

export interface NormalizedItem {
  rank?: number
  title: string
  desc?: string
  value?: string
  link?: string
  cover?: string
  badge?: string
}

export type NormalizedPayload =
  | { kind: 'list'; items: NormalizedItem[]; total: number }
  | { kind: 'fields'; fields: Array<{ label: string; value: string }> }
  | { kind: 'text'; text: string; sub?: string }
  | { kind: 'image'; image: string; title?: string; desc?: string }

export interface FeedDoc {
  key: string
  path: string
  title: string
  desc?: string
  category: FeedCategory
  render: FeedRender
  ok: boolean
  code: number
  error: string | null
  payload: NormalizedPayload | null
  rawSize: number
  payloadBytes: number
  fetchedAt: Date
  upstreamUpdatedAt: Date | null
  lastTryAt: Date
}

const COLLECTION = 'feed_snapshots'
const CONCURRENCY = 4
const TIMEOUT_MS = 15_000

/** 常见字段的中文标签（没命中的就用原字段名） */
const FIELD_LABELS: Record<string, string> = {
  ip: 'IP',
  country: '国家',
  province: '省份',
  city: '城市',
  county: '区县',
  region: '地区',
  areacode: '区号',
  isp: '运营商',
  owner: '归属',
  timezone: '时区',
  continent: '大洲',
  lat: '纬度',
  lng: '经度',
  condition: '天气',
  condition_code: '天气码',
  temperature: '温度',
  humidity: '湿度',
  pressure: '气压',
  precipitation: '降水',
  wind_direction: '风向',
  wind_power: '风力',
  air_quality: '空气质量',
  aqi: 'AQI',
  pm25: 'PM2.5',
  pm10: 'PM10',
  sunrise: '日出',
  sunset: '日落',
  solar: '公历',
  lunar: '农历',
  term: '节气',
  zodiac: '生肖',
  festival: '节日',
  legal_holiday: '法定假日',
  taboo: '宜忌',
  constellation: '星座',
  base_code: '基准货币',
  rates: '汇率',
  updated: '上游更新时间',
  date: '日期',
  today: '今天',
  progress: '进度',
  currentHoliday: '当前假期',
  nextHoliday: '下个假期',
  nextWeekend: '下个周末',
  countdown: '倒计时',
  moyuQuote: '摸鱼语录',
  password: '密码',
  length: '长度',
  hex: 'HEX',
  rgb: 'RGB',
  hsl: 'HSL',
  hsv: 'HSV',
  cmyk: 'CMYK',
  lab: 'LAB',
  brightness: '亮度',
  name: '名称',
  location: '位置',
  metals: '贵金属',
  stores: '品牌金店',
  banks: '银行',
  recycle: '回收价',
  items: '条目',
  tip: '小贴士',
  headline: '标题',
  main_text: '正文',
  copyright: '版权',
  cover: '封面',
  image: '图片',
  weather: '实况',
  air_quality: '空气质量',
  life_indices: '生活指数',
  alerts: '预警',
  hourly_forecast: '逐小时预报',
  daily_forecast: '逐日预报',
  sunrise_sunset: '日出日落',
  next_updated: '下次更新',
  next_updated_at: '下次更新时间',
  base_code: '基准货币',
  stats: '统计',
  sixty_cycle: '干支',
  phase: '月相',
  julian_day: '儒略日',
  rate: '汇率',
  year: '年份',
  month: '月',
  day: '日',
  week_desc: '星期',
  season_desc: '季节',
  hour: '时',
  minute: '分',
  second: '秒',
  week: '周',
  day_of_year: '年内第几天',
  week_of_year: '年内第几周',
  week_of_month: '月内第几周',
  position: '位置',
  name_short: '简称',
  gregorian: '公历',
  weekday: '星期',
  dayOfWeek: '周几',
  isWeekend: '周末',
  isHoliday: '假期',
  isWorkday: '工作日',
  lunarFestivals: '农历节日',
  daysUntil: '还有几天',
  toWeekEnd: '距周末',
  toFriday: '距周五',
  toMonthEnd: '距月末',
  toYearEnd: '距年末',
  year_baizi: '年纳音',
  day_baizi: '日纳音',
  hours: '时辰',
  desc_short: '简称',
  year_desc: '年',
  is_leap_year: '闰年',
  update_date: '更新日期',
  palettes: '调色板',
  color_theory: '色彩理论',
  total_palettes: '调色板数量',
  applications: '应用场景',
  include_numbers: '包含数字',
  include_symbols: '包含符号',
  include_lowercase: '包含小写',
  include_uppercase: '包含大写',
  exclude_similar: '排除相似字符',
  exclude_ambiguous: '排除易混淆字符',
  lowercase: '小写字母',
  uppercase: '大写字母',
  numbers: '数字',
  symbols: '符号',
  input: '输入',
  metadata: '元数据',
  config: '配置',
  character_sets: '字符集',
  generation_info: '生成信息',
  title: '标题',
  description: '描述',
  index: '序号'
}

/** 技术性 / 冗余字段直接跳过，避免卡片被无意义数据挤满 */
const SKIP_KEYS = new Set([
  'api_updated',
  'api_updated_at',
  'created_at',
  'updated_at',
  'julian_day',
  'full_with_time',
  'full',
  'hour',
  'minute',
  'second',
  'radius',
  'accuracy',
  'adcode',
  'asnumber',
  'week_desc_short',
  'season_desc_short',
  'season_name',
  'season_name_desc',
  'update_date_at'
])

/** 单个嵌套对象最多展开多少字段 */
/** 单个榜单最多保留条数（上游热搜一般给 50 条） */
const MAX_LIST_ITEMS = 60

const INNER_FIELD_LIMIT = 6

/** 汇率里优先展示的货币 */
const CURRENCY_PRIORITY = ['USD', 'EUR', 'JPY', 'GBP', 'HKD', 'CNY', 'KRW', 'AUD', 'CAD', 'SGD', 'CHF', 'THB']

function labelOf(key: string): string {
  return FIELD_LABELS[key] || key
}

function getPath(obj: unknown, path?: string): unknown {
  if (!path) return undefined
  if (path === 'self') return obj
  return path.split('.').reduce<unknown>((acc, k) => (acc == null ? acc : (acc as Record<string, unknown>)[k]), obj)
}

function formatValue(v: unknown): string {
  if (v === null || v === undefined) return ''
  if (typeof v === 'boolean') return v ? '是' : '否'
  if (typeof v === 'number') {
    // 毫秒时间戳
    if (v > 1e12 && v < 2e12) {
      const d = new Date(v)
      return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`
    }
    // 年份不加千分位
    if (Number.isInteger(v) && v >= 1900 && v <= 2100) return String(v)
    // 热度这类大数用中文单位，卡片右侧才放得下
    if (Number.isInteger(v)) {
      if (v >= 100_000_000) return `${(v / 1e8).toFixed(1).replace(/\.0$/, '')}亿`
      if (v >= 10_000) return `${(v / 1e4).toFixed(1).replace(/\.0$/, '')}万`
      return v.toLocaleString('en-US')
    }
    return String(Number(v.toFixed(2)))
  }
  if (Array.isArray(v)) return formatArrayPreview(v)
  if (typeof v === 'object') return ''
  const s = String(v)
  return s.length > 80 ? `${s.slice(0, 80)}…` : s
}

/** 数组字段：能识别「键值对数组」就挑前几项展开，否则只报数量 */
function formatArrayPreview(arr: unknown[]): string {
  if (!arr.length) return '—'

  if (typeof arr[0] !== 'object' || arr[0] === null) {
    const head = arr.slice(0, 12).map((x) => String(x))
    return `${head.join(' · ')}${arr.length > 12 ? ` …共 ${arr.length} 项` : ''}`
  }

  const first = arr[0] as Record<string, unknown>
  const keyField = ['code', 'currency', 'name', 'title', 'label', 'date'].find((f) => f in first)
  const valField = ['rate', 'value', 'price', 'score', 'box_office_desc', 'temperature'].find((f) => f in first)

  if (keyField && valField) {
    const head = arr
      .slice(0, 10)
      .map((x) => {
        const o = x as Record<string, unknown>
        return `${formatValue(o[keyField])} ${formatValue(o[valField])}`
      })
      .filter(Boolean)
    return `${head.join(' · ')}${arr.length > 10 ? ` …共 ${arr.length} 项` : ''}`
  }

  return `共 ${arr.length} 项`
}

function toItem(el: unknown, spec: FeedSpec, index: number): NormalizedItem {
  if (typeof el === 'string') {
    return { rank: index + 1, title: el }
  }
  const obj = (el || {}) as Record<string, unknown>
  const m = spec.map || {}
  const titleRaw = m.title === 'self' ? obj : getPath(obj, m.title)
  const title =
    formatValue(titleRaw) ||
    formatValue(obj.title) ||
    formatValue(obj.name) ||
    formatValue(obj.movie_name) ||
    formatValue(obj.question) ||
    `#${index + 1}`

  return {
    rank: typeof obj.rank === 'number' ? obj.rank : index + 1,
    title,
    desc: m.desc ? formatValue(getPath(obj, m.desc)) || undefined : undefined,
    value: m.value ? formatValue(getPath(obj, m.value)) || undefined : undefined,
    link: m.link ? String(getPath(obj, m.link) ?? '') || undefined : undefined,
    cover: m.cover ? String(getPath(obj, m.cover) ?? '') || undefined : undefined,
    badge: m.badge ? formatValue(getPath(obj, m.badge)) || undefined : undefined
  }
}

/** 把一个端点的原始 data 归一化 */
export function normalize(spec: FeedSpec, data: unknown): NormalizedPayload {
  if (spec.render === 'image') {
    const obj = (data || {}) as Record<string, unknown>
    const image = String(getPath(obj, spec.textField) || obj.cover || obj.image || '')
    const title = formatValue(getPath(obj, spec.map?.title) ?? obj.title ?? obj.headline)
    const desc = formatValue(getPath(obj, spec.map?.desc) ?? obj.description ?? obj.copyright)
    return { kind: 'image', image, title: title || undefined, desc: desc || undefined }
  }

  if (spec.render === 'text') {
    const text = formatValue(getPath(data, spec.textField) ?? data)
    const sub = spec.textSubField ? formatValue(getPath(data, spec.textSubField)) : ''
    return { kind: 'text', text: text || '（本次没有拿到内容）', sub: sub || undefined }
  }

  if (spec.render === 'fields') {
    const obj = (data || {}) as Record<string, unknown>
    const fields: Array<{ label: string; value: string }> = []

    for (const [k, v] of Object.entries(obj)) {
      if (SKIP_KEYS.has(k)) continue

      // 嵌套一层展开（rates / weather / location / solar…）
      if (v && typeof v === 'object' && !Array.isArray(v)) {
        const entries = Object.entries(v as Record<string, unknown>).filter(([k2]) => !SKIP_KEYS.has(k2))
        const ordered =
          k === 'rates'
            ? [...entries].sort(
                (a, b) =>
                  (CURRENCY_PRIORITY.indexOf(a[0]) + 1 || 99) - (CURRENCY_PRIORITY.indexOf(b[0]) + 1 || 99)
              )
            : // 有中文映射的字段排前面，其余按原顺序
              [...entries].sort((a, b) => (FIELD_LABELS[a[0]] ? 0 : 1) - (FIELD_LABELS[b[0]] ? 0 : 1))

        let innerCount = 0
        for (const [k2, v2] of ordered) {
          if (v2 && typeof v2 === 'object' && !Array.isArray(v2)) continue
          const val = formatValue(v2)
          if (!val) continue
          // 外层有中文名时才拼「外层 · 内层」，否则直接用内层标签，避免出现 "country · 国家"
          const outerLabel = FIELD_LABELS[k]
          fields.push({ label: outerLabel ? `${outerLabel} · ${labelOf(k2)}` : labelOf(k2), value: val })
          if (++innerCount >= INNER_FIELD_LIMIT) break
          if (fields.length >= 28) break
        }
      } else {
        const val = formatValue(v)
        if (!val) continue
        fields.push({ label: labelOf(k), value: val })
      }
      if (fields.length >= 28) break
    }

    return { kind: 'fields', fields }
  }

  // list
  let arr: unknown[] = []
  if (Array.isArray(data)) arr = data
  else if (spec.listPath) {
    const maybe = getPath(data, spec.listPath)
    if (Array.isArray(maybe)) arr = maybe
  }
  const total = arr.length
  // 全量保留（热搜榜上游给 50 条）。单个文档最大约 45KB，可接受；
  // 列表接口用 $slice 在数据库侧就裁掉，只有详情/卡片滚动才会取到全量。
  const items = arr.slice(0, MAX_LIST_ITEMS).map((el, i) => toItem(el, spec, i))
  return { kind: 'list', items, total }
}

function upstreamUpdated(data: unknown): Date | null {
  const obj = (data || {}) as Record<string, unknown>
  const candidates = [obj.updated_at, obj.update_time_at, obj.api_updated_at, obj.created_at]
  for (const c of candidates) {
    if (typeof c === 'number' && c > 1e12) return new Date(c)
    if (typeof c === 'string') {
      const t = Date.parse(c)
      if (Number.isFinite(t)) return new Date(t)
    }
  }
  return null
}

async function fetchOne(spec: FeedSpec, base: string): Promise<{ spec: FeedSpec; json: any | null; error: string | null; size: number }> {
  try {
    const res = await httpFetch(`${base}${spec.path}`, {
      headers: { Accept: 'application/json', 'User-Agent': 'github-trending-daily/1.0' }
    } as RequestInit)
    const text = await res.text()
    if (!res.ok) return { spec, json: null, error: `HTTP ${res.status}`, size: text.length }
    const json = JSON.parse(text)
    if (json?.code !== 200) return { spec, json: null, error: `API code ${json?.code ?? '?'}`, size: text.length }
    return { spec, json, error: null, size: text.length }
  } catch (err) {
    return { spec, json: null, error: err instanceof Error ? err.message : String(err), size: 0 }
  }
}

export interface CollectResult {
  total: number
  ok: number
  failed: number
  durationMs: number
  failures: Array<{ key: string; error: string }>
  at: string
}

let collecting = false

export function isCollecting(): boolean {
  return collecting
}

/** 抓取全部端点并 upsert 到 MongoDB（失败不清空旧数据） */
export async function collectFeeds(): Promise<CollectResult> {
  if (collecting) {
    return { total: 0, ok: 0, failed: 0, durationMs: 0, failures: [], at: new Date().toISOString() }
  }
  collecting = true

  const started = Date.now()
  const base = appConfig().feedsBase
  const db = await getDb()
  const col = db.collection<FeedDoc>(COLLECTION)

  const results: Array<{ spec: FeedSpec; json: any | null; error: string | null; size: number }> = []

  try {
    for (let i = 0; i < FEEDS.length; i += CONCURRENCY) {
      const batch = FEEDS.slice(i, i + CONCURRENCY)
      results.push(...(await Promise.all(batch.map((spec) => fetchOne(spec, base)))))
    }

    const now = new Date()
    const okOps: Parameters<typeof col.bulkWrite>[0] = []
    const failOps: Parameters<typeof col.bulkWrite>[0] = []
    const failures: Array<{ key: string; error: string }> = []

    for (const r of results) {
      if (r.error || !r.json) {
        failures.push({ key: r.spec.key, error: r.error || 'empty' })
        // 只记录失败，保留上一次成功的数据
        failOps.push({
          updateOne: {
            filter: { key: r.spec.key },
            update: {
              $set: { error: r.error || 'empty', lastTryAt: now, ok: false },
              $setOnInsert: {
                key: r.spec.key,
                path: r.spec.path,
                title: r.spec.title,
                desc: r.spec.desc,
                category: r.spec.category,
                render: r.spec.render,
                code: 0,
                payload: null,
                rawSize: 0,
                payloadBytes: 0,
                fetchedAt: now,
                upstreamUpdatedAt: null
              }
            },
            upsert: true
          }
        })
        continue
      }

      const payload = normalize(r.spec, r.json.data)
      okOps.push({
        updateOne: {
          filter: { key: r.spec.key },
          update: {
            $set: {
              path: r.spec.path,
              title: r.spec.title,
              desc: r.spec.desc,
              category: r.spec.category,
              render: r.spec.render,
              ok: true,
              code: r.json.code,
              error: null,
              payload,
              rawSize: r.size,
              payloadBytes: JSON.stringify(payload).length,
              fetchedAt: now,
              upstreamUpdatedAt: upstreamUpdated(r.json.data),
              lastTryAt: now
            }
          },
          upsert: true
        }
      })
    }

    if (okOps.length) await col.bulkWrite(okOps, { ordered: false })
    if (failOps.length) await col.bulkWrite(failOps, { ordered: false })

    // 配置里删掉的端点，库里的历史文档也要清掉，否则页面上会继续出现
    const validKeys = FEEDS.map((f) => f.key)
    const removed = await col.deleteMany({ key: { $nin: validKeys } })
    if (removed.deletedCount > 0) {
      console.log(`[feeds] 清理已下线的端点数据 ${removed.deletedCount} 条`)
    }

    // 新数据已入库，立刻让接口缓存失效（下次请求读新数据并重新缓存）
    invalidateCache('feeds:')
    invalidateCache(`feed:`)

    const ok = okOps.length
    const result: CollectResult = {
      total: FEEDS.length,
      ok,
      failed: failures.length,
      durationMs: Date.now() - started,
      failures,
      at: new Date().toISOString()
    }

    if (failures.length) {
      console.warn(`[feeds] ${failures.length} 个端点失败：${failures.map((f) => f.key).join(', ')}`)
    }
    return result
  } finally {
    collecting = false
  }
}

/**
 * 读取全部（或某个分类下）的端点数据。
 *
 * preview 存在时会用 MongoDB 的 $slice 投影，只取 list 类型的前 N 条——
 * 列表页一次拿 50 个端点，不裁剪的话单个响应能到 1MB+。
 */
export async function readFeeds(category?: string, preview?: number): Promise<FeedDoc[]> {
  const db = await getDb()
  const col = db.collection<FeedDoc>(COLLECTION)
  const filter = category && category !== 'all' ? { category } : {}

  const options = preview
    ? { projection: { 'payload.items': { $slice: preview }, snapshots: 0 } }
    : {}

  const docs = await col.find(filter, options as never).toArray()

  // 按 config 里声明的分类顺序排，而不是字母序（否则 daily 会跑到最前面）
  const order = new Map(CATEGORY_ORDER.map((k, i) => [k, i]))
  docs.sort((a, b) => {
    const ca = order.get(a.category as FeedCategory) ?? 99
    const cb = order.get(b.category as FeedCategory) ?? 99
    if (ca !== cb) return ca - cb
    return a.key.localeCompare(b.key)
  })
  return docs
}

export async function readFeed(key: string): Promise<FeedDoc | null> {
  const db = await getDb()
  return db.collection<FeedDoc>(COLLECTION).findOne({ key })
}

/**
 * 按分类统计端点数量。
 *
 * 注意不能拿「当前筛选后的结果」去算：请求 ?category=hot 时只返回 hot 的数据，
 * 其他分类的角标就会全变 0。这里单独做一次分组聚合（只读 category 字段，很快）。
 */
export async function countByCategory(): Promise<Record<string, number>> {
  const db = await getDb()
  const rows = await db
    .collection<{ category?: string }>(COLLECTION)
    .aggregate<{ _id: string; n: number }>([
      { $group: { _id: '$category', n: { $sum: 1 } } }
    ])
    .toArray()

  const out: Record<string, number> = {}
  for (const r of rows) {
    if (r._id) out[r._id] = r.n
  }
  return out
}
