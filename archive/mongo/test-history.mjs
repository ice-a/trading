/**
 * 造一天历史数据 → 验证日期切换/分页 → 清理。
 * 用法：node --env-file=.env scripts/test-history.mjs
 */
import { MongoClient } from 'mongodb'

const proxyHost = process.env.MONGO_PROXY_HOST || '127.0.0.1'
const proxyPort = Number(process.env.MONGO_PROXY_PORT || 7897)
const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'
const apiBase = process.env.API_BASE || 'http://localhost:3010'
const tz = process.env.APP_TIMEZONE || 'Asia/Shanghai'

const dayKey = (d) =>
  new Intl.DateTimeFormat('en-CA', { timeZone: tz, year: 'numeric', month: '2-digit', day: '2-digit' }).format(d)

const yesterday = dayKey(new Date(Date.now() - 86400000))
const client = new MongoClient(uri, { proxyHost, proxyPort, serverSelectionTimeoutMS: 25000 })

const fake = (i, bucket, dropped = false) => ({
  date: yesterday,
  repoKey: `history-demo/repo-${i}`,
  owner: 'history-demo',
  name: `repo-${i}`,
  fullName: `history-demo/repo-${i}`,
  url: `https://github.com/history-demo/repo-${i}`,
  description: `历史数据演示 #${i}`,
  language: ['TypeScript', 'Rust', 'Python', 'Go'][i % 4],
  languageColor: ['#3178c6', '#dea584', '#3572A5', '#00ADD8'][i % 4],
  totalStars: 50000 - i * 1000,
  forks: 3000 - i * 100,
  todayStars: 2000 - i * 120,
  rank: bucket === 2 ? null : i,
  bestRank: bucket === 2 ? 3 : i,
  bucket,
  dropped,
  droppedAt: dropped ? new Date() : null,
  firstSeenAt: new Date(),
  lastSeenAt: new Date(),
  snapshots: [],
  createdAt: new Date(),
  updatedAt: new Date()
})

try {
  await client.connect()
  const col = client.db(dbName).collection('trending_repos')
  await col.deleteMany({ date: yesterday })

  const docs = []
  for (let i = 1; i <= 10; i++) docs.push(fake(i, 0))
  for (let i = 11; i <= 12; i++) docs.push(fake(i, 1))
  docs.push(fake(13, 2, true))
  await col.insertMany(docs)
  console.log(`① 已写入 ${docs.length} 条 ${yesterday} 的数据（10 条 top + 2 条榜内 + 1 条掉榜）`)

  const days = await fetch(`${apiBase}/api/days`).then((r) => r.json())
  console.log(`② /api/days 返回 ${days.days.length} 天: ${days.days.map((d) => `${d.date}(${d.count})`).join(', ')}`)

  const p1 = await fetch(`${apiBase}/api/trending?date=${yesterday}&page=1`).then((r) => r.json())
  const p2 = await fetch(`${apiBase}/api/trending?date=${yesterday}&page=2`).then((r) => r.json())
  console.log(`③ 昨天 第1页: ${p1.items.length} 条, isToday=${p1.isToday}, 全部 bucket=${[...new Set(p1.items.map((i) => i.bucket))].join('/')}`)
  console.log(`   昨天 第2页: ${p2.items.length} 条, 排序: ${p2.items.map((i) => `${i.rank ?? '掉榜'}:${i.name}`).join(', ')}`)
  console.log(
    `④ 首页(今日)仍是今天: ${(await fetch(`${apiBase}/api/trending?page=1`).then((r) => r.json())).date === dayKey(new Date())}`
  )
  console.log(`⑤ 页面可访问: ${(await fetch(`${apiBase}/?date=${yesterday}`)).status}`)

  await col.deleteMany({ date: yesterday })
  console.log(`⑥ 已清理 ${yesterday} 的演示数据`)
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
