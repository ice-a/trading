# 瞭望台 · GitHub 日榜简报

> GitHub Trending 日/周/月榜 + GitHub 用户查询 + 个性头像 + 行情台（A股/港股/美股/基金 + 持仓账本）+ 历史榜单。

**一个 Nuxt 全栈应用，两种部署形态共用同一份代码：**

| 形态 | 运行时 | 数据库 | 定时抓取 |
| --- | --- | --- | --- |
| **Vercel（免费 Hobby）** | Serverless Functions | 远程 libSQL（Turso） | Vercel Cron 每天 1 次，或外部 cron 打 `/api/crawl` |
| **自建 1C1G** | Node 常驻进程（pm2） | 本地 SQLite 单文件 | 进程内定时器，启动抓一轮 + 每小时 |

数据层是同一套接口（`sqlAll` / `sqlFirst` / `sqlRun` / `sqlBatch`），
**配了 `TURSO_DATABASE_URL` 就走远程，否则走本地文件** —— 业务代码一行都不用改。

---

## 功能

| 路由 | 说明 | 数据来源 |
| --- | --- | --- |
| `/` | GitHub 日/周/月榜，按日期留存，掉榜不删 | `trending_repos` |
| `/github` | 查任意 GitHub 用户的公开仓库 | GitHub 公开 API |
| `/avatar` | 个性头像生成器（seed 可复现、4 种风格、导出 PNG） | 纯前端 SVG |
| `/stack` | 行情台：热门板块 / 热门股票 / K线 / 基金持仓 / 我的持仓 | 腾讯财经 + 新浪财经 + `portfolio_trades` |
| `/history` | 历史榜单时间线 + 当日完整榜单 | `trending_repos` |

> 已移除：热门榜单（/v2）、网站导航（/nav）、AI 资源台（/ai）、分享（/share）、后台（/admin）。

---

## 技术栈

| 层 | 选型 |
| --- | --- |
| 框架 | Nuxt 4（Vue 3 SSR + Nitro server API） |
| 数据库 | SQLite 语法：本地用 `node:sqlite`，远程用 `@libsql/client`（Turso） |
| 缓存 | 进程内 Map + TTL |
| 抓取 | `cheerio` 解析 GitHub Trending HTML |
| 部署 | Vercel（`vercel` preset）或 Node（`node-server` preset） |

---

## 本地开发

```bash
npm install
npm run db:init        # 建表（默认写 data/app.db）
npm run dev            # http://localhost:3000
```

首次启动会自检数据库并抓一轮榜单（`CRAWL_ON_BOOT=false` 可关）。

### 常用命令

| 命令 | 说明 |
| --- | --- |
| `npm run dev` | 开发（热更新） |
| `npm run build` | 构建（Vercel 上设 `VERCEL=1` 切 preset） |
| `npm run start` | 本地跑生产产物 |
| `npm run db:init` | 建表（幂等；远程库同样适用） |
| `npm run db:seed` | 灌示例数据（幂等） |
| `npm run db:info` | 表行数 / 文件大小 / 连接模式 |
| `npm run db:reset` | 删库重建（`FORCE=1` 确认，仅本地） |
| `npm run turso:init` | 建 Turso 库 + 建表 + 打印 Vercel 环境变量 |
| `npm run crawl` | 手动抓一次（服务需在运行） |
| `npm run verify:sql` | 校验 schema / seed / 关键 SQL |
| `npm run typecheck` | server(tsc) + app(vue-tsc) |

---

## 部署到 Vercel（免费）

### 1. 建远程库（Turso，免费 500MB）

Vercel 的函数**没有持久磁盘**，`/tmp` 不跨实例，SQLite 文件写不了 —— 所以必须用远程库。
Turso 是 libSQL（SQLite 分支），schema 完全不用改。

一条命令搞定建库 + 建表 + 生成 token + 打印环境变量：

```bash
curl -sSfL https://get.tur.so/install.sh | bash   # 装 CLI
turso auth signup                                  # 登录

npm run turso:init        # = bash scripts/init-turso.sh
```

它会：检查 CLI 与登录 → 建库（已存在则复用）→ 取 URL / 生成 token →
就地执行 `db/schema.sql` + `db/seed.sql` → 写回 `.env` → 打印要填到 Vercel 的三条变量。

