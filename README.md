# 瞭望台 · GitHub 日榜简报

> 一个自用的信息聚合站点：GitHub Trending 日/周/月榜 + 19 个热门数据源 + 网站导航 / AI 资源台 / 个性头像 / DNS 看板。

**一个 Nuxt 全栈应用，一个 Node 进程，一个 SQLite 文件。** 页面与 `/api/*` 编译进同一份产物、同源部署；数据落本地单文件，Caddy 反代 127.0.0.1:3000。没有 Cloudflare、没有 MongoDB、没有 GitHub Actions、没有外部定时服务。

实测资源占用（Windows 开发机 / 等价 Linux 容器）：

| 指标 | 数值 |
| --- | --- |
| 常驻内存 RSS | **84 ~ 96 MB** |
| 构建产物 | 5.3 MB（`.output`） |
| 数据库 | 135 KB（含 17 条榜单 + 19 个端点快照） |
| 冷启动到可用 | < 1 秒 |
| 一次抓取耗时 | GitHub 4.1s / 聚合端点 18.6s |

1 核 1G 的机器跑得动，但**构建必须放在本地**（`nuxt build` 峰值 1.2~1.8GB，服务器上会 OOM）。

---

## 功能

### 1. GitHub 榜单（`/`）

- 每天抓取 GitHub Trending **日榜 / 周榜 / 月榜**，一键切换
- 按日期分区存储，**每小时自动更新**；掉出前 10 的记录只降级、不删除
- 首页默认展示今日前 10，翻页可看当日剩余 + 历史掉榜仓库
- 附带一言（每 60 秒自动刷新）

### 2. 热门榜单（`/v2`）

**19 个数据源**，分 2 类：

- 🔥 **热搜榜**（9）：微博 / 知乎 / 抖音 / B站 / 头条 / 百度 / 贴吧 / 小红书 / 夸克
- 📰 **资讯速览**（10）：AI 资讯 / IT 资讯 / IT 榜 / HN 热门·最新·最佳 / 历史上的今天 / 网易云榜 / 60 秒读懂世界 / 必应壁纸

