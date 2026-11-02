-- ============================================================
-- 瞭望台 · SQLite schema（功能裁剪版：只保留榜单 / 抓取 / DNS）
-- 应用方式：npm run db:init（幂等）
-- 远程 libSQL（Turso）：REMOTE=1 npm run db:init
-- ============================================================

-- 榜单：一条 = 某天某周期某仓库
CREATE TABLE IF NOT EXISTS trending_repos (
  date           TEXT    NOT NULL,              -- YYYY-MM-DD
  period         TEXT    NOT NULL DEFAULT 'daily',
  repo_key       TEXT    NOT NULL,              -- owner/name 小写
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
  rank           INTEGER,                       -- 掉榜置 NULL
  best_rank      INTEGER,
  bucket         INTEGER NOT NULL DEFAULT 0,    -- 0 前N / 1 榜内 / 2 已掉榜
  dropped        INTEGER NOT NULL DEFAULT 0,
  dropped_at     TEXT,
  first_seen_at  TEXT    NOT NULL,
  last_seen_at   TEXT    NOT NULL,
  snapshots      TEXT    NOT NULL DEFAULT '[]', -- JSON 数组，保留最近 48 个采样
  created_at     TEXT    NOT NULL,
  updated_at     TEXT    NOT NULL,
  PRIMARY KEY (date, period, repo_key)
) WITHOUT ROWID;

CREATE INDEX IF NOT EXISTS idx_repo_page ON trending_repos (date, period, bucket, rank, today_stars DESC);
CREATE INDEX IF NOT EXISTS idx_repo_seen ON trending_repos (last_seen_at DESC);

-- 抓取日志
CREATE TABLE IF NOT EXISTS crawl_runs (
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
);
CREATE INDEX IF NOT EXISTS idx_runs_started ON crawl_runs (started_at DESC);

-- 运行元信息（lastSuccessAt 等）
CREATE TABLE IF NOT EXISTS app_meta (
  key        TEXT PRIMARY KEY,
  value      TEXT NOT NULL,           -- JSON
  updated_at TEXT NOT NULL
);

-- Cloudflare DNS 看板缓存
CREATE TABLE IF NOT EXISTS dns_records (
  host        TEXT PRIMARY KEY,
  name        TEXT NOT NULL DEFAULT '',
  type        TEXT NOT NULL DEFAULT 'A',
  target      TEXT NOT NULL DEFAULT '',
  proxied     INTEGER NOT NULL DEFAULT 0,
  status      TEXT NOT NULL DEFAULT 'unknown',
  latency_ms  INTEGER NOT NULL DEFAULT 0,
  http_status INTEGER NOT NULL DEFAULT 0,
  checked_at  TEXT,
  created_at  TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at  TEXT
);

-- 抓取锁（单行 + 过期时间）
CREATE TABLE IF NOT EXISTS crawl_locks (
  name       TEXT PRIMARY KEY,
  token      TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL
);