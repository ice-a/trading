<script setup lang="ts">
/**
 * /avatar —— 个性头像生成器
 *
 * 纯前端：一个 seed 唯一确定一张头像（同 seed 永远同一张），
 * 支持 4 种风格、深/浅背景、随机轮播、导出 1024px PNG。
 */

type StyleKey = 'blob' | 'square' | 'bean' | 'splat'

const STYLES: Array<{ key: StyleKey; name: string }> = [
  { key: 'blob', name: '圆润怪' },
  { key: 'square', name: '方块脸' },
  { key: 'bean', name: '豆豆怪' },
  { key: 'splat', name: '涂鸦派' }
]

const BGS = [
  { key: 'light', name: '浅色' },
  { key: 'dark', name: '深色' }
]

const seed = ref(0)
const style = ref<StyleKey>('blob')
const bg = ref<'light' | 'dark'>('light')
const playing = ref(false)
const downloading = ref(false)

/* ---------- 伪随机：同一 seed 得到同一串数 ---------- */
function mulberry32(a: number) {
  return () => {
    a |= 0
    a = (a + 0x6d2b79f5) | 0
    let t = Math.imul(a ^ (a >>> 15), 1 | a)
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296
  }
}

const SKIN = ['#7fd6f0', '#9ee7c6', '#ffd166', '#ff9ec7', '#c3b1ff', '#ffb27a', '#8fd3ff', '#b8e986']
const INK = ['#1b2a41', '#22314a', '#2d3a52']
const ACCENT = ['#4b7bec', '#f76c6c', '#f7b731', '#26de81', '#a55eea', '#fd9644']

const BG_LIGHT = ['#f5f8ff', '#f7f4ff', '#f2fbf6', '#fff7f0']
const BG_DARK = ['#1b2436', '#221d33', '#16261f', '#2a1f2d']

