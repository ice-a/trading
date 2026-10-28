import { ObjectId } from 'mongodb'
import { getDb, reposCol, runsCol, COLLECTIONS } from './mongo'
import type { Bucket, CrawlRunDoc, ParsedRepo, TrendingRepoDoc, DayOption, TrendingPeriod } from './types'
import { dayKeyOf } from './date'

/**
 * 入库：一条文档 = 一天 + 一个仓库。
 *
 * 关键行为（严格对应需求）：
 * 1. 同一个仓库同一天只 upsert，不插入重复文档 —— 每次更新都是覆盖指标
 * 2. 分页靠 bucket 实现：
 *      bucket 0 → 今日前 N 名（首页第一页只查这些）
 *      bucket 1 → 当日榜内但已掉出前 N 名
 *      bucket 2 → 当日曾经上榜、现在彻底掉出 trending 的历史记录
 * 3. 掉榜绝不删除，只降 bucket，翻页时仍能读到
 */

const SNAPSHOT_KEEP = 48

export interface SaveResult {
  date: string
  fetched: number
  upserted: number
  modified: number
  dropped: number
  tracked: number
}

export async function saveDailySnapshot(params: {
  repos: ParsedRepo[]
  date?: string
  topN?: number
  /** 榜单周期，默认 daily */
  period?: TrendingPeriod
}): Promise<SaveResult> {
  const cfg = appConfig()
  const date = params.date ?? dayKeyOf(new Date(), cfg.timezone)
  const topN = params.topN ?? cfg.topN
  const repos = params.repos
  const period: TrendingPeriod = params.period ?? 'daily'
  if (!repos.length) {
    return { date, fetched: 0, upserted: 0, modified: 0, dropped: 0, tracked: 0 }
  }

  const col = await reposCol()
  const now = new Date()

  // 当天已有的记录（用于判断谁掉榜、算最优名次）
  const existing = await col
    .find({ date, period }, { projection: { repoKey: 1, rank: 1, bucket: 1, bestRank: 1, dropped: 1, todayStars: 1 } })
    .toArray()
  const existingMap = new Map(existing.map((d) => [d.repoKey, d]))

  const incoming = new Set(repos.map((r) => r.repoKey))
  const ops: Parameters<typeof col.bulkWrite>[0] = []

  for (const repo of repos) {
    const prev = existingMap.get(repo.repoKey)
    const rank = repo.rank
    const bucket: Bucket = rank <= topN ? 0 : 1
    const bestRank =
      prev?.bestRank != null ? Math.min(prev.bestRank, rank) : rank

    ops.push({
      updateOne: {
        filter: { date, period, repoKey: repo.repoKey },
        update: {
          $set: {
            owner: repo.owner,
            name: repo.name,
            fullName: repo.fullName,
            url: repo.url,
            description: repo.description,
            language: repo.language,
            languageColor: repo.languageColor,
            totalStars: repo.totalStars,
            forks: repo.forks,
            todayStars: repo.todayStars,
            rank,
            bestRank,
            bucket,
            dropped: false,
            droppedAt: null,
            lastSeenAt: now,
            updatedAt: now
          },
          $setOnInsert: {
            date,
            period,
            repoKey: repo.repoKey,
            firstSeenAt: now,
            createdAt: now
          },
          $push: {
            snapshots: {
              $each: [{ at: now, todayStars: repo.todayStars, totalStars: repo.totalStars, rank }],
              $slice: -SNAPSHOT_KEEP
            }
          }
        },
        upsert: true
      }
    })
  }

  // 本次没抓到、但当天库里有记录的仓库 → 保留，降级为「掉榜」
  const dropOps: Parameters<typeof col.bulkWrite>[0] = []
  for (const doc of existing) {
    if (incoming.has(doc.repoKey)) continue
    if (doc.dropped) continue
    dropOps.push({
      updateOne: {
        filter: { date, period, repoKey: doc.repoKey },
        update: {
          $set: {
            bucket: 2 as Bucket,
            rank: null,
            dropped: true,
            droppedAt: now,
            updatedAt: now
          }
        }
      }
    })
  }

  let upserted = 0
  let modified = 0
  if (ops.length) {
    const res = await col.bulkWrite(ops, { ordered: false })
    upserted += res.upsertedCount ?? 0
    modified += res.modifiedCount ?? 0
  }
  if (dropOps.length) {
    const res = await col.bulkWrite(dropOps, { ordered: false })
    modified += res.modifiedCount ?? 0
  }

  const tracked = await col.countDocuments({ date, period })

  return { date, fetched: repos.length, upserted, modified, dropped: dropOps.length, tracked }
}

export async function logCrawlRun(doc: CrawlRunDoc): Promise<void> {
  try {
    const col = await runsCol()
    await col.insertOne(doc)
  } catch (err) {
    console.error('[crawl] 写入抓取日志失败:', err)
  }
}

export async function touchMeta(patch: Record<string, unknown>): Promise<void> {
  try {
    const db = await getDb()
    const col = db.collection(COLLECTIONS.meta)
    await col.updateOne(
      { key: 'crawl_state' },
      { $set: { ...patch, updatedAt: new Date() }, $setOnInsert: { key: 'crawl_state', createdAt: new Date() } },
      { upsert: true }
    )
  } catch (err) {
    console.error('[crawl] 写入 meta 失败:', err)
  }
}

export async function readMeta<T = Record<string, unknown>>(): Promise<T | null> {
  const db = await getDb()
  const col = db.collection(COLLECTIONS.meta)
  const doc = await col.findOne({ key: 'crawl_state' })
  if (!doc) return null
  const { _id, ...rest } = doc as Record<string, unknown> & { _id?: ObjectId }
  void _id
  return rest as T
}

/** 取有数据的日期列表（降序），用于历史日期切换；不传 period 则统计全部周期 */
export async function listDays(limit = 60, period?: TrendingPeriod): Promise<DayOption[]> {
  const col = await reposCol()
  const cfg = appConfig()
  const today = dayKeyOf(new Date(), cfg.timezone)
  const stages: Record<string, unknown>[] = []
  if (period) stages.push({ $match: { period } })
  stages.push(
    { $group: { _id: '$date', count: { $sum: 1 } } },
    { $sort: { _id: -1 } },
    { $limit: limit }
  )
  const rows = await col.aggregate<{ _id: string; count: number }>(stages).toArray()
  return rows.map((r) => ({ date: r._id, count: r.count, isToday: r._id === today }))
}

/** 取某天某周期第一页（前 N 名） */
export async function getTopRepos(
  date: string,
  limit: number,
  period: TrendingPeriod = 'daily'
): Promise<TrendingRepoDoc[]> {
  const col = await reposCol()
  return col
    .find({ date, period, bucket: 0 })
    .sort({ rank: 1 })
    .limit(limit)
    .toArray()
}
