import { runCrawl, crawlState } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { pingDb } from '../utils/db'
import { invalidateCache } from '../utils/cache'
import { appConfig } from '../utils/config'
import { envFlag } from '../utils/env'

/**
 * 抓取调度：进程内定时器（单机常驻进程）。
 *
 * 这是单机部署真正的收益 —— 不再需要 GitHub Actions / 外部 cron / 触发令牌：
 *   启动 → 自检数据库 → （可选）立刻抓一次 → 每 N 分钟抓一轮
 *
 * 一次刷新并行跑两批数据：
 *   1. GitHub Trending 日/周/月榜（crawl_runs 记录）
 *   2. 60s 聚合接口 19 个端点（feed_snapshots 记录）
 *
 * 并发保护有两层：
 *   · 进程内：crawlState().running（同一进程不重入）
 *   · 数据库：crawl_locks 行锁（多进程 / 残留锁时兜底）
 *
 * 环境变量：
 *   UPDATE_INTERVAL_MINUTES  抓取间隔（默认 60）
 *   CRAWL_ON_BOOT            启动是否立刻抓一次（默认 true）
 *   ENABLE_SCHEDULER         置 false 可完全关掉定时器（只用 /api/crawl 手动触发）
 */

const FLAG = '__liaowangtai_scheduler__'

export default defineNitroPlugin((nitroApp) => {
  const g = globalThis as Record<string, unknown>
  if (g[FLAG]) {
    console.log('[scheduler] 已注册，跳过重复初始化')
    return
  }
  g[FLAG] = true

  const cfg = appConfig()
  const state = crawlState()
  const intervalMs = Math.max(cfg.updateIntervalMinutes, 1) * 60_000

  state.intervalMinutes = cfg.updateIntervalMinutes
  state.startedAt = Date.now()
  state.nextRunAt = Date.now() + intervalMs

  const enabled = envFlag('ENABLE_SCHEDULER', true)

  console.log(
    `[scheduler] 间隔 ${cfg.updateIntervalMinutes}min · feeds=${cfg.feedsEnabled ? 'on' : 'off'} · ` +
      `定时器=${enabled ? 'on' : 'off'} · 启动抓取=${cfg.crawlOnBoot ? 'on' : 'off'}`
  )

  const refreshAll = async (trigger: 'boot' | 'schedule' | 'manual') => {
    const started = Date.now()
    const [gh, fd] = await Promise.allSettled([
      runCrawl(trigger),
      cfg.feedsEnabled ? collectFeeds() : Promise.resolve(null)
    ])

    if (gh.status === 'fulfilled') {
      const o = gh.value
      if (o.skipped) console.log('[crawl] 跳过：已有抓取在跑')
      else if (o.ok) {
        console.log(
          `[crawl] ✓ ${o.date} 抓到 ${o.fetched} 个仓库（新增 ${o.upserted} / 更新 ${o.modified} / 掉榜 ${o.dropped}）${o.durationMs}ms`
        )
      } else {
        console.error(`[crawl] ✗ ${o.error}`)
      }
    } else {
      console.error('[crawl] 未捕获异常:', gh.reason)
    }

    if (fd.status === 'fulfilled' && fd.value) {
      const f = fd.value
      console.log(`[feeds] ${f.failed === 0 ? '✓' : '!'} ${f.ok}/${f.total} 成功，${f.durationMs}ms`)
    } else if (fd.status === 'rejected') {
      console.error('[feeds] 未捕获异常:', fd.reason)
    }

    // 新数据已入库：清掉进程内缓存，避免页面继续吃旧值
    invalidateCache('')
    state.nextRunAt = Date.now() + intervalMs
    console.log(
      `[scheduler] 本轮完成 ${Date.now() - started}ms，下次 ${new Date(state.nextRunAt).toLocaleString('zh-CN')}`
    )
  }

  const healthCheck = async (): Promise<boolean> => {
    const ping = await pingDb()
    if (!ping.ok) {
      console.error(`[db] 自检失败：${ping.error}`)
      return false
    }
    console.log(`[db] SQLite 就绪（${ping.latencyMs}ms）· ${ping.path}`)
    return true
  }

  // 启动自检 + 首轮抓取（不阻塞进程启动）
  setTimeout(() => {
    void (async () => {
      const ok = await healthCheck()
      if (!ok) return
      if (cfg.crawlOnBoot) await refreshAll('boot')
    })()
  }, 800)

  if (!enabled) {
    console.log('[scheduler] 定时器已关闭（ENABLE_SCHEDULER=false），只能通过 /api/crawl 手动抓')
    return
  }

  const timer = setInterval(() => {
    void refreshAll('schedule')
  }, intervalMs)
  if (typeof timer.unref === 'function') timer.unref()

  nitroApp.hooks.hook('close', () => {
    clearInterval(timer)
    g[FLAG] = false
    console.log('[scheduler] 已停止')
  })
})