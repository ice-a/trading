import { env } from '../utils/env'
import { sqlBatch } from '../utils/db'
import { listDnsRecords, updateDnsStatus } from '../utils/dns'

/**
 * GET /api/dns?probe=1&source=auto
 *
 * 数据有两层：
 *   1) 配置了 CF_API_TOKEN + CF_ZONE_IDS 时，直接调 Cloudflare API 拉真实 DNS 记录，
 *      并顺手把结果 upsert 进 dns_records 做本地缓存；
 *   2) 没配置或 API 失败时，回退到 dns_records 里的缓存（可手工维护）。
 *
 * ?probe=1 会对每条记录做一次 HEAD 探活，把延迟/状态写回库。
 */

interface CfRecord {
  id: string
  name: string
  type: string
  content: string
  proxied: boolean
  comment?: string | null
  ttl?: number
}

interface CfResponse {
  success: boolean
  errors?: Array<{ message: string }>
  result?: CfRecord[]
  result_info?: { total_count?: number }
}

function envToken(): string {
  return env('CF_API_TOKEN', '')
}

function envZones(): string[] {
  return env('CF_ZONE_IDS', '')
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean)
}

/**
 * CF_ZONE_IDS 允许填两种值：
 *   · 32 位 zone id（abcdef0123...）
 *   · 域名（example.com）—— 自动用 /zones?name= 反查真实 id
 *
 * 之前只支持前者，用户按习惯填了域名，Cloudflare 直接报
 * "Could not route to /zones/example.com/dns_records"，面板就空了。
 */
const ZONE_ID_RE = /^[0-9a-f]{32}$/i

async function resolveZoneId(raw: string, token: string): Promise<{ id: string; name?: string; error?: string }> {
  if (ZONE_ID_RE.test(raw)) return { id: raw }

  try {
    const res = await fetch(
      `https://api.cloudflare.com/client/v4/zones?name=${encodeURIComponent(raw)}&per_page=1`,
      {
        headers: { Authorization: `Bearer ${token}` },
        signal: AbortSignal.timeout(12_000)
      }
    )
    const body = (await res.json().catch(() => null)) as
      | { success?: boolean; errors?: Array<{ message?: string }>; result?: Array<{ id: string; name: string }> }
      | null

    if (!res.ok || !body?.success) {
      const msg = body?.errors?.[0]?.message || `HTTP ${res.status}`
      return { id: '', error: `解析 zone "${raw}" 失败：${msg}` }
    }
    const hit = body.result?.[0]
    if (!hit) return { id: '', error: `找不到 zone "${raw}"，检查 token 是否有该域名的访问权` }
    return { id: hit.id, name: hit.name }
  } catch (err) {
    return { id: '', error: `解析 zone "${raw}" 失败：${err instanceof Error ? err.message : String(err)}` }
  }
}

/** 从 CF 拉一个 zone 的 DNS 记录 */
async function fetchZoneRecords(zoneId: string, token: string): Promise<{ records: CfRecord[]; error?: string }> {
  try {
    const res = await fetch(
      `https://api.cloudflare.com/client/v4/zones/${encodeURIComponent(zoneId)}/dns_records?per_page=200`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json'
        },
        signal: AbortSignal.timeout(12_000)
      }
    )

    const body = (await res.json().catch(() => null)) as CfResponse | null

    if (!res.ok || !body?.success) {
      const msg = body?.errors?.[0]?.message || `Cloudflare API ${res.status}`
      return { records: [], error: msg }
    }

    return { records: body.result || [] }
  } catch (err) {
    return { records: [], error: err instanceof Error ? err.message : String(err) }
  }
}

/** CF 记录 → 我们的 dns_records 文档 */
function toDoc(r: CfRecord): {
  name: string
  host: string
  type: string
  target: string
  proxied: boolean
  cfId: string
} {
  const host = r.name
  const firstLabel = host.split('.')[0] || host
  return {
    name: r.comment?.trim() || (firstLabel === '@' ? host : firstLabel),
    host,
    type: r.type,
    target: r.content,
    proxied: Boolean(r.proxied),
    cfId: r.id
  }
}

