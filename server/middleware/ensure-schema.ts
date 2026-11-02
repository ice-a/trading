import { ensureSchema, dbMode } from '../utils/db'

/**
 * 首次访问时确保表存在（空库自愈）。
 *
 * 只在进程内第一次请求时真正执行 DDL；之后一个布尔判断就返回。
 * 放在 middleware 而不是 plugin，是因为：
 *   · plugin 在 serverless 冷启动时也会跑，但那时库可能还没就绪
 *   · middleware 一定在执行查询之前，保证 store/site 层不会撞上 no such table
 */
let ready = false

export default defineEventHandler(async () => {
  if (ready) return
  try {
    await ensureSchema()
    ready = true
    console.log(`[db] schema 就绪（${dbMode()}）`)
  } catch (err) {
    // 不抛给用户：让具体接口返回自己的错误，这里只记录
    console.error('[db] ensureSchema 失败：', err instanceof Error ? err.message : err)
  }
})
