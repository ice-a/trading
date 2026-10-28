<script setup lang="ts">
/**
 * /dns —— Cloudflare DNS 记录缓存
 *
 * 记录来自 MongoDB（dns_records）。没有 CF Token 也能用：
 * 直接展示库里缓存的状态与延迟，点「探活」会并发请求一次并写回结果。
 */

interface DnsItem {
  name: string
  host: string
  type?: string
  target?: string
  proxied?: boolean
  status?: 'online' | 'offline' | 'unknown'
  latencyMs?: number
  httpStatus?: number
  checkedAt?: string
}

interface DnsResponse {
  total: number
  online: number
  offline: number
  checkedAt: string | null
  probed: boolean
  source?: 'cloudflare' | 'cache'
  cfConfigured?: boolean
  cfError?: string | null
  items: DnsItem[]
}

const probing = ref(false)
const showOffline = ref(true)

const { data, pending, error, refresh } = await useCachedData(
  () => 'dns:list',
  () => $fetch<DnsResponse>(apiUrl('/api/dns')),
  { ttl: 120_000 }
)

const items = computed<DnsItem[]>(() => data.value?.items ?? [])
const visible = computed(() => (showOffline.value ? items.value : items.value.filter((i) => i.status === 'online')))

const updatedLabel = computed(() => {
  const t = data.value?.checkedAt
  if (!t) return '暂无记录'
  const d = new Date(t)
  return d.toLocaleTimeString('zh-CN', { hour12: false })
})

async function probe() {
  if (probing.value) return
  probing.value = true
  try {
    await $fetch(apiUrl('/api/dns'), { query: { probe: 1 } })
    clearDataCache('dns:list')
    await refresh()
  } catch {
    /* 忽略，下面刷新已有数据 */
  } finally {
    probing.value = false
  }
}

function latencyClass(ms?: number) {
  if (!ms) return 'off'
  if (ms < 300) return 'fast'
  if (ms < 1000) return 'mid'
  return 'slow'
}

useHead({ title: 'Cloudflare DNS · 瞭望台' })
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
        <h1>Cloudflare DNS</h1>
        <p>
          共 <b>{{ data?.total ?? 0 }}</b> 条记录 ·
          <span class="ok">{{ data?.online ?? 0 }}</span> 在线 ·
          <span class="bad">{{ data?.offline ?? 0 }}</span> 离线
          <span class="dot-sep">·</span>
          最后更新 {{ updatedLabel }}
          <span class="dot-sep">·</span>
          <span class="src" :class="data?.source === 'cloudflare' ? 'live' : 'cached'">
            {{ data?.source === 'cloudflare' ? 'Cloudflare API' : '本地缓存' }}
          </span>
        </p>
      </div>

      <div class="hero-actions">
        <label class="switch">
          <input v-model="showOffline" type="checkbox" />
          <span class="slider" />
          <span class="switch-label">显示离线站点</span>
        </label>

        <button class="pill-btn primary" :class="{ spinning: probing }" :disabled="probing" @click="probe">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
            <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
          </svg>
          {{ probing ? '探活中…' : '手动刷新' }}
        </button>
      </div>
    </header>

    <div v-if="error" class="alert">加载失败：{{ error.message }}</div>

    <div v-else-if="pending && !items.length" class="grid">
      <div v-for="i in 8" :key="`sk-${i}`" class="card sk">
        <div class="skeleton" style="width: 55%; height: 13px" />
        <div class="skeleton" style="width: 40%; height: 10px; margin-top: 10px" />
      </div>
    </div>

    <div v-else-if="visible.length" class="grid">
      <article v-for="it in visible" :key="it.host" class="card" :class="{ offline: it.status === 'offline' }">
        <header class="card-head">
          <h3 class="name">{{ it.name }}</h3>
          <svg class="ext" viewBox="0 0 16 16" width="11" height="11" aria-hidden="true">
            <path
              fill="currentColor"
              d="M3.75 2h3.5a.75.75 0 0 1 0 1.5h-3.5a.25.25 0 0 0-.25.25v8.5c0 .138.112.25.25.25h8.5a.25.25 0 0 0 .25-.25v-3.5a.75.75 0 0 1 1.5 0v3.5A1.75 1.75 0 0 1 12.25 14h-8.5A1.75 1.75 0 0 1 2 12.25v-8.5C2 2.784 2.784 2 3.75 2Zm6.5-1.5h4.5a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0V2.56L8.28 8.28a.75.75 0 0 1-1.06-1.06L12.94 1.5h-2.69a.75.75 0 0 1 0-1.5Z"
            />
          </svg>
        </header>

        <p class="host">{{ it.host }}</p>

        <div class="status">
          <span class="badge" :class="it.status">
            <span class="dot" />
            {{ it.status === 'online' ? '在线' : it.status === 'offline' ? '离线' : '未知' }}
          </span>
          <span v-if="it.latencyMs" class="latency" :class="latencyClass(it.latencyMs)">{{ it.latencyMs }}ms</span>
          <span v-if="it.httpStatus" class="http">HTTP {{ it.httpStatus }}</span>
        </div>

        <div class="meta">
          <span v-if="it.type" class="type">{{ it.type }}</span>
          <span v-if="it.proxied" class="proxy">CF 代理</span>
        </div>

        <footer class="card-foot">
          <a class="open-btn" :href="`https://${it.host}`" target="_blank" rel="noopener noreferrer">
            打开
            <svg viewBox="0 0 16 16" width="10" height="10" aria-hidden="true">
              <path fill="currentColor" d="M6 3.75 10.25 8 6 12.25V3.75Z" />
            </svg>
          </a>
        </footer>
      </article>
    </div>

    <div v-else class="empty">
      <p>没有可显示的记录</p>
      <p class="empty-sub">往 dns_records 集合里插入数据即可，或用 seed 脚本生成样例</p>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 1240px;
  margin: 0 auto;
  padding: 18px 20px 28px;
}

