/**
 * 测远程 Atlas 各环节耗时，定位瓶颈。
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'

const t = () => Number(process.hrtime.bigint() / 1000000n)
const log = (label, ms) => console.log(`  ${label.padEnd(30)} ${String(ms).padStart(6)} ms`)

let t0 = t()
const client = new MongoClient(uri, { serverSelectionTimeoutMS: 30000, appName: 'perf-probe' })
await client.connect()
log('① 建立连接 (connect)', t() - t0)

const db = client.db(dbName)

t0 = t()
await db.command({ ping: 1 })
log('② ping', t() - t0)

t0 = t()
await db.collection('trending_repos').findOne({})
log('③ findOne (trending_repos)', t() - t0)

t0 = t()
const few = await db.collection('feed_snapshots').find({}).limit(5).toArray()
log('④ 5 条文档', t() - t0)

t0 = t()
const all = await db.collection('feed_snapshots').find({}).toArray()
log(`⑤ ${all.length} 条文档（全量热搜）`, t() - t0)

t0 = t()
await db.collection('nav_links').find({}).limit(200).toArray()
log('⑥ 200 条导航', t() - t0)

// 顺序再测一次，看是否已建立会话后变快
t0 = t()
await db.collection('feed_snapshots').find({}).toArray()
log('⑦ 再次全量热搜（热连接）', t() - t0)

// 数据体积
const bytes = Buffer.byteLength(JSON.stringify(all))
console.log(`\n  热搜全量 JSON 体积: ${(bytes / 1024).toFixed(0)} KB`)

const navAll = await db.collection('nav_links').find({}).toArray()
console.log(`  导航全量 JSON 体积: ${(Buffer.byteLength(JSON.stringify(navAll)) / 1024).toFixed(0)} KB`)

const aiAll = await db.collection('ai_items').find({}).toArray()
console.log(`  AI 资源 JSON 体积: ${(Buffer.byteLength(JSON.stringify(aiAll)) / 1024).toFixed(0)} KB`)

await client.close()
console.log('\n（以上均为一次往返的网络耗时，跨洋链路会明显偏高）')
