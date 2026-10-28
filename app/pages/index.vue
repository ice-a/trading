<script setup lang="ts">
import type { TrendingResponse } from '~~/server/utils/types'

/**
 * 首页：今日榜单（默认）+ 历史日期 + 分页 + 一言。
 * 所有榜单数据都来自 MongoDB（/api/trending），前端不直接访问 GitHub。
 */

const route = useRoute()
const router = useRouter()

const dateParam = ref(typeof route.query.date === 'string' ? route.query.date : '')
const page = ref(Math.max(1, Number(route.query.page) || 1))
const intervalMinutes = ref(60)

/** 榜单周期：日 / 周 / 月 */
type Period = 'daily' | 'weekly' | 'monthly'
const periodRaw = typeof route.query.period === 'string' ? route.query.period : ''
const period = ref<Period>(['daily', 'weekly', 'monthly'].includes(periodRaw) ? (periodRaw as Period) : 'daily')
const PERIOD_LABEL: Record<Period, string> = { daily: '日榜', weekly: '周榜', monthly: '月榜' }

const queryKey = computed(() => `trending:${dateParam.value || 'today'}:${period.value}:${page.value}`)

/**
 * 只在 SSR 阶段 await。
 *
 * 页面里无条件 top-level await 会让组件变成 async 组件并被 Suspense 包裹；
 * 多个 async 页面互相切换时，Vue 的 Suspense 会保留旧组件不销毁，
 * 表现为「URL 变了、新页面也渲染了，但旧页面还盖在上面」。
 * 客户端改成响应式更新，既躲开这个问题，也少一次等待。
 */
const trendingData = useCachedData(
  () => queryKey.value,
  () =>
    $fetch<TrendingResponse>(apiUrl('/api/trending'), {
      query: { date: dateParam.value || undefined, page: page.value, period: period.value }
    }),
  { ttl: 300_000 }
)
if (import.meta.server) await trendingData
const { data, pending, error, refresh } = trendingData

const hitokotoData = useCachedData(
  () => 'hitokoto:first',
  () => $fetch(apiUrl('/api/hitokoto')),
  { ttl: 30_000 }
)
if (import.meta.server) await hitokotoData
const { data: hitokoto } = hitokotoData

/** URL 同步（刷新/分享能还原到同一页同一天） */
/** 切换周期：回到第一页，保留已选日期 */
function changePeriod(p: Period) {
  if (period.value === p) return
  period.value = p
  page.value = 1
}

watch([dateParam, page, period], () => {
  const query: Record<string, string> = {}
  if (dateParam.value) query.date = dateParam.value
  if (page.value > 1) query.page = String(page.value)
  if (period.value !== 'daily') query.period = period.value
  router.replace({ query })
})

onMounted(async () => {
  try {
    const status = await $fetch<{ scheduler: { intervalMinutes: number } }>(apiUrl('/api/status'))
    intervalMinutes.value = status?.scheduler?.intervalMinutes ?? 60
  } catch {
    /* 忽略 */
  }
})

const items = computed(() => data.value?.items ?? [])
const isToday = computed(() => data.value?.isToday ?? true)
const heroDate = computed(() => data.value?.date ?? '')

function backToToday() {
  dateParam.value = ''
  page.value = 1
}

function changePage(p: number) {
  page.value = p
  if (import.meta.client) window.scrollTo({ top: 0, behavior: 'smooth' })
}

async function manualRefresh() {
  clearDataCache('trending:')
  await refresh()
}

useHead({
  title: () => (heroDate.value ? `${heroDate.value} GitHub 日榜简报` : 'GitHub 日榜简报')
})
</script>

<template>
  <div class="page">
    <!-- ===== 顶部标题 ===== -->
    <header class="hero">
      <div class="hero-main">
        <span class="gh-logo">
          <svg viewBox="0 0 16 16" width="34" height="34" aria-hidden="true">
            <path
              fill="currentColor"
              d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z"
            />
          </svg>
        </span>
        <div class="hero-text">
          <h1>
            <span class="date">{{ heroDate || '加载中' }}</span>
            <span class="title">GitHub 日榜简报</span>
          </h1>
          <p class="subtitle">
            GitHub Trending Daily · Top {{ data?.topN ?? 10 }}
            <span v-if="!isToday" class="history-tag">历史数据</span>
          </p>
        </div>
      </div>

      <div class="hero-side">
