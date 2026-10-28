<script setup lang="ts">
/**
 * 一言卡片：每 60 秒自动换一句，底部细进度条走完即刷新。
 * 刷新间隔可在 .env / nuxt.config 里调（hitokotoRefreshMs）。
 */
interface Quote {
  text: string
  from: string
  source: 'remote' | 'local'
}

const props = defineProps<{ initial?: Quote | null }>()

const quote = ref<Quote | null>(props.initial ?? null)
const fading = ref(false)
const ticker = ref(0)

const REFRESH_MS = 60_000
const BAR_SECONDS = REFRESH_MS / 1000

let refreshTimer: ReturnType<typeof setInterval> | null = null
let tickTimer: ReturnType<typeof setInterval> | null = null

async function load() {
  fading.value = true
  try {
    const data = await $fetch<Quote>(apiUrl('/api/hitokoto'))
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
  <div class="hitokoto" :class="{ fading }">
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
  margin-bottom: 18px;
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
