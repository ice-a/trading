import { runCrawl, crawlState } from '../utils/crawler'
import { pingDb, ensureSchema } from '../utils/db'
import { invalidateCache, pruneDbCache } from '../utils/cache'
import { appConfig } from '../utils/config'
import { envFlag } from '../utils/env'

/**
 * 抓取调度（自建 / 常驻进程环境）。
 *
 * 功能裁剪后只需抓 GitHub Trending 三榜（一次请求全拿）。
 *
 * 环境差异：
 *   · 自建 Node（pm2 / systemd）：进程内 setInterval，启动抓一轮 + 每 N 分钟
 *   · Vercel 等 serverless：**没有常驻进程**，这里直接跳过，
 *     抓取由 vercel.json 的 Cron（Hobby 每天 1 次）或外部 cron 打 /api/crawl 完成
 *
 * 并发保护：进程内 crawlState().running + 数据库 crawl_locks 行锁。
 */

const FLAG = '__liaowangtai_scheduler__'

export default defineNitroPlugin((nitroApp) => {
  const g = globalThis as Record<string, unknown>
  if (g[FLAG]) return
  g[FLAG] = true

  const cfg = appConfig()

  if (process.env.VERCEL || process.env.AWS_LAMBDA_FUNCTION_NAME) {
    console.log(
      '[scheduler] serverless 环境：不启用进程内定时器。抓取由 vercel.json 的 cron（Hobby 每天 1 次）' +
        '或外部 cron 打 /api/crawl 完成；想要小时级更新请用 cron-job.org / GitHub Actions。'
    )
    return
  }

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
    void pruneDbCache()
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
      console.error(`[db] 自检失败（${ping.mode}）：${ping.error}`)
      return false
    }
    console.log(`[db] 就绪（${ping.mode}，${ping.latencyMs}ms）`)
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