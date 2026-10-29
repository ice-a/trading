import { defineNuxtConfig } from 'nuxt/config'

/**
 * mongodb driver 用 try/catch 动态 require 了一批"可选依赖"
 * （AWS IAM 认证、GCP、snappy/zstd 压缩、Kerberos、客户端加密）。
 *
 * Node 服务器构建时这些是 external，不参与打包，相安无事；
 * 但 Cloudflare / 边缘构建要求全部 inline，rollup 解析不到就会直接报错
 * （"Cannot resolve @aws-sdk/credential-providers ... externals are not allowed"）。
 *
 * 本项目只用账号密码认证，不涉及上面任何特性，所以统一 stub 成空模块。
 */
const OPTIONAL_MONGO_DEPS = [
  '@aws-sdk/credential-providers',
  'gcp-metadata',
  'snappy',
  'aws4',
  'mongodb-client-encryption',
  'kerberos',
  '@mongodb-js/zstd'
]

function stubOptionalMongoDeps() {
  const isStubbed = (id: string) =>
    OPTIONAL_MONGO_DEPS.some((dep) => id === dep || id.startsWith(`${dep}/`))

  return {
    name: 'stub-optional-mongo-deps',
    enforce: 'pre' as const,
    resolveId(id: string) {
      if (isStubbed(id)) return `\0stub:${id}`
      return null
    },
    load(id: string) {
      if (id.startsWith('\0stub:')) {
        // 空模块：driver 只在对应特性被启用时才会真正调用它
        return 'export default {}'
      }
      return null
    }
  }
}

/**
 * 更新频率、数据库地址全部来自环境变量（.env / 部署平台注入）。
 * 这里只做「读环境变量 → 塞进 runtimeConfig」的桥接，不写死任何值。
 *
 * 部署到 Vercel / Cloudflare 时无需改这个文件：
 *   Vercel     → npx nuxi build --preset vercel（或 VERCEL=1 自动识别）
 *   Cloudflare → npx nuxi build --preset cloudflare-pages / cloudflare-module
 */
export default defineNuxtConfig({
  compatibilityDate: '2025-01-01',
  devtools: { enabled: false },
  // 开发环境可用 NUXT_SSR=false 强制纯客户端渲染（绕开 nuxt dev 的页面切换残留问题）
  ssr: process.env.NUXT_SSR === 'false' ? false : true,

  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    // ---- 敏感 / 服务端专用（不会下发到浏览器）----
    mongoUri: process.env.MONGODB_URI || '',
    mongoDb: process.env.MONGODB_DB || 'github_trending',

    // ---- 网络代理（直连被墙时填；Vercel/CF 部署请留空直连）----
    mongoProxyHost: process.env.MONGO_PROXY_HOST || '',
    mongoProxyPort: process.env.MONGO_PROXY_PORT || '',
    githubProxy: process.env.GITHUB_PROXY || '',

    // ---- 抓取调度 ----
    updateIntervalMinutes: process.env.UPDATE_INTERVAL_MINUTES || '60',
    crawlOnBoot: process.env.CRAWL_ON_BOOT || 'true',

    // ---- 榜单参数 ----
    trendingSince: process.env.TRENDING_SINCE || 'daily',
    trendingLanguage: process.env.TRENDING_LANGUAGE || '',
    topN: process.env.TOP_N || '10',
    pageSize: process.env.PAGE_SIZE || '10',
    appTimezone: process.env.APP_TIMEZONE || 'Asia/Shanghai',

    // ---- 一言 ----
    hitokotoEndpoint: process.env.HITOKOTO_ENDPOINT || 'https://v1.hitokoto.cn/',

    // ---- 60s 聚合接口（热搜/资讯/生活服务等）----
    feedsBase: process.env.FEEDS_BASE || 'https://60.020417.xyz',
    feedsEnabled: process.env.FEEDS_ENABLED || 'true',

    // ---- 外部触发抓取的令牌（Vercel Cron 用 CRON_SECRET）----
    cronToken: process.env.CRON_TOKEN || process.env.CRON_SECRET || '',

    // ---- 跨域白名单（前后端分离部署时用）----
    corsOrigin: process.env.APP_CORS_ORIGIN || '*',

    public: {
      // 前端不含任何密钥
      pageSize: Number(process.env.PAGE_SIZE || 10),
      topN: Number(process.env.TOP_N || 10),
      hitokotoRefreshMs: 60_000,
      // 前后端分离时指向后端域名，同源部署留空
      apiBase: process.env.NUXT_PUBLIC_API_BASE || ''
    }
  },

  nitro: {
    experimental: { tasks: true },

    // 边缘/Serverless 构建（Cloudflare）需要把 mongodb 的可选依赖 stub 掉，
    // 否则 rollup 解析失败。Node 构建下这些包本来就是 external，插件不会生效。
    rollupConfig: {
      plugins: [stubOptionalMongoDeps()]
    },

    // 数据每小时才变一次，边缘/函数层缓存 60 秒可以大幅减少 Mongo 查询，
    // 同时让 Serverless 冷启动后的首屏更快。
    routeRules: {
      // 注意：这里**不要**给页面加 swr/isr。
      // 页面级缓存会把整页 HTML 一起缓存，导致「日期」「更新于 x 分钟前」停留在缓存时刻，
      // 出现「API 已经是今天的数据、页面还显示昨天」的问题。
      // 真正的加速靠两层：接口层的 withCache + 磁盘缓存（20~80ms），页面 SSR 本身很快。
      '/api/trending': { swr: 60 },
      '/api/days': { swr: 300 },
      '/api/hitokoto': { swr: 0 },
      '/api/status': { swr: 0 },
      '/api/health': { swr: 0 },
      '/api/crawl': { swr: 0 }
    }
  },

  app: {
    head: {
      htmlAttrs: { lang: 'zh-CN' },
      title: 'GitHub 日榜简报 · Trending Daily',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'GitHub Trending 每日榜单，每小时自动更新，按日期留存历史排名。'
        }
      ]
    }
  }
})