<div class="hero-deco" aria-hidden="true">
        <svg viewBox="0 0 138 58" width="138" height="58">
          <rect x="0.5" y="0.5" width="137" height="57" rx="10" fill="#f4f8ff" stroke="#dbe7f8" />
          <g>
            <rect x="12" y="30" width="9" height="17" rx="2.5" fill="#bfd9ff" />
            <rect x="26" y="22" width="9" height="25" rx="2.5" fill="#9ec7fb" />
            <rect x="40" y="26" width="9" height="21" rx="2.5" fill="#8ab9f7" />
            <rect x="54" y="15" width="9" height="32" rx="2.5" fill="#6ba4f0" />
            <rect x="68" y="19" width="9" height="28" rx="2.5" fill="#82b4f5" />
            <rect x="82" y="10" width="9" height="37" rx="2.5" fill="#4b8df0" />
          </g>
          <path
            d="M6 9.5 7.4 12.4l3.1.45-2.25 2.2.53 3.1L6 16.7l-2.78 1.45.53-3.1L1.5 12.85l3.1-.45L6 9.5Z"
            fill="#fbbf24"
          />
          <circle cx="122" cy="14" r="3" fill="#cfe8ff" />
          <circle cx="130" cy="24" r="2" fill="#dbe7f8" />
          <path
            d="M104 34.5 105.6 38l3.9.35-2.9 2.6.85 3.8L104 42.7l-3.45 2.05.85-3.8-2.9-2.6 3.9-.35L104 34.5Z"
            fill="#fcd34d"
          />
        </svg>
        </div>
      </div>
    </header>

    <!-- ===== 一言（每 60s 自动刷新）===== -->
    <HitokotoBar :initial="hitokoto" />

    <!-- ===== 工具栏 ===== -->
    <div class="toolbar">
      <div class="tb-left">
          <PeriodSwitch v-model="period" @update:model-value="changePeriod" />
        <button v-if="!isToday" class="pill-btn" @click="backToToday">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path
              fill="currentColor"
              d="M4.75 0a.75.75 0 0 1 .75.75V2h5V.75a.75.75 0 0 1 1.5 0V2h1.25c.966 0 1.75.784 1.75 1.75v10.5A1.75 1.75 0 0 1 13.25 16H2.75A1.75 1.75 0 0 1 1 14.25V3.75C1 2.784 1.784 2 2.75 2H4V.75A.75.75 0 0 1 4.75 0ZM2.5 6.5v7.75c0 .138.112.25.25.25h10.5a.25.25 0 0 0 .25-.25V6.5h-11Z"
            />
          </svg>
          回到今天
        </button>

        <button class="pill-btn ghost" :class="{ spinning: pending }" @click="manualRefresh">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path
              fill="currentColor"
              d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z"
            />
            <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
          </svg>
          刷新
        </button>
      </div>

      <div class="tb-right">
        <span class="stat">
          <span class="dot live" />
          每 {{ intervalMinutes }} 分钟自动更新
        </span>
        <span class="sep" />
        <span class="stat">更新于 {{ data?.updatedAgo ?? '—' }}</span>
        <span class="sep" />
        <span class="stat">已追踪 {{ data?.stats.tracked ?? 0 }} 个仓库</span>
        <span v-if="(data?.stats.droppedCount ?? 0) > 0" class="stat muted">
          · 掉榜保留 {{ data?.stats.droppedCount }}
        </span>
      </div>
    </div>

    <!-- ===== 错误提示 ===== -->
    <div v-if="error" class="alert">
      <b>数据加载失败</b>
      <span>{{ error.message }}</span>
      <button class="pill-btn" @click="manualRefresh">重试</button>
    </div>

    <!-- ===== 榜单 ===== -->
    <TrendingTable
      :items="items"
      :loading="pending"
      :empty-hint="isToday ? '今天还没有抓取到数据，稍等片刻或点「刷新」' : '这一天没有记录'"
    />

    <!-- ===== 分页 ===== -->
    <AppPager
      v-if="(data?.total ?? 0) > 0"
      :page="page"
      :total-pages="data?.totalPages ?? 1"
      :total="data?.total ?? 0"
      :page-size="data?.pageSize ?? 10"
      :loading="pending"
      @change="changePage"
    />

    <footer class="foot">
      <span>数据每小时写入 MongoDB（按日期分区，掉出前 10 的记录只降级、不删除）</span>
      <span class="dot-sep">·</span>
      <NuxtLink to="/history">查看历史榜单</NuxtLink>
      <span class="dot-sep">·</span>
      <a href="https://github.com/trending" target="_blank" rel="noopener noreferrer">来源 github.com/trending</a>
    </footer>
  </div>
