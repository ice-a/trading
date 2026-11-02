/**
 * 从 navcockpit 的库（默认 tools，可选 test）导入到当前项目库。
 *
 * 用法：
 *   node --env-file=.env scripts/import-from-navcockpit.mjs                # 从 tools 导入
 *   node --env-file=.env scripts/import-from-navcockpit.mjs --source=test  # 从 test 导入
 *   node --env-file=.env scripts/import-from-navcockpit.mjs --dry          # 只看统计不写库
 *
 * 映射关系：
 *   navcategories  → nav_categories
 *   navlinks       → nav_links
 *   hubboards      → ai_boards
 *   stations/tools/skills/vpns/servers/tutorials → ai_items（按 board 区分）
 *   creators       → github_creators
 *
 * 安全：stations 的 apiKey / keyId 属于密钥，**一律不导入**目标库。
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const targetDbName = process.env.MONGODB_DB || 'github_trending'

const args = process.argv.slice(2)
const sourceArg = args.find((a) => a.startsWith('--source='))
const sourceDbName = sourceArg ? sourceArg.split('=')[1] : 'tools'
const dry = args.includes('--dry')

const client = new MongoClient(uri, { serverSelectionTimeoutMS: 25000, appName: 'import-navcockpit' })

/** 只挑字符串/数字/布尔，过滤掉 mongoose 内部字段 */
const clean = (v) => (v === null || v === undefined ? '' : typeof v === 'string' ? v.trim() : String(v))

/** 把 detail / tags 之类统一成字符串数组 */
function toArray(v) {
  if (Array.isArray(v)) return v.map((x) => clean(x)).filter(Boolean)
  if (typeof v === 'string' && v.trim()) return [v.trim()]
  return []
}

