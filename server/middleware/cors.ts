/**
 * CORS：允许把前端拆到别的域名（例如 Cloudflare Pages 前端 + Vercel 后端）。
 *
 * APP_CORS_ORIGIN:
 *   *（默认，只读公开数据，安全）| https://your-site.pages.dev | 逗号分隔多个
 *
 * 只对 /api/* 生效，且只放行 GET/POST/OPTIONS。
 */
export default defineEventHandler((event) => {
  const path = getRequestURL(event).pathname
  if (!path.startsWith('/api/')) return

  const cfg = appConfig()
  const allow = cfg.corsOrigin || '*'
  const origin = getHeader(event, 'origin') || ''

  if (allow === '*') {
    setHeader(event, 'Access-Control-Allow-Origin', '*')
  } else if (origin) {
    const list = allow.split(',').map((s) => s.trim()).filter(Boolean)
    if (list.includes(origin)) {
      setHeader(event, 'Access-Control-Allow-Origin', origin)
      appendHeader(event, 'Vary', 'Origin')
    }
  }

  setHeader(event, 'Access-Control-Allow-Methods', 'GET,POST,OPTIONS')
  setHeader(event, 'Access-Control-Allow-Headers', 'Content-Type,x-cron-token,Authorization')
  setHeader(event, 'Access-Control-Max-Age', '86400')

  if (event.method === 'OPTIONS') {
    setResponseStatus(event, 204)
    return ''
  }
})
