/**
 * 时区日期工具。
 * "今日" 的口径由 APP_TIMEZONE 决定（默认 Asia/Shanghai），
 * 全部榜单文档都以 `date: 'YYYY-MM-DD'` 作为分区键落在 MongoDB 里。
 */

export function dayKeyOf(date: Date = new Date(), timeZone = 'Asia/Shanghai'): string {
  const fmt = new Intl.DateTimeFormat('en-CA', {
    timeZone,
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  })
  const parts = fmt.formatToParts(date)
  const get = (t: string) => parts.find((p) => p.type === t)?.value ?? ''
  return `${get('year')}-${get('month')}-${get('day')}`
}

export function isValidDayKey(value: unknown): value is string {
  if (typeof value !== 'string' || !/^\d{4}-\d{2}-\d{2}$/.test(value)) return false
  const t = Date.parse(`${value}T00:00:00Z`)
  return Number.isFinite(t)
}

/** 把某个时区的本地时间显示出来，例如 10:32:07 */
export function clockLabel(date: Date = new Date(), timeZone = 'Asia/Shanghai'): string {
  return new Intl.DateTimeFormat('zh-CN', {
    timeZone,
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false
  }).format(date)
}

/** 2026-10-27 → 2026年10月27日 周二 */
export function humanDay(dayKey: string, timeZone = 'Asia/Shanghai'): string {
  const d = new Date(`${dayKey}T12:00:00Z`)
  const weekday = new Intl.DateTimeFormat('zh-CN', { timeZone, weekday: 'short' }).format(d)
  const [y, m, dd] = dayKey.split('-')
  return `${y}年${Number(m)}月${Number(dd)}日 ${weekday}`
}

export function relativeTime(from: number | Date, now = Date.now()): string {
  const t = typeof from === 'number' ? from : from.getTime()
  const diff = Math.max(0, now - t)
  const min = Math.floor(diff / 60000)
  if (min < 1) return '刚刚'
  if (min < 60) return `${min} 分钟前`
  const h = Math.floor(min / 60)
  if (h < 24) return `${h} 小时前`
  return `${Math.floor(h / 24)} 天前`
}