try {
  await client.connect()
  const src = client.db(sourceDbName)
  const dst = client.db(targetDbName)

  console.log(`源库：${sourceDbName}`)
  console.log(`目标库：${targetDbName}${dry ? '（dry-run）' : ''}\n`)

  const report = []

  /* ---------- 1. 导航分类 ---------- */
  const navcats = await src
    .collection('navcategories')
    .find({})
    .sort({ group: 1, sort: 1, name: 1 })
    .toArray()

  const navCatDocs = navcats.map((c) => ({
    key: clean(c.key) || clean(c.name).toLowerCase().replace(/\s+/g, '-'),
    name: clean(c.name),
    group: clean(c.group) || '其他',
    icon: clean(c.icon),
    sort: Number(c.sort) || 0,
    status: c.status === 'inactive' ? 'inactive' : 'active'
  }))

  report.push(['nav_categories', navCatDocs.length])

  /* ---------- 2. 导航站点 ---------- */
  const navlinks = await src
    .collection('navlinks')
    .find({ status: { $ne: 'inactive' } })
    .sort({ sort: 1, name: 1 })
    .toArray()

  const linkDocs = navlinks
    .filter((l) => clean(l.url))
    .map((l, i) => ({
      name: clean(l.name),
      url: clean(l.url),
      catelog: clean(l.catelog),
      group: clean(l.group) || '其他',
      desc: clean(l.desc),
      icon: clean(l.icon),
      sort: Number(l.sort) || i * 10,
      status: 'active'
    }))

  report.push(['nav_links', linkDocs.length])

  /* ---------- 3. AI 板块 ---------- */
  const boards = await src
    .collection('hubboards')
    .find({ status: { $ne: 'inactive' } })
    .sort({ sort: 1 })
    .toArray()

  /* ---------- 4. AI 条目：6 个内置板块分别映射 ---------- */
  const BOARDS = [
    { key: 'stations', coll: 'stations' },
    { key: 'tools', coll: 'tools' },
    { key: 'skills', coll: 'skills' },
    { key: 'vpns', coll: 'vpns' },
    { key: 'servers', coll: 'servers' },
    { key: 'tutorials', coll: 'tutorials' }
  ]

  const aiItems = []

  for (const b of BOARDS) {
    let rows = []
    try {
      rows = await src.collection(b.coll).find({ status: { $ne: 'inactive' } }).sort({ sort: 1 }).toArray()
    } catch {
      rows = []
    }

    for (const r of rows) {
      const base = {
        board: b.key,
        name: clean(r.name) || clean(r.title),
        url: '',
        desc: '',
        models: '',
        ratio: '',
        tags: [],
        content: '',
        sort: Number(r.sort) || 0,
        status: 'active'
      }

      if (b.key === 'stations') {
        // 注意：baseURL / siteURL 是公开地址；apiKey / keyId 属于密钥，绝不导入
        base.url = clean(r.siteURL) || clean(r.baseURL)
        base.desc = clean(r.remark) || clean(r.desc)
        base.models = toArray(r.models).join(' / ')
        base.tags = [clean(r.balance)].filter(Boolean)
      } else if (b.key === 'tools') {
        base.url = clean(r.home) || clean(r.install)
        base.desc = clean(r.desc)
        base.tags = toArray(r.tags)
      } else if (b.key === 'skills') {
        base.url = clean(r.web)
        base.desc = clean(r.intro) || clean(r.desc)
        base.tags = []
      } else if (b.key === 'vpns') {
        base.url = clean(r.url)
        base.desc = clean(r.desc)
      } else if (b.key === 'servers') {
        base.url = clean(r.url)
        base.desc = clean(r.desc)
        base.tags = [clean(r.category), clean(r.region)].filter(Boolean)
      } else if (b.key === 'tutorials') {
        base.url = clean(r.cover)
        base.desc = clean(r.summary) || clean(r.desc)
        base.tags = toArray(r.tags)
        base.content = clean(r.content)
      }

      if (!base.name) continue
      aiItems.push(base)
    }
  }

  // 只保留真正有条目的板块，避免前端出现空 Tab
  const usedBoards = new Set(aiItems.map((i) => i.board))
  const boardDocs = boards
    .filter((b) => usedBoards.has(clean(b.key)))
    .map((b) => ({
      key: clean(b.key),
      name: clean(b.name),
      icon: clean(b.icon),
      sort: Number(b.sort) || 0,
      status: 'active'
    }))

  // 源库缺板块定义时，按内置板块兜底
  if (!boardDocs.length) {
    const fallback = {
      stations: '中转站',
      tools: '工具',
      skills: 'Skills',
      vpns: 'VPN',
      servers: 'AI 直连平台',
      tutorials: '教程'
    }
    Object.entries(fallback).forEach(([key, name], i) => {
      if (usedBoards.has(key)) boardDocs.push({ key, name, icon: '', sort: i, status: 'active' })
    })
  }

  report.push(['ai_boards', boardDocs.length])
  report.push(['ai_items', aiItems.length])

  /* ---------- 5. 创作者 ---------- */
  const creators = await src
    .collection('creators')
    .find({})
    .sort({ sort: 1, login: 1 })
    .toArray()

  const creatorDocs = creators
    .filter((c) => clean(c.login))
    .map((c) => ({
      login: clean(c.login),
      note: clean(c.note),
      sort: Number(c.sort) || 0
    }))

  report.push(['github_creators', creatorDocs.length])

  /* ---------- 输出统计 ---------- */
  console.log('待导入：')
  for (const [name, n] of report) {
    console.log(`  ${name.padEnd(18)} ${String(n).padStart(5)} 条`)
  }

  const byBoard = aiItems.reduce((acc, it) => {
    acc[it.board] = (acc[it.board] || 0) + 1
    return acc
  }, {})
  console.log(`\nAI 条目分布：${Object.entries(byBoard).map(([k, v]) => `${k} ${v}`).join(' / ')}`)

  if (dry) {
    console.log('\n（dry-run，未写入）')
    process.exit(0)
  }

  /* ---------- 写入 ---------- */
  console.log('\n开始写入…')

  const write = async (name, docs, uniqueKey) => {
    const col = dst.collection(name)
    await col.deleteMany({})
    if (!docs.length) return 0

    const BATCH = 500
    for (let i = 0; i < docs.length; i += BATCH) {
      await col.insertMany(docs.slice(i, i + BATCH), { ordered: false })
    }

    try {
      await col.createIndex({ [uniqueKey]: 1 }, { unique: true })
    } catch {
      /* 已有索引，忽略 */
    }
    return docs.length
  }

  const n1 = await write('nav_categories', navCatDocs, 'key')
  console.log(`  nav_categories  ${n1} 条`)

  const n2 = await write('nav_links', linkDocs, 'url')
  console.log(`  nav_links       ${n2} 条`)

  const n3 = await write('ai_boards', boardDocs, 'key')
  console.log(`  ai_boards       ${n3} 条`)

  const n4 = await write('ai_items', aiItems, 'name')
  console.log(`  ai_items        ${n4} 条`)

  const n5 = await write('github_creators', creatorDocs, 'login')
  console.log(`  github_creators ${n5} 条`)

  console.log('\n导入完成。dns_records 保留原有缓存数据（源库没有 DNS 记录）。')
  console.log('重启服务或等 2 分钟缓存过期后即可看到新数据。')
} catch (err) {
  console.error('✗ 导入失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
