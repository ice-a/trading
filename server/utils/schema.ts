/**
 * 建表语句（编译进产物，不依赖 db/ 目录）。
 *
 * 为什么内联成 TS 字符串而不是读 db/schema.sql：
 *   构建产物里没有 db/ 目录（Vercel 只上传 .output），
 *   而 SQLite / libSQL 都支持 CREATE TABLE IF NOT EXISTS，
 *   把 DDL 编进代码后，任何空库在首次访问时都能自愈。
 *
 * 与 db/schema.sql 保持同步：改表结构时两处都要改（scripts/verify-sql.mjs 会校验）。
 */
export const SCHEMA_VERSION = '4.0.0'

export const SCHEMA_DDL = [
  `CREATE TABLE IF NOT EXISTS trending_repos (
    date           TEXT    NOT NULL,
    period         TEXT    NOT NULL DEFAULT 'daily',
    repo_key       TEXT    NOT NULL,
    owner          TEXT    NOT NULL,
    name           TEXT    NOT NULL,
    full_name      TEXT    NOT NULL,
    url            TEXT    NOT NULL,
    description    TEXT    NOT NULL DEFAULT '',
    language       TEXT    NOT NULL DEFAULT '',
    language_color TEXT    NOT NULL DEFAULT '',
    total_stars    INTEGER NOT NULL DEFAULT 0,
    forks          INTEGER NOT NULL DEFAULT 0,
    today_stars    INTEGER NOT NULL DEFAULT 0,
    rank           INTEGER,
    best_rank      INTEGER,
    bucket         INTEGER NOT NULL DEFAULT 0,
    dropped        INTEGER NOT NULL DEFAULT 0,
    dropped_at     TEXT,
    first_seen_at  TEXT    NOT NULL,
    last_seen_at   TEXT    NOT NULL,
    snapshots      TEXT    NOT NULL DEFAULT '[]',
    created_at     TEXT    NOT NULL,
    updated_at     TEXT    NOT NULL,
    PRIMARY KEY (date, period, repo_key)
  )`,

  `CREATE INDEX IF NOT EXISTS idx_repo_page ON trending_repos (date, period, bucket, rank, today_stars DESC)`,
  `CREATE INDEX IF NOT EXISTS idx_repo_seen ON trending_repos (last_seen_at DESC)`,

  `CREATE TABLE IF NOT EXISTS crawl_runs (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    date         TEXT NOT NULL,
    started_at   TEXT NOT NULL,
    finished_at  TEXT NOT NULL,
    duration_ms  INTEGER NOT NULL DEFAULT 0,
    source       TEXT NOT NULL DEFAULT '',
    fetched      INTEGER NOT NULL DEFAULT 0,
    upserted     INTEGER NOT NULL DEFAULT 0,
    modified     INTEGER NOT NULL DEFAULT 0,
    dropped      INTEGER NOT NULL DEFAULT 0,
    ok           INTEGER NOT NULL DEFAULT 1,
    error        TEXT,
    triggered_by TEXT NOT NULL DEFAULT 'manual'
  )`,

  `CREATE INDEX IF NOT EXISTS idx_runs_started ON crawl_runs (started_at DESC)`,

  `CREATE TABLE IF NOT EXISTS app_meta (
    key        TEXT PRIMARY KEY,
    value      TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )`,

  `CREATE TABLE IF NOT EXISTS crawl_locks (
    name       TEXT PRIMARY KEY,
    token      TEXT NOT NULL,
    expires_at TEXT NOT NULL,
    created_at TEXT NOT NULL
  )`,

  /* ---------- 股票 / 持仓 ---------- */

  `CREATE TABLE IF NOT EXISTS portfolios (
    user       TEXT PRIMARY KEY,
    key_hash   TEXT NOT NULL,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )`,

  `CREATE TABLE IF NOT EXISTS portfolio_trades (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_name  TEXT NOT NULL,
    code       TEXT NOT NULL,
    name       TEXT NOT NULL DEFAULT '',
    market     TEXT NOT NULL DEFAULT 'A',
    side       TEXT NOT NULL DEFAULT 'buy',
    venue      TEXT NOT NULL DEFAULT '',
    trade_date TEXT NOT NULL,
    quantity   REAL NOT NULL DEFAULT 0,
    price      REAL NOT NULL DEFAULT 0,
    fee        REAL NOT NULL DEFAULT 0,
    currency   TEXT NOT NULL DEFAULT 'CNY',
    note       TEXT NOT NULL DEFAULT '',
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )`,
  `CREATE INDEX IF NOT EXISTS idx_trade_user ON portfolio_trades (user_name, trade_date DESC)`,

  `CREATE TABLE IF NOT EXISTS fx_rates (
    currency   TEXT PRIMARY KEY,
    cny_rate   REAL NOT NULL DEFAULT 1,
    updated_at TEXT NOT NULL
  )`,

  `CREATE TABLE IF NOT EXISTS stock_search_history (
    user_name  TEXT NOT NULL,
    keyword    TEXT NOT NULL,
    created_at TEXT NOT NULL,
    PRIMARY KEY (user_name, keyword)
  )`,
  `CREATE INDEX IF NOT EXISTS idx_search_time ON stock_search_history (user_name, created_at DESC)`,
  `CREATE TABLE IF NOT EXISTS response_cache (
    key        TEXT PRIMARY KEY,
    value      TEXT NOT NULL,
    expires_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )`,
  `CREATE INDEX IF NOT EXISTS idx_cache_exp ON response_cache (expires_at)`
]