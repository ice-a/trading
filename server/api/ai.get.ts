import { listAiBoards, listAiItems } from '../utils/site'

/**
 * GET /api/ai?board=stations&keyword=xxx
 *
 * AI 资源台：板块（Tab）与条目都来自 MongoDB（ai_boards / ai_items）。
 */
export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const board = typeof q.board === 'string' ? q.board : ''
  const keyword = typeof q.keyword === 'string' ? q.keyword : ''

  setHeader(event, 'Cache-Control', 'public, max-age=30, stale-while-revalidate=120')

  return withCache(`ai:${board}:${keyword}`, 120_000, async () => {
    const [boards, items] = await Promise.all([listAiBoards(), listAiItems({ board, keyword })])

    const countByBoard = new Map<string, number>()
    for (const it of await listAiItems({})) {
      countByBoard.set(it.board, (countByBoard.get(it.board) || 0) + 1)
    }

    return {
      total: items.length,
      boards: boards.map((b) => ({
        key: b.key,
        name: b.name,
        icon: b.icon || '',
        count: countByBoard.get(b.key) || 0
      })),
      items: items.map((it) => ({
        board: it.board,
        name: it.name,
        url: it.url || '',
        desc: it.desc || '',
        models: it.models || '',
        ratio: it.ratio || '',
        tags: it.tags || []
      }))
    }
  })
})
