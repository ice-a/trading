/**
 * 走本地 SOCKS5 代理连 Atlas（直连 27017 被网络阻断时用）。
 * 用法：node --env-file=.env scripts/check-db-proxy.mjs [proxyHost] [proxyPort]
 */
import { MongoClient } from 'mongodb'

const proxyHost = process.argv[2] || process.env.MONGO_PROXY_HOST || '127.0.0.1'
const proxyPort = Number(process.argv[3] || process.env.MONGO_PROXY_PORT || 7897)
const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'

const t0 = Date.now()
const client = new MongoClient(uri, {
  proxyHost,
  proxyPort,
  serverSelectionTimeoutMS: 25000,
  appName: 'git-trending-probe'
})

try {
  await client.connect()
  const db = client.db(dbName)
  const ping = await db.command({ ping: 1 })
  console.log(`✓ 经 SOCKS5 ${proxyHost}:${proxyPort} 连接成功 db=${db.databaseName} ${Date.now() - t0}ms`)

  const probe = db.collection('__probe__')
  const { insertedId } = await probe.insertOne({ at: new Date() })
  await probe.deleteOne({ _id: insertedId })
  console.log('✓ 读写正常')

  const cols = await db.listCollections().toArray()
  console.log(`· 集合(${cols.length}): ${cols.map((c) => c.name).join(', ') || '(空库)'}`)
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
