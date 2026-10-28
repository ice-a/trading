/**
 * 运行时平台探测。
 *
 * 本地 / 自建服务器 = 常驻进程（可以用 setInterval 做内置调度）
 * Vercel / Cloudflare / Netlify / Lambda = 无状态函数（必须用外部 cron 触发）
 */

export type RuntimeKind =
  | 'node-server'
  | 'vercel'
  | 'cloudflare-workers'
  | 'cloudflare-pages'
  | 'netlify'
  | 'aws-lambda'
  | 'unknown'

function g(): Record<string, unknown> {
  return globalThis as unknown as Record<string, unknown>
}

/** workerd（Cloudflare Workers / Pages Functions）环境：没有真正的 Node 进程 */
export function isCloudflareWorkers(): boolean {
  const nav = g().navigator as { userAgent?: string } | undefined
  if (nav?.userAgent?.includes('Cloudflare-Workers')) return true
  // 兜底：workerd 同时具备 WebSocketPair 且 process.versions 缺失或极简
  return typeof g().WebSocketPair !== 'undefined' && typeof (g().Deno as unknown) === 'undefined'
}

export function runtimeKind(): RuntimeKind {
  if (isCloudflareWorkers()) {
    return process.env.CF_PAGES ? 'cloudflare-pages' : 'cloudflare-workers'
  }
  if (process.env.VERCEL) return 'vercel'
  if (process.env.NETLIFY) return 'netlify'
  if (process.env.AWS_LAMBDA_FUNCTION_NAME) return 'aws-lambda'
  if (process.env.CF_PAGES) return 'cloudflare-pages'
  return 'node-server'
}

/** 无状态函数环境（进程随时被冻结/销毁） */
export function isServerless(): boolean {
  const kind = runtimeKind()
  return kind !== 'node-server' && kind !== 'unknown'
}

/** 边缘运行时（Node 原生模块不可用，mongodb driver 可能跑不了） */
export function isEdgeRuntime(): boolean {
  return isCloudflareWorkers()
}

/**
 * 是否启用进程内定时器。
 *
 * ENABLE_INTERNAL_SCHEDULER:
 *   auto（默认）→ 只有常驻 Node 进程才启用
 *   true        → 强制启用（自建容器里想手动控制时用）
 *   false       → 强制关闭（改用平台 cron / GitHub Actions 触发 /api/crawl）
 */
export function shouldRunInternalScheduler(): boolean {
  const flag = (process.env.ENABLE_INTERNAL_SCHEDULER || 'auto').trim().toLowerCase()
  if (flag === 'true' || flag === '1' || flag === 'yes') return true
  if (flag === 'false' || flag === '0' || flag === 'no') return false
  return !isServerless()
}
