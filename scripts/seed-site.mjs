/**
 * 站点数据种子：网站导航 / AI 资源台 / GitHub 创作者 / DNS 缓存。
 *
 * 用法：
 *   node --env-file=.env scripts/seed-site.mjs          # 写入样例数据（幂等 upsert）
 *   node --env-file=.env scripts/seed-site.mjs clean    # 清空这 6 个集合
 *   node --env-file=.env scripts/seed-site.mjs sample   # 只打印样例文档，不写库
 *
 * 所有数据都落在同一个库（MONGODB_DB）里的独立集合，不影响 GitHub 榜单。
 */
import { MongoClient } from 'mongodb'

const uri = process.env.MONGODB_URI
const dbName = process.env.MONGODB_DB || 'github_trending'
const mode = process.argv[2] || 'seed'

/* ============================================================
 * 1. 网站导航分类 nav_categories
 *    group = 左侧大类的展示分组；key 与 nav_links.catelog 对应
 * ========================================================== */
const CATEGORIES = [
  { key: 'browser-ext', name: '浏览器扩展', group: '效率工具', icon: '🧩', sort: 10 },
  { key: 'download', name: '下载工具', group: '效率工具', icon: '⬇️', sort: 20 },
  { key: 'capture', name: '截图录屏', group: '效率工具', icon: '📸', sort: 30 },
  { key: 'clipboard', name: '剪贴板', group: '效率工具', icon: '📋', sort: 40 },

  { key: 'online-tools', name: '在线工具', group: '开发工具', icon: '🧰', sort: 110 },
  { key: 'api-debug', name: 'API 调试', group: '开发工具', icon: '🔌', sort: 120 },
  { key: 'regex', name: '正则表达式', group: '开发工具', icon: '🔤', sort: 130 },
  { key: 'json', name: 'JSON 处理', group: '开发工具', icon: '🧾', sort: 140 },

  { key: 'official-docs', name: '官方文档', group: '文档资料', icon: '📘', sort: 210 },
  { key: 'handbook', name: '技术手册', group: '文档资料', icon: '📗', sort: 220 },
  { key: 'tutorial', name: '教程合集', group: '文档资料', icon: '🎓', sort: 230 },

  { key: 'ai-chat', name: 'AI 对话', group: 'AI 工具', icon: '💬', sort: 310 },
  { key: 'ai-code', name: 'AI 编程', group: 'AI 工具', icon: '🤖', sort: 320 },
  { key: 'ai-image', name: 'AI 绘图', group: 'AI 工具', icon: '🎨', sort: 330 },

  { key: 'community', name: '技术社区', group: '资源社区', icon: '💬', sort: 410 },
  { key: 'nav-site', name: '导航站', group: '资源社区', icon: '🧭', sort: 420 },
  { key: 'proxy', name: '代理节点', group: '网络代理', icon: '🛡️', sort: 510 }
]

/* ============================================================
 * 2. 网站导航站点 nav_links
 *    catelog 指向 CATEGORIES.key；group 冗余存大类便于筛选
 * ========================================================== */
