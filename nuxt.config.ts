import { defineNuxtConfig } from 'nuxt/config'

/**
 * 观澜志 · GitHub Pages 静态站配置
 *
 * 形态：Nuxt 构建成纯 SPA（ssr:false），数据来自构建期生成的
 *       public/data/bundle.json，全部托管在 GitHub Pages —— 没有服务器、没有数据库。
 *
 * 数据来源：GitHub Actions 定时跑 scripts/generate-static-data.mjs
 *           （cheerio/slim 抓 GitHub Trending → 写 JSON → 提交）。
 *
 * baseURL：
 *   · 项目站 https://<user>.github.io/<repo>/  → /<repo>/（Actions 注入 BASE_PATH）
 *   · 自定义域名                                → /
 */

const basePath = process.env.BASE_PATH || '/'

export default defineNuxtConfig({
  compatibilityDate: '2025-10-01',
  devtools: { enabled: false },
  sourcemap: false,

  // 静态站标记：server 层的定时器 / 建表中间件据此在构建期直接跳过
  runtimeConfig: { staticSite: true },

  // GitHub Pages 只托管静态文件：关掉 SSR，构建成 SPA
  ssr: false,

  app: {
    baseURL: basePath,
    head: {
      htmlAttrs: { lang: 'zh-CN' },
      title: 'GitHub 日榜简报',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'GitHub Trending 每日榜单，每小时自动更新，按日期留存历史排名。'
        }
      ]
    }
  },

  css: ['~/assets/css/main.css'],

  nitro: {
    // 纯静态产物：只生成 .output/public，无常驻 server
    preset: 'static',
    sourcemap: false,
    compressPublicAssets: false
  }
})
