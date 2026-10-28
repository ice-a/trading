import { createShare, listShares } from '../../utils/site'

/**
 * POST /api/share  —— 创建分享
 * GET  /api/share  —— 最近分享列表
 *
 * body: { type, title, desc?, url?, badge?, meta? }
 * 同一条内容（type + url）会复用同一个 sid，不会产生重复记录。
 */
export default defineEventHandler(async (event) => {
  const method = getMethod(event)

  if (method === 'GET') {
    const q = getQuery(event)
    const limit = Math.min(Math.max(Number(q.limit) || 30, 1), 100)
    const shares = await listShares(limit)
    return {
      total: shares.length,
      items: shares.map((s) => ({
        sid: s.sid,
        type: s.type,
        title: s.title,
        desc: s.desc || '',
        url: s.url || '',
        badge: s.badge || '',
        views: s.views || 0,
        createdAt: s.createdAt ? new Date(s.createdAt).toISOString() : null
      }))
    }
  }

  if (method !== 'POST') {
    setResponseStatus(event, 405)
    return { error: '仅支持 GET / POST' }
  }

  const body = (await readBody(event).catch(() => null)) as
    | { type?: string; title?: string; desc?: string; url?: string; badge?: string; meta?: Record<string, unknown> }
    | null

  if (!body?.title) {
    setResponseStatus(event, 400)
    return { error: '缺少 title' }
  }

  const allowed = ['nav', 'ai', 'repo', 'dns', 'custom']
  const type = allowed.includes(String(body.type)) ? (String(body.type) as 'nav' | 'ai' | 'repo' | 'dns' | 'custom') : 'custom'

  const doc = await createShare({
    type,
    title: String(body.title).slice(0, 120),
    desc: String(body.desc || '').slice(0, 300),
    url: String(body.url || '').slice(0, 500),
    badge: String(body.badge || '').slice(0, 40),
    meta: body.meta && typeof body.meta === 'object' ? body.meta : {}
  })

  setResponseStatus(event, 201)
  return { sid: doc.sid, path: `/s/${doc.sid}`, url: doc.url || '', title: doc.title }
})
