import { getAiItem } from '../../utils/site'

/**
 * GET /api/ai/detail?board=tutorials&name=xxx
 *
 * 取单条 AI 资源（含教程的 markdown 原文）。列表接口不带 content，避免响应过大。
 */
export default defineEventHandler(async (event) => {
  const q = getQuery(event)
  const board = String(q.board || '')
  const name = String(q.name || '')

  if (!board || !name) {
    setResponseStatus(event, 400)
    return { error: '缺少 board 或 name' }
  }

  setHeader(event, 'Cache-Control', 'public, max-age=120, stale-while-revalidate=600')

  return withCache(`ai:detail:${board}:${name}`, 5 * 60_000, async () => {
    const doc = await getAiItem(board, name)
    if (!doc) return { found: false }

    return {
      found: true,
      item: {
        board: doc.board,
        name: doc.name,
        url: doc.url || '',
        desc: doc.desc || '',
        models: doc.models || '',
        ratio: doc.ratio || '',
        tags: doc.tags || [],
        content: doc.content || ''
      }
    }
  })
})
