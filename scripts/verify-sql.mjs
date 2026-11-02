/**
 * schema + seed 自检（不依赖 workerd、不需要 Cloudflare 账号）。
 *
 * 用 Node 内置 SQLite（node:sqlite，Node ≥ 22.5）把 cloudflare/*.sql 真实跑一遍：
 *   1. 建表 → 断言 12 张表都在
 *   2. 灌 seed → 断言各表行数
 *   3. 再跑一次 seed → 断言幂等
 *   4. 跑生产代码真正用到的查询（排序 / upsert / union 统计 / 锁 CAS / 分享去重）
 *
 * 用法：node scripts/verify-sql.mjs
 */
import { DatabaseSync } from 'node:sqlite'
import { readFileSync } from 'node:fs'

const db = new DatabaseSync(':memory:')

const EXPECT_TABLES = [
  'ai_boards',
  'ai_items',
  'app_meta',
  'crawl_locks',
  'crawl_runs',
  'dns_records',
  'feed_snapshots',
  'github_creators',
  'nav_categories',
  'nav_links',
  'shares',
  'trending_repos'
]

let failed = 0
const check = (label, ok, detail = '') => {
  console.log(`${ok ? '✓' : '✗'} ${label}${detail ? ` — ${detail}` : ''}`)
  if (!ok) failed++
}

/* ---------- 1. schema ---------- */
console.log('① 执行 schema.sql …')
db.exec(readFileSync('db/schema.sql', 'utf8'))

const tables = db
  .prepare("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name")
  .all()
  .map((r) => r.name)

check('建表数量', tables.length === EXPECT_TABLES.length, `${tables.length} 张`)
for (const t of EXPECT_TABLES) check(`表存在 ${t}`, tables.includes(t))

const indexes = db
  .prepare("select name from sqlite_master where type='index' and name like 'idx_%'")
  .all()
  .map((r) => r.name)
check('索引', indexes.length === 7, `${indexes.length} 个：${indexes.join(', ')}`)

/* ---------- 2. seed ---------- */
console.log('\n② 执行 seed.sql …')
db.exec(readFileSync('db/seed.sql', 'utf8'))

const EXPECT_ROWS = {
  nav_categories: 8,
  nav_links: 30,
  ai_boards: 6,
  ai_items: 10,
  github_creators: 3
}

for (const [table, want] of Object.entries(EXPECT_ROWS)) {
  const got = db.prepare(`select count(*) as n from ${table}`).get().n
  check(`seed ${table}`, got === want, `${got} 行`)
}

console.log('\n③ 幂等性（seed 再跑一次）…')
db.exec(readFileSync('db/seed.sql', 'utf8'))
for (const [table, want] of Object.entries(EXPECT_ROWS)) {
  const got = db.prepare(`select count(*) as n from ${table}`).get().n
  check(`重复执行不增行 ${table}`, got === want, `${got} 行`)
}

/* ---------- 2.5 源码 SQL 静态校验 ----------
 * verify 里手抄的 SQL 只能证明"我抄对了"，不能证明"源码写对了"。
 * 这里直接读源码，把每条 insert 的列数 / 值数对齐检查一遍，
 * 防止「16 values for 15 columns」这类只在运行时才炸的错误溜过去。
 */
console.log('\n③ 源码 insert 语句列数校验 …')

function checkInsertArity(file, label) {
  const text = readFileSync(file, 'utf8')
  const re = /insert\s+(?:or\s+(?:replace|ignore|abort|fail|rollback)\s+)?into\s+(\w+)\s*\(([\s\S]*?)\)\s*values\s*\(([\s\S]*?)\)/gi
  let m
  let idx = 0
  while ((m = re.exec(text)) !== null) {
    idx++
    const table = m[1]
    const cols = m[2].split(',').map((c) => c.trim()).filter(Boolean)
    const raw = m[3]
    // 占位符是 ?, 常量是 null / 数字 / 字符串
    const values = raw
      .split(',')
      .map((v) => v.trim())
      .filter((v) => v.length > 0)
    check(`${label} ${table} #${idx} 列数=值数`, cols.length === values.length, `${cols.length} 列 / ${values.length} 值`)
  }
  return idx
}

const n1 = checkInsertArity('server/utils/feeds.ts', 'feeds.ts')
check('feeds.ts insert 数量', n1 === 2, `${n1} 条`)
const n2 = checkInsertArity('server/utils/store.ts', 'store.ts')
check('store.ts insert 数量', n2 >= 1, `${n2} 条`)
const n3 = checkInsertArity('server/utils/site.ts', 'site.ts')
check('site.ts insert 数量', n3 >= 1, `${n3} 条`)

/* ---------- 3. 生产查询冒烟 ---------- */
console.log('\n④ 生产查询冒烟 …')

// store.ts:getDayRepos 的取数形态（同一日期 + 周期，按 bucket / rank / stars 排序）
const dayRows = db
  .prepare(
    `select repo_key, rank, bucket, dropped, today_stars, last_seen_at
       from trending_repos
      where date = ? and period = ?
      order by case bucket when 0 then 0 when 1 then 1 else 2 end, rank is null, rank, today_stars desc`
  )
  .all('2026-11-02', 'daily')
check('trending_repos 排序查询', Array.isArray(dayRows), `${dayRows.length} 行`)

