/**
 * 一次性自检：MongoDB Atlas 连通性 + 库名校验。
 * 用法：node --env-file=.env scripts/check-db.mjs
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'

if (!uri) {
  console.error('✗ MONGODB_URI 未设置')
  process.exit(1)
}
if (/^(test|admin|local|config)$/i.test(dbName)) {
  console.error(`✗ 库名 "${dbName}" 不允许使用`)
  process.exit(1)
}

const t0 = Date.now()
const client = new MongoClient(uri, { serverSelectionTimeoutMS: 15000, appName: 'git-trending-probe' })

try {
  await client.connect()
  const db = client.db(dbName)
  const ping = await db.command({ ping: 1 })
  console.log(`✓ 连接成功  db=${db.databaseName}  ping=${ping.ok}  ${Date.now() - t0}ms`)

  // 探针文档：写入后立刻删除，不留痕迹
  const probe = db.collection('__probe__')
  const { insertedId } = await probe.insertOne({ at: new Date(), note: 'connectivity probe' })
  const found = await probe.findOne({ _id: insertedId })
  await probe.deleteOne({ _id: insertedId })
  console.log(`✓ 读写正常  inserted=${insertedId}  readBack=${found ? 'yes' : 'no'}`)

  const cols = await db.listCollections().toArray()
  console.log(`· 现有集合(${cols.length}): ${cols.map((c) => c.name).join(', ') || '(空库)'}`)
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
