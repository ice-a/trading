# archive/dev-scripts —— 一次性 UI / 网络调试脚本

都是重构前为了定位具体页面问题临时写的 CDP（Chrome DevTools Protocol）脚本，
**不属于构建与运行时链路**，也不在 npm scripts 里。

| 文件 | 原本查的问题 |
| --- | --- |
| `check-foot.mjs` | 首页表格底部 `.foot` 被压成竖条 |
| `check-scroll.mjs` | 卡片内滚动区域高度异常 |
| `inspect-layout.mjs` | 页面整体布局测量 |
| `inspect-nav-error.mjs` | 客户端导航 `/` → `/v2` 控制台报错 |
| `measure-nav.mjs` | SPA 路由切换耗时 |
| `diagnose-history.mjs` | `/history` → `/` 导航卡住 |
| `check-trending-proxy.mjs` | 带代理抓 GitHub（依赖已移除的 undici ProxyAgent） |

需要重新排查同类问题时，直接照抄其中的 CDP 启动方式即可；
跑不起来是正常的——它们依赖本机 Chrome，且不保证与当前页面结构匹配。
