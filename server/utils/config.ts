/**
 * 服务端配置读取：优先 runtimeConfig（支持 NUXT_ 前缀环境变量覆盖），
 * 回退到 process.env，保证本地 `nuxt dev` 和容器部署都能拿到值。
 */
export interface AppConfig {
  mongoUri: string
  mongoDb: string
  mongoProxyHost: string
  mongoProxyPort: number
  githubProxy: string
  updateIntervalMinutes: number
  crawlOnBoot: boolean
  trendingSince: 'daily' | 'weekly' | 'monthly'
  trendingLanguage: string
  topN: number
  pageSize: number
  timezone: string
  hitokotoEndpoint: string
  cronToken: string
  corsOrigin: string
  feedsBase: string
  feedsEnabled: boolean
}

function pick(key: string, fallback = ''): string {
  const rc = useRuntimeConfig() as unknown as Record<string, unknown>
  const fromRc = rc?.[key]
  if (typeof fromRc === 'string' && fromRc.trim() !== '') return fromRc.trim()
  if (fromRc != null && typeof fromRc !== 'string' && String(fromRc) !== '') return String(fromRc)
  const fromEnv = process.env[toEnvKey(key)]
  if (fromEnv && fromEnv.trim() !== '') return fromEnv.trim()
  return fallback
}

function toEnvKey(key: string): string {
  return key.replace(/[A-Z]/g, (m) => `_${m}`).toUpperCase()
}

export function appConfig(): AppConfig {
  const sinceRaw = pick('trendingSince', 'daily').toLowerCase()
  const since = (['daily', 'weekly', 'monthly'].includes(sinceRaw) ? sinceRaw : 'daily') as AppConfig['trendingSince']

  const intervalRaw = Number(pick('updateIntervalMinutes', '60'))
  // 最小 1 分钟，避免把 GitHub 抓挂了
  const updateIntervalMinutes = Number.isFinite(intervalRaw) && intervalRaw >= 1 ? Math.floor(intervalRaw) : 60

  const pageSizeRaw = Number(pick('pageSize', '10'))
  const topNRaw = Number(pick('topN', '10'))
  const proxyPortRaw = Number(pick('mongoProxyPort', '0'))

  return {
    mongoUri: pick('mongoUri', ''),
    mongoDb: pick('mongoDb', 'github_trending'),
    mongoProxyHost: pick('mongoProxyHost', ''),
    mongoProxyPort: Number.isFinite(proxyPortRaw) && proxyPortRaw > 0 ? Math.floor(proxyPortRaw) : 7897,
    githubProxy: pick('githubProxy', ''),
    updateIntervalMinutes,
    crawlOnBoot: pick('crawlOnBoot', 'true').toLowerCase() !== 'false',
    trendingSince: since,
    trendingLanguage: pick('trendingLanguage', ''),
    topN: Number.isFinite(topNRaw) && topNRaw > 0 ? Math.floor(topNRaw) : 10,
    pageSize: Number.isFinite(pageSizeRaw) && pageSizeRaw > 0 ? Math.floor(pageSizeRaw) : 10,
    timezone: pick('appTimezone', 'Asia/Shanghai'),
    hitokotoEndpoint: pick('hitokotoEndpoint', 'https://v1.hitokoto.cn/'),
    cronToken: pick('cronToken', ''),
    corsOrigin: pick('corsOrigin', '*'),
    feedsBase: pick('feedsBase', 'https://60.020417.xyz').replace(/\/+$/, ''),
    feedsEnabled: pick('feedsEnabled', 'true').toLowerCase() !== 'false'
  }
}
