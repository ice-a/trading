<script setup lang="ts">
import type { TrendingResponse } from '~~/server/utils/types'

/**
 * /history —— 历史榜单
 *
 * 左侧：所有有数据的日期（含当天摘要）
 * 右侧：选中日期的完整榜单（复用首页的表格 + 分页组件）
 */

interface HistoryDay {
  date: string
  label: string
  isToday: boolean
  count: number
  droppedCount: number
  totalTodayStars: number
  topRepo: string
  topStars: number
  lastSeenAt: string | null
}

interface HistoryOverview {
  today: string
  totalDays: number
  totalRepos: number
  days: HistoryDay[]
}

const route = useRoute()
const router = useRouter()

/**
 * 页面里不要无条件 top-level await：那会让组件变成 async 组件并被 Suspense 包裹，
 * 客户端导航时旧页面会一直留在 DOM 里（表现就是「URL 变了但页面不切换」）。
 * 只在 SSR 阶段 await（保证数据进 payload），客户端走响应式更新。
 */
const overviewData = useCachedData(
  () => 'history:overview',
  () => $fetch<HistoryOverview>(apiUrl('/api/history')),
  { ttl: 120_000 }
)
if (import.meta.server) await overviewData
const { data: overview, pending: loadingOverview } = overviewData

const days = computed(() => overview.value?.days ?? [])

/** 默认选中：最近一个「非今天」的日期（进历史页先看历史更像历史页），没有就走最新 */
const initialDate = (() => {
  const q = route.query.date
  if (typeof q === 'string' && q) return q
  const list = days.value
  return (list.find((d) => !d.isToday) ?? list[0])?.date ?? ''
})()

/** 榜单周期：日 / 周 / 月 */
type Period = 'daily' | 'weekly' | 'monthly'
const periodRawH = typeof route.query.period === 'string' ? route.query.period : ''
const period = ref<Period>(['daily', 'weekly', 'monthly'].includes(periodRawH) ? (periodRawH as Period) : 'daily')

const selected = ref(initialDate)

/** 切换周期：保留已选日期，回到第一页；日期在新周期没有数据时回退到最近一天 */
function changePeriod(p: Period) {
  if (period.value === p) return
  period.value = p
  page.value = 1
}
const page = ref(Math.max(1, Number(route.query.page) || 1))

const detailData = useCachedData(
  () => `history:detail:${selected.value}:${page.value}`,
  () =>
    $fetch<TrendingResponse>(apiUrl('/api/trending'), {
      query: { date: selected.value || undefined, page: page.value }
    }),
  { ttl: 60_000 }
)
if (import.meta.server) await detailData
const { data: detail, pending } = detailData

/**
 * URL 同步改成「仅用户主动切换时」触发。
 * 之前用 watch(selected, page) 无条件 router.replace，会在组件卸载/导航过程中改 URL，
 * 和正在进行的导航抢路由状态，导致离开本页时页面卡住不切换。
 */
function syncQuery() {
  const query: Record<string, string> = {}
  if (selected.value) query.date = selected.value
  if (page.value > 1) query.page = String(page.value)
  if (period.value !== 'daily') query.period = period.value
  router.replace({ query })
}

const current = computed(() => days.value.find((d) => d.date === selected.value) ?? null)
const items = computed(() => detail.value?.items ?? [])

function select(date: string) {
  if (date === selected.value) return
  selected.value = date
  page.value = 1
  syncQuery()
}

function changePage(p: number) {
  page.value = p
  syncQuery()
  if (import.meta.client) window.scrollTo({ top: 0, behavior: 'smooth' })
}

useHead({
  title: () => (current.value ? `历史榜单 · ${current.value.date}` : '历史榜单')
})
</script>

<template>
  <div class="page">
    <!-- 顶部 -->
    <header class="hero">
      <PeriodSwitch v-model="period" @update:model-value="changePeriod" />
      <div class="hero-left">
