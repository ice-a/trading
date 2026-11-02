# archive/mongo —— 已弃用的 MongoDB 迁移与诊断脚本

2026-11 重构前的历史留档。当前架构只有 Cloudflare D1，这些脚本**不再被任何代码引用**，
也不会进入构建产物。

| 文件 | 原本用途 |
| --- | --- |
| `migrate-atlas-to-d1.mjs` | Atlas → D1 一次性迁移（产出 SQL） |
| `atlas-export.sql` | 该迁移的产物快照（已灌入 D1） |
| `migrate-db.mjs` / `migrate-to-vercel.mjs` | 跨集群 / 跨平台搬迁 |
| `check-db*.mjs` / `compare-clusters.mjs` / `inspect-remote-db.mjs` | 连接与分片诊断 |
| `bench-feeds.mjs` / `perf-probe.mjs` | 读写性能探针 |
| `seed-site.mjs` / `seed-history.mjs` / `import-from-navcockpit.mjs` | 站点数据播种与导入 |
| `test-drop.mjs` / `test-history.mjs` | 掉榜 / 历史逻辑回归 |

需要新库种子数据时，直接写 SQL 并 `wrangler d1 execute --file=...`，
不要再把这些脚本接回主链路（它们依赖 `mongodb` 驱动，而该依赖已从 package.json 移除）。