const LINKS = [
  // 浏览器扩展
  { name: 'Tampermonkey', url: 'https://www.tampermonkey.net/', catelog: 'browser-ext', desc: '最流行的用户脚本管理器，装脚本就像装插件', icon: '🐒' },
  { name: 'uBlock Origin', url: 'https://github.com/gorhill/uBlock', catelog: 'browser-ext', desc: '轻量高效的广告与追踪拦截扩展', icon: '🛡️' },
  { name: 'Immersive Translate', url: 'https://immersivetranslate.com/', catelog: 'browser-ext', desc: '沉浸式网页双语对照翻译', icon: '🌐' },
  { name: 'Header Editor', url: 'https://github.com/FirefoxBar/HeaderEditor', catelog: 'browser-ext', desc: '自定义 HTTP 请求/响应头，改 UA 改 Referer', icon: '🧾' },

  // 下载
  { name: 'Motrix', url: 'https://motrix.app/', catelog: 'download', desc: '全能的下载工具，支持 HTTP/BT/磁力', icon: '⬇️' },
  { name: 'yt-dlp', url: 'https://github.com/yt-dlp/yt-dlp', catelog: 'download', desc: '命令行视频下载神器，支持上千站点', icon: '🎬' },
  { name: 'N_m3u8DL-RE', url: 'https://github.com/nilaoda/N_m3u8DL-RE', catelog: 'download', desc: '跨平台流媒体下载器，支持 m3u8/MPD', icon: '📺' },

  // 截图录屏
  { name: 'Snipaste', url: 'https://www.snipaste.com/', catelog: 'capture', desc: '贴图式截图工具，截图后钉在屏幕上', icon: '📌' },
  { name: 'ScreenToGif', url: 'https://www.screentogif.com/', catelog: 'capture', desc: '录制屏幕并逐帧编辑导出 GIF', icon: '🎞️' },
  { name: 'PixPin', url: 'https://pixpin.cn/', catelog: 'capture', desc: '截图 / 贴图 / OCR / 长截图一体的新工具', icon: '✂️' },

  // 剪贴板
  { name: 'Ditto', url: 'https://ditto-cp.sourceforge.io/', catelog: 'clipboard', desc: 'Windows 剪贴板历史管理，支持搜索与同步', icon: '📋' },
  { name: 'Maccy', url: 'https://maccy.app/', catelog: 'clipboard', desc: 'macOS 轻量剪贴板历史工具', icon: '🍎' },

  // 在线工具
  { name: 'Carbon', url: 'https://carbon.now.sh/', catelog: 'online-tools', desc: '把代码变成漂亮的分享图片', icon: '🖼️' },
  { name: 'IT-Tools', url: 'https://it-tools.tech/', catelog: 'online-tools', desc: '开发者常用小工具合集，纯前端运行', icon: '🧰' },
  { name: 'Crontab Guru', url: 'https://crontab.guru/', catelog: 'online-tools', desc: '可视化的 cron 表达式解释器', icon: '⏰' },
  { name: 'CyberChef', url: 'https://gchq.github.io/CyberChef/', catelog: 'online-tools', desc: '编码解码 / 加解密 / 数据分析的瑞士军刀', icon: '🔪' },

  // API 调试
  { name: 'Hoppscotch', url: 'https://hoppscotch.io/', catelog: 'api-debug', desc: '开源的轻量 API 调试工具，替代 Postman', icon: '🚀' },
  { name: 'Apifox', url: 'https://apifox.com/', catelog: 'api-debug', desc: '接口设计 / 调试 / 测试 / Mock 一体', icon: '🐝' },
  { name: 'Bruno', url: 'https://www.usebruno.com/', catelog: 'api-debug', desc: '离线优先的 API 客户端，数据存在本地', icon: '🧪' },

  // 正则
  { name: 'Regex101', url: 'https://regex101.com/', catelog: 'regex', desc: '正则在线调试，实时解释每个分组的含义', icon: '🔤' },
  { name: 'Regulex', url: 'https://jex.im/regulex/', catelog: 'regex', desc: '把正则表达式画成可视化的铁路图', icon: '🚉' },

  // JSON
  { name: 'JSON Hero', url: 'https://jsonhero.io/', catelog: 'json', desc: '阅读友好、支持搜索的 JSON 浏览器', icon: '🧾' },
  { name: 'JSON Crack', url: 'https://jsoncrack.com/', catelog: 'json', desc: '把 JSON 可视化成节点图', icon: '🕸️' },

  // 官方文档
  { name: 'MDN Web Docs', url: 'https://developer.mozilla.org/', catelog: 'official-docs', desc: 'Web 标准的权威参考', icon: '📘' },
  { name: 'Node.js 文档', url: 'https://nodejs.org/docs/latest/api/', catelog: 'official-docs', desc: 'Node.js 官方 API 文档', icon: '🟩' },
  { name: 'Vue 3 文档', url: 'https://cn.vuejs.org/', catelog: 'official-docs', desc: 'Vue 3 中文官方文档', icon: '💚' },
  { name: 'Nuxt 文档', url: 'https://nuxt.com/docs', catelog: 'official-docs', desc: 'Nuxt 官方文档', icon: '⛰️' },
  { name: 'MongoDB 手册', url: 'https://www.mongodb.com/docs/manual/', catelog: 'official-docs', desc: 'MongoDB 官方参考手册', icon: '🍃' },

  // 技术手册
  { name: 'Docker 文档', url: 'https://docs.docker.com/', catelog: 'handbook', desc: 'Docker 官方文档与最佳实践', icon: '🐳' },
  { name: 'Kubernetes 文档', url: 'https://kubernetes.io/zh-cn/docs/', catelog: 'handbook', desc: 'K8s 中文文档', icon: '☸️' },
  { name: 'Redis 命令参考', url: 'https://redis.io/commands/', catelog: 'handbook', desc: 'Redis 全量命令速查', icon: '🔴' },

  // 教程
  { name: 'freeCodeCamp', url: 'https://www.freecodecamp.org/', catelog: 'tutorial', desc: '免费的全栈编程课程与认证', icon: '🔥' },
  { name: 'JavaScript.info', url: 'https://zh.javascript.info/', catelog: 'tutorial', desc: '现代 JavaScript 教程，中文版', icon: '📖' },
  { name: 'TypeScript 入门', url: 'https://www.typescriptlang.org/docs/handbook/', catelog: 'tutorial', desc: 'TS 官方手册', icon: '🔷' },

  // AI 对话
  { name: 'ChatGPT', url: 'https://chat.openai.com/', catelog: 'ai-chat', desc: 'OpenAI 官方对话产品', icon: '💬' },
  { name: 'Claude', url: 'https://claude.ai/', catelog: 'ai-chat', desc: 'Anthropic 的对话助手，擅长长文本', icon: '🧠' },
  { name: 'DeepSeek', url: 'https://chat.deepseek.com/', catelog: 'ai-chat', desc: '国产大模型对话平台', icon: '🐋' },
  { name: 'Kimi', url: 'https://kimi.moonshot.cn/', catelog: 'ai-chat', desc: '月之暗面的长文档阅读助手', icon: '🌙' },

  // AI 编程
  { name: 'GitHub Copilot', url: 'https://github.com/features/copilot', catelog: 'ai-code', desc: 'IDE 内的 AI 代码补全', icon: '🤖' },
  { name: 'Cursor', url: 'https://cursor.com/', catelog: 'ai-code', desc: '为 AI 编程重新设计的编辑器', icon: '🖱️' },
  { name: 'Cline', url: 'https://github.com/cline/cline', catelog: 'ai-code', desc: 'VS Code 里的自主编码 Agent', icon: '🧗' },

  // AI 绘图
  { name: 'Midjourney', url: 'https://www.midjourney.com/', catelog: 'ai-image', desc: '文生图标杆产品', icon: '🚣' },
  { name: 'Stable Diffusion', url: 'https://stability.ai/', catelog: 'ai-image', desc: '开源图像生成模型', icon: '🎨' },
  { name: 'ComfyUI', url: 'https://github.com/comfyanonymous/ComfyUI', catelog: 'ai-image', desc: '节点式 SD 工作流编辑器', icon: '🧩' },

  // 技术社区
  { name: 'GitHub', url: 'https://github.com/', catelog: 'community', desc: '全球最大的代码托管平台', icon: '🐙' },
  { name: 'Stack Overflow', url: 'https://stackoverflow.com/', catelog: 'community', desc: '编程问答社区', icon: '📚' },
  { name: 'V2EX', url: 'https://www.v2ex.com/', catelog: 'community', desc: '创意工作者的社区', icon: '🅥' },
  { name: 'Hacker News', url: 'https://news.ycombinator.com/', catelog: 'community', desc: '技术圈新闻与讨论', icon: '🧡' },

  // 导航站
  { name: '领航舱 NavCockpit', url: 'https://020417.xyz/', catelog: 'nav-site', desc: '本项目的参考实现，五大板块导航台', icon: '🧭' },
  { name: 'WebStack', url: 'https://webstack.cc/', catelog: 'nav-site', desc: '开源的网址导航主题', icon: '🗂️' },

  // 代理
  { name: 'Clash Verge Rev', url: 'https://github.com/clash-verge-rev/clash-verge-rev', catelog: 'proxy', desc: '跨平台 Clash 图形客户端', icon: '🐱' },
  { name: 'sing-box', url: 'https://sing-box.sagernet.org/', catelog: 'proxy', desc: '通用代理平台，支持多种协议', icon: '📦' }
]

