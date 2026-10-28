<script setup lang="ts">
/**
 * 一个 60s 端点的卡片。
 *
 * 四种 payload 形态对应四种渲染：list / fields / text / image。
 * 卡片高度固定，头部（标题/时间）常驻，内容区可滚轮滚动查看超出部分。
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

const props = defineProps<{
  feed: {
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
}>()

const payload = computed(() => props.feed.payload)

const timeLabel = computed(() => {
  const t = props.feed.upstreamUpdatedAt || props.feed.fetchedAt
  if (!t) return ''
  const d = new Date(t)
  const diffMin = Math.floor((Date.now() - d.getTime()) / 60000)
  if (diffMin < 1) return '刚刚'
  if (diffMin < 60) return `${diffMin} 分钟前`
  if (diffMin < 1440) return `${Math.floor(diffMin / 60)} 小时前`
  return `${d.getMonth() + 1}-${String(d.getDate()).padStart(2, '0')}`
})
</script>

<template>
  <article class="feed-card" :class="{ broken: !feed.ok }">
    <header class="card-head">
      <h3 class="card-title">
        <NuxtLink :to="`/v2/${feed.key}`">{{ feed.title }}</NuxtLink>
      </h3>
      <div class="card-meta">
        <span v-if="payload?.kind === 'list'" class="pill">{{ feed.total }} 条</span>
        <span v-if="timeLabel" class="time">{{ timeLabel }}</span>
      </div>
    </header>

    <p v-if="feed.desc" class="card-desc">{{ feed.desc }}</p>

    <!-- 内容区：固定高度内滚动 -->
    <div class="scroll-area">
      <!-- 图片 -->
      <figure v-if="payload?.kind === 'image'" class="image-block">
        <img :src="payload.image" :alt="payload.title || feed.title" loading="lazy" referrerpolicy="no-referrer" />
        <figcaption v-if="payload.title">{{ payload.title }}</figcaption>
      </figure>

      <!-- 列表 -->
      <ol v-else-if="payload?.kind === 'list' && payload.items.length" class="list">
        <li v-for="(item, i) in payload.items" :key="`${feed.key}-${i}`" class="list-item">
          <span class="rank" :class="{ top: (item.rank ?? i + 1) <= 3 }">{{ item.rank ?? i + 1 }}</span>

          <a
            v-if="item.link"
            class="item-title link"
            :href="item.link"
            target="_blank"
            rel="noopener noreferrer"
          >{{ item.title }}</a>
          <span v-else class="item-title">{{ item.title }}</span>

          <span v-if="item.value" class="item-value">{{ item.value }}</span>
        </li>
        <li v-if="feed.total > payload.items.length" class="more">
          <NuxtLink :to="`/v2/${feed.key}`">查看全部 {{ feed.total }} 条 →</NuxtLink>
        </li>
      </ol>

      <!-- 键值对 -->
      <dl v-else-if="payload?.kind === 'fields' && payload.fields.length" class="fields">
        <div v-for="f in payload.fields" :key="f.label" class="field-row">
          <dt>{{ f.label }}</dt>
          <dd>{{ f.value }}</dd>
        </div>
      </dl>

      <!-- 文本 -->
      <p v-else-if="payload?.kind === 'text'" class="text-body">
        {{ payload.text }}
        <span v-if="payload.sub" class="text-sub">{{ payload.sub }}</span>
      </p>

      <div v-else class="empty-body">
        <span>{{ feed.error || '本次没有取到数据' }}</span>
      </div>
    </div>
  </article>
</template>

<style scoped>
.feed-card {
  position: relative;
  display: flex;
  flex-direction: column;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  padding: 10px 6px 8px 12px;
  /*
   * 卡片高度跟着视口走：一页 3×3 共 9 张，正好铺满一屏不用滚动页面。
   * 216px ≈ 顶部标题 + 分类 Tab + 网格间距 + 页面上下留白。
   * 缩放浏览器 / 换显示器时自动适配，内容仍可在卡片内滚动。
   */
  height: clamp(158px, calc((100vh - 274px) / 3), 400px);
  height: clamp(158px, calc((100dvh - 274px) / 3), 400px);
  overflow: hidden;
  transition: box-shadow 0.18s ease, border-color 0.18s ease, transform 0.18s ease;
}

