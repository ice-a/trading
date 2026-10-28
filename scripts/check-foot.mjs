/**
 * 诊断首页表格底部 .foot 被压成竖条的问题。
 * 用法：node scripts/check-foot.mjs [url]
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const base = process.env.SITE || 'http://localhost:3000'
const path = process.argv[2] || '/'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9343
const profile = mkdtempSync(join(tmpdir(), 'cdp-foot-'))

const chrome = spawn(
  chromePath,
  ['--headless=new', '--disable-gpu', `--remote-debugging-port=${port}`, `--user-data-dir=${profile}`, '--window-size=1200,1400', 'about:blank'],
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
  throw new Error('CDP not ready')
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
  if (res.result?.exceptionDetails) return { error: res.result.exceptionDetails.text }
  return res.result?.result?.value
}

await send('Page.navigate', { url: `${base}${path}` })

// 等表格和底部说明都渲染出来
for (let i = 0; i < 40; i++) {
  await sleep(500)
  const ready = await evalJs(
    `!!document.querySelector('.table') && !!document.querySelector('.foot') && document.querySelectorAll('.row').length >= 1`
  )
  if (ready === true) break
}
await sleep(500)

const info = await evalJs(`(() => {
  const tables = [...document.querySelectorAll('.table')];
  const foots = [...document.querySelectorAll('.foot')];
  const pick = (el) => {
    const r = el.getBoundingClientRect();
    const cs = getComputedStyle(el);
    return {
      cls: String(el.className),
      w: Math.round(r.width),
      h: Math.round(r.height),
      x: Math.round(r.left),
      display: cs.display,
      gridTemplateColumns: cs.gridTemplateColumns,
      width: cs.width,
      text: (el.textContent || '').trim().slice(0, 24)
    };
  };
  return {
    tableCount: tables.length,
    footCount: foots.length,
    rows: document.querySelectorAll('.row').length,
    skeleton: document.querySelectorAll('.skeleton-row').length,
    tables: tables.map(pick),
    foots: foots.map(pick),
    tableChildren: tables[0] ? [...tables[0].children].map(el => el.className) : []
  };
})()`)
console.log(JSON.stringify(info, null, 2))

ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
