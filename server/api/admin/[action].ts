import { getDb } from '../../utils/mongo'
import { SITE_COLLECTIONS, siteStats } from '../../utils/site'

/**
 * /api/admin/[action] —— 简易后台接口
 *
 *   POST /api/admin/login   { password }                     → { ok, token }
 *   GET  /api/admin/stats                                     → 各集合数量
 *   GET  /api/admin/list?coll=nav_links|ai_items&keyword=&limit=
 *   POST /api/admin/create  { coll, doc }
 *   POST /api/admin/delete  { coll, id }
 *   POST /api/admin/update  { coll, id, patch }
 *
 * 鉴权：请求头 x-admin-password 或 query.pw，需匹配环境变量 ADMIN_PASSWORD（默认 admin123）。
 * 只开放可写集合白名单，避免误改榜单数据。
 */

const ALLOWED = {
  nav_links: { label: '导航站点', required: ['name', 'url'], extra: ['catelog', 'group', 'desc', 'icon', 'sort'] },
  nav_categories: { label: '导航分类', required: ['key', 'name'], extra: ['group', 'icon', 'sort'] },
  ai_items: { label: 'AI 资源', required: ['board', 'name'], extra: ['url', 'desc', 'models', 'ratio', 'tags', 'content', 'sort'] },
  ai_boards: { label: 'AI 板块', required: ['key', 'name'], extra: ['icon', 'sort'] },
  github_creators: { label: 'GitHub 用户', required: ['login'], extra: ['note', 'sort'] }
} as const

type CollKey = keyof typeof ALLOWED

function passwordOf(): string {
  return process.env.ADMIN_PASSWORD || 'admin123'
}

function checkAuth(event: { node: { req: { headers: Record<string, unknown> } } }): boolean {
  const header = String((event.node.req.headers['x-admin-password'] || '') as string)
  const query = String(getQuery(event as never).pw || '')
  return (header || query) === passwordOf()
}

export default defineEventHandler(async (event) => {
  const action = String(getRouterParam(event, 'action') || '')
  const method = getMethod(event)

  /* ---- 登录 ---- */
  if (action === 'login' && method === 'POST') {
    const body = (await readBody(event).catch(() => ({}))) as { password?: string }
    if (String(body?.password || '') !== passwordOf()) {
      setResponseStatus(event, 401)
      return { ok: false, error: '密码不正确' }
    }
    return { ok: true, token: passwordOf() }
  }

  /* ---- 以下都需要鉴权 ---- */
  if (!checkAuth(event as never)) {
    setResponseStatus(event, 401)
    return { ok: false, error: '未鉴权' }
  }

  const db = await getDb()

  /* ---- 统计 ---- */
  if (action === 'stats' && method === 'GET') {
    const stats = await siteStats()
    const [repos, feeds, runs] = await Promise.all([
      db.collection('trending_repos').countDocuments().catch(() => 0),
      db.collection('feed_snapshots').countDocuments().catch(() => 0),
      db.collection('crawl_runs').countDocuments().catch(() => 0)
    ])
    return {
      ok: true,
      stats: {
        ...stats,
        trendingRepos: repos,
        feedSnapshots: feeds,
        crawlRuns: runs
      },
      collections: Object.entries(ALLOWED).map(([key, v]) => ({ key, label: v.label }))
    }
  }

  /* ---- 列表 ---- */
  if (action === 'list' && method === 'GET') {
    const q = getQuery(event)
    const coll = String(q.coll || 'nav_links') as CollKey
    if (!ALLOWED[coll]) {
      setResponseStatus(event, 400)
      return { ok: false, error: '集合不在白名单内' }
    }
    const limit = Math.min(Math.max(Number(q.limit) || 60, 1), 500)
    const kw = String(q.keyword || '').trim()

    const filter: Record<string, unknown> = {}
    if (kw) {
      const re = { $regex: kw.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), $options: 'i' }
      filter.$or = [{ name: re }, { url: re }, { desc: re }, { login: re }, { key: re }, { board: re }]
    }

    const col = db.collection(SITE_COLLECTIONS[coll === 'nav_links' ? 'navLinks' : coll === 'nav_categories' ? 'navCategories' : coll === 'ai_items' ? 'aiItems' : coll === 'ai_boards' ? 'aiBoards' : 'creators'])
    const total = await col.countDocuments(filter)
    const rows = await col
      .find(filter, { projection: { content: 0 } })
      .sort({ sort: 1, _id: -1 })
      .limit(limit)
      .toArray()

    return {
      ok: true,
      coll,
      label: ALLOWED[coll].label,
      total,
      items: rows.map((r) => {
        const { _id, ...rest } = r as Record<string, unknown> & { _id: unknown }
        return { id: String(_id), ...rest }
      })
    }
  }

  /* ---- 新增 ---- */
  if (action === 'create' && method === 'POST') {
    const body = (await readBody(event).catch(() => ({}))) as { coll?: string; doc?: Record<string, unknown> }
    const coll = String(body?.coll || '') as CollKey
    if (!ALLOWED[coll]) {
      setResponseStatus(event, 400)
      return { ok: false, error: '集合不在白名单内' }
    }

    const doc = body?.doc || {}
    for (const field of ALLOWED[coll].required) {
      if (!String(doc[field] ?? '').trim()) {
        setResponseStatus(event, 400)
        return { ok: false, error: `缺少必填字段：${field}` }
      }
    }

    const clean: Record<string, unknown> = { status: 'active', createdAt: new Date() }
    for (const field of [...ALLOWED[coll].required, ...ALLOWED[coll].extra]) {
      if (doc[field] !== undefined && doc[field] !== '') clean[field] = doc[field]
    }
    if (typeof clean.sort !== 'number') clean.sort = Number(clean.sort) || 0
    if (Array.isArray(clean.tags)) clean.tags = clean.tags.map(String)

    const target = db.collection(SITE_COLLECTIONS[coll === 'nav_links' ? 'navLinks' : coll === 'nav_categories' ? 'navCategories' : coll === 'ai_items' ? 'aiItems' : coll === 'ai_boards' ? 'aiBoards' : 'creators'])
    const res = await target.insertOne(clean)
    invalidateCache('')
    return { ok: true, id: String(res.insertedId) }
  }

  /* ---- 删除 ---- */
  if (action === 'delete' && method === 'POST') {
    const body = (await readBody(event).catch(() => ({}))) as { coll?: string; id?: string }
    const coll = String(body?.coll || '') as CollKey
    if (!ALLOWED[coll]) {
      setResponseStatus(event, 400)
      return { ok: false, error: '集合不在白名单内' }
    }
    const id = String(body?.id || '')
    if (!/^[a-f0-9]{24}$/i.test(id)) {
      setResponseStatus(event, 400)
      return { ok: false, error: 'id 格式不正确' }
    }

    const target = db.collection(SITE_COLLECTIONS[coll === 'nav_links' ? 'navLinks' : coll === 'nav_categories' ? 'navCategories' : coll === 'ai_items' ? 'aiItems' : coll === 'ai_boards' ? 'aiBoards' : 'creators'])
    const { ObjectId } = await import('mongodb')
    const res = await target.deleteOne({ _id: new ObjectId(id) })
    invalidateCache('')
    return { ok: res.deletedCount === 1, deleted: res.deletedCount }
  }

  setResponseStatus(event, 404)
  return { ok: false, error: `未知操作：${action}` }
})
