/**
 * 用 CDP 精确测量窄屏布局，定位溢出元素。
 * 用法：node scripts/inspect-layout.mjs [url] [width]
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const url = process.argv[2] || 'http://localhost:3000/'
const width = Number(process.argv[3] || 430)
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9333
const profile = mkdtempSync(join(tmpdir(), 'cdp-profile-'))

const chrome = spawn(
  chromePath,
  [
    '--headless=new',
    '--disable-gpu',
    '--hide-scrollbars',
    `--remote-debugging-port=${port}`,
    `--user-data-dir=${profile}`,
    `--window-size=${width},1000`,
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

const wsUrl = await getWsUrl()
const ws = new WebSocket(wsUrl)
let msgId = 0
const pending = new Map()

ws.onmessage = (ev) => {
  const msg = JSON.parse(ev.data)
  if (msg.id && pending.has(msg.id)) {
    pending.get(msg.id)(msg)
    pending.delete(msg.id)
  }
}

function send(method, params = {}) {
  const id = ++msgId
  return new Promise((resolve) => {
    pending.set(id, resolve)
    ws.send(JSON.stringify({ id, method, params }))
  })
}

await new Promise((r) => (ws.onopen = r))

await send('Emulation.setDeviceMetricsOverride', {
  width,
  height: 1000,
  deviceScaleFactor: 1,
  mobile: true
})
await send('Page.navigate', { url })
await sleep(3500)

const expr = `(() => {
  const pick = (sel) => {
    const el = document.querySelector(sel)
    if (!el) return null
    const r = el.getBoundingClientRect()
    const cs = getComputedStyle(el)
    return {
      sel,
      w: Math.round(r.width),
      left: Math.round(r.left),
      right: Math.round(r.right),
      cols: cs.gridTemplateColumns,
      display: cs.display,
      overflowX: cs.overflowX
    }
  }
  const wide = []
  document.querySelectorAll('body *').forEach((el) => {
    const r = el.getBoundingClientRect()
    if (r.right > document.documentElement.clientWidth + 1) {
      wide.push({ cls: el.className?.toString?.().slice(0, 40) || el.tagName, right: Math.round(r.right), w: Math.round(r.width) })
    }
  })
  return JSON.stringify({
    viewport: { innerWidth: window.innerWidth, clientWidth: document.documentElement.clientWidth, scrollWidth: document.documentElement.scrollWidth, bodyScroll: document.body.scrollWidth },
    page: pick('.page'),
    table: pick('.table'),
    row: pick('.row'),
    rank: pick('.row .c-rank'),
    repo: pick('.row .c-repo'),
    desc: pick('.row .c-desc'),
    today: pick('.row .c-today'),
    stars: pick('.row .c-stars'),
    overflowCount: wide.length,
    overflowSample: wide.slice(0, 12)
  }, null, 2)
})()`

const res = await send('Runtime.evaluate', { expression: expr, returnByValue: true })
console.log(res.result?.result?.value ?? JSON.stringify(res, null, 2))

ws.close()
chrome.kill()
await sleep(300)
process.exit(0)