</template>

<style scoped>
.page {
  max-width: 1080px;
  margin: 0 auto;
  padding: 28px 20px 48px;
}

/* ===== Hero ===== */
.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  margin-bottom: 18px;
}

.hero-main {
  display: flex;
  align-items: center;
  gap: 14px;
  min-width: 0;
}

.gh-logo {
  flex: none;
  width: 56px;
  height: 56px;
  border-radius: 16px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  color: #10161f;
  border: 1px solid var(--line);
  box-shadow: var(--shadow-md);
}

.hero-text {
  min-width: 0;
}

h1 {
  margin: 0;
  display: flex;
  align-items: baseline;
  flex-wrap: wrap;
  gap: 10px;
  line-height: 1.2;
}

.date {
  font-size: 27px;
  font-weight: 800;
  letter-spacing: -0.6px;
  background: linear-gradient(120deg, #1f6feb 0%, #4f46e5 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  font-variant-numeric: tabular-nums;
}

.title {
  font-size: 22px;
  font-weight: 750;
  color: #101828;
  letter-spacing: -0.3px;
}

.subtitle {
  margin: 4px 0 0;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12.5px;
  color: var(--muted);
  letter-spacing: 0.2px;
}

.history-tag {
  padding: 1px 7px;
  border-radius: 999px;
  background: #fff3e0;
  color: #b45309;
  font-size: 10.5px;
  font-weight: 600;
}

.hero-deco {
  flex: none;
  filter: drop-shadow(0 6px 14px rgba(31, 111, 235, 0.09));
}

/* ===== 工具栏 ===== */
.toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 14px;
  margin: 0 0 12px;
  flex-wrap: wrap;
}

.tb-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* 页面级导航（右上角），和工具栏操作区分开 */
.hero-side {
  display: flex;
  align-items: center;
  gap: 14px;
  flex: none;
}

.nav-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  height: 36px;
  padding: 0 13px;
  border-radius: 10px;
  border: 1px solid #cfe0fb;
  background: linear-gradient(180deg, #ffffff 0%, #f2f8ff 100%);
  color: var(--brand);
  font-size: 12.5px;
  font-weight: 650;
  letter-spacing: 0.2px;
  box-shadow: var(--shadow-sm);
  transition: all 0.16s ease;
  white-space: nowrap;
}

.nav-btn:hover {
  border-color: #a9c9f5;
  background: #e9f2ff;
  color: #1558c0;
  box-shadow: 0 4px 14px rgba(31, 111, 235, 0.16);
  transform: translateY(-1px);
}

.pill-btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 34px;
  padding: 0 12px;
  border-radius: 10px;
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

.pill-btn.spinning svg {
  animation: spin 0.9s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.tb-right {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
  font-size: 11.5px;
  color: #7b8999;
}

.stat {
  display: inline-flex;
  align-items: center;
  gap: 5px;
}

.stat.muted {
  color: #a4b0bf;
}

.dot.live {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #22c55e;
  animation: pulse-dot 1.8s ease-in-out infinite;
}

.sep {
  width: 1px;
  height: 10px;
  background: var(--line-strong);
}

/* ===== 提示 ===== */
.alert {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 14px;
  margin-bottom: 12px;
  border-radius: 10px;
  border: 1px solid #ffd9d9;
  background: #fff5f5;
  color: #b42318;
  font-size: 12.5px;
}

.alert b {
  font-weight: 650;
}

.alert span {
  color: #c65a4f;
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ===== 页脚 ===== */
.foot {
  margin-top: 20px;
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

.dot-sep {
  color: #cbd5e1;
}

@media (max-width: 860px) {
  .hero {
    flex-wrap: wrap;
  }
  .hero-deco {
    display: none;
  }
  .nav-btn {
    height: 32px;
    padding: 0 10px;
    font-size: 12px;
  }
  .page {
    padding: 20px 14px 36px;
  }
  .date {
    font-size: 22px;
  }
  .title {
    font-size: 18px;
  }
  .gh-logo {
    width: 46px;
    height: 46px;
    border-radius: 13px;
  }
  .gh-logo svg {
    width: 27px;
    height: 27px;
  }
  .tb-right {
    display: none;
  }
}
</style>
