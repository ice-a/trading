# 瞭望台 · GitHub 日榜简报

> 一个自用的信息聚合站点：GitHub Trending 日/周/月榜 + 19 个热门数据源 + 网站导航 / AI 资源台 / 个性头像 / DNS 看板。

Nuxt 4 前后端一体（Nitro），数据落 MongoDB Atlas，每小时自动抓取一轮。
页面全部 SSR + 页面级 SWR 缓存，预热后全站 **20~40ms**。

---

## 功能

### 1. GitHub 榜单（`/`）

- 每天抓取 GitHub Trending **日榜 / 周榜 / 月榜**，一键切换
- 按日期分区存储，**每小时更新一次**；掉出前 10 的记录只降级、不删除
- 首页默认展示今日前 10，翻页可看当日剩余 + 历史掉榜仓库
- 附带一言（每 60 秒自动刷新）

### 2. 热门榜单（`/v2`）

**19 个数据源**，分 2 类：

- 🔥 **热搜榜**（9）：微博 / 知乎 / 抖音 / B站 / 头条 / 百度 / 贴吧 / 小红书 / 夸克
- 📰 **资讯速览**（10）：AI 资讯 / IT 资讯 / IT 榜 / HN 热门·最新·最佳 / 历史上的今天 / 网易云榜 / 60 秒读懂世界 / 必应壁纸

