/**
 * 一次性自检：抓 GitHub Trending 页面并用 cheerio 解析，验证选择器是否有效。
 * 用法：node scripts/check-trending.mjs
 */
import * as cheerio from 'cheerio'

const url = 'https://github.com/trending?since=daily'
const res = await fetch(url, {
  headers: {
    'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
    Accept: 'text/html,application/xhtml+xml',
    'Accept-Language': 'en-US,en;q=0.9'
  }
})

console.log(`HTTP ${res.status} ${res.statusText}  content-type=${res.headers.get('content-type')}`)
const html = await res.text()
console.log(`HTML 长度: ${html.length}`)

const $ = cheerio.load(html)
const rows = $('article.Box-row')
console.log(`article.Box-row 数量: ${rows.length}`)

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
  const href = $r.find('h2 a').first().attr('href') || ''
  const desc = $r.find('p').first().text().replace(/\s+/g, ' ').trim()
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
    repo: href.replace(/^\//, ''),
    lang,
    color,
    stars: toNumber(stars),
    forks: toNumber(forks),
    today: toNumber(today.match(/[\d.,]+\s*[kKmM]?/)?.[0] || ''),
    todayRaw: today,
    desc: desc.slice(0, 48)
  })
})

console.table(list.slice(0, 12))
console.log('\n解析成功率:', list.filter((x) => x.repo.includes('/')).length, '/', rows.length)
console.log('今日增长非零:', list.filter((x) => x.today > 0).length, '/', rows.length)
