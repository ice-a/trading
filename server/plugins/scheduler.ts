import { runCrawl, crawlState } from '../utils/crawler'
import { pingDb, ensureSchema } from '../utils/db'
import { invalidateCache } from '../utils/cache'
import { appConfig } from '../utils/config'
import { envFlag } from '../utils/env'

/**
 * 抓取调度（单机常驻进程）。
 *
 * 启动时自检数据库并抓一轮，之后进程内 setInterval 每 N 分钟抓一次。
 * 并发保护：进程内 crawlState().running + 数据库 crawl_locks 行锁。
 */

const FLAG = '__liaowangtai_scheduler__'

export default defineNitroPlugin((nitroApp) => {
  // 静态站没有服务器：构建期和运行时都不抓取，数据由 generate-static-data.mjs 生成。
  // 避免 nuxt build 时开 SQLite 连接 / 跑网络请求把进程挂住。
  if (useRuntimeConfig().staticSite) return

  const g = globalThis as Record<string, unknown>
  if (g[FLAG]) return
  g[FLAG] = true

  const cfg = appConfig()
  const state = crawlState()
  const intervalMs = Math.max(cfg.updateIntervalMinutes, 1) * 60_000
  state.intervalMinutes = cfg.updateIntervalMinutes
  state.startedAt = Date.now()
  state.nextRunAt = Date.now() + intervalMs

  const enabled = envFlag('ENABLE_SCHEDULER', true)

  console.log(
    `[scheduler] 间隔 ${cfg.updateIntervalMinutes}min · 定时器=${enabled ? 'on' : 'off'} · 启动抓取=${cfg.crawlOnBoot ? 'on' : 'off'}`
  )

  const runOnce = async (trigger: 'boot' | 'schedule' | 'manual') => {
    const started = Date.now()
    try {
      const o = await runCrawl(trigger)
      if (o.skipped) console.log('[crawl] 跳过：已有抓取在跑')
      else if (o.ok) {
        console.log(
          `[crawl] ✓ ${o.date} 抓到 ${o.fetched} 个仓库（新增 ${o.upserted} / 更新 ${o.modified} / 掉榜 ${o.dropped}）${o.durationMs}ms`
        )
      } else {
        console.error(`[crawl] ✗ ${o.error}`)
      }
    } catch (err) {
      console.error('[crawl] 未捕获异常:', err)
    }
    // 新数据已入库：清掉缓存
    invalidateCache('')
    state.nextRunAt = Date.now() + intervalMs
    console.log(
      `[scheduler] 本轮完成 ${Date.now() - started}ms，下次 ${new Date(state.nextRunAt).toLocaleString('zh-CN')}`
    )
  }

  const healthCheck = async (): Promise<boolean> => {
    // 空库自愈：先确保表存在，再探连通性
    try {
      await ensureSchema()
    } catch (err) {
      console.error('[db] 建表失败：', err instanceof Error ? err.message : err)
      return false
    }
    const ping = await pingDb()
    if (!ping.ok) {
      console.error(`[db] 自检失败：${ping.error}`)
      return false
    }
    console.log(`[db] 就绪（${ping.latencyMs}ms）`)
    return true
  }

  setTimeout(() => {
    void (async () => {
      if (!(await healthCheck())) return
      if (cfg.crawlOnBoot) await runOnce('boot')
    })()
  }, 800)

  if (!enabled) {
    console.log('[scheduler] 定时器已关闭（ENABLE_SCHEDULER=false），只能通过 /api/crawl 手动抓')
    return
  }

  const timer = setInterval(() => void runOnce('schedule'), intervalMs)
  if (typeof timer.unref === 'function') timer.unref()

  nitroApp.hooks.hook('close', () => {
    clearInterval(timer)
    g[FLAG] = false
    console.log('[scheduler] 已停止')
  })
})
