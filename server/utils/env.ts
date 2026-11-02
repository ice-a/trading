/**
 * 运行时配置：`.env` 文件 + `process.env`。
 *
 * 单机部署后就没有 Worker binding、没有 runtimeConfig 桥接了 —— 只有一层：
 *   启动时把 `.env` 读进 process.env（已存在的变量不覆盖），之后全项目只读 env()。
 *
 * 为什么自己解析而不是装 dotenv：
 *   依赖越少越好（1C1G 的机器，node_modules 越小越好），.env 语法也只有
 *   KEY=VALUE + 注释两种，20 行足够。
 *
 * 优先级：systemd / shell 里显式导出的变量 > `.env` 文件 > 代码里的默认值。
 */

import { existsSync, readFileSync } from 'node:fs'
import { resolve } from 'node:path'

let loaded = false

function unquote(raw: string): string {
  const v = raw.trim()
  if (v.length >= 2) {
    const first = v[0]
    const last = v[v.length - 1]
    if ((first === '"' && last === '"') || (first === "'" && last === "'")) {
      return v.slice(1, -1)
    }
  }
  return v
}

/** 加载 .env（幂等；文件不存在则静默跳过） */
export function loadEnvFile(path = resolve(process.cwd(), '.env')): void {
  if (loaded) return
  loaded = true
  if (!existsSync(path)) return

  try {
    const text = readFileSync(path, 'utf8')
    for (const line of text.split(/\r?\n/)) {
      const trimmed = line.trim()
      if (!trimmed || trimmed.startsWith('#')) continue
      const eq = trimmed.indexOf('=')
      if (eq <= 0) continue
      const key = trimmed.slice(0, eq).trim()
      if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(key)) continue
      if (process.env[key] !== undefined) continue // 显式导出优先
      process.env[key] = unquote(trimmed.slice(eq + 1))
    }
  } catch {
    /* .env 读失败不阻塞启动，缺的变量走默认值 */
  }
}

/** 读取一个环境变量（空串视为未配置） */
export function env(key: string, fallback = ''): string {
  loadEnvFile()
  const value = process.env[key]
  if (value == null || String(value).trim() === '') return fallback
  return String(value).trim()
}

/** 布尔开关：1/true/yes/on 为真 */
export function envFlag(key: string, fallback = false): boolean {
  const raw = env(key, '').toLowerCase()
  if (!raw) return fallback
  return raw === '1' || raw === 'true' || raw === 'yes' || raw === 'on'
}

/** 数字开关，非法或 <=0 时回退 */
export function envInt(key: string, fallback: number): number {
  const n = Number(env(key, ''))
  return Number.isFinite(n) && n > 0 ? Math.floor(n) : fallback
}