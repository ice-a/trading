/**
 * 验证「掉榜不删除」逻辑：
 * 1. 伪造一条当天曾在榜的仓库记录（bucket=0, rank=1）
 * 2. 触发一次真实抓取
 * 3. 该仓库不在新榜里 → 应被降级为 bucket=2 / dropped=true / rank=null，文档仍在
 */
import { MongoClient } from 'mongodb'

const proxyHost = process.env.MONGO_PROXY_HOST || '127.0.0.1'
const proxyPort = Number(process.env.MONGO_PROXY_PORT || 7897)
const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'
const apiBase = process.env.API_BASE || 'http://localhost:3000'

const client = new MongoClient(uri, { proxyHost, proxyPort, serverSelectionTimeoutMS: 25000 })

const now = new Date()
const date = new Intl.DateTimeFormat('en-CA', {
  timeZone: 'Asia/Shanghai',
  year: 'numeric',
  month: '2-digit',
  day: '2-digit'
}).format(now)

const FAKE_KEY = 'fake-org/should-be-dropped'

try {
  await client.connect()
  const col = client.db(dbName).collection('trending_repos')

  await col.deleteMany({ repoKey: FAKE_KEY })
  await col.insertOne({
    date,
    repoKey: FAKE_KEY,
    owner: 'fake-org',
    name: 'should-be-dropped',
    fullName: 'fake-org/should-be-dropped',
    url: 'https://github.com/fake-org/should-be-dropped',
    description: '测试用：验证掉榜后记录不删除',
    language: 'TypeScript',
    languageColor: '#3178c6',
    totalStars: 12345,
    forks: 678,
    todayStars: 9999,
    rank: 1,
    bestRank: 1,
    bucket: 0,
    dropped: false,
    droppedAt: null,
    firstSeenAt: now,
    lastSeenAt: now,
    snapshots: [],
    createdAt: now,
    updatedAt: now
  })
  console.log(`① 已插入伪造在榜记录 ${FAKE_KEY}（rank=1, bucket=0）`)

  const res = await fetch(`${apiBase}/api/crawl`, { method: 'POST' })
  const body = await res.json()
  console.log(`② 触发抓取: ok=${body.ok} fetched=${body.fetched} dropped=${body.dropped} tracked=${body.tracked}`)

  const after = await col.findOne({ date, repoKey: FAKE_KEY })
  console.log('③ 抓取后的文档:')
  console.log(
    `   exists=${!!after}  bucket=${after?.bucket}  dropped=${after?.dropped}  rank=${after?.rank}  droppedAt=${after?.droppedAt ? '已记录' : 'null'}`
  )

  const pass = !!after && after.bucket === 2 && after.dropped === true && after.rank === null
  console.log(pass ? '✓ 通过：掉榜记录被保留并降级，未删除' : '✗ 失败：掉榜处理不符合预期')

  // 顺带确认它排在最后一页（bucket 2 在排序末尾）
  const page = await fetch(`${apiBase}/api/trending?page=1`).then((r) => r.json())
  console.log(`④ 第 1 页条数=${page.items.length} total=${page.total} 是否含伪造记录=${page.items.some((i) => i.fullName === FAKE_KEY)}`)

  // 清理
  await col.deleteOne({ date, repoKey: FAKE_KEY })
  console.log('⑤ 已清理测试数据')
} catch (err) {
  console.error('✗ 测试异常:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
