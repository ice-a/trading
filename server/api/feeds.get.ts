import { CATEGORIES } from '../config/feeds'
import { readFeeds, countByCategory, type FeedDoc } from '../utils/feeds'

/**
 * GET /api/feeds?category=hot&preview=8
 *
 * 列表页默认给裁剪版（每个端点最多 8 条，用 $slice 投影在数据库侧就裁掉），
 * 详情走 /api/feeds/:key 拿全量。
 *
 * 结果做 60 秒内存缓存：数据每小时才变，没必要每次导航都查一遍库。
 */
export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const category = typeof q.category === 'string' && q.category ? q.category : 'all'
  const full = q.full === '1' || q.full === 'true'
  const previewCount = Math.min(Math.max(Number(q.preview) || 8, 1), 50)

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  // 数据只在抓取时变化，TTL 略大于抓取间隔；抓取完成后会主动失效
  return withCache(`feeds:${category}:${full ? 'full' : previewCount}`, 65 * 60_000, async () => {
    const docs = await readFeeds(category, full ? undefined : previewCount)

    const feeds = docs.map((doc) => {
      const payload = doc.payload
      // 兜底：投影没生效时（例如 full=1）再裁一次
      const trimmed =
        !full && payload && payload.kind === 'list'
          ? { ...payload, items: payload.items.slice(0, previewCount) }
          : payload

      return {
        key: doc.key,
        title: doc.title,
        desc: doc.desc ?? null,
        category: doc.category,
        render: doc.render,
        ok: doc.ok,
        error: doc.error ?? null,
        fetchedAt: doc.fetchedAt ? new Date(doc.fetchedAt).toISOString() : null,
        upstreamUpdatedAt: doc.upstreamUpdatedAt ? new Date(doc.upstreamUpdatedAt).toISOString() : null,
        payload: trimmed,
        total: payload?.kind === 'list' ? payload.total : payload?.kind === 'fields' ? payload.fields.length : 1
      }
    })

    // 分类计数（Tab 角标）：单独统计全量，不能用当前筛选结果算
    const counts = await withCache('feeds:counts', 65 * 60_000, () => countByCategory())
    const categories = CATEGORIES.map((c) => ({ ...c, count: counts[c.key] ?? 0 }))

    const latest = docs.reduce<number>((max, d) => {
      const t = d.fetchedAt ? new Date(d.fetchedAt).getTime() : 0
      return Math.max(max, t)
    }, 0)

    return {
      updatedAt: latest ? new Date(latest).toISOString() : null,
      totalFeeds: docs.length,
      okFeeds: docs.filter((d) => d.ok).length,
      categories,
      feeds
    }
  })
})

export type { FeedDoc }
