/**
 * API 基地址解析。
 *
 * 同源部署（默认）：返回相对路径，SSR 走内部调用、客户端走同域请求，最快。
 * 前后端分离（例如 Cloudflare Pages 前端 + Vercel 后端）：
 *   设置 NUXT_PUBLIC_API_BASE=https://your-api.vercel.app
 * 此时所有请求都会指向该绝对地址（后端已开放 CORS，见 server/middleware/cors.ts）。
 */
export function apiUrl(path: string): string {
  const cfg = useRuntimeConfig()
  const base = String((cfg.public as Record<string, unknown>).apiBase || '').replace(/\/+$/, '')
  if (!base) return path
  return `${base}${path.startsWith('/') ? path : `/${path}`}`
}
