/**
 * 对比新旧 Atlas 集群延迟（不写数据，只读）。
 * 用法：node scripts/compare-clusters.mjs "<newUri>"
 */
import { MongoClient } from 'mongodb'

const newUri = process.argv[2]
if (!newUri) {
  console.error('用法: node scripts/compare-clusters.mjs "<newUri>"')
  process.exit(1)
}

const oldUri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'

const t = () => Number(process.hrtime.bigint() / 1000000n)

async function probe(uri, label) {
  const out = { label, connect: 0, ping: 0, query: 0, ok: false, error: '' }
  let client
  try {
    const t0 = t()
    client = new MongoClient(uri, { serverSelectionTimeoutMS: 30000, appName: 'compare' })
    await client.connect()
    out.connect = t() - t0

    const db = client.db(dbName)

    const t1 = t()
    await db.command({ ping: 1 })
    out.ping = t() - t1

    const t2 = t()
    await db.collection('feed_snapshots').find({}).limit(5).toArray()
    out.query = t() - t2

    out.ok = true
  } catch (e) {
    out.error = e.message
  } finally {
    if (client) await client.close().catch(() => {})
  }
  return out
}

const [a, b] = await Promise.all([probe(oldUri, '旧集群'), probe(newUri, '新集群 (Vercel)')])

console.log('项目'.padEnd(10), 'connect'.padStart(10), 'ping'.padStart(10), 'query'.padStart(10))
for (const r of [a, b]) {
  if (!r.ok) {
    console.log(r.label.padEnd(10), '失败:', r.error)
    continue
  }
  console.log(
    r.label.padEnd(10),
    `${r.connect}ms`.padStart(10),
    `${r.ping}ms`.padStart(10),
    `${r.query}ms`.padStart(10)
  )
}

if (a.ok && b.ok) {
  const speedup = (a.connect / Math.max(b.connect, 1)).toFixed(1)
  console.log(`\n建连提速: ${speedup}×`)
}
