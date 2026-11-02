import { pingDb, dbInfo } from '../utils/db'

/** GET /api/health —— 数据库连通性 + 进程资源自检 */
export default defineEventHandler(async (event) => {
  const ping = await pingDb()
  const info = dbInfo()

  setResponseStatus(event, ping.ok ? 200 : 503)
  return {
    ok: ping.ok,
    runtime: process.env.VERCEL ? 'vercel' : 'node',
    storage: info.mode === 'remote' ? 'libsql' : 'sqlite',
    db: info,
    latencyMs: ping.latencyMs,
    uptimeSec: Math.round(process.uptime()),
    rssMB: Math.round(process.memoryUsage().rss / 1_048_576),
    error: ping.error ?? null,
    at: new Date().toISOString()
  }
})