想手动来也行：

```bash
turso db create liaowangtai
turso db show liaowangtai --url      # libsql://...
turso db tokens create liaowangtai   # ey...

export TURSO_DATABASE_URL="libsql://xxxx.turso.io"
export TURSO_AUTH_TOKEN="ey..."
npm run db:init && npm run db:seed
```

### 2. 导入仓库

Vercel Dashboard → Add New Project → 选 `ice-a/trading` → Framework 自动识别 Nuxt。

### 3. 配环境变量

Project Settings → Environment Variables：

| 变量 | 值 | 必需 |
| --- | --- | --- |
| `TURSO_DATABASE_URL` | `libsql://xxxx.turso.io` | ✅ |
| `TURSO_AUTH_TOKEN` | `ey...` | ✅ |
| `CRON_SECRET` | 随机串 | ✅（cron 鉴权；`/api/crawl` 也认 `CRON_TOKEN`，两者同名即可） |
| `GITHUB_TOKEN` | GitHub PAT | 可选（提高配额） |

### 4. 部署

push 到 master 即自动部署。部署完访问 `/api/health`：

```json
{"ok":true,"runtime":"vercel","storage":"libsql","db":{"mode":"remote","url":"libsql://..."}}
```

### 5. 灌第一批数据

```bash
curl "https://<your-app>.vercel.app/api/cron" -H "Authorization: Bearer $CRON_SECRET"
```

### 6. 定时抓取的真相（Hobby 限制）

**Vercel Hobby 的 cron 每天只能跑一次**，`vercel.json` 里配的是：

```json
"crons": [{ "path": "/api/cron", "schedule": "0 3 * * *" }]
```

想要**每小时**更新，两种做法。

**A. GitHub Actions（推荐）**

在仓库里新建 `.github/workflows/crawl.yml`，内容：

```yaml
name: crawl
on:
  schedule: [{ cron: '5 * * * *' }]   # 每小时第 5 分钟（UTC）
  workflow_dispatch:
concurrency:
  group: crawl
  cancel-in-progress: false
permissions:
  contents: read
jobs:
  trigger:
    runs-on: ubuntu-latest
    steps:
      - name: 触发抓取
        env:
          APP_URL: ${{ vars.APP_URL }}
          CRON_TOKEN: ${{ secrets.CRON_TOKEN }}
        run: |
          test -n "$APP_URL" && test -n "$CRON_TOKEN" || { echo "缺少 APP_URL / CRON_TOKEN"; exit 1; }
          curl -fsS --max-time 120 -X POST             "$APP_URL/api/crawl?token=$CRON_TOKEN"             -H "Authorization: Bearer $CRON_TOKEN"
```

仓库配置（Settings → Secrets and variables → Actions）：

| 类型 | 名称 | 值 |
| --- | --- | --- |
| Variables | `APP_URL` | `https://<你的 vercel 域名>` |
| Secrets | `CRON_TOKEN` | 与 Vercel 的 `CRON_SECRET` 相同 |

> 用命令行 push 这个文件需要 PAT 带 `workflow` scope；**直接在 GitHub 网页 New file 粘贴内容不需要任何 scope**。

**B. 外部 cron（最省事，不碰 GitHub 权限）**

cron-job.org / UptimeRobot 之类，每小时发一次：

```bash
curl -fsS -X POST "https://<your-app>.vercel.app/api/crawl?token=$CRON_TOKEN"
```

---

## 部署到 1 核 1G 服务器（可选）

自建不需要 Turso，直接本地 SQLite：

```bash
git clone -b dist https://github.com/ice-a/trading.git /opt/liaowangtai
cd /opt/liaowangtai
cp .env.example .env                        # DB_PATH=data/app.db
node scripts/db-cli.mjs init && node scripts/db-cli.mjs seed
pm2 start deploy/ecosystem.config.cjs
pm2 save && pm2 startup
```

`deploy/` 里还有 `Caddyfile`、`deploy.sh`、`liaowangtai.systemd.service`（备选）。

> `dist` 分支只放构建产物（自包含依赖），服务器不需要 `npm install`。
> 本地发版 `./scripts/publish-dist.sh`，服务器更新 `./update.sh`。

