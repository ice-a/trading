#!/usr/bin/env node
/**
 * 手动触发一次抓取（服务必须已在运行）。
 *
 * 这两个接口都能用：
 *   /api/crawl    强制抓，支持 target，需 CRON_TOKEN（若已配置）
 *   /api/refresh  受 1 小时节流，?force=1 强制
 *
 * 用法：
 *   node scripts/crawl-once.mjs                 # 抓全部
 *   node scripts/crawl-once.mjs github          # 只抓榜单
 *   node scripts/crawl-once.mjs feeds           # 只抓聚合端点
 *   BASE=http://127.0.0.1:3000 node scripts/crawl-once.mjs
 */
const base = (process.env.BASE || 'http://127.0.0.1:3000').replace(/\/+$/, '')
const target = process.argv[2] || 'all'
const token = process.env.CRON_TOKEN || ''

const url = `${base}/api/crawl?target=${encodeURIComponent(target)}`
console.log(`→ POST ${url}`)

const t0 = Date.now()
try {
  const res = await fetch(url, {
    method: 'POST',
    headers: token ? { authorization: `Bearer ${token}` } : {},
    signal: AbortSignal.timeout(300_000)
  })
  const body = await res.json().catch(() => null)
  console.log(`HTTP ${res.status} （${Date.now() - t0}ms）`)
  console.log(JSON.stringify(body, null, 2))
  process.exit(res.ok ? 0 : 1)
} catch (err) {
  console.error('✗ 请求失败：', err instanceof Error ? err.message : err)
  console.error('  服务没起？先 npm start，或用 BASE 指定地址')
  process.exit(1)
}