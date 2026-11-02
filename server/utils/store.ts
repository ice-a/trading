import { sqlAll, sqlFirst, sqlRun, sqlBatch, type SqlStmt } from './db'
import type { Bucket, CrawlRunDoc, ParsedRepo, TrendingRepoDoc, DayOption, TrendingPeriod } from './types'
import { dayKeyOf } from './date'

/**
 * 入库（SQLite 版）：一条记录 = 一天 + 一个周期 + 一个仓库。
 *
 * 关键行为与 Mongo 版完全一致：
 * 1. 同一个 (date, period, repoKey) 只 upsert，不插重复行
 * 2. bucket 0 = 前 N 名；1 = 榜内其他；2 = 已掉榜
 * 3. 掉榜绝不删除，只降 bucket，翻页仍读到
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

interface ExistingRow {
  repo_key: string
  rank: number | null
  bucket: number
  best_rank: number | null
  dropped: number
  today_stars: number
  first_seen_at: string
  snapshots: string
}

const iso = (d: Date | string | null | undefined): string | null =>
  d ? new Date(d).toISOString() : null

export async function saveDailySnapshot(params: {
  repos: ParsedRepo[]
  date?: string
  topN?: number
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

  const now = new Date()
  const nowIso = now.toISOString()

  const existing = await sqlAll<ExistingRow>(
    'select repo_key, rank, bucket, best_rank, dropped, today_stars, first_seen_at, snapshots ' +
      'from trending_repos where date = ? and period = ?',
    [date, period]
  )
  const existingMap = new Map(existing.map((d) => [d.repo_key, d]))

  const incoming = new Set(repos.map((r) => r.repoKey))
  const stmts: SqlStmt[] = []

  for (const repo of repos) {
    const prev = existingMap.get(repo.repoKey)
    const rank = repo.rank
    const bucket: Bucket = rank <= topN ? 0 : 1
    const bestRank = prev?.best_rank != null ? Math.min(prev.best_rank, rank) : rank

    // 时间序列：追加本次采样，保留最近 48 个
    let snaps: unknown[] = []
    try {
      snaps = JSON.parse(prev?.snapshots || '[]')
    } catch {
      snaps = []
    }
    snaps.push({ at: nowIso, todayStars: repo.todayStars, totalStars: repo.totalStars, rank })
    if (snaps.length > SNAPSHOT_KEEP) snaps = snaps.slice(-SNAPSHOT_KEEP)

    stmts.push({
      sql:
        `insert into trending_repos
           (date, period, repo_key, owner, name, full_name, url, description, language, language_color,
            total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at,
            first_seen_at, last_seen_at, snapshots, created_at, updated_at)
         values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
         on conflict (date, period, repo_key) do update set
           owner=excluded.owner, name=excluded.name, full_name=excluded.full_name, url=excluded.url,
           description=excluded.description, language=excluded.language, language_color=excluded.language_color,
           total_stars=excluded.total_stars, forks=excluded.forks, today_stars=excluded.today_stars,
           rank=excluded.rank,
           best_rank=min(coalesce(trending_repos.best_rank, 2147483647), excluded.best_rank),
           bucket=excluded.bucket, dropped=0, dropped_at=null,
           last_seen_at=excluded.last_seen_at, snapshots=excluded.snapshots, updated_at=excluded.updated_at`,
      params: [
        date,
        period,
        repo.repoKey,
        repo.owner,
        repo.name,
        repo.fullName,
        repo.url,
        repo.description,
        repo.language,
        repo.languageColor,
        repo.totalStars,
        repo.forks,
        repo.todayStars,
        rank,
        bestRank,
        bucket,
        0,
        null,
        prev?.first_seen_at || nowIso,
        nowIso,
        JSON.stringify(snaps),
        nowIso,
        nowIso
      ]
    })
  }

  // 本次没抓到、但当天库里有记录的 → 保留，降级为「掉榜」
  let dropped = 0
  const dropStmts: SqlStmt[] = []
  for (const doc of existing) {
    if (incoming.has(doc.repo_key)) continue
    if (doc.dropped) continue
    dropped++
    dropStmts.push({
      sql:
        'update trending_repos set bucket = 2, rank = null, dropped = 1, dropped_at = ?, updated_at = ? ' +
        'where date = ? and period = ? and repo_key = ?',
      params: [nowIso, nowIso, date, period, doc.repo_key]
    })
  }

  await sqlBatch([...stmts, ...dropStmts])

  const tracked = await sqlFirst<{ n: number }>(
    'select count(*) as n from trending_repos where date = ? and period = ?',
    [date, period]
  )

  return {
    date,
    fetched: repos.length,
    upserted: stmts.length,
    modified: stmts.length,
    dropped,
    tracked: tracked?.n ?? 0
  }
}

export async function logCrawlRun(doc: CrawlRunDoc): Promise<void> {
  await sqlRun(
    `insert into crawl_runs
       (date, started_at, finished_at, duration_ms, source, fetched, upserted, modified, dropped, ok, error, triggered_by)
     values (?,?,?,?,?,?,?,?,?,?,?,?)`,
    [
      doc.date,
      iso(doc.startedAt),
      iso(doc.finishedAt),
      doc.durationMs,
      doc.source,
      doc.fetched,
      doc.upserted,
      doc.modified,
      doc.dropped,
      doc.ok ? 1 : 0,
      doc.error ?? null,
      doc.trigger
    ]
  )
}

export async function touchMeta(patch: Record<string, unknown>): Promise<void> {
  const nowIso = new Date().toISOString()
  const existing = await sqlFirst<{ value: string }>('select value from app_meta where key = ?', ['app'])
  let merged: Record<string, unknown> = {}
  try {
    merged = JSON.parse(existing?.value || '{}')
  } catch {
    merged = {}
  }
  Object.assign(merged, patch)
  if (existing) {
    await sqlRun('update app_meta set value = ?, updated_at = ? where key = ?', [JSON.stringify(merged), nowIso, 'app'])
  } else {
    await sqlRun('insert into app_meta (key, value, updated_at) values (?, ?, ?)', ['app', JSON.stringify(merged), nowIso])
  }
}

export async function readMeta<T = Record<string, unknown>>(): Promise<T | null> {
  const row = await sqlFirst<{ value: string }>('select value from app_meta where key = ?', ['app'])
  if (!row) return null
  try {
    return JSON.parse(row.value) as T
  } catch {
    return null
  }
}

/** 取有数据的日期列表（降序）；period 不传则统计全部周期 */
export async function listDays(limit = 60, period?: TrendingPeriod): Promise<DayOption[]> {
  const cfg = appConfig()
  const today = dayKeyOf(new Date(), cfg.timezone)
  const where = period ? 'where period = ?' : ''
  const params: unknown[] = period ? [period, limit] : [limit]
  const rows = await sqlAll<{ date: string; count: number }>(
    `select date, count(*) as count from trending_repos ${where} group by date order by date desc limit ?`,
    params
  )
  return rows.map((r) => ({ date: r.date, count: r.count, isToday: r.date === today }))
}