.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 14px;
  flex-wrap: wrap;
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

.hero-left b {
  color: #33425a;
  font-weight: 650;
}

.ok {
  color: #0f8a44;
  font-weight: 650;
}

.src {
  font-size: 11px;
  font-weight: 650;
  padding: 1px 7px;
  border-radius: 5px;
}

.src.live {
  background: #e8f8ee;
  color: #0f8a44;
}

.src.cached {
  background: #f1f5fa;
  color: #7b8999;
}

.bad {
  color: #c2410c;
  font-weight: 650;
}

.dot-sep {
  color: #cbd5e1;
  margin: 0 3px;
}

.hero-actions {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

/* 开关 */
.switch {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  cursor: pointer;
  user-select: none;
}

.switch input {
  display: none;
}

.slider {
  position: relative;
  width: 32px;
  height: 18px;
  border-radius: 999px;
  background: #d8e2ee;
  transition: background 0.18s ease;
}

.slider::after {
  content: '';
  position: absolute;
  top: 2px;
  left: 2px;
  width: 14px;
  height: 14px;
  border-radius: 50%;
  background: #fff;
  box-shadow: 0 1px 3px rgba(16, 32, 56, 0.25);
  transition: transform 0.18s ease;
}

.switch input:checked + .slider {
  background: var(--brand);
}

.switch input:checked + .slider::after {
  transform: translateX(14px);
}

.switch-label {
  font-size: 12px;
  color: #56657a;
}

.pill-btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 34px;
  padding: 0 13px;
  border-radius: 10px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12.5px;
  font-weight: 550;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
}

.pill-btn.primary {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
}

.pill-btn.primary:disabled {
  opacity: 0.7;
  cursor: default;
}

.pill-btn.spinning svg {
  animation: spin 0.9s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(246px, 1fr));
  gap: 12px;
}

.card {
  display: flex;
  flex-direction: column;
  position: relative;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  padding: 11px 12px;
  min-height: 148px;
  transition: all 0.15s ease;
}

.card:hover {
  border-color: #cfe0fb;
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}

.card.offline {
  background: #fcfcfd;
}

.card.sk {
  min-height: 96px;
}

.card-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 8px;
  padding-right: 14px;
}

.name {
  margin: 0;
  font-size: 13px;
  font-weight: 700;
  color: #16233a;
  line-height: 1.35;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
}

.ext {
  position: absolute;
  top: 11px;
  right: 11px;
  color: #c3cfdf;
}

.card:hover .ext {
  color: var(--brand);
}

.host {
  margin: 2px 0 0;
  font-size: 11px;
  color: #93a1b4;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.status {
  display: flex;
  align-items: center;
  gap: 7px;
  margin-top: 8px;
  flex-wrap: wrap;
}

.badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 11px;
  font-weight: 600;
  padding: 1px 7px;
  border-radius: 999px;
}

.badge.online {
  background: #e8f8ee;
  color: #0f8a44;
}

.badge.offline {
  background: #f5f0ee;
  color: #b45309;
}

.badge.unknown {
  background: #f1f5fa;
  color: #7b8999;
}

.dot {
  width: 5px;
  height: 5px;
  border-radius: 50%;
  background: currentColor;
}

.latency {
  font-size: 11px;
  font-variant-numeric: tabular-nums;
  padding: 1px 6px;
  border-radius: 5px;
}

.latency.fast {
  background: #e8f8ee;
  color: #0f8a44;
}
.latency.mid {
  background: #eef7e9;
  color: #4d7c0f;
}
.latency.slow {
  background: #fff4e5;
  color: #b45309;
}
.latency.off {
  background: #f1f5fa;
  color: #8b9aad;
}

.http {
  font-size: 10.5px;
  color: #a4b0bf;
}

.meta {
  display: flex;
  gap: 5px;
  margin-top: 7px;
  flex-wrap: wrap;
}

.type,
.proxy {
  font-size: 10px;
  padding: 0 5px;
  border-radius: 4px;
  line-height: 16px;
}

.type {
  background: #f1f5fa;
  color: #7b8999;
}

.proxy {
  background: #fff4e5;
  color: #b45309;
}

.card-foot {
  margin-top: auto;
  padding-top: 8px;
}

.open-btn {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  padding: 4px 9px;
  border-radius: 7px;
  border: 1px solid #cfe0fb;
  background: #f7fbff;
  color: var(--brand);
  font-size: 11.5px;
  font-weight: 600;
}

.open-btn:hover {
  background: #e9f2ff;
  border-color: #a9c9f5;
}

.alert {
  padding: 10px 14px;
  border-radius: 10px;
  border: 1px solid #ffd9d9;
  background: #fff5f5;
  color: #b42318;
  font-size: 12.5px;
}

.empty {
  padding: 48px 20px;
  text-align: center;
  color: #8b9aad;
  font-size: 13px;
}

.empty-sub {
  margin-top: 6px;
  font-size: 12px;
  color: #b0bccb;
}

@media (max-width: 720px) {
  .page {
    padding: 14px 14px 24px;
  }
  .grid {
    grid-template-columns: minmax(0, 1fr);
  }
}
</style>
