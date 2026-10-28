/**
 * CDP 截屏（支持真实移动视口模拟）。
 * 用法：node scripts/shot.mjs <url> <width> <height> <out.png> [mobile:true|false]
 */
import { spawn } from 'node:child_process'
import { mkdtempSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const [url = 'http://localhost:3000/', w = '1120', h = '1200', out = 'shots/out.png', mobile = 'false', full = 'false'] =
  process.argv.slice(2)
const width = Number(w)
const height = Number(h)
const isMobile = mobile === 'true'
const captureFull = full === 'true' || full === 'full'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9334
const profile = mkdtempSync(join(tmpdir(), 'cdp-shot-'))

const chrome = spawn(
  chromePath,
  [
    '--headless=new',
    '--disable-gpu',
    `--remote-debugging-port=${port}`,
    `--user-data-dir=${profile}`,
    `--window-size=${width},${height}`,
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
await send('Emulation.setDeviceMetricsOverride', {
  width,
  height,
  deviceScaleFactor: 2,
  mobile: isMobile,
  screenWidth: width,
  screenHeight: height
})
await send('Page.navigate', { url })
await sleep(3200)
const shot = await send('Page.captureScreenshot', { format: 'png', captureBeyondViewport: captureFull })
if (shot.result?.data) {
  writeFileSync(out, Buffer.from(shot.result.data, 'base64'))
  console.log(`saved ${out} (${width}x${height}, mobile=${isMobile})`)
} else {
  console.error('截图失败', JSON.stringify(shot).slice(0, 400))
}
ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
