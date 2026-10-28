<script setup lang="ts">
/**
 * /v2 —— 热门榜单（卡片版）
 *
 * 一屏 3×3 共 9 张卡片，每张最多 10 条，超出的在卡片内滚动。
 * 多出来的数据源走分页，不挤在一页里。
 */

interface FeedItem {
  rank?: number
  title: string
  desc?: string
  value?: string
  link?: string
  badge?: string
}

type Payload =
  | { kind: 'list'; items: FeedItem[]; total: number }
  | { kind: 'fields'; fields: Array<{ label: string; value: string }> }
  | { kind: 'text'; text: string; sub?: string }
  | { kind: 'image'; image: string; title?: string; desc?: string }

interface FeedRow {
  key: string
  title: string
  desc: string | null
  category: string
  render: string
  ok: boolean
  error: string | null
  fetchedAt: string | null
  upstreamUpdatedAt: string | null
  payload: Payload | null
  total: number
}

interface FeedsResponse {
  updatedAt: string | null
  totalFeeds: number
  okFeeds: number
  categories: Array<{ key: string; label: string; icon: string; count: number }>
  feeds: FeedRow[]
}

/** 一页 9 张卡；每张卡最多取 50 条，卡片内滚动就能看完，不用点进详情 */
const PAGE_SIZE = 9
const CARD_ITEMS = 50

const route = useRoute()
const category = ref(typeof route.query.c === 'string' && route.query.c ? route.query.c : 'all')
const page = ref(Number(route.query.p) > 0 ? Number(route.query.p) : 1)

const { data, pending, error, refresh } = await useCachedData(
  () => `feeds:${category.value}:${CARD_ITEMS}`,
  () =>
    $fetch<FeedsResponse>(apiUrl('/api/feeds'), {
      query: { category: category.value, preview: CARD_ITEMS }
    }),
  { ttl: 300_000 }
)

const categories = computed(() => data.value?.categories ?? [])
const feeds = computed<FeedRow[]>(() => data.value?.feeds ?? [])

const totalPages = computed(() => Math.max(1, Math.ceil(feeds.value.length / PAGE_SIZE)))
const pagedFeeds = computed(() => {
  const start = (page.value - 1) * PAGE_SIZE
  return feeds.value.slice(start, start + PAGE_SIZE)
})

const updatedLabel = computed(() => {
  const t = data.value?.updatedAt
  if (!t) return '暂无更新'
  const diff = Math.floor((Date.now() - new Date(t).getTime()) / 60000)
  if (diff < 1) return '刚刚更新'
  if (diff < 60) return `${diff} 分钟前更新`
  return `${Math.floor(diff / 60)} 小时前更新`
})

function syncQuery() {
  const q: Record<string, string> = {}
  if (category.value !== 'all') q.c = category.value
  if (page.value > 1) q.p = String(page.value)
  useRouter().replace({ query: q })
}

function pick(key: string) {
  if (category.value === key) return
  category.value = key
  page.value = 1
  syncQuery()
}

function changePage(p: number) {
  if (p < 1 || p > totalPages.value) return
  page.value = p
  syncQuery()
  if (import.meta.client) window.scrollTo({ top: 0, behavior: 'smooth' })
}

// 换分类后页码可能越界，兜底回第一页
watch(totalPages, (n) => {
  if (page.value > n) page.value = 1
})

useHead({ title: '热门榜单 · 瞭望台' })
</script>

