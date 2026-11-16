<script setup lang="ts">
/**
 * 一言卡片：每 60 秒自动换一句，底部细进度条走完即刷新。
 * 刷新间隔固定 60 秒（组件的 setInterval）。
 *
 * compact 模式：嵌入顶栏品牌区与页签之间 —— 透明底、单行截断、高度贴合栏高；
 * 仍挂在 AppHeader（全局常驻），切页时组件不重建、计时器不重置。
 */
import { fetchHitokoto, type Quote } from '~/utils/hitokoto'

interface Props {
  /** 紧凑模式：嵌在顶栏里 */
  compact?: boolean
}

const props = defineProps<Props>()

// 常驻在顶栏里，不再由页面传入 initial：切页时组件不重建，计时器也不重置
const quote = ref<Quote | null>(null)
const fading = ref(false)
const ticker = ref(0)

const REFRESH_MS = 60_000
const BAR_SECONDS = REFRESH_MS / 1000

let refreshTimer: ReturnType<typeof setInterval> | null = null
let tickTimer: ReturnType<typeof setInterval> | null = null

async function load() {
  fading.value = true
  try {
    const data = await fetchHitokoto()
    if (data?.text) quote.value = data
  } catch {
    /* 拿不到就保留上一句 */
  } finally {
    window.setTimeout(() => (fading.value = false), 200)
    ticker.value = 0
  }
}

onMounted(() => {
  if (!quote.value) void load()
  refreshTimer = setInterval(() => void load(), REFRESH_MS)
  tickTimer = setInterval(() => {
    ticker.value = (ticker.value + 1) % BAR_SECONDS
  }, 1000)
})

onBeforeUnmount(() => {
  if (refreshTimer) clearInterval(refreshTimer)
  if (tickTimer) clearInterval(tickTimer)
})
</script>

<template>
  <div class="hitokoto" :class="{ fading, compact: props.compact }">
    <div class="left">
      <span class="quote-mark">“</span>
      <div class="body">
        <p class="text">{{ quote?.text || '正在装载今日一言…' }}</p>
        <p class="from">
          <span class="dash">—</span>
          <span>{{ quote?.from || '一言' }}</span>
          <span v-if="quote?.source === 'local'" class="tag">本地兜底</span>
        </p>
      </div>
    </div>
    <div class="right">
      <span class="refresh-hint">
        <span class="dot" />
        {{ BAR_SECONDS }}s 后更新
      </span>
    </div>
    <div class="bar">
      <div class="bar-fill" :key="ticker === 0 ? 'reset' : 'run'" />
    </div>
  </div>
</template>

<style scoped>
.hitokoto {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 14px 20px 16px;
  border-radius: var(--radius);
  border: 1px solid #e3ebf7;
  background: linear-gradient(100deg, #f7faff 0%, #fbf8ff 55%, #f6fbfa 100%);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: opacity 0.2s ease;
}

.hitokoto.fading .text {
  opacity: 0.35;
}

.left {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  min-width: 0;
}

.quote-mark {
  font-family: Georgia, 'Times New Roman', serif;
  font-size: 40px;
  line-height: 0.7;
  color: #b9cdf0;
  user-select: none;
  margin-top: 2px;
}

.body {
  min-width: 0;
}

.text {
  margin: 0;
  font-size: 14.5px;
  color: #23324a;
  letter-spacing: 0.2px;
  transition: opacity 0.2s ease;
  word-break: break-word;
}

.from {
  margin: 3px 0 0;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--muted);
}

.dash {
  color: #c3cfdf;
}

.tag {
  padding: 0 5px;
  border-radius: 4px;
  background: #fff4e5;
  color: #b45309;
  font-size: 10.5px;
  line-height: 16px;
}

.right {
  flex: none;
  display: flex;
  align-items: center;
}

.refresh-hint {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 11.5px;
  color: #8b9bb0;
  white-space: nowrap;
}

.dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #34c759;
  animation: pulse-dot 1.8s ease-in-out infinite;
}

.bar {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  height: 2px;
  background: rgba(31, 111, 235, 0.07);
}

.bar-fill {
  height: 100%;
  width: 100%;
  transform-origin: left center;
  background: linear-gradient(90deg, #7ab8ff, #4b7bec);
  animation: countdown 60s linear infinite;
}

@keyframes countdown {
  from {
    transform: scaleX(0);
  }
  to {
    transform: scaleX(1);
  }
}

/* ===== 紧凑模式：嵌在顶栏内 ===== */
.hitokoto.compact {
  align-self: stretch;
  display: flex;
  flex: 1;
  min-width: 0;
  align-items: center;
  gap: 10px;
  padding: 0;
  border: none;
  border-radius: 0;
  background: none;
  box-shadow: none;
  overflow: visible;
}

.hitokoto.compact .left {
  align-items: center;
  flex: 1;
  min-width: 0;
}

.hitokoto.compact .quote-mark {
  font-size: 26px;
  margin-top: 0;
  color: #c7d7f2;
}

.hitokoto.compact .body {
  flex: 1;
  min-width: 0;
}

.hitokoto.compact .text {
  font-size: 13px;
  line-height: 1.4;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: normal;
}

.hitokoto.compact .from {
  position: absolute;
  width: 1px;
  height: 1px;
  overflow: hidden;
  clip: rect(0 0 0 0);
  white-space: nowrap;
}

.hitokoto.compact .right {
  flex: none;
}

.hitokoto.compact .bar {
  bottom: 6px;
  left: 0;
  right: 0;
  height: 2px;
  border-radius: 999px;
}

@media (max-width: 720px) {
  .hitokoto.compact {
    display: none;
  }
}

@media (prefers-reduced-motion: reduce) {
  .hitokoto.compact .bar-fill {
    animation: none;
  }
}

@media (max-width: 720px) {
  .hitokoto {
    padding: 12px 16px 14px;
  }
  .right {
    display: none;
  }
  .text {
    font-size: 13.5px;
  }
}
</style>
