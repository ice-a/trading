/**
 * 诊断 /history → / 导航卡住：区分「NuxtLink 点击」和「router.push」。
 * 用法：node scripts/diagnose-history.mjs
 */
import { spawn } from 'node:child_process'
import { mkdtempSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const base = process.env.SITE || 'http://localhost:3000'
const chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
const port = 9341
const profile = mkdtempSync(join(tmpdir(), 'cdp-diag-'))

const chrome = spawn(
  chromePath,
  ['--headless=new', '--disable-gpu', `--remote-debugging-port=${port}`, `--user-data-dir=${profile}`, '--window-size=1280,900', 'about:blank'],
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
const errors = []
const net = []
ws.onmessage = (ev) => {
  const m = JSON.parse(ev.data)
  if (m.id && pending.has(m.id)) {
    pending.get(m.id)(m)
    pending.delete(m.id)
    return
  }
  if (m.method === 'Runtime.exceptionThrown') {
    errors.push('[exception] ' + (m.params.exceptionDetails.exception?.description || m.params.exceptionDetails.text).slice(0, 400))
  }
  if (m.method === 'Runtime.consoleAPICalled') {
    const text = m.params.args.map((a) => a.value ?? a.description ?? a.type).join(' ').slice(0, 300)
    if (m.params.type === 'error') errors.push('[console.error] ' + text)
    else if (m.params.type === 'warning') errors.push('[console.warn] ' + text)
  }
  if (m.method === 'Network.requestWillBeSent') {
    const u = m.params.request.url
    if (u.includes('index') || u.includes('pages') || u.includes('_nuxt')) {
      net.push({ id: m.params.requestId, url: u.replace(base, '').slice(0, 120), status: null, ms: null, t: Date.now() })
    }
  }
  if (m.method === 'Network.responseReceived') {
    const hit = net.find((n) => n.id === m.params.requestId)
    if (hit) hit.status = m.params.response.status
  }
  if (m.method === 'Network.loadingFinished') {
    const hit = net.find((n) => n.id === m.params.requestId)
    if (hit) hit.ms = Date.now() - hit.t
  }
  if (m.method === 'Network.loadingFailed') {
    const hit = net.find((n) => n.id === m.params.requestId)
    if (hit) {
      hit.status = 'FAILED'
      hit.error = m.params.errorText
    }
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
await send('Network.enable')

const evalJs = async (expression) => {
  const res = await send('Runtime.evaluate', { expression, awaitPromise: true, returnByValue: true })
  if (res.result?.exceptionDetails) {
    return { __error: res.result.exceptionDetails.exception?.description || res.result.exceptionDetails.text }
  }
  return res.result?.result?.value
}

await send('Page.navigate', { url: `${base}/history` })
await sleep(5000)

console.log('① /history 初始状态')
console.log(JSON.stringify(await evalJs(`(() => {
  const app = document.querySelector('#__nuxt')?.__vue_app__;
  const router = app?.config?.globalProperties?.$router;
  return {
    path: location.pathname,
    hasApp: !!app,
    hasRouter: !!router,
    routePath: router?.currentRoute?.value?.path,
    h1: document.querySelector('h1')?.textContent?.trim().slice(0, 30)
  };
})()`), null, 2))

errors.length = 0
console.log('\n② 点击 .back-btn，分别看 1s / 3s / 8s 的页面数')
await evalJs(`document.querySelector('.back-btn')?.click(), 'ok'`)
for (const wait of [1000, 2000, 5000]) {
  await sleep(wait)
  const snap = await evalJs(`(() => ({
    t: Math.round(performance.now()),
    path: location.pathname,
    pages: document.querySelectorAll('#__nuxt > .page').length,
    h1: [...document.querySelectorAll('h1')].map(e => e.textContent.trim().slice(0, 14))
  }))()`)
  console.log('  ' + JSON.stringify(snap))
}

if (errors.length) {
  console.log('\n错误：')
  for (const e of errors.slice(0, 10)) console.log('  ' + e)
} else {
  console.log('\n无 JS 错误')
}

console.log('\n③ 改用 router.push("/") 再试')
await evalJs(`(async () => {
  const app = document.querySelector('#__nuxt')?.__vue_app__;
  const router = app?.config?.globalProperties?.$router;
  if (!router) return 'no router';
  await router.push('/');
  return 'pushed';
})()`)
await sleep(3000)
console.log(JSON.stringify(await evalJs(`(() => {
  const app = document.querySelector('#__nuxt')?.__vue_app__;
  const router = app?.config?.globalProperties?.$router;
  return {
    path: location.pathname,
    routePath: router?.currentRoute?.value?.path,
    h1: document.querySelector('h1')?.textContent?.trim().slice(0, 30),
    rows: document.querySelectorAll('.row').length
  };
})()`), null, 2))

console.log('\n④ DOM 结构诊断')
console.log(JSON.stringify(await evalJs(`(() => {
  const h1s = [...document.querySelectorAll('h1')].map(el => el.textContent.trim().slice(0, 24));
  const nuxt = document.querySelector('#__nuxt');
  return {
    h1Count: h1s.length,
    h1s,
    topLevelChildren: nuxt ? [...nuxt.children].map(el => el.tagName + '.' + (el.className || '').toString().slice(0, 40)) : [],
    hasBackBtn: !!document.querySelector('.back-btn'),
    hasNavBtn: !!document.querySelector('.nav-btn'),
    navBtnHref: document.querySelector('.nav-btn')?.getAttribute('href') || null,
    backBtnHref: document.querySelector('.back-btn')?.getAttribute('href') || null
  };
})()`), null, 2))

console.log('\n⑤ 导航期间的前端资源请求')
if (!net.length) console.log('  （无）')
for (const n of net.slice(0, 15)) {
  console.log(`  ${String(n.status).padEnd(7)} ${String(n.ms ?? '-').padEnd(6)} ${n.url}`)
}

console.log('\n⑥ 错误')
if (!errors.length) console.log('  （无）')
for (const e of errors.slice(0, 10)) console.log('  ' + e)

ws.close()
chrome.kill()
await sleep(200)
process.exit(0)
