<script setup lang="ts">
/**
 * /v2/[key] —— 单个数据源详情（完整列表 / 完整字段）
 */
interface FeedItem {
  rank?: number
  title: string
  desc?: string
  value?: string
  link?: string
  cover?: string
  badge?: string
}

type Payload =
  | { kind: 'list'; items: FeedItem[]; total: number }
  | { kind: 'fields'; fields: Array<{ label: string; value: string }> }
  | { kind: 'text'; text: string; sub?: string }
  | { kind: 'image'; image: string; title?: string; desc?: string }

interface FeedDetail {
  key: string
  title: string
  desc: string | null
  category: string
  categoryLabel?: string
  render: string
  ok: boolean
  error: string | null
  path: string
  fetchedAt: string | null
  upstreamUpdatedAt: string | null
  payload: Payload | null
}

const route = useRoute()
const key = computed(() => String(route.params.key || ''))

// 只在 SSR 阶段 await（客户端不阻塞，避免 async 页面组件在 Suspense 里不销毁旧页面）
const feedData = useCachedData(
  () => `feed:${key.value}`,
  () => $fetch<FeedDetail>(apiUrl(`/api/feeds/${key.value}`)),
  { ttl: 600_000 }
)
if (import.meta.server) await feedData
const { data, pending, error, refresh } = feedData

const payload = computed(() => data.value?.payload ?? null)

const timeLabel = computed(() => {
  const t = data.value?.upstreamUpdatedAt || data.value?.fetchedAt
  if (!t) return '—'
  return new Date(t).toLocaleString('zh-CN', { hour12: false })
})

useHead({
  title: () => (data.value?.title ? `${data.value.title} · 详情` : '数据源详情')
})
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
<div class="titles">
          <h1>{{ data?.title || key }}</h1>
          <p v-if="data">
            <span class="tag">{{ data.categoryLabel || data.category }}</span>
            <span class="dot-sep">·</span>
            上游更新 {{ timeLabel }}
            <template v-if="payload?.kind === 'list'">
              <span class="dot-sep">·</span>
              共 {{ payload.total }} 条
            </template>
          </p>
        </div>
      </div>

      <div class="hero-actions">
        <button class="back-btn" title="返回上一级" @click="goBack">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path
              fill="currentColor"
              d="M9.78 12.78a.75.75 0 0 1-1.06 0L4.47 8.53a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 1.06L6.06 8l3.72 3.72a.75.75 0 0 1 0 1.06Z"
            />
          </svg>
          上一级
        </button>

        <NuxtLink to="/v2" class="back-btn">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path
              fill="currentColor"
              d="M8 1.5 1.75 6.75V14a.75.75 0 0 0 .75.75h3.5v-3.5h4v3.5h3.5A.75.75 0 0 0 14.25 14V6.75L8 1.5Z"
            />
          </svg>
          热门榜单
        </NuxtLink>

        <NuxtLink to="/" class="back-btn ghost">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path
              fill="currentColor"
              d="M8 1.5 1.75 6.75V14a.75.75 0 0 0 .75.75h3.5v-3.5h4v3.5h3.5A.75.75 0 0 0 14.25 14V6.75L8 1.5Z"
            />
          </svg>
          首页
        </NuxtLink>

        <button class="pill-btn" :class="{ spinning: pending }" @click="refresh()">
          <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
            <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
            <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
          </svg>
          刷新
        </button>
      </div>
    </header>

    <div v-if="error" class="alert">
      <b>加载失败</b>
      <span>{{ error.message }}</span>
    </div>

    <div v-else-if="pending && !data" class="card">
      <div class="skeleton" style="width: 40%; height: 16px" />
      <div class="skeleton" style="width: 100%; height: 12px; margin-top: 16px" />
      <div class="skeleton" style="width: 96%; height: 12px; margin-top: 10px" />
      <div class="skeleton" style="width: 88%; height: 12px; margin-top: 10px" />
    </div>

    <div v-else-if="data" class="card">
      <p v-if="data.desc" class="desc">{{ data.desc }}</p>

      <!-- 图片 -->
      <figure v-if="payload?.kind === 'image'" class="image-block">
        <img :src="payload.image" :alt="payload.title || key" referrerpolicy="no-referrer" />
        <figcaption>
          <b v-if="payload.title">{{ payload.title }}</b>
          <span v-if="payload.desc">{{ payload.desc }}</span>
        </figcaption>
      </figure>

      <!-- 列表 -->
      <ol v-else-if="payload?.kind === 'list'" class="list">
        <li v-for="(item, i) in payload.items" :key="`${key}-${i}`" class="list-item">
          <span class="rank" :class="{ top: (item.rank ?? i + 1) <= 3 }">{{ item.rank ?? i + 1 }}</span>
          <div class="item-main">
            <a
              v-if="item.link"
              class="item-title link"
              :href="item.link"
              target="_blank"
              rel="noopener noreferrer"
            >{{ item.title }}</a>
            <span v-else class="item-title">{{ item.title }}</span>
            <p v-if="item.desc" class="item-desc">{{ item.desc }}</p>
          </div>
          <div class="item-side">
            <span v-if="item.badge" class="badge">{{ item.badge }}</span>
            <span v-if="item.value" class="item-value">{{ item.value }}</span>
          </div>
        </li>
      </ol>

      <!-- 字段 -->
      <dl v-else-if="payload?.kind === 'fields'" class="fields">
        <div v-for="f in payload.fields" :key="f.label" class="field-row">
          <dt>{{ f.label }}</dt>
          <dd>{{ f.value }}</dd>
        </div>
      </dl>

      <!-- 文本 -->
      <div v-else-if="payload?.kind === 'text'" class="text-block">
        <p class="text-main">{{ payload.text }}</p>
        <p v-if="payload.sub" class="text-sub">{{ payload.sub }}</p>
      </div>

      <p v-else class="empty">{{ data.error || '本次没有取到数据' }}</p>
    </div>

    <footer class="foot">
      <span>数据源 <a :href="`https://60.020417.xyz${data?.path || ''}`" target="_blank" rel="noopener noreferrer">60s API</a></span>
      <span class="dot-sep">·</span>
      <NuxtLink to="/v2">返回榜单</NuxtLink>
    </footer>
  </div>
