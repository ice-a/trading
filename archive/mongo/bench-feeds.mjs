/**
 * 压测 feed_snapshots 的读取耗时，定位 /api/feeds 冷查询慢在哪。
 * 用法：node --env-file=.env scripts/bench-feeds.mjs
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'

const t0 = Date.now()
const client = new MongoClient(uri, { serverSelectionTimeoutMS: 20000, appName: 'bench' })
await client.connect()
const db = client.db(dbName)
await db.command({ ping: 1 })
console.log(`建立连接 + ping: ${Date.now() - t0}ms`)

const col = db.collection('feed_snapshots')

// 1. 全量读（无投影）
let t = Date.now()
const all = await col.find({}).toArray()
const fullBytes = Buffer.byteLength(JSON.stringify(all))
console.log(`全量读 50 条: ${Date.now() - t}ms  体积 ${(fullBytes / 1024).toFixed(0)} KB`)

// 2. 带 $slice 投影
t = Date.now()
const sliced = await col.find({}, { projection: { 'payload.items': { $slice: 6 }, snapshots: 0 } }).toArray()
const slicedBytes = Buffer.byteLength(JSON.stringify(sliced))
console.log(`$slice(6) 投影: ${Date.now() - t}ms  体积 ${(slicedBytes / 1024).toFixed(0)} KB`)

// 3. 只取元信息（不含 payload）
t = Date.now()
const meta = await col
  .find({}, { projection: { payload: 0, snapshots: 0 } })
  .toArray()
console.log(`只取元信息: ${Date.now() - t}ms  条数 ${meta.length}`)

// 4. 预热后再读一次
t = Date.now()
await col.find({}, { projection: { 'payload.items': { $slice: 6 }, snapshots: 0 } }).toArray()
console.log(`第二次 $slice 投影: ${Date.now() - t}ms`)

// 5. 单文档大小分布
const sizes = all
  .map((d) => ({ key: d.key, kb: Buffer.byteLength(JSON.stringify(d.payload || {})) / 1024 }))
  .sort((a, b) => b.kb - a.kb)
console.log('\n最大的 5 个 payload：')
for (const s of sizes.slice(0, 5)) console.log(`  ${String(s.kb.toFixed(1)).padStart(6)} KB  ${s.key}`)
console.log(`  合计 ${(sizes.reduce((a, b) => a + b.kb, 0) / 1024).toFixed(2)} MB`)

await client.close()
