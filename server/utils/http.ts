/**
 * 统一出口 HTTP 客户端。
 *
 * 重构要点：代理逻辑（undici ProxyAgent / GITHUB_PROXY / HTTPS_PROXY）已删除。
 *   · 单机部署直连即可，GitHub 与 60s API 都是公网源；
 *   · 若机器需要代理才能出网，用系统级代理（sing-box / TUN），不要在应用里做；
 * 保留这一层的意义：统一超时、统一 UA、统一错误语义。
 */

const DEFAULT_UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'

export interface HttpOptions extends RequestInit {
  timeoutMs?: number
}

export async function httpFetch(url: string, init: HttpOptions = {}): Promise<Response> {
  const { timeoutMs = 15_000, headers, signal, ...rest } = init

  const merged = new Headers(headers || {})
  if (!merged.has('User-Agent')) merged.set('User-Agent', DEFAULT_UA)

  // 上层传入 signal 时以它为准（用于整体取消），否则只加超时
  const timeoutSignal = AbortSignal.timeout(timeoutMs)
  const effectiveSignal = signal ?? timeoutSignal

  return fetch(url, { ...rest, headers: merged, signal: effectiveSignal })
}

/** 带重试的 GET / POST JSON 取值 */
export async function httpJson<T>(
  url: string,
  init: HttpOptions = {},
  retries = 1
): Promise<T> {
  let lastError: unknown = null
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await httpFetch(url, init)
      if (!res.ok) throw new Error(`HTTP ${res.status} ${url}`)
      return (await res.json()) as T
    } catch (err) {
      lastError = err
    }
  }
  throw lastError instanceof Error ? lastError : new Error(String(lastError))
}