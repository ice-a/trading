# archive/cloudflare —— 已弃用的 Cloudflare 部署形态

2026-11 之前的架构：Nuxt 编译成 Cloudflare Worker，数据落 D1，抓取外包给 GitHub Actions。
后来改为**单机部署**（Node 进程 + 本地 SQLite + Caddy），这些文件不再被任何代码引用。

| 文件 | 原本用途 |
| --- | --- |
| `ci-crawl.mjs` | CI 抓取执行器：起一份 node 产物，POST `/api/crawl` 写 D1 REST |
| `smoke-preload.mjs` | 本地冒烟：用 `node:sqlite` 造一个内存 D1，替代 workerd |

为什么要留档：里面关于「Workers 免费版 10ms CPU 跑不完 cheerio」「D1 REST 批量写入怎么分批」
的判断依然有效，将来若有人想把项目重新搬回边缘运行时，这些是现成的参考。

当前形态见根目录 README「部署到 1 核 1G 服务器」。
