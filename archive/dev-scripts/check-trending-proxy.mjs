/**
 * 走本地 HTTP 代理抓 GitHub Trending（undici ProxyAgent）。
 * 用法：node scripts/check-trending-proxy.mjs [proxyUrl]
 */
import * as cheerio from 'cheerio'
import { fetch as undiciFetch, ProxyAgent } from 'undici'

const proxyUrl = process.argv[2] || process.env.GITHUB_PROXY || process.env.HTTPS_PROXY || 'http://127.0.0.1:7897'
const dispatcher = new ProxyAgent(proxyUrl)

const t0 = Date.now()
const res = await undiciFetch('https://github.com/trending?since=daily', {
  dispatcher,
  headers: {
    'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
    Accept: 'text/html,application/xhtml+xml',
    'Accept-Language': 'en-US,en;q=0.9'
  }
})

console.log(`✓ 代理 ${proxyUrl}  HTTP ${res.status}  ${Date.now() - t0}ms`)
const html = await res.text()
console.log(`HTML ${html.length} 字节`)

const $ = cheerio.load(html)
const rows = $('article.Box-row')
console.log(`article.Box-row = ${rows.length}`)

const toNumber = (raw) => {
  if (!raw) return 0
  const m = String(raw).replace(/,/g, '').match(/([\d.]+)\s*([km]?)/i)
  if (!m) return 0
  let n = parseFloat(m[1])
  const u = (m[2] || '').toLowerCase()
  if (u === 'k') n *= 1000
  if (u === 'm') n *= 1000000
  return Math.round(n)
}

const list = []
rows.each((i, el) => {
  const $r = $(el)
  const href = ($r.find('h2 a').first().attr('href') || '').replace(/^\//, '')
  const lang = $r.find('[itemprop="programmingLanguage"]').first().text().trim()
  const color = ($r.find('.repo-language-color').first().attr('style') || '').match(/#[0-9a-f]{3,8}/i)?.[0] || '-'
  const stars = $r.find('a[href$="/stargazers"]').first().text().trim()
  const forks = $r.find('a[href$="/forks"]').first().text().trim()
  let today = $r.find('span.d-inline-block.float-sm-right').first().text().trim()
  if (!today) {
    const m = $r.text().replace(/\s+/g, ' ').match(/[\d.,]+\s*[kKmM]?\s*stars?\s+(today|this week|this month)/i)
    today = m ? m[0] : ''
  }
  list.push({
    rank: i + 1,
    repo: href,
    lang: lang || '(无)',
    color,
    stars: toNumber(stars),
    forks: toNumber(forks),
    today: toNumber(today.match(/[\d.,]+\s*[kKmM]?/)?.[0] || ''),
    todayRaw: today,
    desc: $r.find('p').first().text().replace(/\s+/g, ' ').trim().slice(0, 40)
  })
})

console.table(list.slice(0, 12))
console.log('仓库名字段解析成功:', list.filter((x) => x.repo.includes('/')).length, '/', rows.length)
console.log('今日增长解析成功  :', list.filter((x) => x.today > 0).length, '/', rows.length)
await dispatcher.close()