<div class="titles">
          <h1>历史榜单</h1>
          <p>
            共 <b>{{ overview?.totalDays ?? 0 }}</b> 天 · <b>{{ overview?.totalRepos ?? 0 }}</b> 条仓库记录
            <span class="hint">· 掉出前 10 的记录也按日期留在这里</span>
          </p>
        </div>
      </div>
    </header>

    <!-- 空态 -->
    <div v-if="!loadingOverview && !days.length" class="empty-card">
      <div class="empty-icon">🗂️</div>
      <p class="empty-title">还没有历史数据</p>
      <p class="empty-sub">抓取任务每天落一份数据，第二天起这里就会出现记录</p>
      <NuxtLink to="/" class="pill-btn">回到今日</NuxtLink>
    </div>

    <div v-else class="layout">
      <!-- 日期列表 -->
      <aside class="sidebar">
        <div class="sidebar-head">日期</div>
        <div class="day-list">
          <template v-if="loadingOverview && !days.length">
            <div v-for="i in 6" :key="`sk-${i}`" class="day-item skeleton-item">
              <div class="skeleton" style="width: 62%; height: 12px" />
              <div class="skeleton" style="width: 40%; height: 10px; margin-top: 8px" />
            </div>
          </template>

          <button
            v-for="d in days"
            :key="d.date"
            class="day-item"
            :class="{ active: d.date === selected, 'is-today': d.isToday }"
            @click="select(d.date)"
          >
            <div class="day-top">
              <span class="day-date">{{ d.date }}</span>
              <span v-if="d.isToday" class="tag-today">今日</span>
            </div>
            <div class="day-meta">
              <span>{{ d.count }} 条</span>
              <span class="dot-sep">·</span>
              <span class="growth">+{{ plainNumber(d.totalTodayStars) }}</span>
              <span v-if="d.droppedCount > 0" class="dot-sep">·</span>
              <span v-if="d.droppedCount > 0" class="dropped">掉榜 {{ d.droppedCount }}</span>
            </div>
            <div v-if="d.topRepo" class="day-top-repo">
              <svg viewBox="0 0 24 24" width="11" height="11" aria-hidden="true">
                <path
                  fill="currentColor"
                  d="M3 8.5 6.6 11 12 5.2 17.4 11 21 8.5l-1.6 9.9a1 1 0 0 1-1 .8H5.6a1 1 0 0 1-1-.8L3 8.5Z"
                />
              </svg>
              <span class="ellipsis">{{ d.topRepo }}</span>
            </div>
          </button>
        </div>
      </aside>

      <!-- 右侧榜单 -->
      <section class="main">
        <div class="detail-head">
          <div class="detail-titles">
            <h2>{{ current?.label || detail?.humanDate || '—' }}</h2>
            <p>
              <b>{{ detail?.total ?? 0 }}</b> 条记录 · 今日增长合计
              <b>{{ plainNumber(current?.totalTodayStars ?? detail?.stats.totalTodayStars ?? 0) }}</b>
              <span v-if="current?.droppedCount" class="dropped"> · 掉榜保留 {{ current.droppedCount }}</span>
            </p>
          </div>
          <NuxtLink v-if="current && !current.isToday" to="/" class="pill-btn">
            回到今日
          </NuxtLink>
        </div>

        <TrendingTable
          :items="items"
          :loading="pending"
          :empty-hint="`${selected || '这一天'} 没有记录`"
        />

        <AppPager
          v-if="(detail?.total ?? 0) > 0"
          :page="page"
          :total-pages="detail?.totalPages ?? 1"
          :total="detail?.total ?? 0"
          :page-size="detail?.pageSize ?? 10"
          :loading="pending"
          @change="changePage"
        />
      </section>
    </div>

    <footer class="foot">
      <span>历史数据全部来自 MongoDB，按日期分区留存</span>
      <span class="dot-sep">·</span>
      <NuxtLink to="/">返回今日榜单</NuxtLink>
    </footer>
  </div>
</template>

<style scoped>
.page {
  max-width: 1180px;
  margin: 0 auto;
  padding: 26px 20px 48px;
}

/* ===== 顶部 ===== */
.hero {
  margin-bottom: 18px;
}

.hero-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.back-btn {
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
  transition: all 0.15s ease;
}

.back-btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

