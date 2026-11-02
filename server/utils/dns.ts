/**
 * Cloudflare DNS 看板数据层（从原 site.ts 拆出来的，功能裁剪后只保留这一块）。
 */
import { sqlAll, sqlRun } from './db'

export interface DnsRecordDoc {
  name: string
  host: string
  type?: string
  target?: string
  proxied?: boolean
  status?: 'online' | 'offline' | 'unknown'
  latencyMs?: number
  httpStatus?: number
  checkedAt?: string | null
}

interface DnsRow {
  name: string
  host: string
  type: string
  target: string
  proxied: number
  status: string
  latency_ms: number
  http_status: number
  checked_at: string | null
}

export async function listDnsRecords(): Promise<DnsRecordDoc[]> {
  const rows = await sqlAll<DnsRow>('select * from dns_records order by name asc')
  return rows.map((r) => ({
    name: r.name,
    host: r.host,
    type: r.type,
    target: r.target,
    proxied: Boolean(r.proxied),
    status: r.status as DnsRecordDoc['status'],
    latencyMs: r.latency_ms,
    httpStatus: r.http_status,
    checkedAt: r.checked_at
  }))
}

export async function updateDnsStatus(
  host: string,
  patch: { status: string; latencyMs: number; httpStatus: number }
): Promise<void> {
  const now = new Date().toISOString()
  await sqlRun(
    'update dns_records set status = ?, latency_ms = ?, http_status = ?, checked_at = ?, updated_at = ? where host = ?',
    [patch.status, patch.latencyMs, patch.httpStatus, now, now, host]
  )
}

/** CF API 拉回来的记录 upsert 进本地缓存 */
export async function upsertDnsRecords(
  records: Array<{
    name: string
    host: string
    type: string
    target: string
    proxied: boolean
  }>
): Promise<void> {
  const now = new Date().toISOString()
  for (const r of records) {
    await sqlRun(
      `insert into dns_records (host, name, type, target, proxied, status, latency_ms, http_status, checked_at, created_at, updated_at)
       values (?,?,?,?,?, 'unknown', 0, 0, null, ?, ?)
       on conflict (host) do update set
         name = excluded.name, type = excluded.type, target = excluded.target,
         proxied = excluded.proxied, updated_at = excluded.updated_at`,
      [r.host, r.name, r.type, r.target, r.proxied ? 1 : 0, now, now]
    )
  }
}