一屏 **3 × 3 共 9 张卡片**，每张卡片最多展示 50 条，卡片内滚动即可看完，不用点进详情。
上游来自 [60s API](https://60.020417.xyz)，同样每小时更新。

### 3. 站点板块

| 路由 | 说明 | 数据 |
| --- | --- | --- |
| `/nav` | 网站导航：左侧分类侧栏（默认折叠）+ 站点卡片，支持搜索 | `nav_categories` / `nav_links` |
| `/ai` | AI 资源台：6 个板块 Tab + 资源卡片，教程可点开看 markdown 全文 | `ai_boards` / `ai_items` |
| `/github` | 查任意 GitHub 用户的公开仓库，可搜索、按推送时间/Star 排序 | GitHub 公开 API |
| `/avatar` | 个性头像生成器：seed 可复现、4 种风格、导出 1024px PNG | 纯前端 SVG |
| `/dns` | Cloudflare DNS 看板：记录缓存 + 在线状态与延迟，可手动探活 | `dns_records` + CF API |
| `/share` | 分享合集：任意卡片点「分享」生成的页面汇总于此 | `shares` |
| `/admin` | 数据后台：统计 / 列表 / 新增 / 删除（密码保护） | 全部集合 |
| `/history` | 历史榜单：日期时间线 + 当日完整榜单，支持日/周/月切换 | `trending_repos` |

---

## 技术栈

- **Nuxt 4** + Nitro + Vue 3（SSR）
- **MongoDB Atlas**（M0 免费层）+ 官方 driver
- **Vite** 构建，`markdown-it` 渲染教程正文
- 部署目标：**Vercel**

---

## 快速开始

```bash
npm install
cp .env.example .env      # 填入 MONGODB_URI 等
npm run dev               # http://localhost:3000
```

首次启动会自动跑一轮抓取并预热缓存。也可以手动触发：

```bash
curl -X POST http://localhost:3000/api/crawl
```

---

## 环境变量

```bash
# 必填：MongoDB Atlas 连接串（库名不要用 test）
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/?retryWrites=true&w=majority
MONGODB_DB=github_trending

# 数据源上游
FEEDS_BASE=https://60.020417.xyz

# 时区 / 抓取频率
APP_TIMEZONE=Asia/Shanghai
UPDATE_INTERVAL_MINUTES=60

# 可选：提高 GitHub API 限额（未配置时限流 60 次/小时）
GITHUB_TOKEN=

# 可选：Cloudflare DNS 看板（未配置时读数据库缓存）
CF_API_TOKEN=
CF_ZONE_IDS=            # 多个 zone 用逗号分隔

# 后台密码（/admin）
ADMIN_PASSWORD=admin123

# 缓存：磁盘层目录（Vercel 上设 /tmp）
DISK_CACHE_DIR=.cache
DISK_CACHE=on
```

---

## 数据模型

数据库 `github_trending`，12 个集合。

### 榜单

**`trending_repos`** —— 榜单仓库，按 `date + period` 分区

```jsonc
{
  "date": "2026-10-28",
  "period": "daily",          // daily | weekly | monthly
  "repoKey": "owner/name",
  "fullName": "owner/name",
  "description": "...",
  "language": "TypeScript",
  "totalStars": 50000,
  "todayStars": 1395,         // 该周期内的新增 Star
  "rank": 1,
  "bucket": 0,                // 0=前N名 1=榜内其他 2=已掉榜
  "dropped": false,
  "snapshots": []             // 历次抓取快照
}
```

唯一索引 `(date, period, repoKey)`。

**`feed_snapshots`** —— 外部数据源快照，每个端点一条

```jsonc
{
  "key": "baidu-hot",
  "title": "百度热搜",
  "category": "hot",          // hot | info
  "ok": true,
  "payload": { "kind": "list", "items": [], "total": 50 },
  "fetchedAt": "2026-10-28T07:00:00Z"
}
```

**`crawl_runs`** / **`crawl_locks`** / **`app_meta`** —— 抓取日志、分布式锁（带 TTL）、运行元信息。

### 站点板块

**`nav_categories`**（55 条）

```jsonc
{ "key": "browser-ext", "name": "浏览器扩展", "group": "效率工具", "icon": "🧩", "sort": 10 }
```

**`nav_links`**（424 条）

```jsonc
{
  "name": "Tampermonkey", "url": "https://www.tampermonkey.net/",
  "catelog": "browser-ext", "group": "效率工具",
  "desc": "最流行的用户脚本管理器", "icon": "🐒", "sort": 10
}
```

**`ai_boards`**（6 条）/ **`ai_items`**（79 条）

```jsonc
{ "key": "stations", "name": "中转站", "icon": "☁️", "sort": 0 }
```

```jsonc
{
  "board": "stations", "name": "小蚯蚓", "url": "https://api.example.com",
  "models": "gpt-5.5-turbo / gpt-4", "ratio": "0.05x",
  "tags": ["低价"], "content": ""
}
```

**`github_creators`**（17 条）

```jsonc
{ "login": "gaearon", "note": "React 核心", "sort": 0 }
```

**`dns_records`**（14 条）

```jsonc
{
  "name": "AI 资源台", "host": "web.example.com", "type": "CNAME",
  "target": "cname.example.com", "proxied": true,
  "status": "online", "latencyMs": 214, "httpStatus": 200
}
```

**`shares`** —— 分享快照，`sid` 为短 id，访问 `/s/{sid}`。

---

## 性能设计

数据库在远程 Atlas，跨洋链路建连约 4s、单次查询 200~800ms，而全部业务数据只有 ~500KB。
因此做了**三级读取**：

```
内存（微秒级）→ .cache/*.json（毫秒级）→ MongoDB（百毫秒级）
```

- 进程重启后直接读磁盘文件，不用重新连库
- 抓取写库后 `invalidateCache` 同时清掉内存与磁盘
- 目录不可写（Serverless 只读）时自动降级
- 启动预热 13 个热点接口
- 页面级 SWR：`/`、`/v2` 300s，`/nav`、`/ai` 600s，`/dns` 120s

实测（预热后）：

| 路由 | 耗时 |
| --- | --- |
| `/` `/v2` `/history` `/nav` `/ai` `/dns` `/share` `/admin` | **19~37 ms** |
| 冷启动首次请求 | 60~300 ms |

---

## API

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/trending?date=&page=&period=` | 榜单分页（daily/weekly/monthly） |
| GET | `/api/history?period=` | 历史总览 |
| GET | `/api/days` | 有数据的日期列表 |
| GET | `/api/feeds?category=&preview=` | 热门榜单（hot/info/all） |
| GET | `/api/feeds/:key` | 单个数据源全量 |
| GET | `/api/nav?catelog=&keyword=` | 网站导航 |
| GET | `/api/ai?board=&keyword=` | AI 资源台 |
| GET | `/api/ai/detail?board=&name=` | 资源详情（含 markdown） |
| GET | `/api/repos?user=&sort=` | GitHub 用户仓库 |
| GET | `/api/creators` | 热门 GitHub 用户 |
| GET | `/api/dns?probe=1` | DNS 记录（probe=1 触发探活） |
| GET/POST | `/api/share` | 分享列表 / 创建分享 |
| GET | `/api/share/:sid` | 单条分享 |
| POST | `/api/crawl` | 手动触发抓取 |
| GET | `/api/health`、`/api/status` | 健康检查 / 运行状态 |
| POST | `/api/admin/login` | 后台登录 |
| GET | `/api/admin/stats`、`/api/admin/list` | 统计 / 列表 |
| POST | `/api/admin/create`、`/api/admin/delete` | 新增 / 删除 |

---

## 数据脚本

```bash
# 站点数据（导航 / AI 资源 / 创作者 / DNS）
node --env-file=.env scripts/seed-site.mjs sample   # 只看样例文档
node --env-file=.env scripts/seed-site.mjs          # 写入样例
node --env-file=.env scripts/seed-site.mjs clean    # 清空

# 从 navcockpit 的真实库导入（同集群的 tools 库）
node --env-file=.env scripts/import-from-navcockpit.mjs --dry
node --env-file=.env scripts/import-from-navcockpit.mjs

# 数据库迁移 / 跨集群迁移
node --env-file=.env scripts/migrate-db.mjs --target=xxx
node --env-file=.env scripts/migrate-to-vercel.mjs "<NEW_URI>" github_trending

# 性能诊断
node --env-file=.env scripts/perf-probe.mjs
node --env-file=.env scripts/compare-clusters.mjs "<URI>"
```

---

## 部署到 Vercel

### 1. 推送代码

```bash
git init
git add .
git commit -m "feat: 瞭望台"
git branch -M master
git remote add origin https://github.com/ice-a/trading.git
git push -u origin master
```

### 2. 在 Vercel 导入项目

1. 打开 https://vercel.com/new
2. 选择 **Import Git Repository** → 选 `ice-a/trading`
3. Framework Preset 自动识别为 **Nuxt**，构建命令不用改
4. Region 要和 MongoDB Atlas 集群同区域
   （`vercel.json` 里当前写的是 `sin1`，若 Atlas 在美区请改成 `iad1`）

### 3. 配置环境变量

Project Settings → Environment Variables，四个必填（Production + Preview 都勾上）：

| Key | Value |
| --- | --- |
| `MONGODB_URI` | `mongodb+srv://Vercel-Admin-...@atlas-bronze-door.ct968qe.mongodb.net/?retryWrites=true&w=majority` |
| `MONGODB_DB` | `github_trending` |
| `DISK_CACHE_DIR` | `/tmp` |
| `ADMIN_PASSWORD` | 你的后台密码 |

可选：`FEEDS_BASE`、`GITHUB_TOKEN`、`CF_API_TOKEN`、`CF_ZONE_IDS`、`APP_TIMEZONE`。

### 4. 放行数据库访问

Atlas 控制台 → **Network Access** → 添加 IP：

- 免费版常用：`0.0.0.0/0`（允许所有来源）
- 严谨做法：限制到 Vercel 出网 IP（需 Pro 版静态 IP）

### 5. 部署

点 **Deploy**，约 1~2 分钟。首次访问会触发冷启动 + 抓取，稍等几秒即可。

### 6. 配置定时抓取

`vercel.json` 已内置 Cron：

```json
"crons": [{ "path": "/api/crawl", "schedule": "0 * * * *" }]
```

> **Vercel Hobby（免费）计划的 Cron 每天只能跑一次**。要每小时抓取，二选一：
> - 升级 Pro，或
> - 用 **GitHub Actions** 定时打 `/api/crawl`（免费）

### 7. （可选）GitHub Actions 兜底定时

`.github/workflows/crawl.yml` 已包含，配两个 Secret：

| Secret | 值 |
| --- | --- |
| `SITE_URL` | `https://你的域名.vercel.app` |
| `CRON_SECRET` | 与 Vercel 环境变量里的 `CRON_SECRET` 一致 |

### 8. 部署后自检

```bash
curl https://你的域名.vercel.app/api/health
curl "https://你的域名.vercel.app/api/trending?period=weekly"
curl -X POST https://你的域名.vercel.app/api/crawl
```

---

## 其他部署方式

### 自建服务器 / Docker

```bash
npm run build
PORT=3000 node .output/server/index.mjs
```

常驻进程，`setInterval` 定时器自动生效，磁盘缓存也能落盘（`DISK_CACHE_DIR=.cache`）。

### Cloudflare Workers

**不建议**。workerd 没有原始 TCP socket，`mongodb` driver 依赖 `net`/`tls`；
即使开 `nodejs_compat` 能让握手成功，跨请求复用连接池也会被 runtime 判定 hung。
`wrangler.toml` 仅保留用于复现验证。

---

## 目录结构

```
app/
  app.vue                 # 全局外壳（AppHeader）
  components/
    AppHeader.vue         # 顶部导航
    AppPager.vue          # 分页器
    FeedCard.vue          # 热门榜单卡片（内容区可滚动）
    FeedTable.vue         # 表格视图（备用）
    TrendingTable.vue     # GitHub 榜单表格
    HitokotoBar.vue       # 一言
    PeriodSwitch.vue      # 日/周/月切换
    ShareButton.vue       # 卡片分享按钮
    RankBadge.vue         # 名次徽章
  pages/
    index.vue             # GitHub 榜单首页
    history.vue           # 历史榜单
    v2/index.vue          # 热门榜单
    v2/[key].vue          # 数据源详情
    nav.vue  ai.vue  github.vue  avatar.vue  dns.vue
    share.vue  s/[sid].vue
    admin.vue
    ai/tutorial/[name].vue
server/
  api/                    # Nitro 接口
  utils/
    cache.ts              # 两级缓存（内存 + 磁盘）
    mongo.ts              # 连接与索引
    crawler.ts            # 抓取编排（日/周/月）
    trending.ts           # GitHub Trending 解析
    store.ts              # 榜单读写
    feeds.ts              # 外部数据源抓取与归一化
    site.ts               # 导航/AI/创作者/DNS/分享数据层
  plugins/scheduler.ts    # 定时任务 + 预热
  config/feeds.ts         # 数据源清单
scripts/                  # 运维脚本（seed / migrate / perf）
```

---

## 常见问题

**Q：Vercel 上首屏很慢？**
A：Serverless 冷启动会重连数据库。设 `DISK_CACHE_DIR=/tmp`，并确保 Vercel region
和 Atlas 集群同区域。页面级 SWR 会让绝大多数用户命中 CDN 缓存，不触发函数。

**Q：榜单不更新？**
A：先 `curl -X POST /api/crawl` 看返回，再查 `/api/status`。免费版 Vercel Cron 每天只能跑一次，
需要每小时更新请用 GitHub Actions。

**Q：`/dns` 显示「本地缓存」？**
A：说明没配 `CF_API_TOKEN` / `CF_ZONE_IDS`，配好后自动切到 Cloudflare 实时数据。

**Q：历史榜单是空的？**
A：`trending_repos` 按日期累积，新部署只有当天数据，之后每天自然增长。

**Q：换数据库要重抓吗？**
A：不用。用 `scripts/migrate-to-vercel.mjs` 整库迁移，索引会一并重建。
