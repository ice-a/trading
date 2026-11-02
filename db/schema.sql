-- ============================================================
-- 瞭望台 · SQLite schema（单文件数据库）
-- 应用方式：npm run db:init（幂等，可反复执行）
-- 文件位置：DB_PATH，默认 data/app.db
-- ============================================================

-- 榜单：一条 = 某天某周期某仓库（对应 Mongo 的 trending_repos）
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
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT NOT NULL,
  started_at  TEXT NOT NULL,
  finished_at TEXT NOT NULL,
  duration_ms INTEGER NOT NULL DEFAULT 0,
  source      TEXT NOT NULL DEFAULT '',
  fetched     INTEGER NOT NULL DEFAULT 0,
  upserted    INTEGER NOT NULL DEFAULT 0,
  modified    INTEGER NOT NULL DEFAULT 0,
  dropped     INTEGER NOT NULL DEFAULT 0,
  ok          INTEGER NOT NULL DEFAULT 1,
  error       TEXT,
  triggered_by TEXT NOT NULL DEFAULT 'manual'
);
CREATE INDEX IF NOT EXISTS idx_runs_started ON crawl_runs (started_at DESC);

-- 运行元信息（lastSuccessAt / lastAutoCrawlAt 等）
CREATE TABLE IF NOT EXISTS app_meta (
  key        TEXT PRIMARY KEY,
  value      TEXT NOT NULL,           -- JSON
  updated_at TEXT NOT NULL
);

-- 60s 聚合端点快照（payload 为归一化后的 JSON）
CREATE TABLE IF NOT EXISTS feed_snapshots (
  key                 TEXT PRIMARY KEY,
  path                TEXT NOT NULL DEFAULT '',
  title               TEXT NOT NULL DEFAULT '',
  descr               TEXT NOT NULL DEFAULT '',
  category            TEXT NOT NULL DEFAULT 'hot',
  render              TEXT NOT NULL DEFAULT 'list',
  ok                  INTEGER NOT NULL DEFAULT 0,
  code                INTEGER NOT NULL DEFAULT 0,
  error               TEXT,
  payload             TEXT,           -- JSON（NormalizedPayload）
  raw_size            INTEGER NOT NULL DEFAULT 0,
  payload_bytes       INTEGER NOT NULL DEFAULT 0,
  fetched_at          TEXT NOT NULL,
  upstream_updated_at TEXT,
  last_try_at         TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_feed_cat ON feed_snapshots (category, key);

-- ============ 站点板块（与 Mongo 集合一一对应）============

CREATE TABLE IF NOT EXISTS nav_categories (
  key        TEXT PRIMARY KEY,
  name       TEXT NOT NULL,
  grp        TEXT NOT NULL DEFAULT '其他',
  icon       TEXT NOT NULL DEFAULT '',
  sort       INTEGER NOT NULL DEFAULT 0,
  status     TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT
);

CREATE TABLE IF NOT EXISTS nav_links (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  name       TEXT NOT NULL,
  url        TEXT NOT NULL UNIQUE,
  catelog    TEXT NOT NULL DEFAULT '',
  grp        TEXT NOT NULL DEFAULT '',
  descr      TEXT NOT NULL DEFAULT '',
  icon       TEXT NOT NULL DEFAULT '',
  sort       INTEGER NOT NULL DEFAULT 0,
  status     TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT
);
CREATE INDEX IF NOT EXISTS idx_navlink_cat ON nav_links (catelog, sort);

CREATE TABLE IF NOT EXISTS ai_boards (
  key        TEXT PRIMARY KEY,
  name       TEXT NOT NULL,
  icon       TEXT NOT NULL DEFAULT '',
  sort       INTEGER NOT NULL DEFAULT 0,
  status     TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT
);

CREATE TABLE IF NOT EXISTS ai_items (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  board      TEXT NOT NULL,
  name       TEXT NOT NULL,
  url        TEXT NOT NULL DEFAULT '',
  descr      TEXT NOT NULL DEFAULT '',
  models     TEXT NOT NULL DEFAULT '',
  ratio      TEXT NOT NULL DEFAULT '',
  tags       TEXT NOT NULL DEFAULT '[]',   -- JSON 数组
  content    TEXT NOT NULL DEFAULT '',     -- 教程 markdown
  sort       INTEGER NOT NULL DEFAULT 0,
  status     TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at TEXT,
  UNIQUE (board, name)
);
CREATE INDEX IF NOT EXISTS idx_aiitem_board ON ai_items (board, sort);

CREATE TABLE IF NOT EXISTS github_creators (
  login      TEXT PRIMARY KEY,
  note       TEXT NOT NULL DEFAULT '',
  sort       INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

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

CREATE TABLE IF NOT EXISTS shares (
  sid        TEXT PRIMARY KEY,
  type       TEXT NOT NULL DEFAULT 'custom',
  title      TEXT NOT NULL,
  descr      TEXT NOT NULL DEFAULT '',
  url        TEXT NOT NULL DEFAULT '',
  badge      TEXT NOT NULL DEFAULT '',
  meta       TEXT NOT NULL DEFAULT '{}',   -- JSON
  views      INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE UNIQUE INDEX IF NOT EXISTS idx_share_type_url ON shares (type, url) WHERE url <> '';

-- 抓取锁（单行 + 过期时间，替代 Mongo 时代的 TTL 索引）
CREATE TABLE IF NOT EXISTS crawl_locks (
  name       TEXT PRIMARY KEY,
  token      TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL
);
