/**
 * 站点数据层：网站导航 / AI 资源台 / GitHub 创作者 / DNS 缓存。
 *
 * 与 GitHub 榜单共用同一个库（github_trending），但集合各自独立：
 *   nav_categories  导航分类
 *   nav_links       导航站点
 *   ai_boards       AI 资源台板块（Tab）
 *   ai_items        AI 资源台条目
 *   github_creators 热门 GitHub 用户
 *   dns_records     DNS 记录缓存
 */
import { getDb } from './mongo'

export const SITE_COLLECTIONS = {
  navCategories: 'nav_categories',
  navLinks: 'nav_links',
  aiBoards: 'ai_boards',
  aiItems: 'ai_items',
  creators: 'github_creators',
  dns: 'dns_records',
  shares: 'shares'
} as const

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
  /** 教程类才有：markdown 原文，列表接口不返回 */
  content?: string
  sort?: number
  status?: 'active' | 'inactive'
}

export interface CreatorDoc {
  login: string
  note?: string
  avatar?: string
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
  checkedAt?: Date | string
}

let indexReady = false

async function ensureIndexes(): Promise<void> {
  if (indexReady) return
  const db = await getDb()
  await Promise.all([
    db.collection(SITE_COLLECTIONS.navCategories).createIndex({ key: 1 }, { unique: true }).catch(() => null),
    db.collection(SITE_COLLECTIONS.navLinks).createIndex({ catelog: 1, sort: 1 }).catch(() => null),
    db.collection(SITE_COLLECTIONS.aiBoards).createIndex({ key: 1 }, { unique: true }).catch(() => null),
    db.collection(SITE_COLLECTIONS.aiItems).createIndex({ board: 1, sort: 1 }).catch(() => null),
    db.collection(SITE_COLLECTIONS.creators).createIndex({ login: 1 }, { unique: true }).catch(() => null),
    db.collection(SITE_COLLECTIONS.dns).createIndex({ host: 1 }, { unique: true }).catch(() => null)
  ])
  indexReady = true
}

async function col<T>(name: string) {
  await ensureIndexes()
  const db = await getDb()
  return db.collection<T & { _id?: unknown }>(name)
}

/** 导航分类（按 group → sort → name 排序） */
export async function listNavCategories(): Promise<NavCategoryDoc[]> {
  const c = await col<NavCategoryDoc>(SITE_COLLECTIONS.navCategories)
  const rows = await c
    .find({ status: { $ne: 'inactive' } })
    .sort({ group: 1, sort: 1, name: 1 })
    .toArray()
  return rows.map(({ _id, ...rest }) => rest as NavCategoryDoc)
}

/** 导航站点：支持按分类、关键字过滤 */
export async function listNavLinks(opts: { catelog?: string; keyword?: string } = {}): Promise<NavLinkDoc[]> {
  const c = await col<NavLinkDoc>(SITE_COLLECTIONS.navLinks)
  const filter: Record<string, unknown> = { status: { $ne: 'inactive' } }

  if (opts.catelog && opts.catelog !== 'all') filter.catelog = opts.catelog

  const kw = (opts.keyword || '').trim()
  if (kw) {
    const re = { $regex: kw.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), $options: 'i' }
    Object.assign(filter, { $or: [{ name: re }, { desc: re }, { url: re }, { group: re }] })
  }

  const rows = await c.find(filter).sort({ sort: 1, name: 1 }).toArray()
  return rows.map(({ _id, ...rest }) => rest as NavLinkDoc)
}

/** AI 资源台板块 */
export async function listAiBoards(): Promise<AiBoardDoc[]> {
  const c = await col<AiBoardDoc>(SITE_COLLECTIONS.aiBoards)
  const rows = await c
    .find({ status: { $ne: 'inactive' } })
    .sort({ sort: 1, name: 1 })
    .toArray()
  return rows.map(({ _id, ...rest }) => rest as AiBoardDoc)
}

/** AI 资源台条目（列表用：不含 content，避免接口过大） */
export async function listAiItems(opts: { board?: string; keyword?: string } = {}): Promise<AiItemDoc[]> {
  const c = await col<AiItemDoc>(SITE_COLLECTIONS.aiItems)
  const filter: Record<string, unknown> = { status: { $ne: 'inactive' } }
  if (opts.board && opts.board !== 'all') filter.board = opts.board

  const kw = (opts.keyword || '').trim()
  if (kw) {
    const re = { $regex: kw.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), $options: 'i' }
    Object.assign(filter, { $or: [{ name: re }, { desc: re }, { models: re }, { url: re }] })
  }

  const rows = await c
    .find(filter, { projection: { content: 0 } })
    .sort({ sort: 1, name: 1 })
    .toArray()
  return rows.map(({ _id, ...rest }) => rest as AiItemDoc)
}