.feed-card:hover {
  border-color: #cfe0fb;
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}

.feed-card.broken {
  background: #fcfcfd;
}

.card-head {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 8px;
  flex: none;
  padding-right: 6px;
}

.card-title {
  margin: 0;
  font-size: 13px;
  font-weight: 700;
  color: #16233a;
  min-width: 0;
}

.card-title a {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.card-title a:hover {
  color: var(--brand);
}

.card-meta {
  flex: none;
  display: flex;
  align-items: center;
  gap: 6px;
}

.pill {
  padding: 0 6px;
  border-radius: 5px;
  background: #eef4ff;
  color: #4a7bd0;
  font-size: 10.5px;
  line-height: 16px;
  font-weight: 600;
}

.time {
  font-size: 10.5px;
  color: #a4b0bf;
  white-space: nowrap;
}

.card-desc {
  margin: 3px 0 0;
  font-size: 11.5px;
  color: var(--muted);
  flex: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  padding-right: 8px;
}

/* ===== 滚动区 ===== */
.scroll-area {
  flex: 1 1 auto;
  min-height: 0;
  overflow-y: auto;
  overflow-x: hidden;
  margin-top: 5px;
  padding-right: 6px;
  padding-bottom: 8px;
  overscroll-behavior: contain;
  scrollbar-width: thin;
  scrollbar-color: #d4dde9 transparent;
}

.scroll-area::-webkit-scrollbar {
  width: 6px;
}

.scroll-area::-webkit-scrollbar-thumb {
  background: #d4dde9;
  border-radius: 999px;
}

.scroll-area::-webkit-scrollbar-thumb:hover {
  background: #b9c7d9;
}

.scroll-area::-webkit-scrollbar-track {
  background: transparent;
}

/* ===== 图片 ===== */
.image-block {
  margin: 0;
  border-radius: 10px;
  overflow: hidden;
  background: #f3f6fa;
}

.image-block img {
  display: block;
  width: 100%;
  height: auto;
  object-fit: cover;
}

.image-block figcaption {
  padding: 7px 10px;
  font-size: 11.5px;
  color: #55657a;
  background: #fafcff;
  line-height: 1.45;
}

/* ===== 列表 ===== */
.list {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.list-item {
  display: grid;
  grid-template-columns: 18px minmax(0, 1fr) auto;
  align-items: baseline;
  gap: 6px;
  padding: 3px 0;
  border-bottom: 1px dashed #f1f5fa;
}

.list-item:last-of-type {
  border-bottom: 0;
}

.rank {
  font-size: 10.5px;
  font-weight: 700;
  color: #b3bfcd;
  text-align: center;
  font-variant-numeric: tabular-nums;
}

.rank.top {
  color: #ef8a1f;
}

.item-title {
  font-size: 12px;
  color: #33425a;
  line-height: 1.4;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  min-width: 0;
}

.item-title.link:hover {
  color: var(--brand);
  text-decoration: underline;
  text-underline-offset: 2px;
}

.item-value {
  font-size: 11px;
  color: #9aa7b7;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

.more {
  padding: 7px 0 2px;
  font-size: 11.5px;
}

.more a {
  color: var(--brand);
}

/* ===== 键值对 ===== */
.fields {
  margin: 0;
  display: grid;
  grid-template-columns: minmax(0, 1fr);
}

.field-row {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 10px;
  padding: 3px 0;
  border-bottom: 1px dashed #f1f5fa;
}

.field-row:last-child {
  border-bottom: 0;
}

.field-row dt {
  font-size: 11.5px;
  color: #8b9aad;
  flex: none;
  max-width: 48%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.field-row dd {
  margin: 0;
  font-size: 12px;
  color: #22314a;
  font-weight: 550;
  text-align: right;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ===== 文本 ===== */
.text-body {
  margin: 0;
  font-size: 13.5px;
  line-height: 1.75;
  color: #22314a;
  letter-spacing: 0.2px;
  word-break: break-word;
}

.text-sub {
  display: block;
  margin-top: 8px;
  font-size: 12px;
  color: var(--muted);
  white-space: pre-wrap;
}

.empty-body {
  font-size: 12px;
  color: #b0bccb;
}
</style>