/** 某天的全部行（bucket/rank 排序），API 层做分页 */
export async function getDayRepos(
  date: string,
  period: TrendingPeriod
): Promise<TrendingRepoDoc[]> {
  const rows = await sqlAll<Record<string, unknown>>(
    'select * from trending_repos where date = ? and period = ? order by bucket asc, rank asc, today_stars desc',
    [date, period]
  )
  return rows.map(rowToDoc)
}

/** 有数据的日期集合（预渲染 /v2/[key] 用） */
export async function latestRunAt(): Promise<string | null> {
  const row = await sqlFirst<{ t: string }>(
    'select max(last_seen_at) as t from trending_repos'
  )
  return row?.t ?? null
}

function rowToDoc(r: Record<string, unknown>): TrendingRepoDoc {
  let snaps: TrendingRepoDoc['snapshots'] = []
  try {
    snaps = JSON.parse(String(r.snapshots || '[]'))
  } catch {
    snaps = []
  }
  return {
    date: String(r.date),
    period: (String(r.period || 'daily') as TrendingPeriod) || 'daily',
    repoKey: String(r.repo_key),
    owner: String(r.owner),
    name: String(r.name),
    fullName: String(r.full_name),
    url: String(r.url),
    description: String(r.description || ''),
    language: String(r.language || ''),
    languageColor: String(r.language_color || ''),
    totalStars: Number(r.total_stars) || 0,
    forks: Number(r.forks) || 0,
    todayStars: Number(r.today_stars) || 0,
    rank: r.rank == null ? null : Number(r.rank),
    bestRank: r.best_rank == null ? null : Number(r.best_rank),
    bucket: (Number(r.bucket) || 0) as Bucket,
    dropped: Boolean(r.dropped),
    droppedAt: r.dropped_at ? new Date(String(r.dropped_at)) : null,
    firstSeenAt: new Date(String(r.first_seen_at)),
    lastSeenAt: new Date(String(r.last_seen_at)),
    snapshots: snaps,
    createdAt: new Date(String(r.created_at)),
    updatedAt: new Date(String(r.updated_at))
  }
}