<template>
  <div class="page">
    <!-- 标题区：和首页同一套排版 -->
    <header class="hero">
      <div class="hero-left">
        <div class="hero-icon">
          <svg viewBox="0 0 24 24" width="26" height="26" aria-hidden="true">
            <path
              fill="url(#flame)"
              d="M12 2c.6 3.7-1.6 5.3-2.9 6.9C7.8 10.5 6.5 12 6.5 14a5.5 5.5 0 0 0 11 0c0-1.3-.4-2.3-1-3.2-.3 1-.9 1.7-1.6 2.1.2-2.6-.9-4.6-2.4-6.1C11.2 5.5 11.6 3.6 12 2Z"
            />
            <defs>
              <linearGradient id="flame" x1="6" y1="2" x2="18" y2="20" gradientUnits="userSpaceOnUse">
                <stop stop-color="#f97316" />
                <stop offset="1" stop-color="#ef4444" />
              </linearGradient>
            </defs>
          </svg>
        </div>
        <div class="hero-text">
          <h1>热门榜单</h1>
          <p>
            <b>{{ data?.okFeeds ?? 0 }}</b>/{{ data?.totalFeeds ?? 0 }} 个数据源 · 每张卡 10 条 ·
            {{ updatedLabel }} · 每小时自动刷新
          </p>
        </div>
      </div>

      <button class="pill-btn" :class="{ spinning: pending }" @click="refresh()">
        <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
          <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
          <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
        </svg>
        刷新
      </button>
    </header>

    <!-- 分类 -->
    <nav class="tabs">
      <button class="tab" :class="{ on: category === 'all' }" @click="pick('all')">
        <span class="tab-icon">📋</span>
        全部
        <span class="cnt">{{ data?.totalFeeds ?? 0 }}</span>
      </button>
      <button
        v-for="c in categories"
        :key="c.key"
        class="tab"
        :class="{ on: category === c.key }"
        @click="pick(c.key)"
      >
        <span class="tab-icon">{{ c.icon }}</span>
        {{ c.label }}
        <span class="cnt">{{ c.count }}</span>
      </button>
    </nav>

    <div v-if="error" class="alert">加载失败：{{ error.message }}</div>

    <!-- 卡片 3×3 -->
    <div v-else class="grid">
      <FeedCard v-for="feed in pagedFeeds" :key="feed.key" :feed="feed" />
    </div>

    <AppPager
      v-if="totalPages > 1"
      :page="page"
      :total-pages="totalPages"
      :total="feeds.length"
      :page-size="PAGE_SIZE"
      @change="changePage"
    />
  </div>
</template>

<style scoped>
.page {
  max-width: 1240px;
  margin: 0 auto;
  padding: 14px 20px 18px;
}

/* ===== 标题区 ===== */
.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 10px;
  flex-wrap: wrap;
}

.hero-left {
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 0;
}

.hero-icon {
  flex: none;
  width: 44px;
  height: 44px;
  border-radius: 13px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(180deg, #fff7ed 0%, #ffedd5 100%);
  border: 1px solid #ffe0c2;
  box-shadow: 0 3px 10px rgba(249, 115, 22, 0.14);
}

.hero-text h1 {
  margin: 0;
  font-size: 21px;
  font-weight: 800;
  letter-spacing: -0.4px;
  color: #101828;
  line-height: 1.25;
}

.hero-text p {
  margin: 2px 0 0;
  font-size: 12px;
  color: var(--muted);
}

.hero-text b {
  color: #33425a;
  font-weight: 650;
}

.pill-btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 32px;
  padding: 0 12px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12.5px;
  font-weight: 550;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  flex: none;
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

/* ===== 分类 ===== */
.tabs {
  display: flex;
  gap: 6px;
  padding-bottom: 8px;
  overflow-x: auto;
  scrollbar-width: none;
}

.tabs::-webkit-scrollbar {
  display: none;
}

.tab {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 5px 11px;
  border-radius: 9px;
  border: 1px solid var(--line);
  background: #fff;
  color: #4a5768;
  font-size: 12.5px;
  font-weight: 550;
  white-space: nowrap;
  cursor: pointer;
  box-shadow: var(--shadow-sm);
}

.tab:hover {
  border-color: #cfe0fb;
  color: var(--brand);
}

.tab.on {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
  box-shadow: 0 3px 10px rgba(31, 111, 235, 0.25);
}

.tab-icon {
  font-size: 12px;
  line-height: 1;
}

.cnt {
  font-size: 10px;
  padding: 0 5px;
  border-radius: 5px;
  background: #f1f5fa;
  color: #8b9aad;
  line-height: 15px;
}

.tab.on .cnt {
  background: rgba(255, 255, 255, 0.22);
  color: #fff;
}

/* ===== 网格：固定 3 列 ===== */
.grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 12px;
  align-items: start;
}

.alert {
  padding: 10px 14px;
  border-radius: 10px;
  border: 1px solid #ffd9d9;
  background: #fff5f5;
  color: #b42318;
  font-size: 12.5px;
}

@media (max-width: 1100px) {
  .grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 720px) {
  .page {
    padding: 12px 14px 16px;
  }
  .grid {
    grid-template-columns: minmax(0, 1fr);
  }
  .hero-text h1 {
    font-size: 19px;
  }
}
</style>