function buildSvg(s: number, st: StyleKey, bgKey: 'light' | 'dark'): string {
  const rnd = mulberry32(s)
  const pick = <T,>(arr: T[]): T => arr[Math.floor(rnd() * arr.length)]!
  const between = (a: number, b: number) => a + rnd() * (b - a)

  const skin = pick(SKIN)
  const ink = pick(INK)
  const accent = pick(ACCENT)
  const bgColor = bgKey === 'dark' ? pick(BG_DARK) : pick(BG_LIGHT)

  const cx = 128
  const cy = 132
  const rot = between(-8, 8)
  const eyeGap = between(28, 38)
  const eyeY = cy - between(2, 12)
  const eyeR = between(7, 12)
  const mouthY = cy + between(22, 32)

  // 眼睛：4 种画法
  const eyeStyle = Math.floor(rnd() * 4)
  const eye = (x: number) => {
    switch (eyeStyle) {
      case 0: // 圆点
        return `<circle cx="${x}" cy="${eyeY}" r="${eyeR}" fill="${ink}"/>`
      case 1: // 竖椭圆
        return `<ellipse cx="${x}" cy="${eyeY}" rx="${eyeR * 0.55}" ry="${eyeR * 1.15}" fill="${ink}"/>`
      case 2: // 叉
        return `<path d="M${x - eyeR * 0.8} ${eyeY - eyeR * 0.8} l${eyeR * 1.6} ${eyeR * 1.6} M${x + eyeR * 0.8} ${eyeY - eyeR * 0.8} l${-eyeR * 1.6} ${eyeR * 1.6}" stroke="${ink}" stroke-width="3.4" stroke-linecap="round" fill="none"/>`
      default: // 半圆眼
        return `<path d="M${x - eyeR} ${eyeY} a${eyeR} ${eyeR} 0 0 1 ${eyeR * 2} 0 Z" fill="${ink}"/>`
    }
  }

  // 嘴：5 种画法
  const mouthStyle = Math.floor(rnd() * 5)
  const mouth = (() => {
    switch (mouthStyle) {
      case 0:
        return `<path d="M${cx - 13} ${mouthY} q13 11 26 0" stroke="${ink}" stroke-width="3.2" stroke-linecap="round" fill="none"/>`
      case 1:
        return `<ellipse cx="${cx}" cy="${mouthY + 2}" rx="8" ry="6" fill="${ink}"/>`
      case 2:
        return `<path d="M${cx - 10} ${mouthY} h20" stroke="${ink}" stroke-width="3.2" stroke-linecap="round"/>`
      case 3:
        return `<path d="M${cx - 11} ${mouthY - 3} q11 14 22 0" stroke="${ink}" stroke-width="3" stroke-linecap="round" fill="${accent}" fill-opacity="0.35"/>`
      default:
        return `<path d="M${cx - 9} ${mouthY} q9 -9 18 0" stroke="${ink}" stroke-width="3.2" stroke-linecap="round" fill="none"/>`
    }
  })()

  // 腮红
  const blush =
    rnd() > 0.45
      ? `<ellipse cx="${cx - eyeGap - 6}" cy="${eyeY + 20}" rx="8" ry="5" fill="${accent}" opacity="0.45"/>
         <ellipse cx="${cx + eyeGap + 6}" cy="${eyeY + 20}" rx="8" ry="5" fill="${accent}" opacity="0.45"/>`
      : ''

  // 头顶装饰
  const decorType = Math.floor(rnd() * 3)
  const decor =
    decorType === 0
      ? `<path d="M${cx - 22} ${cy - 62} q8 -18 16 0 M${cx + 6} ${cy - 64} q8 -20 16 0" stroke="${ink}" stroke-width="2.6" fill="none" stroke-linecap="round"/>`
      : decorType === 1
        ? `<circle cx="${cx + between(-6, 10)}" cy="${cy - 66}" r="${between(3, 6)}" fill="${accent}"/>`
        : ''

  // 主体形状
  let body = ''
  if (st === 'blob') {
    const r = between(58, 68)
    body = `<path d="M${cx - r} ${cy} a${r} ${r * between(0.94, 1.06)} 0 1 0 ${r * 2} 0 a${r} ${r * between(0.94, 1.06)} 0 1 0 ${-r * 2} 0 Z" fill="${skin}"/>`
  } else if (st === 'square') {
    const w = between(56, 64)
    const rr = between(12, 22)
    body = `<rect x="${cx - w}" y="${cy - w}" width="${w * 2}" height="${w * 2}" rx="${rr}" ry="${rr}" fill="${skin}"/>`
  } else if (st === 'bean') {
    const w = between(50, 58)
    const h = between(64, 74)
    body = `<ellipse cx="${cx}" cy="${cy}" rx="${w}" ry="${h}" fill="${skin}"/>`
  } else {
    // 涂鸦派：多边形
    const n = 9
    const base = between(58, 70)
    const pts: string[] = []
    for (let i = 0; i < n; i++) {
      const ang = (Math.PI * 2 * i) / n
      const rad = base * between(0.86, 1.14)
      pts.push(`${(cx + Math.cos(ang) * rad).toFixed(1)},${(cy + Math.sin(ang) * rad).toFixed(1)}`)
    }
    body = `<polygon points="${pts.join(' ')}" fill="${skin}"/>`
  }

  // 小装饰点
  const dots = Array.from({ length: 3 }, () => {
    const ang = between(0, Math.PI * 2)
    const rad = between(78, 104)
    const x = cx + Math.cos(ang) * rad
    const y = cy + Math.sin(ang) * rad
    return `<circle cx="${x.toFixed(1)}" cy="${y.toFixed(1)}" r="${between(2, 4).toFixed(1)}" fill="${accent}" opacity="0.65"/>`
  }).join('')

  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="512" height="512">
  <rect width="256" height="256" rx="40" fill="${bgColor}"/>
  ${dots}
  <g transform="rotate(${rot.toFixed(1)} ${cx} ${cy})">
    ${body}
    ${decor}
    ${eye(cx - eyeGap)}
    ${eye(cx + eyeGap)}
    ${blush}
    ${mouth}
  </g>
</svg>`
}

const svgMarkup = computed(() => buildSvg(seed.value, style.value, bg.value))

/* ---------- 随机 / 轮播 ---------- */
let timer: ReturnType<typeof setInterval> | null = null

function roll() {
  seed.value = Math.floor(Math.random() * 100_000_000)
}

function togglePlay() {
  playing.value = !playing.value
  if (playing.value) {
    roll()
    timer = setInterval(roll, 1600)
  } else if (timer) {
    clearInterval(timer)
    timer = null
  }
}

onBeforeUnmount(() => {
  if (timer) clearInterval(timer)
})

/* ---------- 导出 PNG ---------- */
async function download() {
  if (downloading.value) return
  downloading.value = true
  try {
    const svg = svgMarkup.value
    const blob = new Blob([svg], { type: 'image/svg+xml;charset=utf-8' })
    const url = URL.createObjectURL(blob)

    const img = new Image()
    await new Promise<void>((resolve, reject) => {
      img.onload = () => resolve()
      img.onerror = () => reject(new Error('svg load failed'))
      img.src = url
    })

    const size = 1024
    const canvas = document.createElement('canvas')
    canvas.width = size
    canvas.height = size
    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('canvas 不可用')
    ctx.imageSmoothingEnabled = true
    ctx.drawImage(img, 0, 0, size, size)
    URL.revokeObjectURL(url)

    const pngUrl = canvas.toDataURL('image/png')
    const a = document.createElement('a')
    a.href = pngUrl
    a.download = `avatar-${style.value}-${seed.value}.png`
    a.click()
  } catch {
    /* 静默失败，界面不打扰 */
  } finally {
    downloading.value = false
  }
}

onMounted(() => {
  const q = useRoute().query.seed
  seed.value = q && !Number.isNaN(Number(q)) ? Number(q) : Math.floor(Math.random() * 100_000_000)
})

useHead({ title: '个性头像 · 瞭望台' })
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
        <h1>个性头像</h1>
        <p>seed 可复现 · 可导出 1024 × 1024 PNG</p>
      </div>
    </header>

    <div class="panel">
      <!-- 预览 -->
      <div class="preview" :class="bg">
        <div class="avatar-wrap" v-html="svgMarkup" />
      </div>

      <!-- 控制 -->
      <div class="controls">
        <div class="field">
          <label>物种 / 风格</label>
          <div class="chips">
            <button
              v-for="s in STYLES"
              :key="s.key"
              class="chip"
              :class="{ on: style === s.key }"
              @click="style = s.key"
            >
              {{ s.name }}
            </button>
          </div>
        </div>

        <div class="field">
          <label>Seed</label>
          <div class="seed-row">
            <input v-model.number="seed" type="number" min="0" max="99999999" />
            <button class="mini" @click="roll">按 Seed 生成</button>
          </div>
        </div>

        <div class="field">
          <label>背景</label>
          <div class="chips">
            <button v-for="b in BGS" :key="b.key" class="chip" :class="{ on: bg === b.key }" @click="bg = b.key">
              {{ b.name }}
            </button>
          </div>
        </div>

        <div class="actions">
          <button class="btn primary" @click="togglePlay">
            {{ playing ? '暂停动画' : '🎲 随机一张' }}
          </button>
          <button class="btn" :disabled="downloading" @click="download">
            {{ downloading ? '导出中…' : '⬇ 下载 PNG' }}
          </button>
        </div>

        <p class="tip">
          同一个 Seed 永远生成同一张头像。觉得好看就把 Seed 记下来，填回输入框即可复现。
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 1040px;
  margin: 0 auto;
  padding: 18px 20px 32px;
}

.hero {
  margin-bottom: 14px;
}

.hero-left h1 {
  margin: 0;
  font-size: 22px;
  font-weight: 800;
  letter-spacing: -0.3px;
  background: linear-gradient(120deg, #1f6feb 0%, #4f46e5 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.hero-left p {
  margin: 3px 0 0;
  font-size: 12.5px;
  color: var(--muted);
}

.panel {
  display: grid;
  grid-template-columns: minmax(0, 1.1fr) minmax(280px, 0.9fr);
  gap: 18px;
  align-items: start;
}

.preview {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
  border-radius: 16px;
  border: 1px solid var(--line);
  box-shadow: var(--shadow-md);
  background: #fff;
  min-height: 340px;
}

.preview.dark {
  background: #1b2436;
  border-color: #2a3550;
}

.avatar-wrap {
  width: min(320px, 100%);
  aspect-ratio: 1;
}

.avatar-wrap :deep(svg) {
  width: 100%;
  height: 100%;
  display: block;
  border-radius: 18px;
}

.controls {
  display: flex;
  flex-direction: column;
  gap: 14px;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 14px;
  box-shadow: var(--shadow-sm);
  padding: 16px;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 7px;
}

.field label {
  font-size: 11.5px;
  font-weight: 650;
  color: var(--muted);
  letter-spacing: 0.3px;
}

.chips {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.chip {
  padding: 5px 11px;
  border-radius: 8px;
  border: 1px solid var(--line);
  background: #fff;
  color: #4a5768;
  font-size: 12px;
  font-weight: 550;
  cursor: pointer;
  transition: all 0.15s ease;
}

.chip:hover {
  border-color: #cfe0fb;
  color: var(--brand);
}

.chip.on {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
  box-shadow: 0 3px 10px rgba(31, 111, 235, 0.25);
}

.seed-row {
  display: flex;
  gap: 8px;
}

.seed-row input {
  flex: 1;
  min-width: 0;
  height: 34px;
  padding: 0 10px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  font-size: 13px;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  color: #22314a;
  outline: 0;
}

.seed-row input:focus {
  border-color: var(--brand);
  box-shadow: 0 0 0 3px rgba(31, 111, 235, 0.12);
}

.mini {
  flex: none;
  height: 34px;
  padding: 0 11px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12px;
  cursor: pointer;
}

.mini:hover {
  border-color: #b9cdee;
  color: var(--brand);
}

.actions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.btn {
  flex: 1;
  min-width: 132px;
  height: 38px;
  border-radius: 10px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.15s ease;
}

.btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

.btn.primary {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
}

.btn.primary:hover {
  background: #1a5fd0;
  color: #fff;
}

.btn:disabled {
  opacity: 0.65;
  cursor: default;
}

.tip {
  margin: 0;
  font-size: 11.5px;
  line-height: 1.6;
  color: #a4b0bf;
}

@media (max-width: 860px) {
  .page {
    padding: 14px 14px 24px;
  }
  .panel {
    grid-template-columns: minmax(0, 1fr);
  }
  .preview {
    min-height: 280px;
  }
}
</style>
