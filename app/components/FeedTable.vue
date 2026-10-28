<script setup lang="ts">
/**
 * 热门榜单表格：和 GitHub 日榜保持同一套表头 / 列宽 / 行高，
 * 每行一个数据源，内容列填充该榜单的前几条。
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
  ok: boolean
  error: string | null
  fetchedAt: string | null
  upstreamUpdatedAt: string | null
  payload: Payload | null
  total: number
}

const props = defineProps<{ items: FeedRow[]; loading?: boolean }>()

const CATEGORY_ICON: Record<string, string> = {
  hot: '🔥',
  tech: '💻',
  life: '🌤️',
  music: '🎵',
  daily: '📰'
}

/** 把不同类型的 payload 压成一行预览文本 */
function preview(feed: FeedRow): string {
  const p = feed.payload
  if (!p) return feed.error || '暂无数据'

  if (p.kind === 'list') {
    if (!p.items.length) return '暂无数据'
    return p.items
      .slice(0, 3)
      .map((i) => i.title)
      .join('  ·  ')
  }
  if (p.kind === 'fields') {
    if (!p.fields.length) return '暂无数据'
    return p.fields
      .slice(0, 3)
      .map((f) => `${f.label} ${f.value}`)
      .join('  ·  ')
  }
  if (p.kind === 'text') return p.text
  if (p.kind === 'image') return p.title || '图片'
  return ''
}

function timeLabel(feed: FeedRow): string {
  const t = feed.upstreamUpdatedAt || feed.fetchedAt
  if (!t) return '—'
  const diff = Math.floor((Date.now() - new Date(t).getTime()) / 60000)
  if (diff < 1) return '刚刚'
  if (diff < 60) return `${diff} 分钟前`
  if (diff < 1440) return `${Math.floor(diff / 60)} 小时前`
  return `${Math.floor(diff / 1440)} 天前`
}

function countLabel(feed: FeedRow): string {
  const p = feed.payload
  if (p?.kind === 'list') return `${feed.total}`;
  if (p?.kind === 'fields') return `${p.fields.length} 项`
  if (p?.kind === 'image') return '图片'
  return '—'
}
</script>

<template>
  <div class="table">
    <!-- 表头 -->
    <div class="head">
      <div class="c-cat">分类</div>
      <div class="c-name">榜单</div>
      <div class="c-preview">内容</div>
      <div class="c-count">条数</div>
      <div class="c-time">更新</div>
      <div class="c-act">操作</div>
    </div>

    <!-- 骨架 -->
    <template v-if="loading && !items.length">
      <div v-for="i in 10" :key="`sk-${i}`" class="row sk-row">
        <div class="c-cat"><div class="skeleton sk-icon" /></div>
        <div class="c-name"><div class="skeleton sk-line w70" /></div>
        <div class="c-preview"><div class="skeleton sk-line w90" /></div>
        <div class="c-count"><div class="skeleton sk-line w50" /></div>
        <div class="c-time"><div class="skeleton sk-line w60" /></div>
        <div class="c-act"><div class="skeleton sk-line w40" /></div>
      </div>
    </template>

    <!-- 数据行 -->
    <div v-for="feed in items" :key="feed.key" class="row" :class="{ broken: !feed.ok }">
      <div class="c-cat">
        <span class="cat-icon">{{ CATEGORY_ICON[feed.category] || '•' }}</span>
      </div>

      <div class="c-name">
        <NuxtLink :to="`/v2/${feed.key}`" class="feed-title">{{ feed.title }}</NuxtLink>
        <span class="feed-desc">{{ feed.desc }}</span>
      </div>

      <div class="c-preview">
        <span class="preview-text">{{ preview(feed) || '暂无数据' }}</span>
      </div>

      <div class="c-count">
        <span class="pill">{{ countLabel(feed) }}</span>
      </div>

      <div class="c-time">{{ timeLabel(feed) }}</div>

      <div class="c-act">
        <ShareButton
          type="ai"
          :title="feed.title"
          :desc="feed.desc || ''"
          :badge="(CATEGORY_ICON[feed.category] || '📊') + ' ' + feed.title"
          :meta="{ key: feed.key, category: feed.category }"
        />
        <NuxtLink :to="`/v2/${feed.key}`" class="view-btn" title="查看详情">
          <svg viewBox="0 0 16 16" width="11" height="11" aria-hidden="true">
            <path fill="currentColor" d="M6 3.75 10.25 8 6 12.25V3.75Z" />
          </svg>
        </NuxtLink>
      </div>
    </div>

    <div v-if="!loading && !items.length" class="empty">
      <p>还没有采集到数据</p>
      <p class="empty-sub">服务端启动后会自动抓取一轮，也可以点右上角刷新</p>
    </div>

    <div class="foot">
      数据源：60s API · 每小时自动更新 · 点「操作」里的箭头查看完整榜单
    </div>
  </div>
