<script setup lang="ts">
/** /share —— 分享集合页：所有被分享过的卡片都在这里 */
interface ShareItem {
  sid: string
  type: string
  title: string
  desc: string
  url: string
  badge: string
  views: number
  createdAt: string | null
}

const { data, pending, refresh } = await useCachedData(
  () => 'share:list',
  () => $fetch<{ total: number; items: ShareItem[] }>(apiUrl('/api/share'), { query: { limit: 60 } }),
  { ttl: 60_000 }
)

const items = computed<ShareItem[]>(() => data.value?.items ?? [])

const typeLabel: Record<string, string> = {
  nav: '网站导航',
  ai: 'AI 资源',
  repo: '仓库',
  dns: 'DNS',
  custom: '分享'
}

function ago(iso: string | null) {
  if (!iso) return ''
  const diff = Date.now() - new Date(iso).getTime()
  const m = Math.floor(diff / 60000)
  if (m < 1) return '刚刚'
  if (m < 60) return `${m} 分钟前`
  const h = Math.floor(m / 60)
  if (h < 24) return `${h} 小时前`
  return `${Math.floor(h / 24)} 天前`
}

useHead({ title: '分享 · 瞭望台' })
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
        <h1>分享</h1>
        <p>从任意卡片点「分享」生成的页面都汇总在这里 · 共 <b>{{ data?.total ?? 0 }}</b> 条</p>
      </div>
      <button class="pill-btn" :class="{ spinning: pending }" @click="refresh()">
        <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
          <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
          <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
        </svg>
        刷新
      </button>
    </header>

    <div v-if="pending && !items.length" class="grid">
      <div v-for="i in 6" :key="`sk-${i}`" class="card sk">
        <div class="skeleton" style="width: 50%; height: 13px" />
        <div class="skeleton" style="width: 80%; height: 10px; margin-top: 10px" />
      </div>
    </div>

    <div v-else-if="items.length" class="grid">
      <NuxtLink v-for="s in items" :key="s.sid" :to="`/s/${s.sid}`" class="card">
        <header class="card-head">
          <span class="badge">{{ s.badge || typeLabel[s.type] || '分享' }}</span>
          <span class="views">{{ s.views }} 浏览</span>
        </header>
        <h3 class="title">{{ s.title }}</h3>
        <p v-if="s.desc" class="desc">{{ s.desc }}</p>
        <footer class="card-foot">
          <span class="time">{{ ago(s.createdAt) }}</span>
          <span class="go">查看 →</span>
        </footer>
      </NuxtLink>
    </div>

    <div v-else class="empty">
      <div class="empty-icon">🔗</div>
      <p class="empty-title">还没有任何分享</p>
      <p class="empty-sub">去「网站导航」或「AI 资源台」，点卡片右上角的分享按钮试试</p>
      <div class="empty-actions">
        <NuxtLink to="/nav" class="pill-btn">去网站导航</NuxtLink>
        <NuxtLink to="/ai" class="pill-btn">去 AI 资源台</NuxtLink>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 1100px;
  margin: 0 auto;
  padding: 18px 20px 32px;
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

.pill-btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
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
  grid-template-columns: repeat(auto-fill, minmax(268px, 1fr));
  gap: 12px;
}

.card {
  display: flex;
  flex-direction: column;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  padding: 12px 13px;
  min-height: 132px;
  transition: all 0.15s ease;
}

.card:hover {
  border-color: #cfe0fb;
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}

.card.sk {
  min-height: 90px;
}

.card-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.badge {
  padding: 1px 8px;
  border-radius: 999px;
  background: #eef4ff;
  color: #3f6fd8;
  font-size: 10.5px;
  font-weight: 650;
}

.views {
  font-size: 10.5px;
  color: #b0bccb;
}

.title {
  margin: 9px 0 0;
  font-size: 14px;
  font-weight: 700;
  color: #16233a;
  line-height: 1.4;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
}

.desc {
  margin: 5px 0 0;
  font-size: 11.5px;
  color: #7b8999;
  line-height: 1.45;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
}

.card-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: auto;
  padding-top: 10px;
  font-size: 10.5px;
  color: #b0bccb;
}

.go {
  color: var(--brand);
  font-weight: 600;
}

.empty {
  padding: 64px 20px;
  text-align: center;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 14px;
  box-shadow: var(--shadow-sm);
}

.empty-icon {
  font-size: 34px;
  margin-bottom: 10px;
}

.empty-title {
  margin: 0;
  font-size: 15px;
  font-weight: 650;
  color: #3b4a5e;
}

.empty-sub {
  margin: 6px 0 16px;
  font-size: 12.5px;
  color: var(--muted);
}

.empty-actions {
  display: flex;
  gap: 8px;
  justify-content: center;
  flex-wrap: wrap;
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
