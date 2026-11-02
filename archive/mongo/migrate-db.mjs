/**
 * 数据库迁移：把本项目全部集合从源库搬到目标库（默认 github_trending → re_save）。
 *
 * 用法：
 *   node --env-file=.env scripts/migrate-db.mjs                 # 迁移到 re_save
 *   node --env-file=.env scripts/migrate-db.mjs --target=xxx    # 指定目标库
 *   node --env-file=.env scripts/migrate-db.mjs --dry           # 只检查，不写入
 *
 * 会一并重建索引（含唯一索引与 TTL），否则 upsert / 锁过期这些逻辑会失效。
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const sourceDb = process.env.MONGODB_DB || 'github_trending'

const args = process.argv.slice(2)
const targetArg = args.find((a) => a.startsWith('--target='))
const targetDb = targetArg ? targetArg.split('=')[1] : 're_save'
const dry = args.includes('--dry')

/** 本项目的全部集合 */
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
  'dns_records'
]

if (!uri) {
  console.error('✗ MONGODB_URI 未设置')
  process.exit(1)
}
if (sourceDb === targetDb) {
  console.error(`✗ 源库与目标库相同（${sourceDb}），无需迁移`)
  process.exit(1)
}

const client = new MongoClient(uri, { serverSelectionTimeoutMS: 25000, appName: 'migrate-db' })

try {
  await client.connect()
  const src = client.db(sourceDb)
  const dst = client.db(targetDb)

  console.log(`源库：${sourceDb}`)
  console.log(`目标库：${targetDb}${dry ? '（dry-run，不写入）' : ''}\n`)

  // 目标库现有集合
  const dstExisting = new Set((await dst.listCollections().toArray()).map((c) => c.name))

  let totalDocs = 0
  let totalIndexes = 0

  for (const name of COLLECTIONS) {
    const srcCol = src.collection(name)

    let count = 0
    try {
      count = await srcCol.countDocuments()
    } catch {
      count = 0
    }

    if (count === 0) {
      console.log(`  ${name.padEnd(18)} 源集合为空或不存在，跳过`)
      continue
    }

    // 读索引定义（去掉 MongoDB 内部字段）
    let indexSpecs = []
    try {
      const raw = await srcCol.listIndexes().toArray()
      indexSpecs = raw
        .filter((ix) => ix.name !== '_id_')
        .map((ix) => {
          const { key, name: ixName, unique, sparse, expireAfterSeconds, partialFilterExpression } = ix
          const spec = { key, name: ixName }
          if (unique) spec.unique = true
          if (sparse) spec.sparse = true
          if (typeof expireAfterSeconds === 'number') spec.expireAfterSeconds = expireAfterSeconds
          if (partialFilterExpression) spec.partialFilterExpression = partialFilterExpression
          return spec
        })
    } catch {
      indexSpecs = []
    }

    if (dry) {
      console.log(`  ${name.padEnd(18)} ${String(count).padStart(6)} 条 · ${indexSpecs.length} 个索引（dry-run）`)
      totalDocs += count
      totalIndexes += indexSpecs.length
      continue
    }

    const dstCol = dst.collection(name)

    // 目标集合已存在则先清空，保证「导入」= 源库当前状态
    if (dstExisting.has(name)) {
      await dstCol.deleteMany({})
    }

    // 分批复制，避免超大集合一次性读进内存
    const BATCH = 1000
    let copied = 0
    let cursor = srcCol.find({}).batchSize(BATCH)
    let batch = []

    const flush = async () => {
      if (!batch.length) return
      await dstCol.insertMany(batch, { ordered: false })
      copied += batch.length
      batch = []
    }

    for await (const doc of cursor) {
      batch.push(doc)
      if (batch.length >= BATCH) await flush()
    }
    await flush()

    // 重建索引
    let ixCount = 0
    for (const spec of indexSpecs) {
      try {
        await dstCol.createIndex(spec.key, {
          name: spec.name,
          ...(spec.unique ? { unique: true } : {}),
          ...(spec.sparse ? { sparse: true } : {}),
          ...(typeof spec.expireAfterSeconds === 'number' ? { expireAfterSeconds: spec.expireAfterSeconds } : {}),
          ...(spec.partialFilterExpression ? { partialFilterExpression: spec.partialFilterExpression } : {})
        })
        ixCount++
      } catch (err) {
        console.warn(`    ! ${name} 索引 ${spec.name} 重建失败：${err?.message || err}`)
      }
    }

    totalDocs += copied
    totalIndexes += ixCount
    console.log(`  ${name.padEnd(18)} ${String(copied).padStart(6)} 条 · ${ixCount} 个索引  ✓`)
  }

  if (dry) {
    console.log(`\n合计 ${totalDocs} 条文档、${totalIndexes} 个索引待迁移（dry-run）`)
  } else {
    console.log(`\n迁移完成：${totalDocs} 条文档、${totalIndexes} 个索引 → ${targetDb}`)
    console.log(`\n下一步：把 .env 里的 MONGODB_DB 改成 ${targetDb}，然后重启服务。`)
  }
} catch (err) {
  console.error('✗ 迁移失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
