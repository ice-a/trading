const base = process.argv[2] || 'https://info.020417.xyz'

async function get(path, init = {}) {
  const t0 = Date.now()
  try {
    const res = await fetch(base + path, { signal: AbortSignal.timeout(60000), ...init })
    const text = await res.text()
    return { status: res.status, ms: Date.now() - t0, text }
  } catch (e) {
    return { status: 0, ms: Date.now() - t0, text: '', error: e.message }
  }
}

const now = new Date()
console.log('当前时间:', now.toISOString(), '（北京 ' + new Date(now.getTime() + 8 * 3600e3).toISOString().slice(0, 19) + '）')
console.log('站点:', base, '\n')

// 1) bundle 接口
const b = await get('/api/trending-bundle')
console.log(`/api/trending-bundle  HTTP ${b.status}  ${b.ms}ms`)
if (b.status === 200) {
  try {
    const j = JSON.parse(b.text)
    console.log('  date:', j.date, ' daily.total:', j.daily?.total, ' daily.items:', j.daily?.items?.length)
    console.log('  updatedAt:', j.daily?.updatedAt, ' updatedAgo:', j.daily?.updatedAgo)
    if (j.daily?.items?.[0]) console.log('  首条:', j.daily.items[0].fullName)
  } catch (e) {
    console.log('  解析失败:', b.text.slice(0, 200))
  }
} else {
  console.log('  响应:', b.text.slice(0, 300))
}

// 2) 首页 HTML 里的日期
const h = await get('/')
console.log(`\n/  HTTP ${h.status}  ${h.ms}ms  ${h.text.length} bytes`)
const dateMatch = h.text.match(/(\d{4}-\d{2}-\d{2})\s*GitHub/)
console.log('  页面标题日期:', dateMatch ? dateMatch[1] : '未匹配')
const agoMatch = h.text.match(/更新于\s*([^<]+)</)
console.log('  更新于:', agoMatch ? agoMatch[1].trim() : '未匹配')

// 3) refresh 接口（不 force，只看是否会抓）
const r = await get('/api/refresh', { method: 'POST' })
console.log(`\n/api/refresh  HTTP ${r.status}  ${r.ms}ms`)
if (r.status === 200) {
  try {
    const j = JSON.parse(r.text)
    console.log('  crawled:', j.crawled, ' reason:', j.reason || '-', ' lastCrawlAt:', j.lastCrawlAt)
    console.log('  nextCrawlAt:', j.nextCrawlAt, ' remainingMs:', j.remainingMs)
  } catch {
    console.log('  ', r.text.slice(0, 200))
  }
} else {
  console.log('  响应:', r.text.slice(0, 300))
}
