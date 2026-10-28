import type { Dispatcher } from 'undici'
import { isEdgeRuntime } from './platform'

/**
 * 统一出口 HTTP 客户端。
 *
 * 代理只对「需要翻墙的本地/国内环境」有意义：
 *   GITHUB_PROXY=http://127.0.0.1:7897
 *
 * Vercel / Cloudflare 部署时留空即可直连——而且边缘运行时（workerd）
 * 根本没有 undici 的 ProxyAgent，这里会自动跳过代理逻辑。
 */

let proxyDispatcher: Dispatcher | null = null
let proxyUrl: string | null = null

function resolveProxy(): string {
  if (isEdgeRuntime()) return '' // 边缘运行时不做代理，避免 import undici 失败
  return appConfig().githubProxy || process.env.HTTPS_PROXY || process.env.https_proxy || ''
}

export async function httpFetch(url: string, init: RequestInit = {}): Promise<Response> {
  const proxy = resolveProxy()

  if (!proxy) {
    return fetch(url, init)
  }

  try {
    const undici = await import('undici')
    if (!proxyDispatcher || proxyUrl !== proxy) {
      proxyDispatcher = new undici.ProxyAgent(proxy) as unknown as Dispatcher
      proxyUrl = proxy
    }
    const res = await undici.fetch(url, { ...(init as object), dispatcher: proxyDispatcher } as never)
    return res as unknown as Response
  } catch (err) {
    // 代理不可用（或打包后没有 undici）时退回直连，让上层重试逻辑处理
    console.warn(`[http] 代理 ${proxy} 不可用，回退直连：`, err instanceof Error ? err.message : err)
    return fetch(url, init)
  }
}