.titles h1 {
  margin: 0;
  font-size: 24px;
  font-weight: 800;
  letter-spacing: -0.4px;
  background: linear-gradient(120deg, #1f6feb 0%, #4f46e5 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.titles p {
  margin: 3px 0 0;
  font-size: 12.5px;
  color: var(--muted);
}

.titles b {
  color: #33425a;
  font-weight: 650;
}

.hint {
  color: #a4b0bf;
}

/* ===== 布局 ===== */
.layout {
  display: grid;
  grid-template-columns: 264px minmax(0, 1fr);
  gap: 16px;
  align-items: start;
}

/* ===== 侧栏 ===== */
.sidebar {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: var(--radius);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  position: sticky;
  top: 16px;
}

.sidebar-head {
  padding: 10px 14px;
  font-size: 11.5px;
  font-weight: 650;
  letter-spacing: 0.4px;
  color: var(--muted);
  background: var(--card-soft);
  border-bottom: 1px solid var(--line);
}

.day-list {
  max-height: min(72vh, 720px);
  overflow-y: auto;
  padding: 6px;
}

.day-item {
  display: block;
  width: 100%;
  text-align: left;
  padding: 9px 10px;
  margin-bottom: 2px;
  border: 1px solid transparent;
  border-radius: 9px;
  background: transparent;
  cursor: pointer;
  transition: all 0.14s ease;
}

.day-item:hover {
  background: #f6faff;
}

.day-item.active {
  background: #edf4ff;
  border-color: #cfe0fb;
  box-shadow: inset 2px 0 0 var(--brand);
}

.day-top {
  display: flex;
  align-items: center;
  gap: 6px;
}

.day-date {
  font-size: 13px;
  font-weight: 650;
  color: #253248;
  font-variant-numeric: tabular-nums;
  letter-spacing: 0.2px;
}

.day-item.active .day-date {
  color: var(--brand);
}

.tag-today {
  padding: 0 5px;
  border-radius: 4px;
  background: #e7f8ee;
  color: #0f8a44;
  font-size: 10px;
  line-height: 15px;
  font-weight: 600;
}

.day-meta {
  display: flex;
  align-items: center;
  gap: 4px;
  margin-top: 3px;
  font-size: 11px;
  color: #8b9aad;
  flex-wrap: wrap;
}

.day-meta .growth {
  color: #0f8a44;
  font-weight: 600;
}

.day-meta .dropped {
  color: #b08a4a;
}

.day-top-repo {
  display: flex;
  align-items: center;
  gap: 4px;
  margin-top: 3px;
  font-size: 11px;
  color: #9aa7b7;
}

.day-top-repo svg {
  color: #f0b429;
  flex: none;
}

.ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.dot-sep {
  color: #cbd5e1;
}

.skeleton-item {
  pointer-events: none;
}

/* ===== 主区 ===== */
.main {
  min-width: 0;
}

.detail-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 10px;
  padding: 0 2px;
  flex-wrap: wrap;
}

.detail-titles h2 {
  margin: 0;
  font-size: 16px;
  font-weight: 700;
  color: #16233a;
}

.detail-titles p {
  margin: 3px 0 0;
  font-size: 12px;
  color: var(--muted);
}

.detail-titles b {
  color: #33425a;
  font-weight: 650;
}

.detail-titles .dropped {
  color: #b08a4a;
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
  transition: all 0.15s ease;
}

.pill-btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

/* ===== 空态 ===== */
.empty-card {
  padding: 64px 20px;
  text-align: center;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: var(--radius);
  box-shadow: var(--shadow-sm);
}

.empty-icon {
  font-size: 36px;
  margin-bottom: 10px;
}

.empty-title {
  margin: 0;
  font-size: 16px;
  font-weight: 650;
  color: #3b4a5e;
}

.empty-sub {
  margin: 6px 0 16px;
  font-size: 12.5px;
  color: var(--muted);
}

/* ===== 页脚 ===== */
.foot {
  margin-top: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  flex-wrap: wrap;
  font-size: 11.5px;
  color: #9aa7b7;
}

.foot a {
  color: #7b93b5;
  text-decoration: underline;
  text-underline-offset: 2px;
}

/* ===== 响应式 ===== */
@media (max-width: 900px) {
  .page {
    padding: 18px 14px 36px;
  }

  .layout {
    grid-template-columns: minmax(0, 1fr);
  }

  .sidebar {
    position: static;
  }

  .day-list {
    display: flex;
    gap: 8px;
    max-height: none;
    overflow-x: auto;
    overflow-y: hidden;
    padding: 8px;
    scroll-snap-type: x proximity;
  }

  .day-item {
    flex: none;
    width: auto;
    min-width: 132px;
    margin-bottom: 0;
    border: 1px solid var(--line);
    scroll-snap-align: start;
  }

  .day-item.active {
    border-color: #cfe0fb;
  }

  .titles h1 {
    font-size: 20px;
  }

  .hint {
    display: none;
  }
}
</style>
