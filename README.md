# 观澜志 · GitHub 日榜简报

> GitHub Trending 日/周/月榜 + GitHub 用户查询 + 个性头像 + 历史榜单。

**纯静态站点**：Nuxt 4 构建成 SPA，托管在 **GitHub Pages** —— 没有服务器、没有数据库。
数据由 GitHub Actions 每小时抓取并写成静态 JSON，随站点一起发布。

---

## 功能

| 路由 | 说明 | 数据来源 |
| --- | --- | --- |
| `/` | GitHub 日/周/月榜，按日期留存，掉榜不删 | `public/data/bundle.json` |
| `/github` | 查任意 GitHub 用户的公开仓库 / 全站搜索 | 浏览器直连 GitHub API |
| `/avatar` | 个性头像生成器（seed 可复现、4 种风格、导出 PNG） | 纯前端 SVG |
| `/history` | 历史榜单时间线 + 当日完整榜单 | `public/data/bundle.json` |
| 顶栏一言 | 自动轮换短句 | v1.hitokoto.cn（失败本地兜底） |

---

## 技术栈

| 层 | 选型 |
| --- | --- |
| 框架 | Nuxt 4（Vue 3 SPA，`ssr:false`，Nitro `static` preset） |
| 数据 | 构建期生成的 `public/data/bundle.json`（历史 + 掉榜语义都在里面） |
| 抓取 | GitHub Actions 定时跑 `cheerio/slim` 解析 GitHub Trending |
| 托管 | GitHub Pages（免费、无运维、自带 HTTPS + CDN） |

---

## 工作原理

```
GitHub Actions  pages.yml（每小时 + push + 手动触发，一条龙）：
  抓 GitHub Trending 三榜 → 合并历史/掉榜 → 写 public/data/bundle.json
  → commit 回 master → npm ci + build → 部署到 GitHub Pages
```

抓取和部署放在同一 workflow 里：GITHUB_TOKEN 的 push 不会触发别的 workflow，
拆成两个的话新数据不会重新部署，所以合并。

`server/` 目录保留作历史参考，**静态站不依赖它**；前端已全部改为直读 JSON / 直连外部 API。

---

## 部署到 GitHub Pages（一次配置）

### 1. 开启 Pages
仓库 **Settings → Pages → Build and deployment**：
- Source 选 **GitHub Actions**。

### 2. 配 baseURL（二选一）

**A. 项目站**（`https://<user>.github.io/trading/`）：不用配，workflow 自动用 `/trading/`。

**B. 自定义域名**（推荐，走根路径 `/`）：
在 **Settings → Secrets and variables → Actions → Variables** 新增：
- `CNAME` = 你的域名（如 `guanlan.example.com`）

workflow 会自动把 baseURL 设为 `/` 并把域名写进产物。

### 3. 可选变量
同在 Variables 里可按需要覆盖：
`APP_TIMEZONE`(默认 `Asia/Shanghai`)、`TOP_N`(10)、`PAGE_SIZE`(10)、`TRENDING_LANGUAGE`(空=全部)、`UPDATE_INTERVAL_MINUTES`(60)。

### 4. 首次触发
把代码 push 到 `master`，或手动跑一次 **Actions → pages → Run workflow**。
之后 `pages.yml` 每小时自动抓数据并重新部署。

### 5. 自定义域名 DNS（如果用了 B）
在域名服务商处，二选一：

| 域名类型 | 记录 | 值 |
| --- | --- | --- |
| 子域名 `abc.example.com` | CNAME → | `<user>.github.io` |
| 根域名 `example.com` | A（4 条）→ | `185.199.108.153` / `.109` / `.110` / `.111` |

再回到 **Settings → Pages → Custom domain** 填域名 → Save → 勾选 **Enforce HTTPS**。
> 注意：即使 workflow 写了 CNAME 文件，也仍需在 Pages 设置里填一次域名，HTTPS 才会生效。

---

## 本地开发

```bash
npm install
npm run gen:data     # 抓一次数据，写 public/data/bundle.json（首次已有示例数据）
npm run dev          # http://localhost:3000
```

`bundle.json` 已随仓库提交了一份初始数据，直接 `npm run dev` 也能看。

| 命令 | 说明 |
| --- | --- |
| `npm run dev` | 开发（热更新） |
| `npm run build` | 构建静态产物到 `.output/public`（`BASE_PATH` 可设子路径） |
| `npm run gen:data` | 抓 GitHub Trending 并更新 `bundle.json` |
| `npm run typecheck` | server + app 类型检查 |

---

## 数据文件结构

`public/data/bundle.json`：
```jsonc
{
  "generatedAt": "ISO 时间",
  "meta": { "topN": 10, "pageSize": 10, "intervalMinutes": 60, "today": "YYYY-MM-DD", ... },
  "days": [
    {
      "date": "YYYY-MM-DD",
      "humanDate": "2026年11月16日 周一",
      "periods": {
        "daily":   { /* TrendingResponse: items / stats / days / updatedAt ... */ },
        "weekly":  { ... },
        "monthly": { ... }
      }
    }
  ]
}
```

前端 `app/utils/staticData.ts` 把它转成页面需要的结构，渲染逻辑基本不变。

---

## 常见问题

**Q：为什么不用服务器/SQLite 了？**
GitHub Pages 只托管静态文件。要零运维和免费，就把数据生成挪到构建期（Actions），前端读静态 JSON。

**Q：数据多久更新？**
`pages.yml` 每小时跑一次（抓取+部署）。注意 GitHub 的定时任务**不保证准点**，高峰可能延迟几十分钟；仓库 60 天无提交会暂停定时任务。

**Q：`/github` 页的 Token 存哪？**
只存在浏览器 localStorage，请求时直连 GitHub，不经过任何第三方服务器。

**Q：首页「刷新」按钮现在做什么？**
静态站没有可抓的后端，刷新 = 清前端缓存并重读一次 `bundle.json`（破浏览器缓存）。真正的数据更新由 Actions 定时完成。

**Q：还能部署到自己的小服务器吗？**
`server/` 目录和 `deploy/`（systemd/Caddy）配置仍保留，但当前 `nuxt.config.ts` 已切到静态 SPA + `static` preset。若要回到 SSR 单机，需要把 `ssr` 改回 `true`、preset 改回 `node-server`，并恢复页面的 `/api/*` 调用。
