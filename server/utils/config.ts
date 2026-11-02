/**
 * 服务端配置读取（功能裁剪版）。
 *
 * 配置来源只有两条：`.env` 文件（启动时载入 process.env）与 shell / systemd / Vercel 注入的变量。
 */

import { env, envFlag, envInt } from './env'

export interface AppConfig {
  updateIntervalMinutes: number
  crawlOnBoot: boolean
  trendingSince: 'daily' | 'weekly' | 'monthly'
  trendingLanguage: string
  topN: number
  pageSize: number
  timezone: string
  hitokotoEndpoint: string
  cronToken: string
}

export function appConfig(): AppConfig {
  const sinceRaw = env('TRENDING_SINCE', 'daily').toLowerCase()
  const since = (['daily', 'weekly', 'monthly'].includes(sinceRaw) ? sinceRaw : 'daily') as AppConfig['trendingSince']

  return {
    // 最小 1 分钟，避免把 GitHub 抓挂
    updateIntervalMinutes: envInt('UPDATE_INTERVAL_MINUTES', 60),
    crawlOnBoot: envFlag('CRAWL_ON_BOOT', true),
    trendingSince: since,
    trendingLanguage: env('TRENDING_LANGUAGE', ''),
    topN: envInt('TOP_N', 10),
    pageSize: envInt('PAGE_SIZE', 10),
    timezone: env('APP_TIMEZONE', 'Asia/Shanghai'),
    hitokotoEndpoint: env('HITOKOTO_ENDPOINT', 'https://v1.hitokoto.cn/'),
    // 一个值两种叫法：Vercel 习惯 CRON_SECRET，外部 cron 习惯 CRON_TOKEN。
    // 任一存在即启用鉴权；都不配才不校验（仅限本机调试）。
    cronToken: env('CRON_TOKEN', '') || env('CRON_SECRET', '')
  }
}