/* ============================================================
 * 3. AI 资源台板块 ai_boards
 * ========================================================== */
const AI_BOARDS = [
  { key: 'stations', name: '中转站', icon: '☁️', sort: 0 },
  { key: 'tools', name: '工具', icon: '🧰', sort: 1 },
  { key: 'skills', name: 'Skills', icon: '🧩', sort: 2 },
  { key: 'vpns', name: 'VPN', icon: '🛡️', sort: 3 },
  { key: 'servers', name: 'AI 直连平台', icon: '⚡', sort: 4 },
  { key: 'tutorials', name: '教程', icon: '📄', sort: 5 }
]

/* ============================================================
 * 4. AI 资源台条目 ai_items
 *    models = 支持的模型清单；ratio = 计费倍率
 * ========================================================== */
const AI_ITEMS = [
  { board: 'stations', name: '小蚯蚓', url: 'https://api.xiaohui.example', ratio: '0.05x', models: 'gpt-5.5-turbo / gpt-4', tags: ['低价', '稳定'], sort: 10 },
  { board: 'stations', name: '悠悠', url: 'https://api.youyou.example', ratio: '0.07x', models: 'gpt-5.4 / gpt-5.5 / gpt-5.4-mini / gpt-5.4-nano', tags: ['全模型'], sort: 20 },
  { board: 'stations', name: 'cooioo', url: 'https://api.cooioo.example', ratio: '0.06x', models: 'gpt-5.5-codex-spark / gpt-5.4-mini / gpt-5.4 / gpt-5.4-term', tags: ['Codex'], sort: 30 },
  { board: 'stations', name: 'gateai', url: 'https://api.gateai.example', ratio: '0.04x', models: 'gpt-5.4 / gpt-5.3-codex / gpt-5.3-term / gpt-5.4-mini', tags: ['性价比'], sort: 40 },
  { board: 'stations', name: 'codex666ai', url: 'https://api.codex666.example', ratio: '0.06x', models: 'codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.3-codex', tags: ['Codex'], sort: 50 },
  { board: 'stations', name: 'ai 快速', url: 'https://api.fast.example', ratio: '0.05x', models: 'gpt-5.3-codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.5-open', tags: ['低延迟'], sort: 60 },
  { board: 'stations', name: '一坨轮', url: 'https://api.lun.example', ratio: '0.07x', models: 'gpt-5.4 / gpt-5.3-codex-spark / gpt-5.4-mini / gpt-5.5-openai-compact', tags: ['轮询'], sort: 70 },
  { board: 'stations', name: 'agentrouter', url: 'https://api.agentrouter.example', ratio: '0.08x', models: 'gpt-5.5-turbo / gpt-4', tags: ['需邀请码'], sort: 80 },

  { board: 'tools', name: 'Cherry Studio', url: 'https://cherry-ai.com/', desc: '支持多模型的桌面 AI 客户端', tags: ['桌面端'], sort: 10 },
  { board: 'tools', name: 'Chatbox', url: 'https://chatboxai.app/', desc: '跨平台 AI 对话客户端，支持本地模型', tags: ['客户端'], sort: 20 },
  { board: 'tools', name: 'Open WebUI', url: 'https://openwebui.com/', desc: '自托管的 LLM 交互界面', tags: ['自托管'], sort: 30 },
  { board: 'tools', name: 'LobeChat', url: 'https://lobehub.com/', desc: '现代设计的开源 AI 聊天框架', tags: ['开源'], sort: 40 },

  { board: 'skills', name: 'Anthropic Skills', url: 'https://github.com/anthropics/skills', desc: '官方 Skills 仓库，可直接装进 Claude', tags: ['官方'], sort: 10 },
  { board: 'skills', name: 'awesome-claude-skills', url: 'https://github.com/travisvn/awesome-claude-skills', desc: '社区整理的 Skills 合集', tags: ['合集'], sort: 20 },
  { board: 'skills', name: 'SCI Skills', url: 'https://github.com/skills-sci', desc: '科研场景的 Agent Skills 集合', tags: ['科研'], sort: 30 },

  { board: 'vpns', name: 'Cloudflare WARP', url: 'https://1.1.1.1/', desc: '免费且速度不错的 WireGuard 隧道', tags: ['免费'], sort: 10 },
  { board: 'vpns', name: 'Tailscale', url: 'https://tailscale.com/', desc: '基于 WireGuard 的零配置组网', tags: ['组网'], sort: 20 },

  { board: 'servers', name: 'SiliconFlow', url: 'https://siliconflow.cn/', desc: '国内直连的大模型推理平台', tags: ['国内直连'], sort: 10 },
  { board: 'servers', name: 'OpenRouter', url: 'https://openrouter.ai/', desc: '一个 Key 调用上百个模型', tags: ['聚合'], sort: 20 },
  { board: 'servers', name: 'Together AI', url: 'https://www.together.ai/', desc: '开源模型托管与推理', tags: ['开源模型'], sort: 30 },

  { board: 'tutorials', name: '从零搭建 AI 中转', url: 'https://github.com/', desc: '用 one-api / new-api 自建中转站的完整流程', tags: ['入门'], sort: 10 },
  { board: 'tutorials', name: 'Claude Code 上手指南', url: 'https://docs.anthropic.com/', desc: '终端里的 AI 编程助手使用要点', tags: ['CLI'], sort: 20 }
]

