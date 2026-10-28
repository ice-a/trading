/**
 * 探测 60s API 全部端点的数据形态，用于设计统一渲染器。
 * 用法：node scripts/probe-60s.mjs
 * 输出：data/probe-60s.json + 控制台摘要
 */
import { mkdirSync, writeFileSync } from 'node:fs'
import { join } from 'node:path'

const BASE = process.env.API_60S_BASE || 'https://60.020417.xyz'
const CONCURRENCY = 4
const TIMEOUT = 20000

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

function shapeOf(value, depth = 0) {
  if (value === null) return 'null'
  if (Array.isArray(value)) {
    if (!value.length) return 'array<empty>'
    const first = value[0]
    if (first && typeof first === 'object') {
      return { kind: 'array', itemKeys: Object.keys(first) }
    }
    return { kind: 'array', itemType: typeof first }
  }
  if (typeof value === 'object') {
    const out = {}
    for (const [k, v] of Object.entries(value)) {
      out[k] = depth < 2 && v && typeof v === 'object' ? shapeOf(v, depth + 1) : typeof v
    }
    return { kind: 'object', keys: out }
  }
  return typeof value
}

async function probe(path) {
  // 根路径返回的 endpoints 已经带 /v2 前缀
  const url = `${BASE}${path}`
  const started = Date.now()
  try {
    const res = await fetch(url, {
      headers: { Accept: 'application/json', 'User-Agent': 'github-trending-daily/probe' },
      signal: AbortSignal.timeout(TIMEOUT)
    })
    const text = await res.text()
    let json = null
    try {
      json = JSON.parse(text)
    } catch {
      return { path, ok: false, status: res.status, ms: Date.now() - started, error: 'invalid json', preview: text.slice(0, 120) }
    }
    return {
      path,
      ok: json.code === 200,
      status: res.status,
      code: json.code,
      ms: Date.now() - started,
      message: json.message?.slice(0, 40),
      dataShape: shapeOf(json.data),
      sample: JSON.stringify(json.data)?.slice(0, 300)
    }
  } catch (err) {
    return { path, ok: false, status: 0, ms: Date.now() - started, error: err?.message || String(err) }
  }
}

const root = await fetch(`${BASE}/`, { signal: AbortSignal.timeout(TIMEOUT) }).then((r) => r.json())
const endpoints = (root.endpoints || []).filter((p) => typeof p === 'string')
console.log(`API ${root.api_version} · 共 ${endpoints.length} 个端点\n`)

const results = []
for (let i = 0; i < endpoints.length; i += CONCURRENCY) {
  const batch = endpoints.slice(i, i + CONCURRENCY)
  const settled = await Promise.all(batch.map((p) => probe(p)))
  results.push(...settled)
  process.stdout.write(`\r  探测进度 ${Math.min(i + CONCURRENCY, endpoints.length)}/${endpoints.length}`)
  await sleep(300)
}
console.log('\n')

mkdirSync('data', { recursive: true })
writeFileSync(join('data', 'probe-60s.json'), JSON.stringify({ apiVersion: root.api_version, endpoints, results }, null, 2))

// 摘要
const okCount = results.filter((r) => r.ok).length
console.log(`成功 ${okCount}/${results.length}\n`)

const table = results.map((r) => {
  let shape = '—'
  if (r.dataShape?.kind === 'array' && r.dataShape.itemKeys) shape = `array[${r.dataShape.itemKeys.join(',')}]`
  else if (r.dataShape?.kind === 'array') shape = `array<${r.dataShape.itemType}>`
  else if (r.dataShape?.kind === 'object') shape = `object{${Object.keys(r.dataShape.keys).join(',')}}`
  else if (r.dataShape) shape = String(r.dataShape)
  return { path: r.path, ok: r.ok ? '✓' : '✗', ms: r.ms, shape: shape.slice(0, 110) }
})
console.table(table)

console.log('\n数据已保存到 data/probe-60s.json')
