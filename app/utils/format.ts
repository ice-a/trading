/** 数字格式化工具（自动导入，模板里直接用） */

/** 36600 → 36.6k */
export function compactNumber(n: number | null | undefined): string {
  const v = Number(n ?? 0)
  if (!Number.isFinite(v) || v <= 0) return '0'
  if (v >= 1_000_000) return `${trim(v / 1_000_000)}m`
  if (v >= 1_000) return `${trim(v / 1_000)}k`
  return String(v)
}

/** 2244 → 2,244 */
export function plainNumber(n: number | null | undefined): string {
  const v = Math.round(Number(n ?? 0))
  if (!Number.isFinite(v)) return '0'
  return v.toLocaleString('en-US')
}

/** 总计用：1,234,567 → 1.2m，控制在 6 字符内 */
export function humanTotal(n: number | null | undefined): string {
  const v = Number(n ?? 0)
  if (v < 10_000) return plainNumber(v)
  return compactNumber(v)
}

function trim(v: number): string {
  return v >= 100 ? String(Math.round(v)) : v.toFixed(1).replace(/\.0$/, '')
}

/** 今日增长的分级配色：越高越绿 */
export function growthLevel(n: number): 'hot' | 'warm' | 'cool' {
  if (n >= 1000) return 'hot'
  if (n >= 300) return 'warm'
  return 'cool'
}
