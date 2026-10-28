import { MongoClient, type Db, type Collection, type MongoClientOptions } from 'mongodb'
import { isServerless, isEdgeRuntime, runtimeKind } from './platform'
import type { CrawlRunDoc, TrendingRepoDoc } from './types'

/**
 * MongoDB 连接管理（云数据库 Atlas）。
 * - 单例复用连接，避免 dev 热更新时连接泄漏
 * - 强制校验库名，绝不允许落到 test 库
 * - 首次连接自动建索引
 */

let clientPromise: Promise<MongoClient> | null = null
let dbPromise: Promise<Db> | null = null
let indexReady = false

export const COLLECTIONS = {
  repos: 'trending_repos',
  runs: 'crawl_runs',
  meta: 'app_meta',
  locks: 'crawl_locks',
  feeds: 'feed_snapshots'
} as const

function assertDbName(dbName: string): string {
  const name = (dbName || '').trim()
  if (!name) throw new Error('[mongo] MONGODB_DB 未配置')
  if (/^(test|admin|local|config)$/i.test(name)) {
    throw new Error(`[mongo] 不允许使用系统/测试库 "${name}"，请在 .env 里设置 MONGODB_DB=github_trending`)
  }
  return name
}

async function getClient(): Promise<MongoClient> {
  if (!clientPromise) {
    const cfg = appConfig()
    if (!cfg.mongoUri) throw new Error('[mongo] MONGODB_URI 未配置')
    const serverless = isServerless()
    const options: MongoClientOptions = {
      // Serverless 下每个实例都会建连接，池子必须小，否则 Atlas 连接数会被打满
      maxPoolSize: serverless ? 5 : 10,
      minPoolSize: 0,
      retryWrites: true,
      // Serverless 函数有执行时限，选主超时不能拖太久
      serverSelectionTimeoutMS: serverless ? 8_000 : 20_000,
      connectTimeoutMS: serverless ? 8_000 : 20_000,
      maxIdleTimeMS: serverless ? 60_000 : 0,
      appName: `github-trending-daily (${runtimeKind()})`
    }

    // 直连 Atlas 27017 被网络阻断时，可通过本地 SOCKS5 代理建立连接。
    // 边缘运行时（workerd）没有 socks 支持，直接忽略该配置。
    if (cfg.mongoProxyHost && !isEdgeRuntime()) {
      options.proxyHost = cfg.mongoProxyHost
      options.proxyPort = cfg.mongoProxyPort
    }

    const client = new MongoClient(cfg.mongoUri, options)
    clientPromise = client.connect().catch((err) => {
      clientPromise = null
      throw err
    })
  }
  return clientPromise
}

export async function getDb(): Promise<Db> {
  if (!dbPromise) {
    dbPromise = (async () => {
      const cfg = appConfig()
      const name = assertDbName(cfg.mongoDb)
      const client = await getClient()
      const db = client.db(name)
      if (!indexReady) {
        await ensureIndexes(db)
        indexReady = true
      }
      return db
    })().catch((err) => {
      dbPromise = null
      throw err
    })
  }
  return dbPromise
}

export async function reposCol(): Promise<Collection<TrendingRepoDoc>> {
  const db = await getDb()
  return db.collection<TrendingRepoDoc>(COLLECTIONS.repos)
}

export async function runsCol(): Promise<Collection<CrawlRunDoc>> {
  const db = await getDb()
  return db.collection<CrawlRunDoc>(COLLECTIONS.runs)
}

async function ensureIndexes(db: Db): Promise<void> {
  const repos = db.collection(COLLECTIONS.repos)

  // 迁移：旧的唯一索引只按 (date, repoKey)，会阻止同一天存 daily/weekly/monthly 三份，
  // 先删掉再建带 period 的新索引。已删过时会抛错，忽略即可。
  for (const oldName of ['uniq_date_repo', 'rank_page', 'date_today_stars']) {
    try {
      await repos.dropIndex(oldName)
    } catch {
      /* 索引不存在，跳过 */
    }
  }

  await Promise.all([
    // 同一天 + 同一周期，一个仓库只有一条文档
    repos.createIndex({ date: 1, period: 1, repoKey: 1 }, { unique: true, name: 'uniq_date_period_repo' }),
    // 首页/翻页的主排序：bucket → rank → todayStars
    repos.createIndex({ date: 1, period: 1, bucket: 1, rank: 1, todayStars: -1 }, { name: 'rank_page' }),
    repos.createIndex({ date: 1, period: 1, todayStars: -1 }, { name: 'date_today_stars' }),
    repos.createIndex({ lastSeenAt: -1 }, { name: 'last_seen' })
  ])

  const runs = db.collection(COLLECTIONS.runs)
  await Promise.all([
    runs.createIndex({ startedAt: -1 }, { name: 'started_desc' }),
    runs.createIndex({ date: 1, startedAt: -1 }, { name: 'date_started' })
  ])

  const meta = db.collection(COLLECTIONS.meta)
  await meta.createIndex({ key: 1 }, { unique: true, name: 'uniq_key' })

  const locks = db.collection(COLLECTIONS.locks)
  await locks.createIndex({ expiresAt: 1 }, { expireAfterSeconds: 0, name: 'ttl_expires' })

  // 60s 聚合接口：一个端点一行，只保留最新一次快照
  const feeds = db.collection(COLLECTIONS.feeds)
  await Promise.all([
    feeds.createIndex({ key: 1 }, { unique: true, name: 'uniq_key' }),
    feeds.createIndex({ category: 1, key: 1 }, { name: 'category_key' }),
    feeds.createIndex({ fetchedAt: -1 }, { name: 'fetched_desc' })
  ])
}

export async function pingMongo(): Promise<{ ok: boolean; db: string; latencyMs: number; error?: string }> {
  const started = Date.now()
  try {
    const db = await getDb()
    await db.command({ ping: 1 })
    return { ok: true, db: db.databaseName, latencyMs: Date.now() - started }
  } catch (err) {
    return {
      ok: false,
      db: appConfig().mongoDb,
      latencyMs: Date.now() - started,
      error: err instanceof Error ? err.message : String(err)
    }
  }
}

export async function closeMongo(): Promise<void> {
  if (clientPromise) {
    try {
      const client = await clientPromise
      await client.close()
    } catch {
      /* ignore */
    }
  }
  clientPromise = null
  dbPromise = null
  indexReady = false
}