// 抓取链路的核心写操作：主键 upsert
const upsertStmt = db.prepare(
  `insert or replace into trending_repos
   (date, period, repo_key, owner, name, full_name, url, description, language, language_color,
    total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at,
    first_seen_at, last_seen_at, snapshots, created_at, updated_at)
   values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
)
const args = [
  '2026-11-02', 'daily', 'demo/repo', 'demo', 'repo', 'demo/repo',
  'https://github.com/demo/repo', '', 'TypeScript', '#3178c6',
  100, 10, 5, 1, 1, 0, 0, null,
  '2026-11-02T00:00:00.000Z', '2026-11-02T00:00:00.000Z', '[]',
  '2026-11-02T00:00:00.000Z', '2026-11-02T00:00:00.000Z'
]
upsertStmt.run(...args)
upsertStmt.run(...args)
const upserted = db.prepare("select count(*) as n from trending_repos where repo_key = 'demo/repo'").get().n
check('trending_repos upsert 幂等', upserted === 1, `${upserted} 行`)

// site.ts:siteStats 的 union all 统计
const stats = db
  .prepare(
    `select 'nav_links' as t, count(*) as n from nav_links
     union all select 'nav_categories', count(*) from nav_categories
     union all select 'ai_items', count(*) from ai_items
     union all select 'ai_boards', count(*) from ai_boards
     union all select 'github_creators', count(*) from github_creators
     union all select 'dns_records', count(*) from dns_records
     union all select 'shares', count(*) from shares`
  )
  .all()
check('siteStats union 查询', stats.length === 7, stats.map((r) => `${r.t}=${r.n}`).join(' '))

// lock.ts 的 CAS 形态
db.prepare('insert or replace into crawl_locks (name, token, expires_at, created_at) values (?,?,?,?)').run(
  'github-trending-crawl',
  'tok-1',
  '2026-11-02T01:00:00.000Z',
  '2026-11-02T00:00:00.000Z'
)
const takeover = db
  .prepare('update crawl_locks set token = ?, expires_at = ?, created_at = ? where name = ? and token = ?')
  .run('tok-2', '2026-11-02T02:00:00.000Z', '2026-11-02T00:05:00.000Z', 'github-trending-crawl', 'tok-1')
check('crawl_locks CAS 更新', Number(takeover.changes) === 1, `${takeover.changes} 行受影响`)

// feeds.ts 的两条 upsert：列数与占位符必须严格一致
// （历史 bug：失败分支写了 16 个 value 对 15 列，导致聚合端点全部写不进去）
const FEED_COLS =
  '(key, path, title, descr, category, render, ok, code, error, payload, raw_size, payload_bytes, fetched_at, upstream_updated_at, last_try_at)'

const feedOk = db.prepare(
  `insert into feed_snapshots ${FEED_COLS} values (?,?,?,?,?,?,1,?,null,?,?,?,?,?,?)
   on conflict (key) do update set ok = 1, payload = excluded.payload`
)
feedOk.run('hot-weibo', '/weibo', '微博热搜', '', 'hot', 'list', 200, '{"kind":"list"}', 128, 20, '2026-11-02T00:00:00.000Z', null, '2026-11-02T00:00:00.000Z')
check('feed_snapshots 成功分支 upsert', db.prepare("select count(*) as n from feed_snapshots where key='hot-weibo'").get().n === 1)

const feedFail = db.prepare(
  `insert into feed_snapshots ${FEED_COLS} values (?,?,?,?,?,?,0,?,?,null,0,0,?,null,?)
   on conflict (key) do update set error = excluded.error, ok = 0, last_try_at = excluded.last_try_at`
)
feedFail.run('hot-zhihu', '/zhihu', '知乎热榜', '', 'hot', 'list', 0, 'timeout', '2026-11-02T00:01:00.000Z', '2026-11-02T00:01:00.000Z')
check('feed_snapshots 失败分支 upsert', db.prepare("select count(*) as n from feed_snapshots where key='hot-zhihu'").get().n === 1)

// 幂等：两个分支各再跑一次，行数不变
feedOk.run('hot-weibo', '/weibo', '微博热搜', '', 'hot', 'list', 200, '{"kind":"list"}', 128, 20, '2026-11-02T00:02:00.000Z', null, '2026-11-02T00:02:00.000Z')
feedFail.run('hot-zhihu', '/zhihu', '知乎热榜', '', 'hot', 'list', 0, 'timeout', '2026-11-02T00:02:00.000Z', '2026-11-02T00:02:00.000Z')
check('feed_snapshots upsert 幂等', db.prepare('select count(*) as n from feed_snapshots').get().n === 2)

// shares 的 (type, url) 唯一索引
const shareSql =
  'insert or ignore into shares (sid, type, title, descr, url, badge, meta, views, created_at) values (?,?,?,?,?,?,?,?,?)'
db.prepare(shareSql).run('abc12345', 'nav', 't', '', 'https://example.com', '', '{}', 0, '2026-11-02T00:00:00.000Z')
db.prepare(shareSql).run('def67890', 'nav', 't2', '', 'https://example.com', '', '{}', 0, '2026-11-02T00:00:00.000Z')
const shareN = db.prepare('select count(*) as n from shares').get().n
check('shares 同 url 去重', shareN === 1, `${shareN} 行`)

console.log(`\n${failed === 0 ? '✓ 全部通过' : `✗ ${failed} 项失败`}`)
process.exit(failed === 0 ? 0 : 1)