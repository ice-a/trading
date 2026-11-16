import { ensureSchema } from '../utils/db'

/**
 * 首次访问时确保表存在（空库自愈）。
 *
 * 只在进程内第一次请求时真正执行 DDL；之后一个布尔判断就返回。
 * 放在 middleware，保证一定在执行查询之前，store 层不会撞上 no such table。
 */
let ready = false

export default defineEventHandler(async () => {
  // 静态站不需要数据库（数据来自 bundle.json）
  if (useRuntimeConfig().staticSite) return
  if (ready) return
  try {
    await ensureSchema()
    ready = true
    console.log('[db] schema 就绪')
  } catch (err) {
    // 不抛给用户：让具体接口返回自己的错误，这里只记录
    console.error('[db] ensureSchema 失败：', err instanceof Error ? err.message : err)
  }
})
