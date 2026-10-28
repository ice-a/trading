import { getShare } from '../../utils/site'

/** GET /api/share/:sid —— 取一条分享（同时 views +1） */
export default defineEventHandler(async (event) => {
  const sid = getRouterParam(event, 'sid')
  if (!sid) {
    setResponseStatus(event, 400)
    return { error: '缺少 sid' }
  }

  setHeader(event, 'Cache-Control', 'no-store')

  const share = await getShare(sid)
  if (!share) {
    setResponseStatus(event, 404)
    return { found: false }
  }

  return {
    found: true,
    share: {
      sid: share.sid,
      type: share.type,
      title: share.title,
      desc: share.desc || '',
      url: share.url || '',
      badge: share.badge || '',
      meta: share.meta || {},
      views: share.views || 0,
      createdAt: share.createdAt ? new Date(share.createdAt).toISOString() : null
    }
  }
})
