import { sqlAll, sqlFirst, sqlRun, pingDb } from '../../utils/db'
import { siteStats } from '../../utils/site'
import { env } from '../../utils/env'

/**
 * /api/admin/[action] —— 简易后台（SQLite 版）
 *
 *   POST /api/admin/login   { password }                     → { ok, token }
 *   GET  /api/admin/stats                                     → 各表数量
 *   GET  /api/admin/list?coll=nav_links|ai_items&keyword=&limit=
 *   POST /api/admin/create  { coll, doc }
 *   POST /api/admin/delete  { coll, id }
 *
 * 鉴权：请求头 x-admin-password 或 query.pw，需匹配环境变量 ADMIN_PASSWORD（默认 admin123）。
 * 表名/列名全部走白名单映射，绝不用用户输入拼 SQL。
 */

interface FieldDef {
  /** API 字段名（前端传的 doc 的 key） */
  key: string
  /** 表列名 */
  col: string
  required?: boolean
  kind?: 'string' | 'int' | 'json'
}

interface TableDef {
  label: string
  table: string
  pk: string
  pkAuto: boolean
  fields: FieldDef[]
  orderBy: string
  searchCols: string[]
}

const TABLES: Record<string, TableDef> = {
  nav_links: {
    label: '导航站点',
    table: 'nav_links',
    pk: 'id',
    pkAuto: true,
    orderBy: 'sort asc, name asc',
    searchCols: ['name', 'url', 'descr'],
    fields: [
      { key: 'name', col: 'name', required: true },
      { key: 'url', col: 'url', required: true },
      { key: 'catelog', col: 'catelog' },
      { key: 'group', col: 'grp' },
      { key: 'desc', col: 'descr' },
      { key: 'icon', col: 'icon' },
      { key: 'sort', col: 'sort', kind: 'int' }
    ]
  },
  nav_categories: {
    label: '导航分类',
    table: 'nav_categories',
    pk: 'key',
    pkAuto: false,
    orderBy: 'grp asc, sort asc',
    searchCols: ['key', 'name', 'grp'],
    fields: [
      { key: 'key', col: 'key', required: true },
      { key: 'name', col: 'name', required: true },
      { key: 'group', col: 'grp' },
      { key: 'icon', col: 'icon' },
      { key: 'sort', col: 'sort', kind: 'int' }
    ]
  },
  ai_items: {
    label: 'AI 资源',
    table: 'ai_items',
    pk: 'id',
    pkAuto: true,
    orderBy: 'sort asc, name asc',
    searchCols: ['name', 'url', 'descr', 'board'],
    fields: [
      { key: 'board', col: 'board', required: true },
      { key: 'name', col: 'name', required: true },
      { key: 'url', col: 'url' },
      { key: 'desc', col: 'descr' },
      { key: 'models', col: 'models' },
      { key: 'ratio', col: 'ratio' },
      { key: 'tags', col: 'tags', kind: 'json' },
      { key: 'sort', col: 'sort', kind: 'int' }
    ]
  },
  ai_boards: {
    label: 'AI 板块',
    table: 'ai_boards',
    pk: 'key',
    pkAuto: false,
    orderBy: 'sort asc',
    searchCols: ['key', 'name'],
    fields: [
      { key: 'key', col: 'key', required: true },
      { key: 'name', col: 'name', required: true },
      { key: 'icon', col: 'icon' },
      { key: 'sort', col: 'sort', kind: 'int' }
    ]
  },
  github_creators: {
    label: 'GitHub 用户',
    table: 'github_creators',
    pk: 'login',
    pkAuto: false,
    orderBy: 'sort asc, login asc',
    searchCols: ['login', 'note'],
    fields: [
      { key: 'login', col: 'login', required: true },
      { key: 'note', col: 'note' },
      { key: 'sort', col: 'sort', kind: 'int' }
    ]
  }
}

function passwordOf(): string {
  return env('ADMIN_PASSWORD', 'admin123')
}

/**
 * 鉴权：请求头 x-admin-password 或 query.pw。
 *
 * 重构点：原实现读 event.node.req.headers —— 那是 Node server 专有对象，
 * workerd 里没有 event.node，会在 Cloudflare 上直接抛错。统一走 getHeader/getQuery。
 */
