/**
 * Atlas(MongoDB) → Cloudflare D1 数据迁移导出器。
 *
 * 把当前 MONGODB_URI 指向的库里 12 个集合导出成一份可直接执行的 SQL：
 *   cloudflare/migrate.sql
 *
 * 用法：
 *   node --env-file=.env scripts/migrate-atlas-to-d1.mjs
 *   wrangler d1 execute liaowangtai-db --file=cloudflare/schema.sql   --local
 *   wrangler d1 execute liaowangtai-db --file=cloudflare/migrate.sql  --local   # 本地先验
 *   wrangler d1 execute liaowangtai-db --file=cloudflare/schema.sql   --remote
 *   wrangler d1 execute liaowangtai-db --file=cloudflare/migrate.sql  --remote
 *
 * 为什么导 SQL 而不是直连 D1：D1 没有对外 TCP/HTTP 写入口（只有 REST 查询接口，
 * 且大 SQL 体容易被截断），wrangler 走官方通道最稳，还能 --local 先验证。
 */
import { MongoClient } from 'mongodb'
import { writeFileSync, statSync as fs_statSync } from 'node:fs'

const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'
const outFile = 'cloudflare/migrate.sql'

if (!uri) {
  console.error('✗ MONGODB_URI 未配置')
  process.exit(1)
}

/* ---------- SQL 工具 ---------- */
const q = (v) => (v === null || v === undefined ? 'NULL' : `'${String(v).replace(/'/g, "''")}'`)
const num = (v) => (v === null || v === undefined || Number.isNaN(Number(v)) ? 'NULL' : String(Number(v)))
const bool = (v) => (v ? '1' : '0')
const iso = (v) => (v ? new Date(v).toISOString() : null)
const json = (v) => q(JSON.stringify(v ?? null))

/** 每批多少行一条多值 INSERT（D1 单语句上限 100KB，保守取小批次） */
const BATCH = 50

function insertMany(table, cols, rows, toVals) {
  const out = []
  for (let i = 0; i < rows.length; i += BATCH) {
    const chunk = rows.slice(i, i + BATCH)
    const values = chunk.map((r) => `(${toVals(r).join(',')})`).join(',\n')
    out.push(`insert or replace into ${table} (${cols.join(', ')}) values\n${values};`)
  }
  return out
}

const client = new MongoClient(uri, { serverSelectionTimeoutMS: 30000, appName: 'migrate-atlas-d1' })

