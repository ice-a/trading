/**
 * CI 抓取入口（GitHub Actions 用）。
 *
 * 思路：数据层（server/utils/d1.ts）本身就支持两种模式——
 *   · CF Pages 运行时 → env.DB binding
 *   · 其它环境        → D1 REST API（CLOUDFLARE_ACCOUNT_ID / CLOUDFLARE_D1_TOKEN / CLOUDFLARE_D1_ID）
 * 所以 CI 里直接起一份构建产物（node preset），让它用 REST 模式读写 D1，
 * 再本地 POST /api/crawl 触发完整抓取链路（锁、upsert、掉榜逻辑全部复用生产代码）。
 *
 * 前置：npm run build:node
 */
import { spawn } from 'node:child_process'

const env = process.env

const D1_ACCOUNT = env.D1_ACCOUNT_ID || env.CLOUDFLARE_ACCOUNT_ID || ''
const D1_TOKEN = env.D1_TOKEN || env.CLOUDFLARE_D1_TOKEN || ''
const D1_DATABASE = env.D1_DATABASE || env.CLOUDFLARE_D1_ID || ''

if (!D1_ACCOUNT || !D1_TOKEN || !D1_DATABASE) {
  console.error('✗ 缺少 D1 凭据：需要 D1_ACCOUNT_ID / D1_TOKEN / D1_DATABASE（仓库 Secrets）')
  process.exit(1)
}

const PORT = 4310
const child = spawn(process.execPath, ['.output/server/index.mjs'], {
  env: {
    ...env,
    PORT: String(PORT),
    NODE_ENV: 'production',
    // 数据层的 REST 模式认这三个名字
    CLOUDFLARE_ACCOUNT_ID: D1_ACCOUNT,
    CLOUDFLARE_D1_TOKEN: D1_TOKEN,
    CLOUDFLARE_D1_ID: D1_DATABASE
    // 无需再关内嵌定时器：Workers 形态没有进程内调度，CI 只跑一次抓取
  },
  stdio: ['ignore', 'inherit', 'inherit']
})

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

async function waitReady(maxMs = 60_000) {
  const t0 = Date.now()
  while (Date.now() - t0 < maxMs) {
    try {
      const res = await fetch(`http://127.0.0.1:${PORT}/api/health`, { signal: AbortSignal.timeout(3_000) })
      if (res.ok) return true
    } catch {
      /* 还没起来 */
    }
    await sleep(1_000)
  }
  return false
}

const shutdown = (code) => {
  try {
    child.kill('SIGTERM')
  } catch {
    /* ignore */
  }
  process.exit(code)
}

try {
  console.log('→ 等待服务启动…')
  if (!(await waitReady())) {
    console.error('✗ 服务 60 秒内未就绪')
    shutdown(1)
  }

  const target = env.TARGET || 'all'
  console.log(`→ POST /api/crawl?target=${target}`)
  const res = await fetch(`http://127.0.0.1:${PORT}/api/crawl?target=${target}`, {
    method: 'POST',
    signal: AbortSignal.timeout(300_000)
  })
  const body = await res.json().catch(() => null)
  console.log(`HTTP ${res.status}`)
  console.log(JSON.stringify(body, null, 2))

  // 200=成功 429=已有抓取在跑（视为正常）
  shutdown(res.status === 200 || res.status === 429 ? 0 : 1)
} catch (err) {
  console.error('✗ 抓取失败:', err?.message || err)
  shutdown(1)
}