</template>

<style scoped>
.table {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: var(--radius);
  box-shadow: var(--shadow-md);
  overflow: hidden;
}

/* 表头与行共用栅格：分类 / 榜单 / 内容 / 条数 / 更新 / 操作 */
.head,
.row {
  display: grid;
  grid-template-columns: 54px minmax(160px, 0.9fr) minmax(240px, 2.4fr) 66px 84px 76px;
  align-items: center;
  gap: 10px;
  padding: 0 16px;
}

.head {
  height: 34px;
  background: var(--card-soft);
  border-bottom: 1px solid var(--line);
  font-size: 11.5px;
  font-weight: 600;
  color: var(--muted);
  letter-spacing: 0.3px;
}

.head .c-count,
.head .c-time,
.head .c-act {
  text-align: center;
}

.row {
  min-height: 30px;
  padding-top: 2px;
  padding-bottom: 2px;
  border-bottom: 1px solid var(--line);
  transition: background-color 0.14s ease;
}

.row:last-of-type {
  border-bottom: 0;
}

.row:hover {
  background: #f8fbff;
}

.row.broken {
  background: #fcfcfd;
}

/* 分类图标 */
.c-cat {
  display: flex;
  justify-content: center;
}

.cat-icon {
  width: 24px;
  height: 24px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 7px;
  background: linear-gradient(180deg, #f7fbff 0%, #eef5ff 100%);
  border: 1px solid #e3edfb;
  font-size: 12px;
}

/* 名称 */
.c-name {
  min-width: 0;
  display: flex;
  flex-direction: column;
  line-height: 1.25;
}

.feed-title {
  font-size: 12.8px;
  font-weight: 650;
  color: #16233a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.feed-title:hover {
  color: var(--brand);
}

.feed-desc {
  font-size: 10.5px;
  color: #a4b0bf;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 内容预览 */
.c-preview {
  min-width: 0;
}

.preview-text {
  display: block;
  font-size: 12px;
  color: #4a5768;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.row.broken .preview-text {
  color: #b0bccb;
}

/* 条数 */
.c-count {
  display: flex;
  justify-content: center;
}

.pill {
  min-width: 40px;
  text-align: center;
  padding: 1px 7px;
  border-radius: 999px;
  background: #eef4ff;
  color: #4a7bd0;
  font-size: 10.5px;
  font-weight: 650;
  font-variant-numeric: tabular-nums;
}

/* 时间 */
.c-time {
  text-align: center;
  font-size: 10.5px;
  color: #a4b0bf;
  white-space: nowrap;
}

/* 操作 */
.c-act {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 4px;
}

.view-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 6px;
  border: 1px solid transparent;
  color: #c3cfdf;
  transition: all 0.15s ease;
  flex: none;
}

.view-btn:hover {
  border-color: #cfe0fb;
  background: #f7fbff;
  color: var(--brand);
}

/* 骨架 */
.sk-row {
  pointer-events: none;
}

.sk-icon {
  width: 26px;
  height: 26px;
  border-radius: 7px;
}

.sk-line {
  height: 9px;
  border-radius: 5px;
}

.w40 { width: 40%; }
.w50 { width: 50%; }
.w60 { width: 60%; }
.w70 { width: 70%; }
.w90 { width: 90%; }

.empty {
  padding: 44px 20px;
  text-align: center;
  color: #8b9aad;
  font-size: 13px;
}

.empty-sub {
  margin-top: 6px;
  font-size: 12px;
  color: #b0bccb;
}

.foot {
  padding: 6px 16px;
  background: var(--card-soft);
  border-top: 1px solid var(--line);
  text-align: center;
  font-size: 11px;
  color: #98a5b6;
}

@media (max-width: 900px) {
  .head {
    display: none;
  }

  .row {
    grid-template-columns: 34px minmax(0, 1fr) auto;
    grid-template-areas:
      'cat name act'
      'cat preview count';
    row-gap: 2px;
    padding: 9px 12px;
  }

  .c-cat { grid-area: cat; }
  .c-name { grid-area: name; }
  .c-preview { grid-area: preview; }
  .c-count { grid-area: count; justify-content: flex-end; }
  .c-time { display: none; }
  .c-act { grid-area: act; }
}
</style>