function checkAuth(event: Parameters<typeof getHeader>[0]): boolean {
  const header = String(getHeader(event, 'x-admin-password') || '')
  const query = String(getQuery(event).pw || '')
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

  if (!checkAuth(event)) {
    setResponseStatus(event, 401)
    return { ok: false, error: '未鉴权' }
  }

  /* ---- 统计 ---- */
  if (action === 'stats' && method === 'GET') {
    const [stats, ping] = await Promise.all([siteStats(), pingDb()])
    const [repos, feeds, runs] = await Promise.all([
      sqlFirst<{ n: number }>('select count(*) as n from trending_repos').catch(() => null),
      sqlFirst<{ n: number }>('select count(*) as n from feed_snapshots').catch(() => null),
      sqlFirst<{ n: number }>('select count(*) as n from crawl_runs').catch(() => null)
    ])
    return {
      ok: true,
      storage: 'sqlite',
      dbLatencyMs: ping.latencyMs,
      stats: {
        ...stats,
        trendingRepos: repos?.n ?? 0,
        feedSnapshots: feeds?.n ?? 0,
        crawlRuns: runs?.n ?? 0
      },
      tables: Object.entries(TABLES).map(([key, v]) => ({ key, label: v.label }))
    }
  }

  /* ---- 列表 ---- */
  if (action === 'list' && method === 'GET') {
    const q = getQuery(event)
    const coll = String(q.coll || 'nav_links')
    const def = TABLES[coll]
    if (!def) {
      setResponseStatus(event, 400)
      return { ok: false, error: '表不在白名单内' }
    }
    const limit = Math.min(Math.max(Number(q.limit) || 60, 1), 500)
    const kw = String(q.keyword || '').trim()

    const where: string[] = ["status <> 'inactive'"]
    const params: unknown[] = []
    if (kw) {
      where.push('(' + def.searchCols.map((c) => `${c} like ?`).join(' or ') + ')')
      params.push(...def.searchCols.map(() => `%${kw}%`))
    }

    const total = await sqlFirst<{ n: number }>(
      `select count(*) as n from ${def.table} where ${where.join(' and ')}`,
      params
    )
    const cols = def.fields.map((f) => f.col).join(', ')
    const rows = await sqlAll<Record<string, unknown>>(
      `select ${def.pkAuto ? 'id as __pk, ' : ''}${cols} from ${def.table} where ${where.join(' and ')} order by ${def.orderBy} limit ?`,
      [...params, limit]
    )

    return {
      ok: true,
      coll,
      label: def.label,
      total: total?.n ?? 0,
      items: rows.map((r) => {
        const out: Record<string, unknown> = { id: String(r.__pk ?? r[def.pk]) }
        for (const f of def.fields) {
          let v = r[f.col]
          if (f.kind === 'json' && typeof v === 'string') {
            try {
              v = JSON.parse(v)
            } catch {
              v = []
            }
          }
          out[f.key] = v ?? ''
        }
        return out
      })
    }
  }

  /* ---- 新增 ---- */
  if (action === 'create' && method === 'POST') {
    const body = (await readBody(event).catch(() => ({}))) as { coll?: string; doc?: Record<string, unknown> }
    const def = TABLES[String(body?.coll || '')]
    if (!def) {
      setResponseStatus(event, 400)
      return { ok: false, error: '表不在白名单内' }
    }

    const doc = body?.doc || {}
    for (const f of def.fields) {
      if (f.required && !String(doc[f.key] ?? '').trim()) {
        setResponseStatus(event, 400)
        return { ok: false, error: `缺少必填字段：${f.key}` }
      }
    }

    const cols: string[] = []
    const marks: string[] = []
    const params: unknown[] = []
    for (const f of def.fields) {
      const raw = doc[f.key]
      if (raw === undefined || raw === '') continue
      cols.push(f.col)
      marks.push('?')
      if (f.kind === 'int') params.push(Number(raw) || 0)
      else if (f.kind === 'json') params.push(JSON.stringify(Array.isArray(raw) ? raw : [raw]))
      else params.push(String(raw))
    }
    cols.push('updated_at')
    marks.push('?')
    params.push(new Date().toISOString())

    await sqlRun(`insert into ${def.table} (${cols.join(', ')}) values (${marks.join(', ')})`, params)

    // 自增表回读 id（REST 模式拿不到 lastInsertRowid）
    let id: string | null = null
    const firstField = def.fields[0]!
    if (def.pkAuto) {
      const row = await sqlFirst<Record<string, unknown>>(
        `select ${def.pk} as pk from ${def.table} where ${firstField.col} = ? order by ${def.pk} desc limit 1`,
        [doc[firstField.key]]
      )
      id = row ? String(row.pk) : null
    } else {
      id = String(doc[firstField.key] ?? '')
    }

    invalidateCache('')
    return { ok: true, id }
  }

  /* ---- 删除 ---- */
  if (action === 'delete' && method === 'POST') {
    const body = (await readBody(event).catch(() => ({}))) as { coll?: string; id?: string }
    const def = TABLES[String(body?.coll || '')]
    if (!def) {
      setResponseStatus(event, 400)
      return { ok: false, error: '表不在白名单内' }
    }
    const id = String(body?.id || '')
    if (!id) {
      setResponseStatus(event, 400)
      return { ok: false, error: '缺少 id' }
    }

    if (def.pkAuto) {
      if (!/^\d+$/.test(id)) {
        setResponseStatus(event, 400)
        return { ok: false, error: 'id 必须是数字' }
      }
      await sqlRun(`delete from ${def.table} where ${def.pk} = ?`, [Number(id)])
    } else {
      await sqlRun(`delete from ${def.table} where ${def.pk} = ?`, [id])
    }
    invalidateCache('')
    return { ok: true }
  }

  setResponseStatus(event, 404)
  return { ok: false, error: `未知操作：${action}` }
})
