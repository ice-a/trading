/**
 * 验证卡片内容区是否真的可滚动。
 * 用法：node scripts/check-scroll.mjs [url]
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const base = process.env.SITE || 'http://localhost:3000'
const path = process.argv[2] || '/v2'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9342
const profile = mkdtempSync(join(tmpdir(), 'cdp-scroll-'))

const chrome = spawn(
  chromePath,
  ['--headless=new', '--disable-gpu', `--remote-debugging-port=${port}`, `--user-data-dir=${profile}`, '--window-size=1280,1400', 'about:blank'],
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
await send('Emulation.setDeviceMetricsOverride', {
  width: Number(process.env.VW || 1280),
  height: Number(process.env.VH || 900),
  deviceScaleFactor: 1,
  mobile: false
})

const evalJs = async (expression) => {
  const res = await send('Runtime.evaluate', { expression, awaitPromise: true, returnByValue: true })
  if (res.result?.exceptionDetails) return { error: res.result.exceptionDetails.text }
  return res.result?.result?.value
}

await send('Page.navigate', { url: `${base}${path}` })
await sleep(4500)

const info = await evalJs(`(() => {
  const areas = [...document.querySelectorAll('.scroll-area')];
  const cards = [...document.querySelectorAll('.feed-card')];
  const scrollable = areas.filter(a => a.scrollHeight > a.clientHeight + 2);
  const doc = document.documentElement;
  return {
    /* 一页 9 张是否能一屏放下 */
    viewportH: doc.clientHeight,
    pageH: doc.scrollHeight,
    fitsOneScreen: doc.scrollHeight <= doc.clientHeight + 2,
    cardH: cards[0] ? Math.round(cards[0].getBoundingClientRect().height) : 0,
    cards: cards.length,
    scrollAreas: areas.length,
    scrollableCount: scrollable.length,
    sample: scrollable.slice(0, 3).map(a => ({
      title: a.closest('.feed-card')?.querySelector('.card-title')?.textContent?.trim().slice(0, 14),
      clientH: a.clientHeight,
      scrollH: a.scrollHeight,
      overflowY: getComputedStyle(a).overflowY
    }))
  };
})()`)
console.log('① 卡片滚动 & 一屏适配')
console.log(JSON.stringify(info, null, 2))

// 真的滚一下，确认内容会移动
const scrolled = await evalJs(`(() => {
  const a = [...document.querySelectorAll('.scroll-area')].find(el => el.scrollHeight > el.clientHeight + 2);
  if (!a) return { error: '没有可滚动的卡片' };
  const before = a.scrollTop;
  a.scrollTop = a.scrollHeight;
  return {
    title: a.closest('.feed-card')?.querySelector('.card-title')?.textContent?.trim().slice(0, 14),
    before,
    after: a.scrollTop,
    maxScroll: a.scrollHeight - a.clientHeight,
    moved: a.scrollTop > before
  };
})()`)
console.log('\n② 实际滚动测试')
console.log(JSON.stringify(scrolled, null, 2))

ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
