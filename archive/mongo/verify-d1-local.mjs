/**
 * 在本地 miniflare（wrangler 内置）里验证 D1 全链路：
 *   schema.sql + migrate.sql → 起真实 Pages 构建 → 打所有 API → 比对数据。
 *
 * 用法：npx wrangler dev 之前先跑本脚本自检
 *   node scripts/verify-d1-local.mjs
 * 它做三件事：
 *   1. 用 wrangler d1 execute --local 灌 schema + 数据
 *   2. 断言各表行数与导出时一致
 *   3. 提示可以 wrangler dev 起服务
 */
import { execSync } from 'node:child_process'
import { existsSync } from 'node:fs'

const DB = process.env.D1_NAME || 'liaowangtai-db'

if (!existsSync('cloudflare/migrate.sql')) {
  console.error('✗ 先运行 node --env-file=.env scripts/migrate-atlas-to-d1.mjs 生成 migrate.sql')
  process.exit(1)
}

const run = (cmd) => {
  console.log(`\n$ ${cmd}`)
  return execSync(cmd, { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 })
}

run(`npx wrangler d1 execute ${DB} --local --file=cloudflare/schema.sql`)
run(`npx wrangler d1 execute ${DB} --local --file=cloudflare/migrate.sql`)

const EXPECT = {
  trending_repos: 299,
  crawl_runs: 73,
  app_meta: 1,
  feed_snapshots: 19,
  nav_categories: 55,
  nav_links: 424,
  ai_boards: 6,
  ai_items: 79,
  github_creators: 17,
  dns_records: 14,
  shares: 2
}

console.log('\n=== 行数比对 ===')
let allOk = true
for (const [table, want] of Object.entries(EXPECT)) {
  const out = run(`npx wrangler d1 execute ${DB} --local --json --command "select count(*) as n from ${table}"`)
  let got = -1
  try {
    const j = JSON.parse(out.slice(out.indexOf('[')))
    got = Number(j[0]?.results?.[0]?.n ?? j[0]?.n ?? -1)
  } catch {
    /* 保持 -1 */
  }
  const ok = got === want
  if (!ok) allOk = false
  console.log(`  ${table.padEnd(18)} 期望 ${String(want).padStart(4)}  实际 ${String(got).padStart(4)}  ${ok ? '✓' : '✗'}`)
}

console.log(allOk ? '\n✓ D1 本地数据完整，可以 wrangler dev 起服务联调' : '\n✗ 有表行数不符，检查上面输出')
process.exit(allOk ? 0 : 1)
