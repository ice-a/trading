import { listNavCategories, listNavLinks } from '../utils/site'

/**
 * GET /api/nav?catelog=xxx&keyword=yyy
 *
 * 返回导航分类 + 站点。数据全部来自 MongoDB（nav_categories / nav_links），
 * 后台直接往集合里插数据即可生效，不用改代码。
 */
export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const catelog = typeof q.catelog === 'string' ? q.catelog : ''
  const keyword = typeof q.keyword === 'string' ? q.keyword : ''

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  return withCache(`nav:${catelog}:${keyword}`, 120_000, async () => {
    const [categories, links] = await Promise.all([
      listNavCategories(),
      listNavLinks({ catelog, keyword })
    ])

    // 按大类聚合，前端做侧栏分组
    const groups: Array<{ group: string; categories: Array<{ key: string; name: string; icon: string; count: number }> }> = []
    const groupMap = new Map<string, { group: string; categories: Array<{ key: string; name: string; icon: string; count: number }> }>()

    const countByCat = new Map<string, number>()
    for (const l of links) {
      const k = l.catelog || ''
      countByCat.set(k, (countByCat.get(k) || 0) + 1)
    }

    for (const c of categories) {
      const g = c.group || '其他'
      if (!groupMap.has(g)) {
        const entry = { group: g, categories: [] as Array<{ key: string; name: string; icon: string; count: number }> }
        groupMap.set(g, entry)
        groups.push(entry)
      }
      groupMap.get(g)!.categories.push({
        key: c.key,
        name: c.name,
        icon: c.icon || '',
        count: countByCat.get(c.key) || 0
      })
    }

    return {
      total: links.length,
      totalCategories: categories.length,
      groups,
      links: links.map((l) => ({
        name: l.name,
        url: l.url,
        desc: l.desc || '',
        icon: l.icon || '',
        catelog: l.catelog || '',
        group: l.group || ''
      }))
    }
  })
})