/* ============================================================
 * 5. 热门 GitHub 用户 github_creators
 * ========================================================== */
const CREATORS = [
  { login: 'gaearon', note: 'React 核心' },
  { login: 'yyx990803', note: 'Vue / Vite 作者' },
  { login: 'tj', note: '前端生态老兵' },
  { login: 'sindresorhus', note: 'npm 包之王' },
  { login: 'antfu', note: 'Anthony Fu' },
  { login: 'shadcn', note: 'shadcn/ui' },
  { login: 'tannerlinsley', note: 'TanStack 作者' },
  { login: 'Rich-Harris', note: 'Svelte 作者' },
  { login: 'kentcdodds', note: 'Testing Library' },
  { login: 'tjmlabs', note: 'AI 工具' },
  { login: 'vercel', note: 'Vercel 官方' },
  { login: 'nodejs', note: 'Node.js 官方' },
  { login: 'microsoft', note: '微软官方' },
  { login: 'google', note: 'Google 官方' },
  { login: 'torvalds', note: 'Linus' },
  { login: 'ruanyf', note: '阮一峰' },
  { login: 'youngjuning', note: '前端工程化' },
  { login: 'sorrycc', note: 'Umi / Farm' },
  { login: 'xiaoyifang', note: 'GoldenDict-ng' },
  { login: 'DIYgod', note: 'RSSHub 作者' }
]