try {
  await client.connect()
  const db = client.db(dbName)
  console.log(`源库：${db.databaseName}\n`)

  const stmts = ['-- 瞭望台 Atlas → D1 迁移（生成于 ' + new Date().toISOString() + '）', '-- 前置：先执行 cloudflare/schema.sql', '']

  /* ---------- trending_repos ---------- */
  {
    // 按 updated_at 升序：同键重复时（旧唯一索引迁移遗留）让最新一行最后写入并胜出
    const rows = await db.collection('trending_repos').find({}).sort({ updated_at: 1, updatedAt: 1 }).toArray()
    stmts.push(
      ...insertMany(
        'trending_repos',
        [
          'date', 'period', 'repo_key', 'owner', 'name', 'full_name', 'url', 'description',
          'language', 'language_color', 'total_stars', 'forks', 'today_stars', 'rank', 'best_rank',
          'bucket', 'dropped', 'dropped_at', 'first_seen_at', 'last_seen_at', 'snapshots',
          'created_at', 'updated_at'
        ],
        rows,
        (r) => [
          q(r.date), q(r.period || 'daily'), q(r.repoKey), q(r.owner), q(r.name), q(r.fullName), q(r.url),
          q(r.description || ''), q(r.language || ''), q(r.languageColor || ''),
          num(r.totalStars), num(r.forks), num(r.todayStars), num(r.rank), num(r.bestRank),
          num(r.bucket ?? 0), bool(r.dropped), q(iso(r.droppedAt)),
          q(iso(r.firstSeenAt) || new Date().toISOString()), q(iso(r.lastSeenAt) || new Date().toISOString()),
          json(r.snapshots || []), q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt) || new Date().toISOString())
        ]
      )
    )
    console.log(`  trending_repos    ${rows.length}`)
  }

  /* ---------- crawl_runs ---------- */
  {
    const rows = await db.collection('crawl_runs').find({}).sort({ startedAt: 1 }).toArray()
    stmts.push(
      ...insertMany(
        'crawl_runs',
        ['date', 'started_at', 'finished_at', 'duration_ms', 'source', 'fetched', 'upserted', 'modified', 'dropped', 'ok', 'error', 'triggered_by'],
        rows,
        (r) => [
          q(r.date), q(iso(r.startedAt)), q(iso(r.finishedAt)), num(r.durationMs), q(r.source || ''),
          num(r.fetched), num(r.upserted), num(r.modified), num(r.dropped), bool(r.ok), q(r.error || null), q(r.trigger || 'manual')
        ]
      )
    )
    console.log(`  crawl_runs        ${rows.length}`)
  }

  /* ---------- app_meta（合并成单行 JSON） ---------- */
  {
    const rows = await db.collection('app_meta').find({}).toArray()
    const merged = {}
    for (const r of rows) merged[r.key] = r.value
    stmts.push(
      `insert or replace into app_meta (key, value, updated_at) values ('app', ${json(merged)}, ${q(new Date().toISOString())});`
    )
    console.log(`  app_meta          ${rows.length} → 1`)
  }

  /* ---------- feed_snapshots ---------- */
  {
    const rows = await db.collection('feed_snapshots').find({}).toArray()
    stmts.push(
      ...insertMany(
        'feed_snapshots',
        ['key', 'path', 'title', 'descr', 'category', 'render', 'ok', 'code', 'error', 'payload',
         'raw_size', 'payload_bytes', 'fetched_at', 'upstream_updated_at', 'last_try_at'],
        rows,
        (r) => [
          q(r.key), q(r.path || ''), q(r.title || ''), q(r.desc || ''), q(r.category || 'hot'), q(r.render || 'list'),
          bool(r.ok), num(r.code), q(r.error || null), json(r.payload),
          num(r.rawSize), num(r.payloadBytes), q(iso(r.fetchedAt) || new Date().toISOString()),
          q(iso(r.upstreamUpdatedAt)), q(iso(r.lastTryAt) || new Date().toISOString())
        ]
      )
    )
    console.log(`  feed_snapshots    ${rows.length}`)
  }

  /* ---------- nav_categories / nav_links ---------- */
  {
    const rows = await db.collection('nav_categories').find({}).toArray()
    stmts.push(
      ...insertMany(
        'nav_categories',
        ['key', 'name', 'grp', 'icon', 'sort', 'status', 'created_at', 'updated_at'],
        rows,
        (r) => [q(r.key), q(r.name), q(r.group || '其他'), q(r.icon || ''), num(r.sort), q(r.status || 'active'),
                q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt))]
      )
    )
    console.log(`  nav_categories    ${rows.length}`)
  }
  {
    const rows = await db.collection('nav_links').find({}).sort({ updated_at: 1, updatedAt: 1 }).toArray()
    stmts.push(
      ...insertMany(
        'nav_links',
        ['name', 'url', 'catelog', 'grp', 'descr', 'icon', 'sort', 'status', 'created_at', 'updated_at'],
        rows,
        (r) => [q(r.name), q(r.url), q(r.catelog || ''), q(r.group || ''), q(r.desc || ''), q(r.icon || ''),
                num(r.sort), q(r.status || 'active'), q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt))]
      )
    )
    console.log(`  nav_links         ${rows.length}`)
  }

  /* ---------- ai_boards / ai_items ---------- */
  {
    const rows = await db.collection('ai_boards').find({}).toArray()
    stmts.push(
      ...insertMany(
        'ai_boards',
        ['key', 'name', 'icon', 'sort', 'status', 'created_at', 'updated_at'],
        rows,
        (r) => [q(r.key), q(r.name), q(r.icon || ''), num(r.sort), q(r.status || 'active'),
                q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt))]
      )
    )
    console.log(`  ai_boards         ${rows.length}`)
  }
  {
    const rows = await db.collection('ai_items').find({}).sort({ updated_at: 1, updatedAt: 1 }).toArray()
    stmts.push(
      ...insertMany(
        'ai_items',
        ['board', 'name', 'url', 'descr', 'models', 'ratio', 'tags', 'content', 'sort', 'status', 'created_at', 'updated_at'],
        rows,
        (r) => [q(r.board), q(r.name), q(r.url || ''), q(r.desc || ''), q(r.models || ''), q(r.ratio || ''),
                json(r.tags || []), q(r.content || ''), num(r.sort), q(r.status || 'active'),
                q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt))]
      )
    )
    console.log(`  ai_items          ${rows.length}`)
  }

  /* ---------- github_creators / dns_records / shares ---------- */
  {
    const rows = await db.collection('github_creators').find({}).toArray()
    stmts.push(
      ...insertMany(
        'github_creators',
        ['login', 'note', 'sort', 'created_at'],
        rows,
        (r) => [q(r.login), q(r.note || ''), num(r.sort), q(iso(r.createdAt) || new Date().toISOString())]
      )
    )
    console.log(`  github_creators   ${rows.length}`)
  }
  {
    const rows = await db.collection('dns_records').find({}).toArray()
    stmts.push(
      ...insertMany(
        'dns_records',
        ['host', 'name', 'type', 'target', 'proxied', 'status', 'latency_ms', 'http_status', 'checked_at', 'created_at', 'updated_at'],
        rows,
        (r) => [q(r.host), q(r.name || ''), q(r.type || 'A'), q(r.target || ''), bool(r.proxied),
                q(r.status || 'unknown'), num(r.latencyMs), num(r.httpStatus), q(iso(r.checkedAt)),
                q(iso(r.createdAt) || new Date().toISOString()), q(iso(r.updatedAt))]
      )
    )
    console.log(`  dns_records       ${rows.length}`)
  }
  {
    const rows = await db.collection('shares').find({}).toArray()
    stmts.push(
      ...insertMany(
        'shares',
        ['sid', 'type', 'title', 'descr', 'url', 'badge', 'meta', 'views', 'created_at'],
        rows,
        (r) => [q(r.sid), q(r.type || 'custom'), q(r.title), q(r.desc || ''), q(r.url || ''), q(r.badge || ''),
                json(r.meta || {}), num(r.views || 0), q(iso(r.createdAt) || new Date().toISOString())]
      )
    )
    console.log(`  shares            ${rows.length}`)
  }

  writeFileSync(outFile, stmts.join('\n') + '\n', 'utf8')
  const kb = (fs_statSync(outFile).size / 1024).toFixed(0)
  console.log('\n✓ 已生成 ' + outFile + '（' + kb + ' KB）')
  console.log('\n下一步：')
  console.log('  wrangler d1 create liaowangtai-db                # 首次：建库，把 database_id 填进 wrangler.toml')
  console.log('  wrangler d1 execute liaowangtai-db --file=cloudflare/schema.sql  --remote')
  console.log('  wrangler d1 execute liaowangtai-db --file=cloudflare/migrate.sql --remote')
} catch (err) {
  console.error('✗ 导出失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
