/**
 * 诊断：客户端导航 / → /v2 时控制台报了什么错。
 * 用法：node scripts/inspect-nav-error.mjs
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const base = process.env.SITE || 'http://localhost:3000'
const startPath = process.argv[2] || '/'
const selector = process.argv[3] || 'a.nav-btn'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9339
const profile = mkdtempSync(join(tmpdir(), 'cdp-err-'))

const chrome = spawn(
  chromePath,
  [
    '--headless=new',
    '--disable-gpu',
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
const events = []

ws.onmessage = (ev) => {
  const m = JSON.parse(ev.data)
  if (m.id && pending.has(m.id)) {
    pending.get(m.id)(m)
    pending.delete(m.id)
    return
  }
  // 收集错误与日志
  if (m.method === 'Runtime.exceptionThrown') {
    const d = m.params.exceptionDetails
    events.push(`[exception] ${d.exception?.description?.split('\n')[0] || d.text}`)
  }
  if (m.method === 'Runtime.consoleAPICalled' && ['error', 'warning'].includes(m.params.type)) {
    const text = m.params.args.map((a) => a.value ?? a.description ?? a.type).join(' ')
    events.push(`[console.${m.params.type}] ${text.slice(0, 300)}`)
  }
  if (m.method === 'Log.entryAdded' && m.params.entry.level === 'error') {
    events.push(`[log] ${m.params.entry.text.slice(0, 300)}`)
  }
  if (m.method === 'Network.loadingFailed') {
    events.push(`[net-fail] ${m.params.requestId} ${m.params.errorText}`)
  }
  if (m.method === 'Network.responseReceived' && m.params.response.status >= 400) {
    events.push(`[http ${m.params.response.status}] ${m.params.response.url.slice(0, 160)}`)
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
await send('Runtime.enable')
await send('Log.enable')
await send('Network.enable')

const evalJs = async (expression) => {
  const res = await send('Runtime.evaluate', { expression, awaitPromise: true, returnByValue: true })
  if (res.result?.exceptionDetails) {
    return { __error: res.result.exceptionDetails.exception?.description || res.result.exceptionDetails.text }
  }
  return res.result?.result?.value
}

await send('Page.navigate', { url: `${base}${startPath}` })
await sleep(5000)
events.length = 0

console.log(`在 ${startPath} 点击 ${selector} …\n`)
await evalJs(`(() => {
  const el = document.querySelector('${selector}');
  if (!el) return 'NOT FOUND';
  el.click();
  return 'clicked ' + (el.getAttribute('href') || '');
})()`)
await sleep(4000)

const state = await evalJs(`(() => ({
  path: location.pathname,
  h1: document.querySelector('h1')?.textContent?.trim().slice(0, 40) || '',
  rows: document.querySelectorAll('.row').length,
  cards: document.querySelectorAll('.feed-card').length,
  dayItems: document.querySelectorAll('.day-item').length,
  hasBackBtn: !!document.querySelector('.back-btn'),
  hasNavBtn: !!document.querySelector('.nav-btn'),
  bodyLen: document.body ? document.body.innerHTML.length : -1
}))()`)

console.log('页面状态：', JSON.stringify(state, null, 2))
console.log('\n期间的事件：')
if (!events.length) console.log('  （无）')
for (const e of events.slice(0, 30)) console.log('  ' + e)

ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
