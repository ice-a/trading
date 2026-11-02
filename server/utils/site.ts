/**
 * 站点数据层（SQLite 版）：网站导航 / AI 资源台 / GitHub 创作者 / DNS 缓存 / 分享。
 *
 * 表一览：
 *   nav_categories  导航分类
 *   nav_links       导航站点
 *   ai_boards       AI 板块
 *   ai_items        AI 资源（含教程正文）
 *   github_creators 关注列表
 *   dns_records     DNS 看板缓存
 *   shares          分享短链
 */
import { sqlAll, sqlFirst, sqlRun, sqlBatch, type SqlStmt } from './db'

export interface NavCategoryDoc {
  key: string
  name: string
  group?: string
  icon?: string
  sort?: number
  status?: 'active' | 'inactive'
}

export interface NavLinkDoc {
  name: string
  url: string
  catelog?: string
  group?: string
  desc?: string
  icon?: string
  sort?: number
  status?: 'active' | 'inactive'
}

export interface AiBoardDoc {
  key: string
  name: string
  icon?: string
  sort?: number
  status?: 'active' | 'inactive'
}

export interface AiItemDoc {
  board: string
  name: string
  url?: string
  desc?: string
  models?: string
  ratio?: string
  tags?: string[]
  /** 教程类才有：markdown 原文，列表查询不返回 */
  content?: string
  sort?: number
  status?: 'active' | 'inactive'
}

export interface CreatorDoc {
  login: string
  note?: string
  sort?: number
}

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

/* ---------- 行类型 ---------- */
interface NavCatRow {
  key: string
  name: string
  grp: string
  icon: string
  sort: number
  status: string
}
interface NavLinkRow {
  name: string
  url: string
  catelog: string
  grp: string
  descr: string
  icon: string
  sort: number
}
interface AiBoardRow {
  key: string
  name: string
  icon: string
  sort: number
}
interface AiItemRow {
  board: string
  name: string
  url: string
  descr: string
  models: string
  ratio: string
  tags: string
  sort: number
  content?: string
}
interface CreatorRow {
  login: string
  note: string
  sort: number
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

/* ---------- 导航 ---------- */

export async function listNavCategories(): Promise<NavCategoryDoc[]> {
  const rows = await sqlAll<NavCatRow>(
    "select key, name, grp, icon, sort, status from nav_categories where status <> 'inactive' order by grp asc, sort asc, name asc"
  )
  return rows.map((r) => ({ key: r.key, name: r.name, group: r.grp, icon: r.icon, sort: r.sort, status: 'active' }))
}

export async function listNavLinks(opts: { catelog?: string; keyword?: string } = {}): Promise<NavLinkDoc[]> {
  const where: string[] = ["status <> 'inactive'"]
  const params: unknown[] = []

  if (opts.catelog && opts.catelog !== 'all') {
    where.push('catelog = ?')
    params.push(opts.catelog)
  }

  const kw = (opts.keyword || '').trim()
  if (kw) {
    where.push('(name like ? or descr like ? or url like ? or grp like ?)')
    const like = `%${kw}%`
    params.push(like, like, like, like)
  }

  const rows = await sqlAll<NavLinkRow>(
    `select name, url, catelog, grp, descr, icon, sort from nav_links where ${where.join(' and ')} order by sort asc, name asc limit 1000`,
    params
  )
  return rows.map((r) => ({
    name: r.name,
    url: r.url,
    catelog: r.catelog,
    group: r.grp,
    desc: r.descr,
    icon: r.icon,
    sort: r.sort,
    status: 'active'
  }))
}

/* ---------- AI 资源台 ---------- */

export async function listAiBoards(): Promise<AiBoardDoc[]> {
  const rows = await sqlAll<AiBoardRow>(
    "select key, name, icon, sort from ai_boards where status <> 'inactive' order by sort asc, name asc"
  )
  return rows.map((r) => ({ key: r.key, name: r.name, icon: r.icon, sort: r.sort, status: 'active' }))
}

function parseTags(raw: string | undefined): string[] {
  try {
    const v = JSON.parse(raw || '[]')
    return Array.isArray(v) ? v.map(String) : []
  } catch {
    return []
  }
}

export async function listAiItems(opts: { board?: string; keyword?: string } = {}): Promise<AiItemDoc[]> {
  const where: string[] = ["status <> 'inactive'"]
  const params: unknown[] = []
  if (opts.board && opts.board !== 'all') {
    where.push('board = ?')
    params.push(opts.board)
  }
  const kw = (opts.keyword || '').trim()
  if (kw) {
    where.push('(name like ? or descr like ? or models like ? or url like ?)')
    const like = `%${kw}%`
    params.push(like, like, like, like)
  }

  const rows = await sqlAll<AiItemRow>(
    `select board, name, url, descr, models, ratio, tags, sort from ai_items where ${where.join(' and ')} order by sort asc, name asc limit 1000`,
    params
  )
  return rows.map((r) => ({
    board: r.board,
    name: r.name,
    url: r.url,
    desc: r.descr,
    models: r.models,
    ratio: r.ratio,
    tags: parseTags(r.tags),
    sort: r.sort,
    status: 'active'
  }))
}

/** 单条 AI 资源（含 markdown 正文，教程详情页用） */
export async function getAiItem(board: string, name: string): Promise<AiItemDoc | null> {
  const r = await sqlFirst<AiItemRow & { content: string }>(
    'select board, name, url, descr, models, ratio, tags, sort, content from ai_items where board = ? and name = ? and status <> \'inactive\'',
    [board, name]
  )
  if (!r) return null
  return {
    board: r.board,
    name: r.name,
    url: r.url,
    desc: r.descr,
    models: r.models,
    ratio: r.ratio,
    tags: parseTags(r.tags),
    content: r.content || '',
    sort: r.sort,
    status: 'active'
  }
}

/* ---------- 创作者 ---------- */

export async function listCreators(): Promise<CreatorDoc[]> {
  const rows = await sqlAll<CreatorRow>('select login, note, sort from github_creators order by sort asc, login asc')
  return rows.map((r) => ({ login: r.login, note: r.note, sort: r.sort }))
}

/* ---------- DNS ---------- */

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
  await sqlRun(
    'update dns_records set status = ?, latency_ms = ?, http_status = ?, checked_at = ?, updated_at = ? where host = ?',
    [patch.status, patch.latencyMs, patch.httpStatus, new Date().toISOString(), new Date().toISOString(), host]
  )
}

