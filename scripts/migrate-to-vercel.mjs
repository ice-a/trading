/**
 * 跨集群迁移：旧 Atlas → Vercel 集成的 Atlas。
 *
 * 用法：
 *   node --env-file=.env scripts/migrate-to-vercel.mjs "<NEW_URI>" [targetDb]
 *   node --env-file=.env scripts/migrate-to-vercel.mjs "<NEW_URI>" github_trending --dry
 *
 * 会复制全部集合 + 重建索引（含唯一索引与 TTL），目标集合已存在时先清空。
 */
import { MongoClient } from 'mongodb'

const newUri = process.argv[2]
const targetDbName = process.argv[3] && !process.argv[3].startsWith('--') ? process.argv[3] : 'github_trending'
const dry = process.argv.includes('--dry')

if (!newUri) {
  console.error('用法: node --env-file=.env scripts/migrate-to-vercel.mjs "<NEW_URI>" [targetDb]')
  process.exit(1)
}

const oldUri = process.env.MONGODB_URI
const sourceDbName = process.env.MONGODB_DB || 'github_trending'

const COLLECTIONS = [
  'trending_repos',
  'crawl_runs',
  'app_meta',
  'crawl_locks',
  'feed_snapshots',
  'nav_categories',
  'nav_links',
  'ai_boards',
  'ai_items',
  'github_creators',
  'dns_records',
  'shares'
]

const t = () => Number(process.hrtime.bigint() / 1000000n)

console.log(`源：${sourceDbName}（旧集群）`)
console.log(`目标：${targetDbName}（Vercel 集群）${dry ? '  [dry-run]' : ''}\n`)

const src = new MongoClient(oldUri, { serverSelectionTimeoutMS: 30000, appName: 'migrate-src' })
const dst = new MongoClient(newUri, { serverSelectionTimeoutMS: 30000, appName: 'migrate-dst' })

let totalDocs = 0
let totalIndexes = 0

try {
  const t0 = t()
  await Promise.all([src.connect(), dst.connect()])
  console.log(`双端连接完成（${t() - t0}ms）\n`)

  const from = src.db(sourceDbName)
  const to = dst.db(targetDbName)

  const existing = new Set((await to.listCollections().toArray()).map((c) => c.name))

  for (const name of COLLECTIONS) {
    const srcCol = from.collection(name)

    let count = 0
    try {
      count = await srcCol.countDocuments()
    } catch {
      count = 0
    }
    if (count === 0) {
      console.log(`  ${name.padEnd(18)} 源集合为空，跳过`)
      continue
    }

    // 索引定义
    let specs = []
    try {
      specs = (await srcCol.listIndexes().toArray())
        .filter((ix) => ix.name !== '_id_')
        .map((ix) => {
          const s = { key: ix.key, name: ix.name }
          if (ix.unique) s.unique = true
          if (ix.sparse) s.sparse = true
          if (typeof ix.expireAfterSeconds === 'number') s.expireAfterSeconds = ix.expireAfterSeconds
          if (ix.partialFilterExpression) s.partialFilterExpression = ix.partialFilterExpression
          return s
        })
    } catch {
      specs = []
    }

    if (dry) {
      console.log(`  ${name.padEnd(18)} ${String(count).padStart(6)} 条 · ${specs.length} 索引  [dry]`)
      totalDocs += count
      totalIndexes += specs.length
      continue
    }

    const dstCol = to.collection(name)
    if (existing.has(name)) await dstCol.deleteMany({})

    const BATCH = 500
    let copied = 0
    let batch = []
    const flush = async () => {
      if (!batch.length) return
      await dstCol.insertMany(batch, { ordered: false })
      copied += batch.length
      batch = []
    }
    for await (const doc of srcCol.find({}).batchSize(BATCH)) {
      batch.push(doc)
      if (batch.length >= BATCH) await flush()
    }
    await flush()

    let ixOk = 0
    for (const spec of specs) {
      try {
        await dstCol.createIndex(spec.key, {
          name: spec.name,
          ...(spec.unique ? { unique: true } : {}),
          ...(spec.sparse ? { sparse: true } : {}),
          ...(typeof spec.expireAfterSeconds === 'number' ? { expireAfterSeconds: spec.expireAfterSeconds } : {}),
          ...(spec.partialFilterExpression ? { partialFilterExpression: spec.partialFilterExpression } : {})
        })
        ixOk++
      } catch (e) {
        console.warn(`    ! ${name}.${spec.name} 索引失败：${e.message}`)
      }
    }

    totalDocs += copied
    totalIndexes += ixOk
    console.log(`  ${name.padEnd(18)} ${String(copied).padStart(6)} 条 · ${ixOk} 索引  ✓`)
  }

  if (!dry) {
    // 校验：目标库集合与文档数
    const verify = await to.listCollections().toArray()
    console.log(`\n目标库现有 ${verify.length} 个集合，共 ${totalDocs} 条文档 / ${totalIndexes} 个索引`)
    console.log('下一步：把 .env 的 MONGODB_URI 换成新连接串，然后重启服务。')
  } else {
    console.log(`\n[dry-run] 待迁移 ${totalDocs} 条 / ${totalIndexes} 索引`)
  }
} catch (e) {
  console.error('✗ 迁移失败:', e.message)
  process.exitCode = 1
} finally {
  await src.close().catch(() => {})
  await dst.close().catch(() => {})
}