/* ============================================================
 * 6. DNS 记录缓存 dns_records
 *    status / latencyMs 由探活任务更新，也可以手工填
 * ========================================================== */
const DNS_RECORDS = [
  { name: '领航舱·个人导航与工具箱', host: '020417.xyz', type: 'A', target: '104.21.x.x', proxied: true, status: 'online', latencyMs: 715 },
  { name: '领航舱·个人导航与工具箱', host: 'www.020417.xyz', type: 'CNAME', target: '020417.xyz', proxied: true, status: 'online', latencyMs: 368 },
  { name: 'CTFever Toolkit by unlem', host: 'cf.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 798 },
  { name: 'WallMuse', host: 'book.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 1198 },
  { name: 'Umami', host: 'cloud.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 427 },
  { name: '导航卡片', host: 'nav.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 1208 },
  { name: '题库系统 - Question Bank', host: 'sub.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 693 },
  { name: 'AI 资源台', host: 'web.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 214 },
  { name: '文章 Markdown 归档', host: 'blog.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 1134 },
  { name: 'game', host: 'game.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 1283 },
  { name: '60 秒读懂世界', host: '60.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'online', latencyMs: 2396 },
  { name: 'Wave Example', host: 'wave.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'offline', httpStatus: 403, latencyMs: 3072 },
  { name: 'bt', host: 'bt.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'offline', httpStatus: 404, latencyMs: 0 },
  { name: 'just-a-moment', host: 'fs.020417.xyz', type: 'CNAME', target: 'cname.020417.xyz', proxied: true, status: 'offline', httpStatus: 403, latencyMs: 0 }
]

const SAMPLE = {
  nav_categories: CATEGORIES.slice(0, 3),
  nav_links: LINKS.slice(0, 3),
  ai_boards: AI_BOARDS.slice(0, 2),
  ai_items: AI_ITEMS.slice(0, 3),
  github_creators: CREATORS.slice(0, 3),
  dns_records: DNS_RECORDS.slice(0, 2)
}

if (mode === 'sample') {
  console.log(JSON.stringify(SAMPLE, null, 2))
  process.exit(0)
}

const client = new MongoClient(uri, { serverSelectionTimeoutMS: 25000, appName: 'seed-site' })

try {
  await client.connect()
  const db = client.db(dbName)
  console.log(`库：${db.databaseName}\n`)

  if (mode === 'clean') {
    for (const name of ['nav_categories', 'nav_links', 'ai_boards', 'ai_items', 'github_creators', 'dns_records']) {
      const r = await db.collection(name).deleteMany({})
      console.log(`  清空 ${name}: ${r.deletedCount} 条`)
    }
    process.exit(0)
  }

  const groupOf = new Map(CATEGORIES.map((c) => [c.key, c.group]))

  // 分类
  const catOps = CATEGORIES.map((c) => ({
    updateOne: {
      filter: { key: c.key },
      update: { $set: { ...c, status: 'active', updatedAt: new Date() }, $setOnInsert: { createdAt: new Date() } },
      upsert: true
    }
  }))
  const catRes = await db.collection('nav_categories').bulkWrite(catOps, { ordered: false })
  console.log(`nav_categories  写入 ${catRes.upsertedCount + catRes.modifiedCount} 条（共 ${CATEGORIES.length}）`)

  // 站点
  const linkOps = LINKS.map((l, i) => ({
    updateOne: {
      filter: { url: l.url },
      update: {
        $set: {
          ...l,
          group: groupOf.get(l.catelog || '') || '其他',
          sort: i * 10,
          status: 'active',
          updatedAt: new Date()
        },
        $setOnInsert: { createdAt: new Date() }
      },
      upsert: true
    }
  }))
  const linkRes = await db.collection('nav_links').bulkWrite(linkOps, { ordered: false })
  console.log(`nav_links       写入 ${linkRes.upsertedCount + linkRes.modifiedCount} 条（共 ${LINKS.length}）`)

  // AI 板块
  const boardOps = AI_BOARDS.map((b) => ({
    updateOne: {
      filter: { key: b.key },
      update: { $set: { ...b, status: 'active', updatedAt: new Date() }, $setOnInsert: { createdAt: new Date() } },
      upsert: true
    }
  }))
  const boardRes = await db.collection('ai_boards').bulkWrite(boardOps, { ordered: false })
  console.log(`ai_boards       写入 ${boardRes.upsertedCount + boardRes.modifiedCount} 条（共 ${AI_BOARDS.length}）`)

  // AI 条目
  const itemOps = AI_ITEMS.map((it) => ({
    updateOne: {
      filter: { board: it.board, name: it.name },
      update: { $set: { ...it, status: 'active', updatedAt: new Date() }, $setOnInsert: { createdAt: new Date() } },
      upsert: true
    }
  }))
  const itemRes = await db.collection('ai_items').bulkWrite(itemOps, { ordered: false })
  console.log(`ai_items        写入 ${itemRes.upsertedCount + itemRes.modifiedCount} 条（共 ${AI_ITEMS.length}）`)

  // 创作者
  const creatorOps = CREATORS.map((c, i) => ({
    updateOne: {
      filter: { login: c.login },
      update: { $set: { ...c, sort: i * 10 }, $setOnInsert: { createdAt: new Date() } },
      upsert: true
    }
  }))
  const creatorRes = await db.collection('github_creators').bulkWrite(creatorOps, { ordered: false })
  console.log(`github_creators 写入 ${creatorRes.upsertedCount + creatorRes.modifiedCount} 条（共 ${CREATORS.length}）`)

  // DNS
  const dnsOps = DNS_RECORDS.map((d) => ({
    updateOne: {
      filter: { host: d.host },
      update: { $set: { ...d, updatedAt: new Date() }, $setOnInsert: { createdAt: new Date() } },
      upsert: true
    }
  }))
  const dnsRes = await db.collection('dns_records').bulkWrite(dnsOps, { ordered: false })
  console.log(`dns_records     写入 ${dnsRes.upsertedCount + dnsRes.modifiedCount} 条（共 ${DNS_RECORDS.length}）`)

  console.log('\n完成。运行 `node --env-file=.env scripts/seed-site.mjs sample` 可只看样例文档。')
} catch (err) {
  console.error('✗ 失败:', err?.message || err)
  process.exitCode = 1
} finally {
  await client.close()
}