/** 单条 AI 资源（含 markdown 正文，教程详情页用） */
export async function getAiItem(board: string, name: string): Promise<AiItemDoc | null> {
  const c = await col<AiItemDoc>(SITE_COLLECTIONS.aiItems)
  const doc = await c.findOne({ board, name })
  if (!doc) return null
  const { _id, ...rest } = doc as AiItemDoc & { _id?: unknown }
  return rest as AiItemDoc
}

/** 热门 GitHub 用户 */
export async function listCreators(): Promise<CreatorDoc[]> {
  const c = await col<CreatorDoc>(SITE_COLLECTIONS.creators)
  const rows = await c.find({}).sort({ sort: 1, login: 1 }).toArray()
  return rows.map(({ _id, ...rest }) => rest as CreatorDoc)
}

/** DNS 记录缓存 */
export async function listDnsRecords(): Promise<DnsRecordDoc[]> {
  const c = await col<DnsRecordDoc>(SITE_COLLECTIONS.dns)
  const rows = await c.find({}).sort({ name: 1 }).toArray()
  return rows.map(({ _id, ...rest }) => rest as DnsRecordDoc)
}

/** 更新单条 DNS 记录的探活结果 */
export async function updateDnsStatus(
  host: string,
  patch: { status: string; latencyMs: number; httpStatus: number }
): Promise<void> {
  const c = await col<DnsRecordDoc>(SITE_COLLECTIONS.dns)
  await c.updateOne({ host }, { $set: { ...patch, checkedAt: new Date() } })
}

/** 各集合的文档数量（首页/统计用） */
export async function siteStats(): Promise<Record<string, number>> {
  await ensureIndexes()
  const db = await getDb()
  const [nav, navCat, ai, aiBoard, creators, dns, shares] = await Promise.all([
    db.collection(SITE_COLLECTIONS.navLinks).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.navCategories).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.aiItems).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.aiBoards).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.creators).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.dns).countDocuments().catch(() => 0),
    db.collection(SITE_COLLECTIONS.shares).countDocuments().catch(() => 0)
  ])
  return { navLinks: nav, navCategories: navCat, aiItems: ai, aiBoards: aiBoard, creators, dns, shares }
}

/* ============================================================
 * 分享
 * ========================================================== */

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

/** 生成短 id（8 位 base36，足够 424 条数据的分享场景） */
function shortId(): string {
  return Math.random().toString(36).slice(2, 10).padEnd(8, '0')
}

export async function createShare(input: Omit<ShareDoc, 'sid' | 'createdAt' | 'views'>): Promise<ShareDoc> {
  const c = await col<ShareDoc>(SITE_COLLECTIONS.shares)
  // 同一条内容（type + url）复用同一个 sid，避免刷出无数重复分享
  if (input.url) {
    const exist = await c.findOne({ type: input.type, url: input.url })
    if (exist) return exist as unknown as ShareDoc
  }

  const doc: ShareDoc = {
    ...input,
    sid: shortId(),
    views: 0,
    createdAt: new Date()
  }
  await c.insertOne(doc as ShareDoc & { _id?: unknown })
  return doc
}

export async function getShare(sid: string): Promise<ShareDoc | null> {
  const c = await col<ShareDoc>(SITE_COLLECTIONS.shares)
  const doc = await c.findOneAndUpdate(
    { sid },
    { $inc: { views: 1 } },
    { returnDocument: 'after' }
  )
  if (!doc) return null
  const { _id, ...rest } = doc as ShareDoc & { _id?: unknown }
  return rest as ShareDoc
}

export async function getShareNoCount(sid: string): Promise<ShareDoc | null> {
  const c = await col<ShareDoc>(SITE_COLLECTIONS.shares)
  const doc = await c.findOne({ sid })
  if (!doc) return null
  const { _id, ...rest } = doc as ShareDoc & { _id?: unknown }
  return rest as ShareDoc
}

/** 最近分享（分享页列表 / 后台统计用） */
export async function listShares(limit = 50): Promise<ShareDoc[]> {
  const c = await col<ShareDoc>(SITE_COLLECTIONS.shares)
  const rows = await c.find({}).sort({ createdAt: -1 }).limit(limit).toArray()
  return rows.map(({ _id, ...rest }) => rest as ShareDoc)
}
