import { pingMongo } from '../utils/mongo'

/** GET /api/health —— 数据库连通性自检 */
export default defineEventHandler(async (event) => {
  const ping = await pingMongo()
  setResponseStatus(event, ping.ok ? 200 : 503)
  return {
    ok: ping.ok,
    database: ping.db,
    latencyMs: ping.latencyMs,
    error: ping.error ?? null,
    at: new Date().toISOString()
  }
})
