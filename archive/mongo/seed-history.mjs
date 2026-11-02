/**
 * 临时：造几天历史数据用于查看 /history 效果。
 *   node --env-file=.env scripts/seed-history.mjs        # 造 4 天
 *   node --env-file=.env scripts/seed-history.mjs clean  # 清理
 */
import { MongoClient } from 'mongodb'

const proxyHost = process.env.MONGO_PROXY_HOST || ''
const proxyPort = Number(process.env.MONGO_PROXY_PORT || 7897)
const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'
const tz = process.env.APP_TIMEZONE || 'Asia/Shanghai'
const mode = process.argv[2] || 'seed'

const PREFIX = 'demo-history/'
const client = new MongoClient(uri, {
  ...(proxyHost ? { proxyHost, proxyPort } : {}),
  serverSelectionTimeoutMS: 25000
})

const dayKey = (offset) =>
  new Intl.DateTimeFormat('en-CA', { timeZone: tz, year: 'numeric', month: '2-digit', day: '2-digit' }).format(
    new Date(Date.now() + offset * 86400000)
  )

const NAMES = [
  ['Nutlope', 'hallmark', 'CSS', '#663399', 'Anti-AI-slop design skill for Claude Code.'],
  ['nightly-labs', 'openbot', 'TypeScript', '#3178c6', 'Local-first desktop workspace for AI teammates.'],
  ['obra', 'superpowers', 'Shell', '#89e051', 'Agentic skills framework & methodology.'],
  ['pbakaus', 'impeccable', 'Rust', '#dea584', 'Design language for AI harnesses.'],
  ['makecindy', 'cindy', 'TypeScript', '#3178c6', 'Open-source AI agent that works out of the box.'],
  ['gitroomhq', 'postiz-app', 'TypeScript', '#3178c6', 'Agentic social media scheduling tool.'],
  ['affaan-m', 'ECC', 'JavaScript', '#f1e05a', 'Agent harness performance optimization.'],
  ['HKUDS', 'DeepTutor', 'Python', '#3572A5', 'Lifelong personalized tutoring.'],
  ['JetBrains', 'thinkrail', 'TypeScript', '#3178c6', 'Lightweight real IDE with pi.'],
  ['TauricResearch', 'TradingAgents', 'Python', '#3572A5', 'Multi-agent LLM financial trading framework.'],
  ['pollen-robotics', 'microduck', 'Rust', '#dea584', 'Tiny RL quadruped runtime.'],
  ['NVIDIA', 'SkillSpector', 'Python', '#3572A5', 'Agent skill security and supply chain checks.']
]

try {
  await client.connect()
  const col = client.db(dbName).collection('trending_repos')

  if (mode === 'clean') {
    const r = await col.deleteMany({ repoKey: { $regex: `^${PREFIX}` } })
    console.log(`已清理演示数据 ${r.deletedCount} 条`)
  } else {
    let inserted = 0
    for (let d = 4; d >= 1; d--) {
      const date = dayKey(-d)
      await col.deleteMany({ date, repoKey: { $regex: `^${PREFIX}` } })
      const docs = NAMES.map((n, i) => {
        const [owner, name, language, languageColor, description] = n
        const rank = i + 1
        const bucket = rank <= 10 ? 0 : 1
        const todayStars = Math.max(80, 2400 - i * 170 - d * 60)
        return {
          date,
          repoKey: `${PREFIX}${owner}-${name}`.toLowerCase(),
          owner,
          name,
          fullName: `${owner}/${name}`,
          url: `https://github.com/${owner}/${name}`,
          description,
          language,
          languageColor,
          totalStars: 90000 - i * 5200 + d * 300,
          forks: 6000 - i * 380,
          todayStars,
          rank,
          bestRank: rank,
          bucket,
          dropped: false,
          droppedAt: null,
          firstSeenAt: new Date(),
          lastSeenAt: new Date(),
          snapshots: [],
          createdAt: new Date(),
          updatedAt: new Date()
        }
      })
      await col.insertMany(docs)
      inserted += docs.length
      console.log(`  ${date}: ${docs.length} 条`)
    }
    console.log(`合计写入 ${inserted} 条演示数据（repoKey 前缀 ${PREFIX}）`)
  }
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
