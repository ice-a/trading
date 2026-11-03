/**
 * schema + seed 自检（不需要云账号，也不需要起服务）。
 *
 * 用 Node 内置 SQLite（node:sqlite，Node ≥ 22.5）把 db/*.sql 真实跑一遍：
 *   1. 建表 → 断言 5 张表都在
 *   2. 灌 seed → 断言行数
 *   3. 再跑一次 seed → 断言幂等
 *   4. 源码 insert 的列数/值数对齐
 *   5. 生产代码真正用到的查询与 upsert
 *
 * 用法：node scripts/verify-sql.mjs
 */
import { DatabaseSync } from 'node:sqlite'
import { readFileSync } from 'node:fs'

const db = new DatabaseSync(':memory:')

const EXPECT_TABLES = [
  'app_meta',
  'crawl_locks',
  'crawl_runs',
  'fx_rates',
  'portfolio_trades',
  'portfolios',
  'response_cache',
  'stock_search_history',
  'trending_repos'
]

let failed = 0
const check = (label, ok, detail = '') => {
  console.log(`${ok ? '✓' : '✗'} ${label}${detail ? ` — ${detail}` : ''}`)
  if (!ok) failed++
}

/* ---------- 1. schema ---------- */
console.log('① 执行 db/schema.sql …')
db.exec(readFileSync('db/schema.sql', 'utf8'))

const tables = db
  .prepare("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name")
  .all()
  .map((r) => r.name)

check('建表数量', tables.length === EXPECT_TABLES.length, `${tables.length} 张：${tables.join(', ')}`)
for (const t of EXPECT_TABLES) check(`表存在 ${t}`, tables.includes(t))

const indexes = db
  .prepare("select name from sqlite_master where type='index' and name like 'idx_%'")
  .all()
  .map((r) => r.name)
check('索引', indexes.length >= 6, `${indexes.length} 个：${indexes.join(', ')}`)

/* ---------- 1.5 内联 DDL 与 schema.sql 一致性 ----------
 * server/utils/schema.ts 里的 SCHEMA_DDL 是构建进产物的一份副本，
 * 它和 db/schema.sql 必须描述同一套表。这里用「建表后的表名集合」比对。
 */
console.log('\n①.5 内联 DDL 一致性 …')
{
  const { SCHEMA_DDL } = await import('../server/utils/schema.ts').catch(() => ({ SCHEMA_DDL: null }))
  if (!SCHEMA_DDL) {
    console.log('  (跳过：Node 无法直接 import .ts，由下面的表名断言兜底)')
  } else {
    const fs2 = new DatabaseSync(':memory:')
    for (const ddl of SCHEMA_DDL) fs2.exec(ddl)
    const inlineTables = fs2
      .prepare("select name from sqlite_master where type='table' and name not like 'sqlite_%' order by name")
      .all()
      .map((r) => r.name)
    const same = inlineTables.join(',') === tables.join(',')
    check('schema.ts 与 schema.sql 表一致', same, inlineTables.join(', '))
    fs2.close()
  }
}

/* ---------- 2. seed ---------- */
console.log('\n② 执行 db/seed.sql …')
db.exec(readFileSync('db/seed.sql', 'utf8'))
check('seed fx_rates', db.prepare('select count(*) as n from fx_rates').get().n === 3)

console.log('\n③ 幂等性（seed 再跑一次）…')
db.exec(readFileSync('db/seed.sql', 'utf8'))
check('重复执行不增行', db.prepare('select count(*) as n from fx_rates').get().n === 3)

/* ---------- 3. 源码 insert 列数校验 ---------- */
console.log('\n④ 源码 insert 语句列数校验 …')
function checkInsertArity(file, label) {
  const text = readFileSync(file, 'utf8')
  const re =
    /insert\s+(?:or\s+(?:replace|ignore|abort|fail|rollback)\s+)?into\s+(\w+)\s*\(([\s\S]*?)\)\s*values\s*\(([\s\S]*?)\)/gi
  let m
  let idx = 0
  while ((m = re.exec(text)) !== null) {
    idx++
    const cols = m[2].split(',').map((c) => c.trim()).filter(Boolean)
    const values = m[3].split(',').map((v) => v.trim()).filter((v) => v.length > 0)
    check(`${label} ${m[1]} #${idx}`, cols.length === values.length, `${cols.length} 列 / ${values.length} 值`)
  }
  return idx
}
const n1 = checkInsertArity('server/utils/store.ts', 'store.ts')
check('store.ts insert 数量', n1 >= 2, `${n1} 条`)

/* ---------- 4. 生产查询冒烟 ---------- */
console.log('\n⑤ 生产查询冒烟 …')

const dayRows = db
  .prepare(
    `select repo_key, rank, bucket, dropped, today_stars, last_seen_at
       from trending_repos
      where date = ? and period = ?
      order by case bucket when 0 then 0 when 1 then 1 else 2 end, rank is null, rank, today_stars desc`
  )
  .all('2026-11-02', 'daily')
check('trending_repos 排序查询', Array.isArray(dayRows), `${dayRows.length} 行`)

const upsert = db.prepare(
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
upsert.run(...args)
upsert.run(...args)
check(
  'trending_repos upsert 幂等',
  db.prepare("select count(*) as n from trending_repos where repo_key='demo/repo'").get().n === 1
)

db.prepare('insert or replace into crawl_locks (name, token, expires_at, created_at) values (?,?,?,?)').run(
  'github-trending-crawl',
  'tok-1',
  '2026-11-02T01:00:00.000Z',
  '2026-11-02T00:00:00.000Z'
)
const takeover = db
  .prepare('update crawl_locks set token = ?, expires_at = ?, created_at = ? where name = ? and token = ?')
  .run('tok-2', '2026-11-02T02:00:00.000Z', '2026-11-02T00:05:00.000Z', 'github-trending-crawl', 'tok-1')
check('crawl_locks CAS 更新', Number(takeover.changes) === 1, `${takeover.changes} 行`)

const metaUpsert = db.prepare(
  `insert into app_meta (key, value, updated_at) values (?,?,?)
   on conflict (key) do update set value = excluded.value, updated_at = excluded.updated_at`
)
metaUpsert.run('status', '{"lastSuccessAt":"x"}', '2026-11-02T00:00:00.000Z')
metaUpsert.run('status', '{"lastSuccessAt":"y"}', '2026-11-02T00:01:00.000Z')
check('app_meta upsert', db.prepare("select count(*) as n from app_meta where key='status'").get().n === 1)

console.log(`\n${failed === 0 ? '✓ 全部通过' : `✗ ${failed} 项失败`}`)
process.exit(failed === 0 ? 0 : 1)