---

## 数据模型

5 张表，见 [`db/schema.sql`](db/schema.sql)。

| 表 | 用途 | 主键 |
| --- | --- | --- |
| `trending_repos` | 榜单仓库（日/周/月 × 日期） | `(date, period, repo_key)` |
| `crawl_runs` | 抓取日志 | `id` |
| `app_meta` | 运行元信息（上次抓取时间等） | `key` |
| `portfolios` | 持仓账本凭据（user → key 哈希） | `user` |
| `portfolio_trades` | 买卖流水（持仓由流水实时推导） | `id` |
| `fx_rates` | 汇率（1 外币 = ? 人民币） | `currency` |
| `stock_search_history` | 搜索历史（去重） | `(user_name, keyword)` |
| `crawl_locks` | 抓取锁（防并发） | `name` |

榜单行语义：`bucket` = `0` 前 N 名 / `1` 榜内其他 / `2` 已掉榜；`dropped` 掉榜标记；`snapshots` 最近 48 个采样点。

---

## API

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/trending` | 单周期榜单（`date`/`period`/`page`） |
| GET | `/api/trending-bundle` | 日/周/月三份一次取回 |
| GET | `/api/history` | 历史总览 |
| GET | `/api/stock/hot` | A股涨幅榜 + 行业板块 |
| GET | `/api/stock/list?market=hk\|us` | 港股 / 美股热门 |
| GET | `/api/stock/search?q=` | 搜股票 / 港股 / 美股 / 基金 |
| GET | `/api/stock/kline?symbol=` | K 线（日/周/月），symbol 形如 sh600519 / hk00700 / usAAPL |
| GET | `/api/stock/fund?code=` | 基金前十重仓 |
| GET/POST | `/api/stock/portfolio` | 持仓账本（user + key） |
| GET | `/api/hitokoto` | 一言 |
| GET | `/api/github-search` · `/api/repos` | GitHub 查询 |
| POST | `/api/refresh` | 页面按需刷新（1 小时节流，`?force=1`） |
| GET/POST | `/api/crawl` | 强制抓取（`token` 鉴权） |
| GET | `/api/cron` | Vercel Cron 入口（`Bearer CRON_SECRET`） |
| GET | `/api/health` · `/api/status` | 自检 / 调度状态 |

---

## 目录结构

```
├─ app/                 # 前端：5 个页面 + 组件
├─ server/
│  ├─ api/              # 同源 Nitro 路由
│  ├─ utils/
│  │  ├─ db.ts          # 双模式数据层（file: node:sqlite / remote: libSQL）
│  │  ├─ crawler.ts     # 抓取编排（锁 → 抓 → upsert → 日志）
│  │  ├─ trending.ts    # GitHub Trending 解析
│  │  └─ …
│  └─ plugins/scheduler.ts   # 仅自建环境启用进程内定时器
├─ db/schema.sql · seed.sql
├─ deploy/              # 自建方案（pm2 / Caddy / systemd）
├─ scripts/             # db-cli / crawl-once / verify-sql / publish-dist
├─ vercel.json          # cron（Hobby 每天 1 次）
└─ nuxt.config.ts       # preset 随 VERCEL 环境切换
```

---

## FAQ

**Q：为什么 Vercel 上不能用 SQLite 文件？**
Serverless 函数没有持久磁盘，`/tmp` 只在单次调用内有效，实例随时销毁重建。所以必须用远程库 —— Turso 是 libSQL（SQLite 语法），schema 零改动。

**Q：Turso 免费额度够吗？**
500MB 存储 + 10 亿行读/月。这个站点一天几十行写入、页面读几十次，绰绰有余。

**Q：抓取会不会超时？**
GitHub Trending 一次抓 3 个周期约 3~5 秒。`nuxt.config` 里已给 Vercel 函数配了 `maxDuration: 60`、`memory: 1024`。

**Q：Vercel 上还要 pm2 吗？**
不需要。`deploy/` 那套是给自建服务器的，Vercel 上完全不生效。

**Q：本地构建报 `node:sqlite` 找不到？**
需要 Node ≥ 22.5。Node 22.x 要加 `--experimental-sqlite`，Node 23+ 默认可用。