</template>

<style scoped>
.page {
  max-width: 860px;
  margin: 0 auto;
  padding: 26px 20px 48px;
}

.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 16px;
  flex-wrap: wrap;
}

.hero-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
  min-width: 0;
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
  white-space: nowrap;
}

.back-btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

.titles h1 {
  margin: 0;
  font-size: 22px;
  font-weight: 800;
  letter-spacing: -0.3px;
  color: #101828;
}

.titles p {
  margin: 3px 0 0;
  display: flex;
  align-items: center;
  gap: 2px;
  font-size: 12px;
  color: var(--muted);
  flex-wrap: wrap;
}

.tag {
  padding: 0 6px;
  border-radius: 5px;
  background: #eef4ff;
  color: #4a7bd0;
  font-size: 10.5px;
  line-height: 16px;
  font-weight: 600;
}

.dot-sep {
  color: #cbd5e1;
  margin: 0 4px;
}

.hero-actions {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  flex-wrap: wrap;
}

.back-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  height: 32px;
  padding: 0 11px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12.5px;
  font-weight: 550;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all 0.15s ease;
}

.back-btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

.back-btn.ghost {
  border-color: var(--line);
  color: #7b8999;
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

.card {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: var(--radius);
  box-shadow: var(--shadow-md);
  padding: 18px 20px;
}

.desc {
  margin: 0 0 12px;
  font-size: 12.5px;
  color: var(--muted);
}

/* 图片 */
.image-block {
  margin: 0;
  border-radius: 12px;
  overflow: hidden;
  background: #f3f6fa;
}

.image-block img {
  display: block;
  width: 100%;
  max-height: 480px;
  object-fit: cover;
}

.image-block figcaption {
  padding: 10px 12px;
  background: #fafcff;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.image-block figcaption b {
  font-size: 13px;
  color: #22314a;
}

.image-block figcaption span {
  font-size: 11.5px;
  color: var(--muted);
}

/* 列表 */
.list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.list-item {
  display: grid;
  grid-template-columns: 28px minmax(0, 1fr) auto;
  gap: 10px;
  align-items: start;
  padding: 10px 0;
  border-bottom: 1px solid var(--line);
}

.list-item:last-child {
  border-bottom: 0;
}

.rank {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  border-radius: 6px;
  background: #f3f6fa;
  color: #8b9aad;
  font-size: 11px;
  font-weight: 700;
  font-variant-numeric: tabular-nums;
  margin-top: 1px;
}

.rank.top {
  background: #fff4e5;
  color: #d97706;
}

.item-main {
  min-width: 0;
}

.item-title {
  font-size: 13.5px;
  color: #22314a;
  font-weight: 550;
  line-height: 1.5;
}

.item-title.link:hover {
  color: var(--brand);
  text-decoration: underline;
  text-underline-offset: 2px;
}

.item-desc {
  margin: 3px 0 0;
  font-size: 12px;
  color: #8b9aad;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.item-side {
  display: flex;
  align-items: center;
  gap: 6px;
  flex: none;
}

.badge {
  padding: 0 6px;
  border-radius: 5px;
  background: #f3f6fa;
  color: #8b9aad;
  font-size: 10.5px;
  line-height: 17px;
  max-width: 110px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.item-value {
  font-size: 12px;
  color: #7b8999;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

/* 字段 */
.fields {
  margin: 0;
  display: grid;
  grid-template-columns: minmax(0, 1fr);
}

.field-row {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 16px;
  padding: 9px 0;
  border-bottom: 1px solid var(--line);
}

.field-row:last-child {
  border-bottom: 0;
}

.field-row dt {
  font-size: 12.5px;
  color: #8b9aad;
  flex: none;
  max-width: 45%;
}

.field-row dd {
  margin: 0;
  font-size: 13px;
  color: #22314a;
  font-weight: 550;
  text-align: right;
  word-break: break-all;
}

/* 文本 */
.text-block {
  padding: 6px 2px 2px;
}

.text-main {
  margin: 0;
  font-size: 16px;
  line-height: 1.8;
  color: #1b2a41;
  letter-spacing: 0.3px;
}

.text-sub {
  margin: 14px 0 0;
  font-size: 13px;
  color: var(--muted);
  line-height: 1.7;
  white-space: pre-wrap;
}

.empty {
  margin: 0;
  padding: 24px 0;
  text-align: center;
  font-size: 13px;
  color: #b0bccb;
}

.alert {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 14px;
  border-radius: 10px;
  border: 1px solid #ffd9d9;
  background: #fff5f5;
  color: #b42318;
  font-size: 12.5px;
}

.alert span {
  color: #c65a4f;
}

.foot {
  margin-top: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  flex-wrap: wrap;
  font-size: 11.5px;
  color: #9aa7b7;
}

.foot a {
  color: #7b93b5;
  text-decoration: underline;
  text-underline-offset: 2px;
}
</style>
