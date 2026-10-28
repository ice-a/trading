import { runCrawl, crawlState } from '../utils/crawler'
import { collectFeeds } from '../utils/feeds'
import { pingMongo } from '../utils/mongo'
import { readMeta } from '../utils/store'
import { runtimeKind, isServerless, isCloudflareWorkers, shouldRunInternalScheduler } from '../utils/platform'

/**
 * 抓取调度（自适应部署形态）。
 *
 * 每个周期并行刷新两批数据：
 *   1. GitHub Trending 日榜（crawl_runs 记录）
 *   2. 60s 聚合接口 50 个端点（feed_snapshots 记录）
 * 频率统一由 UPDATE_INTERVAL_MINUTES 控制。
 *
 * 三种运行方式：
 *  1. 常驻 Node 进程（本地 / VPS / Docker）→ 内置 setInterval
 *  2. Cloudflare Workers → cloudflare:scheduled 钩子（wrangler.toml 的 crons）
 *  3. Vercel / Netlify / Lambda → 外部 cron 调 /api/crawl
 */

const FLAG = '__github_trending_scheduler__'

export default defineNitroPlugin((nitroApp) => {
  const cfg = appConfig()
  const g = globalThis as Record<string, unknown>

  if (g[FLAG]) {
    console.log('[scheduler] 已注册，跳过重复初始化')
    return
  }
  g[FLAG] = true

  const kind = runtimeKind()
  const serverless = isServerless()
  const useInterval = shouldRunInternalScheduler()

  console.log(
    `[scheduler] 运行时=${kind} · 无状态=${serverless} · 内置定时器=${useInterval ? '开' : '关'} · 间隔=${cfg.updateIntervalMinutes} 分钟 · 库=${cfg.mongoDb} · 聚合接口=${cfg.feedsEnabled ? '开' : '关'}`
  )

  /** 一次完整刷新：GitHub + 聚合接口，互不阻塞 */
  const refreshAll = async (trigger: 'boot' | 'schedule' | 'manual') => {
    const [gh, fd] = await Promise.allSettled([
      runCrawl(trigger),
      cfg.feedsEnabled ? collectFeeds() : Promise.resolve(null)
    ])

    if (gh.status === 'fulfilled') {
      const o = gh.value
      if (o.ok) {
        console.log(
          `[crawl] ✓ ${o.date} 抓到 ${o.fetched} 个仓库（新增 ${o.upserted} / 更新 ${o.modified} / 掉榜 ${o.dropped}）耗时 ${o.durationMs}ms`
        )
      } else if (!o.skipped) {
        console.error(`[crawl] ✗ ${o.error}`)
      }
    } else {
      console.error('[crawl] 未捕获异常:', gh.reason)
    }

    if (fd.status === 'fulfilled' && fd.value) {
      const r = fd.value
      console.log(
        `[feeds] ${r.failed === 0 ? '✓' : '!'} ${r.total} 个端点：成功 ${r.ok} / 失败 ${r.failed}，耗时 ${r.durationMs}ms`
      )
    } else if (fd.status === 'rejected') {
      console.error('[feeds] 未捕获异常:', fd.reason)
    }

    // 抓取会把缓存打失效，这里立刻回填一遍，
    // 避免「抓完之后第一个访问的用户吃一次 8 秒的冷查询」
    await warmupCache()
  }

  /**
   * 预热接口缓存。
   *
   * Atlas 在这里是跨洋链路：建连 ~5.8s、单次读 50 个文档 ~2.3s，
   * 冷查询对用户来说就是「转圈 8 秒」。预热一次之后所有请求都命中内存缓存。
   * 只在常驻进程做（Serverless 每次冷启动没法预热，直接用 HTTP 缓存头兜底）。
   */
  const warmupCache = async () => {
    if (!useInterval) return
    const port = process.env.PORT || process.env.NITRO_PORT || 3000
    const base = `http://127.0.0.1:${port}`
    // 预热全部热点：热门榜单各分类 + 三周期榜单 + 各站点页，首次访问即命中磁盘缓存
    const urls = [
      '/api/feeds?preview=50',
      '/api/feeds?category=hot&preview=50',
      '/api/feeds?category=info&preview=50',
      '/api/feeds?category=all&preview=50',
      '/api/trending?page=1',
      '/api/trending?page=1&period=weekly',
      '/api/trending?page=1&period=monthly',
      '/api/history',
      '/api/history?period=weekly',
      '/api/history?period=monthly',
      '/api/nav',
      '/api/ai',
      '/api/creators'
    ]
    const started = Date.now()
    await Promise.allSettled(
      urls.map((u) => fetch(base + u, { signal: AbortSignal.timeout(90_000) }))
    )
    console.log(`[scheduler] 缓存预热完成（${Date.now() - started}ms）`)
  }

  const healthCheck = async (): Promise<boolean> => {
    const ping = await pingMongo()
    if (!ping.ok) {
      console.error(`[mongo] 连接失败（库 ${ping.db}）：${ping.error}`)
      console.error('[mongo] 检查 MONGODB_URI 与 Atlas Network Access 白名单')
      return false
    }
    console.log(`[mongo] 已连接 ${ping.db}（${ping.latencyMs}ms）`)
    return true
  }

  // ---------- Cloudflare Cron ----------
  if (isCloudflareWorkers()) {
    try {
      ;(nitroApp.hooks as unknown as { hook: (name: string, fn: () => unknown) => void }).hook(
        'cloudflare:scheduled',
        async () => {
          const ok = await healthCheck()
          if (!ok) return
          await refreshAll('schedule')
        }
      )
      console.log('[scheduler] 已挂载 cloudflare:scheduled 钩子（由 wrangler.toml 的 crons 触发）')
    } catch (err) {
      console.warn('[scheduler] 挂载 Cloudflare cron 钩子失败：', err instanceof Error ? err.message : err)
    }
  }

  // ---------- 无状态环境：不做任何全局 I/O ----------
  if (!useInterval) {
    console.log(
      '[scheduler] 当前为无状态环境，进程内定时器已关闭。请用以下任一方式触发：\n' +
        '  · Vercel：vercel.json 的 crons（GET /api/crawl）\n' +
        '  · Cloudflare：wrangler.toml 的 [triggers] crons\n' +
        '  · 通用：.github/workflows/crawl.yml 定时 curl，或任意外部 cron\n' +
        '  本地想强制开启：ENABLE_INTERNAL_SCHEDULER=true'
    )
    // Workers 全局作用域禁止异步 I/O / 定时器，这里绝不能做健康检查
    return
  }

  // ---------- 常驻进程：内置定时器 ----------
  const intervalMs = Math.max(cfg.updateIntervalMinutes, 1) * 60_000
  const state = crawlState()
  state.intervalMinutes = cfg.updateIntervalMinutes
  state.startedAt = Date.now()
  state.nextRunAt = Date.now() + intervalMs

  const bootstrap = async () => {
    const ok = await healthCheck()
    if (!ok) {
      console.error('[scheduler] 数据库不可用，抓取将在下一轮重试')
      return
    }
    if (!cfg.crawlOnBoot) {
      console.log('[scheduler] CRAWL_ON_BOOT=false，跳过启动抓取')
      await warmupCache()
      return
    }

    // dev 热重载 / 容器反复重启时，避免短时间内重复打上游
    try {
      const meta = (await readMeta()) as { lastSuccessAt?: string | Date } | null
      const last = meta?.lastSuccessAt ? new Date(meta.lastSuccessAt).getTime() : 0
      const gapMinutes = Math.min(5, cfg.updateIntervalMinutes)
      if (last && Date.now() - last < gapMinutes * 60_000) {
        console.log(`[scheduler] 距上次成功抓取不足 ${gapMinutes} 分钟，跳过启动抓取`)
        // 跳过抓取也要预热：否则服务刚起时第一个访问的用户会吃冷查询
        await warmupCache()
        return
      }
    } catch {
      /* 读不到就正常抓 */
    }

    await refreshAll('boot')
  }

  setTimeout(() => void bootstrap(), 300)

  const timer = setInterval(() => {
    void refreshAll('schedule').finally(() => {
      state.nextRunAt = Date.now() + intervalMs
    })
  }, intervalMs)
  if (typeof timer.unref === 'function') timer.unref()

  nitroApp.hooks.hook('close', () => {
    clearInterval(timer)
    g[FLAG] = false
    console.log('[scheduler] 已停止')
  })
})