一屏 **3 × 3 共 9 张卡片**，每张卡片最多展示 50 条，卡片内滚动看完，不用点进详情。
上游来自 [60s API](https://60.020417.xyz)，同样每小时更新。

### 3. 站点板块

| 路由 | 说明 | 数据表 |
| --- | --- | --- |
| `/nav` | 网站导航：左侧分类侧栏 + 站点卡片，支持搜索 | `nav_categories` / `nav_links` |
| `/ai` | AI 资源台：6 个板块 Tab + 资源卡片，教程可点开看 markdown 全文 | `ai_boards` / `ai_items` |
| `/github` | 查任意 GitHub 用户的公开仓库，可搜索、按推送时间/Star 排序 | GitHub 公开 API |
| `/avatar` | 个性头像生成器：seed 可复现、4 种风格、导出 1024px PNG | 纯前端 SVG |
| `/dns` | Cloudflare DNS 看板：记录缓存 + 在线状态与延迟，可手动探活 | `dns_records` + CF API |
| `/share` | 分享汇总：任意卡片点「分享」生成的页面汇总于此 | `shares` |
| `/admin` | 数据后台：统计 / 列表 / 新增 / 删除（密码保护） | 全部表 |
| `/history` | 历史榜单：日期时间线 + 当日完整榜单，支持日/周/月切换 | `trending_repos` |

---

## 技术栈

| 层 | 选型 |
| --- | --- |
| 框架 | **Nuxt 4**（Vue 3 SSR + Nitro server API），前后端同一份代码 |
| 运行时 | **Node 单进程**（`node-server` preset，`node .output/server/index.mjs`） |
| 数据库 | **SQLite 单文件**，走 Node 内置 `node:sqlite`（零外部依赖） |
| 缓存 | 进程内 Map + TTL（300 条上限） |
| 定时 | 进程内 `setInterval`（启动即抓一轮，之后每 60 分钟） |
| 反代 | **Caddy**（zstd/gzip + 静态资源长缓存） |
| 守护 | **systemd**（`MemoryMax=450M`、失败自动重启） |

### 为什么是 SQLite 而不是 JSON

业务是关系型查询：按 `date + period` 过滤、按 `bucket/rank/stars` 排序、翻页、`union all` 统计、主键 upsert 去重。
JSON 方案每条都要全量 parse 进内存再排序，历史榜单攒几个月后就是 CPU 与 GC 灾难。
SQLite 是单文件 + 索引 + WAL（写不阻塞读），查询走索引直接出结果，磁盘占用也就百 KB 级。

### 为什么用 `node:sqlite` 而不是 `better-sqlite3`

`better-sqlite3` 要 node-gyp 编译，1C1G 上装一次要装 python/gcc、编译很久。
`node:sqlite` 是 Node 内置模块：**零编译、零依赖**，`npm ci` 秒装。

要求 Node ≥ 22.5（22.x 需 `--experimental-sqlite`，23+ 默认可用；推荐 22 LTS 以上）。

---

## 快速开始

```bash
npm install

npm run db:init          # 建表（幂等）
npm run db:seed          # 可选：导航 / AI / 关注列表种子

npm run dev              # 开发：http://localhost:3000（HMR）
# 或
npm run build && npm start
```

首次启动后，`server/plugins/scheduler.ts` 会在 0.8 秒后自检数据库并抓一轮
（`CRAWL_ON_BOOT=false` 可关闭）。

### 常用命令

| 命令 | 说明 |
| --- | --- |
| `npm run dev` | 开发模式（热更新） |
| `npm run build` | 构建 `.output`（**本地/CI 执行，别在 1G 机器上跑**） |
| `npm start` | 启动生产服务 |
| `npm run db:init` | 建表（幂等） |
| `npm run db:seed` | 灌种子数据（幂等） |
| `npm run db:info` | 表行数 / 文件大小 / WAL 状态 |
| `npm run db:reset` | 删库重建（`FORCE=1` 确认） |
| `npm run db:shell` | 打印常用 SQL（配合 `sqlite3` CLI） |
| `npm run crawl` | 手动抓一次（服务需在运行） |
| `npm run verify:sql` | 校验 schema / seed / 关键 SQL（不需要数据库） |
| `npm run typecheck` | server(tsc) + app(vue-tsc) 全量类型检查 |

---

## 环境变量

复制 `.env.example` 为 `.env`，或直接用 systemd 的 `Environment=` 注入。

```bash
# ── 进程 ──
HOST=127.0.0.1          # 只监听回环，外部统一走 Caddy
PORT=3000
DB_PATH=data/app.db

# ── 抓取调度（进程内，不需要 cron / Actions）──
UPDATE_INTERVAL_MINUTES=60
CRAWL_ON_BOOT=true
ENABLE_SCHEDULER=true

# ── 展示参数 ──
TRENDING_SINCE=daily
TRENDING_LANGUAGE=
TOP_N=10
PAGE_SIZE=10
APP_TIMEZONE=Asia/Shanghai
HITOKOTO_ENDPOINT=https://v1.hitokoto.cn/

# ── 60s 聚合接口 ──
FEEDS_BASE=https://60.020417.xyz
FEEDS_ENABLED=true

# ── 可选 ──
CRON_TOKEN=             # /api/crawl 鉴权；不配则不校验
ADMIN_PASSWORD=         # /admin 后台密码
GITHUB_TOKEN=           # 提高 GitHub API 配额
CF_API_TOKEN=           # /dns 页直读 Cloudflare（Zone.DNS:Read）
CF_ZONE_IDS=            # 逗号分隔的 zone id
```

---

## 数据模型（SQLite）

一个文件 12 张表，schema 见 [`db/schema.sql`](db/schema.sql)。

| 表 | 用途 | 主键 |
| --- | --- | --- |
| `trending_repos` | 榜单仓库（日/周/月 × 日期） | `(date, period, repo_key)` |
| `crawl_runs` | 抓取日志 | `id` |
| `app_meta` | 运行元信息（上次成功时间等） | `key` |
| `feed_snapshots` | 60s 聚合端点快照（归一化 JSON） | `key` |
| `nav_categories` / `nav_links` | 导航分类 / 站点 | `key` / `id` |
| `ai_boards` / `ai_items` | AI 板块 / 资源（含教程 markdown） | `key` / `id` |
| `github_creators` | 关注列表 | `login` |
| `dns_records` | DNS 看板缓存 | `host` |
| `shares` | 分享短链 | `sid` |
| `crawl_locks` | 抓取锁（行 + 过期时间） | `name` |

榜单行的关键语义：

| 字段 | 含义 |
| --- | --- |
| `bucket` | `0` 今日前 N 名 / `1` 榜内其他 / `2` 已掉榜 |
| `dropped` | 是否掉出当日榜单（保留，不删行） |
| `best_rank` | 历史最高名次 |
| `snapshots` | 最近 48 个采样点的 JSON 时间序列 |

---

## 部署到 1 核 1G 服务器

### 1. 装 Node

```bash
# Debian/Ubuntu：NodeSource 或 nvm 均可，要求 >= 22.5
node -v
```

### 2. 建目录 + 拉代码（或只用 rsync 推产物）

```bash
sudo mkdir -p /opt/liaowangtai && sudo chown $USER:$USER /opt/liaowangtai
cd /opt/liaowangtai
git clone https://github.com/ice-a/trading.git .
```

> 也可以用 `deploy/deploy.sh`：本地构建后只把 `.output`（5MB）同步过去，服务器完全不跑构建。

### 3. 初始化数据库

```bash
node scripts/db-cli.mjs init
node scripts/db-cli.mjs seed     # 可选
```

**服务器不需要 `npm install`**：`.output` 是自包含的（自带 38 个生产依赖），
`db-cli.mjs` 只用 Node 内置模块。服务器上只有 `node` + `pm2` 两样东西。

### 4. PM2 守护

```bash
# 装一次（用 Node 自带 npm 即可）
npm i -g pm2

cd /opt/liaowangtai
pm2 start ecosystem.config.cjs      # 配置在 deploy/ecosystem.config.cjs
pm2 save                            # 保存进程列表
pm2 startup                         # 按它输出的那条 sudo 命令执行，实现开机自启

pm2 status
pm2 logs liaowangtai --lines 60
```

**必须是单实例 fork 模式**（配置里已固定）：SQLite 是单文件单连接，cluster 多进程会抢写锁并让定时器重复抓取。配置里已经写死 `instances: 1` + `exec_mode: 'fork'`，改目录时只要 `export APP_DIR=...` 即可，不用改文件。

| 命令 | 作用 |
| --- | --- |
| `pm2 startOrReload ecosystem.config.cjs` | 首次启动 / 原子重载（部署脚本用的就是这条） |
| `pm2 restart liaowangtai` | 重启 |
| `pm2 stop liaowangtai` | 停止（会走 15 秒优雅退出，等抓取收尾） |
| `pm2 logs liaowangtai --err` | 只看错误 |
| `pm2 describe liaowangtai` | 重启次数、内存、启动参数 |
| `pm2 monit` | 实时 CPU / 内存 |

日志默认落在 `data/pm2-out.log` 与 `data/pm2-error.log`。想自动切割：

```bash
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 3
```

> 不想用 PM2？`deploy/liaowangtai.systemd.service` 是等价的 systemd 方案，但**两者只能启用一个**，否则会抢 3000 端口。

### 5. Caddy 反代

```bash
sudo cp deploy/Caddyfile /etc/caddy/Caddyfile   # 改域名
sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

Caddy 配好了 `encode zstd gzip`、`/_nuxt/*` 长缓存、页面 `no-cache`，
以及 `/api/refresh` 需要的 **120 秒**反代超时（抓取是同步的，可能跑 20 秒）。

如果服务器上已有 Caddyfile（和 sing-box 共用），只需要追加这一段：

```caddyfile
liaowangtai.example.com {
	encode zstd gzip
	reverse_proxy 127.0.0.1:3000 {
		transport http {
			response_header_timeout 120s
		}
	}
}
```

### 6. 验证

```bash
curl -s http://127.0.0.1:3000/api/health
curl -s https://your-domain/api/trending?page=1 | head -c 200
```

`health` 返回 `"ok":true,"storage":"sqlite"` 即通。

### 7. 备份

```bash
# 手动
node scripts/backup-db.mjs          # VACUUM INTO，抓取中也能备份

# crontab：每天 4 点，保留 7 份
0 4 * * * cd /opt/liaowangtai && /usr/bin/node scripts/backup-db.mjs >> data/backup.log 2>&1
```

### 8. 更新版本

```bash
HOST=user@your-server ./deploy/deploy.sh    # 本地构建 + 同步 + 重启 + 健康检查
```

---

## 与 sing-box / Caddy 共存

- **端口**：应用只监听 `127.0.0.1:3000`，不占公网端口，不会和 sing-box 抢
- **Caddy**：占 80/443 做 TLS 与反代；sing-box 用其它端口（或 Caddy 反代到 sing-box 的入站）
- **内存**：应用限 320M 堆 / 450M 上限，给 sing-box 与 Caddy 留足余量
- **CPU**：抓取只占 4~19 秒，每小时一次；`CPUQuota=90%` 防止单次抓取把机器占满

---

## 目录结构

```
├─ app/                 # 前端：页面 / 组件 / composables（Vue 3）
├─ server/
│  ├─ api/              # 后端：同源 Nitro 路由（/api/*）
│  ├─ utils/
│  │  ├─ db.ts          # SQLite 数据层（node:sqlite + 预编译缓存 + 事务）
│  │  ├─ cache.ts       # 进程内缓存（TTL + 上限淘汰）
│  │  ├─ env.ts         # .env 加载 + process.env
│  │  ├─ crawler.ts     # 抓取编排（锁 → 抓 → upsert → 日志）
│  │  └─ feeds.ts       # 19 个聚合端点采集与归一化
│  ├─ plugins/
│  │  └─ scheduler.ts   # 进程内定时抓取（启动抓一轮 + 每小时）
│  └─ config/feeds.ts   # 聚合端点定义
├─ db/
│  ├─ schema.sql        # 12 张表 + 索引
│  └─ seed.sql          # 种子数据（幂等）
├─ deploy/
│  ├─ ecosystem.config.cjs  # PM2（单实例 fork + 内存上限 + 日志）
│  ├─ Caddyfile             # 反代 3000 + 缓存 + 120s 超时
│  ├─ deploy.sh             # 本地构建 → rsync → pm2 重载 → 体检
│  └─ liaowangtai.systemd.service  # 备选：不用 PM2 时的 systemd 单元
├─ scripts/             # db-cli / crawl-once / backup-db / verify-sql / …
├─ archive/             # 历史脚本（Cloudflare、MongoDB、一次性 UI 调试）
├─ nuxt.config.ts       # preset: node-server
└─ data/                # app.db + backups（已在 .gitignore）
```

---

## FAQ

**Q：为什么构建不能在服务器上跑？**
`nuxt build` 峰值内存 1.2~1.8GB，1C1G 会被 OOM killer 干掉。用 `deploy/deploy.sh` 本地构建后只推 5MB 产物。

**Q：PM2 用 cluster 模式会不会更快？**
不会，而且会出问题。SQLite 单文件单连接，多进程抢同一把写锁；抓取定时器也会每个进程跑一遍。配置里已固定 `instances: 1` + `fork`。

**Q：能多进程 / pm2 cluster 吗？**
单机 SQLite 单连接，**只能单实例**。要更高并发就把 `NODE_OPTIONS` 调大、或换 PostgreSQL —— 但对这个站点的量级（个人使用）没必要。

**Q：数据会不会丢？**
WAL + `synchronous=NORMAL`：断电最多丢最后一次事务。跑 `scripts/backup-db.mjs`（`VACUUM INTO`）可以热备份，抓到一半也能备份。

**Q：不用内置定时器，想用系统 cron？**
设 `ENABLE_SCHEDULER=false`，然后 `*/60 * * * * curl -fsS -X POST http://127.0.0.1:3000/api/crawl -H 'x-cron-token: ...'`。

**Q：`/dns` 页面还需要 Cloudflare token 吗？**
要，但只需 **Zone → DNS → Read**（不是部署用的那种大权限）。不配就只读 `dns_records` 缓存。

**Q：想加 HTTPS 以外的端口 / 子路径？**
Caddy 里加 `handle_path /app/* { reverse_proxy 127.0.0.1:3000 }` 即可，应用侧已按相对路径工作。