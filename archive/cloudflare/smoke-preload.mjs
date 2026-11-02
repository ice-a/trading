/**
 * 本地冒烟专用预加载：给 Nitro node 产物注入一个「内存版 D1」。
 *
 * 目的：在不需要远端 D1 凭据、也不需要 workerd 的前提下，
 * 用真实 SQLite（node:sqlite）跑完整的 SSR + API + SQL 链路，
 * 验证重构后的同源全栈代码在运行时是通的。
 *
 * 用法：
 *   npm run build:node
 *   node --import ./scripts/smoke-preload.mjs .output/server/index.mjs
 *
 * 生产环境不会加载这个文件（它只出现在 scripts/ 目录，不在 server/ 里）。
 */
import { readFileSync } from 'node:fs'
import { DatabaseSync } from 'node:sqlite'

const db = new DatabaseSync(':memory:')
db.exec(readFileSync(new URL('../cloudflare/schema.sql', import.meta.url), 'utf8'))
// 站点基础数据直接用生产的 seed.sql，保证 /nav /ai 页面有真实结构的内容
db.exec(readFileSync(new URL('../cloudflare/seed.sql', import.meta.url), 'utf8'))

function statement(sql) {
  return {
    bind(...params) {
      const st = db.prepare(sql)
      return {
        async all() {
          return { results: st.all(...params) }
        },
        async first() {
          return st.get(...params) ?? null
        },
        async run() {
          st.run(...params)
          return { success: true }
        }
      }
    },
    async all() {
      return { results: db.prepare(sql).all() }
    },
    async run() {
      db.prepare(sql).run()
      return { success: true }
    }
  }
}

const DB = {
  prepare: (sql) => statement(sql),
  async batch(stmts) {
    return {
      results: stmts.map((s) => {
        const st = db.prepare(s.sql)
        return { results: st.all(...(s.params ?? [])) }
      })
    }
  }
}

// ---- 种子数据（覆盖首页 / 导航 / AI / 历史 / 状态几条主链路）----
const now = new Date().toISOString()
const day = '2026-11-02'

const repo = db.prepare(
  `insert or replace into trending_repos
   (date, period, repo_key, owner, name, full_name, url, description, language, language_color,
    total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at,
    first_seen_at, last_seen_at, snapshots, created_at, updated_at)
   values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
)

const rows = [
  ['obra', 'superpowers', 'obra/superpowers', 'An agentic skills framework', 'Shell', '#89e051', 306745, 27303, 617, 1],
  ['Nutlope', 'hallmark', 'Nutlope/hallmark', 'Anti-AI-slop design skill', 'CSS', '#663399', 39547, 2066, 2830, 2],
  ['pbakaus', 'impeccable', 'pbakaus/impeccable', 'Design vocabulary for your coding agent', 'Rust', '#dea584', 91063, 5394, 1449, 3]
]

for (const period of ['daily', 'weekly', 'monthly']) {
  for (const [owner, name, fullName, desc, lang, color, stars, forks, today, rank] of rows) {
    repo.run(
      day, period, `${owner}/${name}`.toLowerCase(), owner, name, fullName,
      `https://github.com/${fullName}`, desc, lang, color,
      stars, forks, today, rank, rank, 0, 0, null,
      now, now, '[]', now, now
    )
  }
}

db.prepare("insert or replace into app_meta (key, value, updated_at) values ('status', ?, ?)").run(
  JSON.stringify({ lastSuccessAt: now }),
  now
)

db.prepare(
  'insert or replace into dns_records (host, name, type, target, proxied, status, latency_ms, http_status, checked_at) values (?,?,?,?,?,?,?,?,?)'
).run('example.com', 'example.com', 'A', '1.2.3.4', 1, 'online', 30, 200, now)

globalThis.__env__ = {
  DB,
  ADMIN_PASSWORD: 'smoke-pass',
  APP_TIMEZONE: 'Asia/Shanghai',
  NODE_ENV: 'production'
}

console.log('[smoke] 内存 D1 就绪（node:sqlite + schema.sql + seed.sql + 榜单样本）')