import { defineNuxtConfig } from 'nuxt/config'

/**
 * 瞭望台 · 单机全栈配置
 *
 * 形态：一个 Nuxt 应用（Vue 页面 + Nitro API）编译成一个 Node 进程，
 *       数据落本地 SQLite 单文件，Caddy 反代 127.0.0.1:3000。
 *
 * 目标机器：1 核 1G。因此：
 *   · 构建产物在本地/CI 打包，不在服务器上跑 nuxt build（1G 会 OOM）
 *   · 运行时只跑一个进程（SQLite 单连接，不支持多副本）
 *   · 压缩交给 Caddy（zstd/gzip），Node 不再做二次压缩
 */
export default defineNuxtConfig({
  compatibilityDate: '2025-10-01',
  devtools: { enabled: false },

  // 前后端不分离：页面在服务端渲染，数据在同进程内直接读 SQLite
  ssr: true,

  css: ['~/assets/css/main.css'],

  nitro: {
    preset: 'node-server',

    // 静态资源（.output/public）由 Nitro 直接服务；压缩交给前置的 Caddy
    compressPublicAssets: false,

    // 进程内定时抓取由 server/plugins/scheduler.ts 负责，不依赖平台 cron
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