/** 把 CF 拉到的记录 upsert 进本地缓存（SQLite） */
async function persist(records: CfRecord[]): Promise<void> {
  if (!records.length) return
  const nowIso = new Date().toISOString()
  const stmts = records.map((r) => {
    const doc = toDoc(r)
    return {
      sql:
        'insert into dns_records (host, name, type, target, proxied, updated_at, created_at) values (?,?,?,?,?,?,?) ' +
        'on conflict (host) do update set name=excluded.name, type=excluded.type, target=excluded.target, ' +
        'proxied=excluded.proxied, updated_at=excluded.updated_at',
      params: [doc.host, doc.name, doc.type, doc.target, doc.proxied ? 1 : 0, nowIso, nowIso]
    }
  })
  try {
    await sqlBatch(stmts)
  } catch {
    /* 并发 upsert 可能有个别冲突，忽略 */
  }
}

async function probeOne(host: string): Promise<{ status: 'online' | 'offline'; latencyMs: number; httpStatus: number }> {
  const started = Date.now()
  try {
    const res = await fetch(`https://${host}/`, {
      method: 'HEAD',
      redirect: 'follow',
      signal: AbortSignal.timeout(8_000),
      headers: { 'User-Agent': 'liaowangtai/dns-probe' }
    })
    const ms = Date.now() - started
    const reachable = res.status < 500
    return { status: reachable ? 'online' : 'offline', latencyMs: ms, httpStatus: res.status }
  } catch {
    return { status: 'offline', latencyMs: Date.now() - started, httpStatus: 0 }
  }
}

export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const shouldProbe = q.probe === '1' || q.probe === 'true'
  const token = envToken()
  const zones = envZones()

  setHeader(event, 'Cache-Control', 'no-store')

  /* ---- 1. 取数据：优先 CF API ---- */
  let items: Array<Record<string, unknown>> = []
  let source: 'cloudflare' | 'cache' = 'cache'
  let cfError: string | null = null
  let zoneCount = 0

  if (token && zones.length) {
    // 先解析 zone（域名 → 32 位 id），解析失败的单独收集错误
    const resolved = await Promise.all(zones.map((z) => resolveZoneId(z, token)))
    const validIds: string[] = []
    const errors: string[] = []

    for (const r of resolved) {
      if (r.error) errors.push(r.error)
      else if (r.id) validIds.push(r.id)
    }

    const results = await Promise.all(validIds.map((id) => fetchZoneRecords(id, token)))
    const allRecords: CfRecord[] = []

    for (const r of results) {
      if (r.error) errors.push(r.error)
      allRecords.push(...r.records)
    }

    if (allRecords.length) {
      source = 'cloudflare'
      zoneCount = validIds.length
      await persist(allRecords)
      cfError = errors.length ? errors.join('; ') : null
    } else {
      cfError = errors.length ? errors.join('; ') : 'Cloudflare 未返回记录'
    }
  } else if (!token) {
    cfError = '未配置 CF_API_TOKEN，只能读本地缓存'
  } else {
    cfError = '未配置 CF_ZONE_IDS（可填域名或 32 位 zone id）'
  }

  /* ---- 2. 读库（CF 成功时读的就是刚写入的；60 秒缓存，DNS 记录本身很少变） ---- */
  const rows = await withCache('dns:rows', 60_000, () => listDnsRecords())

  /* ---- 3. 可选探活 ---- */
  if (shouldProbe && rows.length) {
    const CONCURRENCY = 5
    const resultMap = new Map<string, { status: string; latencyMs: number; httpStatus: number }>()

    for (let i = 0; i < rows.length; i += CONCURRENCY) {
      const batch = rows.slice(i, i + CONCURRENCY)
      const settled = await Promise.all(
        batch.map(async (r) => {
          const p = await probeOne(r.host)
          await updateDnsStatus(r.host, p).catch(() => null)
          return { host: r.host, ...p }
        })
      )
      for (const s of settled) resultMap.set(s.host, s)
    }

    items = rows.map((r) => {
      const p = resultMap.get(r.host)
      return p
        ? { ...r, status: p.status, latencyMs: p.latencyMs, httpStatus: p.httpStatus, checkedAt: new Date() }
        : r
    }) as unknown as Array<Record<string, unknown>>
  } else {
    items = rows as unknown as Array<Record<string, unknown>>
  }

  if (shouldProbe) invalidateCache('dns:')

  const online = items.filter((r) => r.status === 'online').length
  const checked = items
    .map((r) => (r.checkedAt ? new Date(r.checkedAt as string).getTime() : 0))
    .reduce((a, b) => Math.max(a, b), 0)

  return {
    total: items.length,
    online,
    offline: items.length - online,
    checkedAt: checked ? new Date(checked).toISOString() : null,
    probed: Boolean(shouldProbe),
    source,
    zoneCount,
    cfError,
    cfConfigured: Boolean(token && zones.length),
    items
  }
})
