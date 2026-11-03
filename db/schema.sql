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

-- 抓取锁（单行 + 过期时间）
CREATE TABLE IF NOT EXISTS crawl_locks (
  name       TEXT PRIMARY KEY,
  token      TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL
);

-- 跨实例响应缓存（Vercel 上内存缓存不跨实例，必须落共享库）
CREATE TABLE IF NOT EXISTS response_cache (
  key        TEXT PRIMARY KEY,
  value      TEXT NOT NULL,          -- JSON
  expires_at TEXT NOT NULL,          -- ISO 时间，到点即失效
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_cache_exp ON response_cache (expires_at);


-- ============ 股票 / 持仓 ============

-- 账本凭据：user → key 的哈希（不存明文）
CREATE TABLE IF NOT EXISTS portfolios (
  user       TEXT PRIMARY KEY,
  key_hash   TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

-- 一条记录 = 一次买入/卖出；持仓由记录实时推导
CREATE TABLE IF NOT EXISTS portfolio_trades (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name  TEXT NOT NULL,
  code       TEXT NOT NULL,
  name       TEXT NOT NULL DEFAULT '',
  market     TEXT NOT NULL DEFAULT 'A',   -- A | HK | US | FUND
  side       TEXT NOT NULL DEFAULT 'buy', -- buy | sell
  venue      TEXT NOT NULL DEFAULT '',    -- 交易所/券商
  trade_date TEXT NOT NULL,
  quantity   REAL NOT NULL DEFAULT 0,
  price      REAL NOT NULL DEFAULT 0,
  fee        REAL NOT NULL DEFAULT 0,
  currency   TEXT NOT NULL DEFAULT 'CNY',
  note       TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_trade_user ON portfolio_trades (user_name, trade_date DESC);

-- 汇率：1 单位外币 = cny_rate 人民币（手工维护，不依赖外部 fx 接口）
CREATE TABLE IF NOT EXISTS fx_rates (
  currency   TEXT PRIMARY KEY,
  cny_rate   REAL NOT NULL DEFAULT 1,
  updated_at TEXT NOT NULL
);

-- 搜索历史（去重）
CREATE TABLE IF NOT EXISTS stock_search_history (
  user_name  TEXT NOT NULL,
  keyword    TEXT NOT NULL,
  created_at TEXT NOT NULL,
  PRIMARY KEY (user_name, keyword)
);
CREATE INDEX IF NOT EXISTS idx_search_time ON stock_search_history (user_name, created_at DESC);
