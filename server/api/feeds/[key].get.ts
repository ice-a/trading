import { readFeed } from '../../utils/feeds'
import { CATEGORIES } from '../../config/feeds'

/** GET /api/feeds/:key —— 单个端点的完整数据 */
export default defineEventHandler(async (event) => {
  const key = getRouterParam(event, 'key')
  if (!key) {
    setResponseStatus(event, 400)
    return { error: '缺少 key' }
  }

  const doc = await withCache(`feed:${key}`, 65 * 60_000, () => readFeed(key))
  if (!doc) {
    setResponseStatus(event, 404)
    return { error: `未知端点：${key}` }
  }

  return {
    key: doc.key,
    title: doc.title,
    desc: doc.desc ?? null,
    category: doc.category,
    categoryLabel: CATEGORIES.find((c) => c.key === doc.category)?.label ?? doc.category,
    render: doc.render,
    ok: doc.ok,
    error: doc.error ?? null,
    path: doc.path,
    fetchedAt: doc.fetchedAt ? new Date(doc.fetchedAt).toISOString() : null,
    upstreamUpdatedAt: doc.upstreamUpdatedAt ? new Date(doc.upstreamUpdatedAt).toISOString() : null,
    payload: doc.payload
  }
})
