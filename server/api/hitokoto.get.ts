/**
 * GET /api/hitokoto —— 一言接口
 *
 * 前端每 60 秒调一次（见 app/pages/index.vue）。
 * 这里做一层服务端代理 + 短缓存 + 本地兜底，避免上游挂掉导致首页文字空掉。
 */

interface HitokotoPayload {
  text: string
  from: string
  source: 'remote' | 'local'
  at: string
}

const FALLBACK: Array<{ text: string; from: string }> = [
  { text: '代码写得好，不如日志打得好。', from: '工程师格言' },
  { text: '先让它跑起来，再让它跑得快。', from: 'Kent Beck' },
  { text: '今天不重构，明天重构两天。', from: '技术债守恒' },
  { text: '简单性是可靠性的前提。', from: 'Edsger W. Dijkstra' },
  { text: '过早优化是万恶之源。', from: 'Donald Knuth' },
  { text: '能运行的代码，胜过完美的设计文档。', from: '实用主义' },
  { text: '每一次提交，都该让明天的自己感谢今天。', from: 'Git 哲学' },
  { text: '世界很大，先把 index 建好。', from: 'DBA 语录' },
  { text: '与其担心流量，不如先担心单点。', from: '架构笔记' },
  { text: '万般皆下品，唯有复盘高。', from: '运维老话' },
  { text: '只要学不死，就往死里学。', from: '考研人' },
  { text: '星光不问赶路人，时光不负有心人。', from: '网络' }
]

let cache: { payload: HitokotoPayload; at: number } | null = null
const CACHE_MS = 3_000

function pickFallback(): HitokotoPayload {
  const item = FALLBACK[Math.floor(Math.random() * FALLBACK.length)]!
  return { text: item.text, from: item.from, source: 'local', at: new Date().toISOString() }
}

export default defineEventHandler(async (event): Promise<HitokotoPayload> => {
  setHeader(event, 'Cache-Control', 'no-store')

  if (cache && Date.now() - cache.at < CACHE_MS) return cache.payload

  const cfg = appConfig()
  const endpoints = [
    cfg.hitokotoEndpoint,
    'https://v1.hitokoto.cn/?c=d&c=i&c=k&encode=json',
    'https://v1.hitokoto.cn/?encode=json'
  ].filter(Boolean)

  for (const url of endpoints) {
    try {
      const res = await fetch(url, {
        headers: { Accept: 'application/json', 'User-Agent': 'github-trending-daily/1.0' },
        signal: AbortSignal.timeout(4_000)
      })
      if (!res.ok) continue
      const data = (await res.json()) as { hitokoto?: string; from?: string; from_who?: string | null }
      const text = (data.hitokoto || '').trim()
      if (!text) continue
      const from = (data.from_who || data.from || '一言').trim()
      const payload: HitokotoPayload = {
        text,
        from,
        source: 'remote',
        at: new Date().toISOString()
      }
      cache = { payload, at: Date.now() }
      return payload
    } catch {
      // 换下一个源
    }
  }

  const fallback = pickFallback()
  cache = { payload: fallback, at: Date.now() }
  return fallback
})