/* ---------- 统计 ---------- */

const COUNT_TABLES = {
  navLinks: 'nav_links',
  navCategories: 'nav_categories',
  aiItems: 'ai_items',
  aiBoards: 'ai_boards',
  creators: 'github_creators',
  dns: 'dns_records',
  shares: 'shares'
} as const

export async function siteStats(): Promise<Record<string, number>> {
  const out: Record<string, number> = {}
  const rows = await sqlAll<{ t: string; n: number }>(
    `select 'nav_links' as t, count(*) as n from nav_links
     union all select 'nav_categories', count(*) from nav_categories
     union all select 'ai_items', count(*) from ai_items
     union all select 'ai_boards', count(*) from ai_boards
     union all select 'github_creators', count(*) from github_creators
     union all select 'dns_records', count(*) from dns_records
     union all select 'shares', count(*) from shares`
  )
  const map = new Map(rows.map((r) => [r.t, r.n]))
  for (const [k, table] of Object.entries(COUNT_TABLES)) {
    out[k] = map.get(table) ?? 0
  }
  return out
}

/* ---------- 分享 ---------- */

export interface ShareDoc {
  sid: string
  type: 'nav' | 'ai' | 'repo' | 'dns' | 'custom'
  title: string
  desc?: string
  url?: string
  badge?: string
  meta?: Record<string, unknown>
  views?: number
  createdAt: Date
}

/** 生成短 id（8 位 base36，足够全站分享场景） */
function shortId(): string {
  return Math.random().toString(36).slice(2, 10).padEnd(8, '0')
}

interface ShareRow {
  sid: string
  type: string
  title: string
  descr: string
  url: string
  badge: string
  meta: string
  views: number
  created_at: string
}

function shareRow(r: ShareRow): ShareDoc {
  let meta: Record<string, unknown> = {}
  try {
    meta = JSON.parse(r.meta || '{}')
  } catch {
    meta = {}
  }
  return {
    sid: r.sid,
    type: r.type as ShareDoc['type'],
    title: r.title,
    desc: r.descr,
    url: r.url,
    badge: r.badge,
    meta,
    views: r.views,
    createdAt: new Date(r.created_at)
  }
}

export async function createShare(input: Omit<ShareDoc, 'sid' | 'createdAt' | 'views'>): Promise<ShareDoc> {
  // 同一条内容（type + url）复用同一个 sid，避免刷出无数重复分享
  if (input.url) {
    const exist = await sqlFirst<ShareRow>('select * from shares where type = ? and url = ?', [input.type, input.url])
    if (exist) return shareRow(exist)
  }

  const doc: ShareRow = {
    sid: shortId(),
    type: input.type,
    title: input.title,
    descr: input.desc || '',
    url: input.url || '',
    badge: input.badge || '',
    meta: JSON.stringify(input.meta || {}),
    views: 0,
    created_at: new Date().toISOString()
  }
  await sqlRun(
    'insert or ignore into shares (sid, type, title, descr, url, badge, meta, views, created_at) values (?,?,?,?,?,?,?,?,?)',
    [doc.sid, doc.type, doc.title, doc.descr, doc.url, doc.badge, doc.meta, 0, doc.created_at]
  )
  return { ...input, sid: doc.sid, views: 0, createdAt: new Date(doc.created_at) }
}

/** 取一条分享（同时 views +1；先自增再读，避免依赖 RETURNING） */
export async function getShare(sid: string): Promise<ShareDoc | null> {
  await sqlRun('update shares set views = views + 1 where sid = ?', [sid])
  const row = await sqlFirst<ShareRow>('select * from shares where sid = ?', [sid])
  return row ? shareRow(row) : null
}

/** 最近分享（分享页列表用） */
export async function listShares(limit = 50): Promise<ShareDoc[]> {
  const rows = await sqlAll<ShareRow>('select * from shares order by created_at desc limit ?', [limit])
  return rows.map(shareRow)
}
