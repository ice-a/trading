/**
 * 测量 SPA 路由切换耗时（客户端导航，非整页刷新）。
 * 用法：SITE=http://localhost:3020 node scripts/measure-nav.mjs
 *
 * 判定标准：URL 已切换 且 目标页独有元素出现
 *   /        → .row >= 3 且 h1 含 "GitHub"
 *   /v2      → .feed-card >= 3
 *   /history → .day-item >= 1
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const base = process.env.SITE || 'http://localhost:3000'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9340
const profile = mkdtempSync(join(tmpdir(), 'cdp-nav-'))

const chrome = spawn(
  chromePath,
  [
    '--headless=new',
    '--disable-gpu',
    '--hide-scrollbars',
    `--remote-debugging-port=${port}`,
    `--user-data-dir=${profile}`,
    '--window-size=1280,900',
    'about:blank'
  ],
  { stdio: 'ignore' }
)

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

async function getWsUrl() {
  for (let i = 0; i < 40; i++) {
    try {
      const list = await fetch(`http://127.0.0.1:${port}/json/list`).then((r) => r.json())
      const page = list.find((t) => t.type === 'page')
      if (page?.webSocketDebuggerUrl) return page.webSocketDebuggerUrl
    } catch {
      /* retry */
    }
    await sleep(250)
  }
  throw new Error('CDP 未就绪')
}

const ws = new WebSocket(await getWsUrl())
let msgId = 0
const pending = new Map()
ws.onmessage = (ev) => {
  const m = JSON.parse(ev.data)
  if (m.id && pending.has(m.id)) {
    pending.get(m.id)(m)
    pending.delete(m.id)
  }
}
const send = (method, params = {}) => {
  const id = ++msgId
  return new Promise((resolve) => {
    pending.set(id, resolve)
    ws.send(JSON.stringify({ id, method, params }))
  })
}
await new Promise((r) => (ws.onopen = r))
await send('Page.enable')

const evalJs = async (expression) => {
  const res = await send('Runtime.evaluate', { expression, awaitPromise: true, returnByValue: true })
  if (res.result?.exceptionDetails) {
    return { __error: res.result.exceptionDetails.exception?.description || res.result.exceptionDetails.text }
  }
  return res.result?.result?.value
}

const READY_FN = `(target) => {
  if (location.pathname !== target) return false;
  if (target === '/v2') return document.querySelectorAll('.feed-card').length >= 3;
  if (target === '/history') return document.querySelectorAll('.day-item').length >= 1;
  const h1 = document.querySelector('h1')?.textContent || '';
  return document.querySelectorAll('.row').length >= 3 && h1.includes('GitHub');
}`

/** 从 from 页点击 selector，测量切到 to 页所需时间 */
const measure = (fromPath, selector, toPath) => `(async () => {
  const ready = ${READY_FN};
  const link = document.querySelector('${selector}');
  if (!link) return { error: 'no ${selector}' };

  // 打一个只存在于当前 JS 上下文的标记：整页刷新后它会消失
  window.__spaMarker = 'alive';

  const t0 = performance.now();
  link.click();

  const ok = await new Promise((resolve) => {
    const started = performance.now();
    const tick = () => {
      if (ready('${toPath}')) return resolve(true);
      if (performance.now() - started > 25000) return resolve(false);
      requestAnimationFrame(tick);
    };
    tick();
  });

  return {
    ms: ok ? Math.round(performance.now() - t0) : -1,
    from: '${fromPath}',
    to: '${toPath}',
    path: location.pathname,
    fullReload: window.__spaMarker !== 'alive'
  };
})()`

async function runPair(fromPath, selector, toPath) {
  await send('Page.navigate', { url: `${base}${fromPath}` })
  await sleep(4000)
  const r = await evalJs(measure(fromPath, selector, toPath))
  await sleep(1500)
  return r
}

const results = []

// 首页 → 各页（点右上角导航）
results.push(await runPair('/', 'a.nav-btn', '/v2'))
results.push(await runPair('/', 'a.nav-btn:last-of-type', '/history'))

// 各页 → 首页（点返回按钮）
results.push(await runPair('/v2', '.back-btn', '/'))
results.push(await runPair('/history', '.back-btn', '/'))

// 再跑一轮，看第二次是否更快（缓存命中）
results.push(await runPair('/', 'a.nav-btn', '/v2'))
results.push(await runPair('/v2', '.back-btn', '/'))

console.log(`\n站点：${base}\n`)
console.log('方向              耗时        整页刷新')
for (const r of results) {
  const ms = r?.ms === -1 ? '超时' : r?.ms != null ? `${r.ms}ms` : '—'
  const reload = r?.fullReload ? '是（SPA 失效）' : '否'
  console.log(`  ${String(r.from).padEnd(9)} → ${String(r.to).padEnd(9)} ${ms.padEnd(11)} ${reload}`)
}

const valid = results.filter((r) => r?.ms > 0).map((r) => r.ms)
if (valid.length) {
  console.log(`\n平均 ${Math.round(valid.reduce((a, b) => a + b, 0) / valid.length)}ms`)
}

ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
