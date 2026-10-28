/**
 * 探查远端库（默认 re_save）的集合与文档结构，用于编写映射导入。
 * 用法：node --env-file=.env scripts/inspect-remote-db.mjs [dbName]
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const dbName = process.argv[2] || 're_save'

const client = new MongoClient(uri, { serverSelectionTimeoutMS: 25000, appName: 'inspect-remote' })

try {
  await client.connect()
  const db = client.db(dbName)
  const cols = await db.listCollections().toArray()
  console.log(`库：${db.databaseName} · 集合数：${cols.length}\n`)

  for (const c of cols.sort((a, b) => a.name.localeCompare(b.name))) {
    const col = db.collection(c.name)
    const count = await col.countDocuments().catch(() => -1)
    console.log(`── ${c.name}  (${count} 条)`)

    const sample = await col.findOne({})
    if (sample) {
      // 只打印字段名与类型/示例值，避免长文本刷屏
      const shape = {}
      for (const [k, v] of Object.entries(sample)) {
        if (v === null || v === undefined) shape[k] = 'null'
        else if (Array.isArray(v)) shape[k] = `[${v.length}] ${v.length ? JSON.stringify(v[0]).slice(0, 40) : ''}`
        else if (v instanceof Date) shape[k] = 'Date'
        else if (typeof v === 'object') shape[k] = `{${Object.keys(v).slice(0, 6).join(',')}}`
        else shape[k] = `${typeof v}: ${String(v).slice(0, 60)}`
      }
      console.log(JSON.stringify(shape, null, 2).split('\n').map((l) => '   ' + l).join('\n'))
    }
    console.log()
  }
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
