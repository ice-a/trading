<script setup lang="ts">
/**
 * 榜单表格：排名 / 项目 / 简介 / 今日增长 / 总 Star / Fork
 * 视觉参考：卡片式列表 + 前三名高亮 + owner 首字母头像。
 */
export interface TrendingRow {
  rank: number | null
  owner: string
  name: string
  fullName: string
  url: string
  description: string
  language: string
  languageColor: string
  totalStars: number
  forks: number
  todayStars: number
  bucket: number
  dropped: boolean
}

const props = defineProps<{
  items: TrendingRow[]
  loading?: boolean
  emptyHint?: string
}>()

const PALETTE = [
  '#f59e0b',
  '#111827',
  '#7c3aed',
  '#ec4899',
  '#374151',
  '#60a5fa',
  '#2563eb',
  '#0ea5e9',
  '#6366f1',
  '#9f1239',
  '#059669',
  '#c2410c'
]

function hashCode(s: string): number {
  let h = 0
  for (let i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) >>> 0
  return h
}

function avatarColor(owner: string): string {
  return PALETTE[hashCode(owner.toLowerCase()) % PALETTE.length]!
}

function initials(owner: string): string {
  const clean = owner.replace(/[-_.]/g, '')
  return (clean.slice(0, 2) || 'GH').toUpperCase()
}

function rowClass(item: TrendingRow) {
  return {
    'is-top1': item.rank === 1,
    'is-top2': item.rank === 2,
    'is-top3': item.rank === 3,
    'is-dropped': item.dropped,
    'is-rest': item.bucket > 0 && !item.dropped
  }
}
</script>

<template>
  <div class="table">
    <!-- 表头 -->
    <div class="head">
      <div class="c-rank">排名</div>
      <div class="c-repo">项目</div>
      <div class="c-desc">简介</div>
      <div class="c-today">今日增长</div>
      <div class="c-stars">总 Star</div>
      <div class="c-forks">Fork</div>
    </div>

    <!-- 骨架屏 -->
    <template v-if="loading && !items.length">
      <div v-for="i in 8" :key="`sk-${i}`" class="row skeleton-row">
        <div class="c-rank"><div class="skeleton sk-badge" /></div>
        <div class="c-repo">
          <div class="skeleton sk-avatar" />
          <div class="sk-lines">
            <div class="skeleton sk-line w60" />
            <div class="skeleton sk-line w30" />
          </div>
        </div>
        <div class="c-desc"><div class="skeleton sk-line w80" /></div>
        <div class="c-today"><div class="skeleton sk-pill" /></div>
        <div class="c-stars"><div class="skeleton sk-line w50" /></div>
        <div class="c-forks"><div class="skeleton sk-line w50" /></div>
      </div>
    </template>

    <!-- 数据行 -->
    <template v-else-if="items.length">
      <div
        v-for="item in items"
        :key="`${item.owner}/${item.name}`"
        class="row"
        :class="rowClass(item)"
      >
        <div class="c-rank">
          <RankBadge :rank="item.rank" :dropped="item.dropped" />
        </div>

        <div class="c-repo">
          <a class="repo" :href="item.url" target="_blank" rel="noopener noreferrer">
            <span class="avatar" :style="{ background: avatarColor(item.owner) }">
              {{ initials(item.owner) }}
            </span>
            <span class="repo-text">
              <span class="repo-name">{{ item.name }}</span>
              <span class="repo-owner">{{ item.owner }}</span>
            </span>
          </a>
        </div>

        <div class="c-desc">
          <p class="desc-text">{{ item.description || '暂无简介' }}</p>
          <div class="meta">
            <span class="lang">
              <i class="dot" :style="{ background: item.languageColor }" />
              {{ item.language }}
            </span>
            <span v-if="item.dropped" class="badge drop">已掉榜</span>
          </div>
        </div>

        <div class="c-today">
          <span class="growth" :class="growthLevel(item.todayStars)">
            +{{ plainNumber(item.todayStars) }}
          </span>
        </div>

        <div class="c-stars">
          <svg class="ico star" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
            <path
              fill="currentColor"
              d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.75.75 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z"
            />
          </svg>
          <span class="num">{{ compactNumber(item.totalStars) }}</span>
        </div>

        <div class="c-forks">
          <svg class="ico" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
            <path
              fill="currentColor"
              d="M5 5.372v.878c0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75v-.878a2.25 2.25 0 1 1 1.5 0v.878a2.25 2.25 0 0 1-2.25 2.25h-1.5v2.128a2.251 2.251 0 1 1-1.5 0V8.5h-1.5A2.25 2.25 0 0 1 3.5 6.25v-.878a2.25 2.25 0 1 1 1.5 0ZM5 3.25a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Zm6.75.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm-3 8.75a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"
            />
          </svg>
          <span class="num">{{ compactNumber(item.forks) }}</span>
        </div>
      </div>
    </template>

    <!-- 空状态 -->
    <div v-else class="empty">
      <div class="empty-icon">📭</div>
      <p class="empty-title">{{ emptyHint || '这一天还没有数据' }}</p>
      <p class="empty-sub">抓取任务会按 .env 里的 UPDATE_INTERVAL_MINUTES 自动运行</p>
    </div>

    <div class="foot">
      数据源：GitHub Trending（Daily）· 今日增长为 GitHub 官方滚动统计，非自然日增量
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

/* ===== 栅格 ===== */
.head,
.row {
  display: grid;
  grid-template-columns: 62px minmax(170px, 1.05fr) minmax(200px, 2.1fr) 106px 96px 84px;
  align-items: center;
  gap: 8px;
  padding: 0 18px;
}

.head {
  height: 44px;
  background: var(--card-soft);
  border-bottom: 1px solid var(--line);
  font-size: 12px;
  font-weight: 600;
  color: var(--muted);
  letter-spacing: 0.3px;
}

.head .c-today,
.head .c-stars,
.head .c-forks {
  text-align: center;
}

.row {
  min-height: 66px;
  padding-top: 10px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--line);
  transition: background-color 0.16s ease, transform 0.16s ease;
  animation: fade-up 0.28s ease both;
}

.row:hover {
  background: #f8fbff;
}

.row.is-top1 {
  background: linear-gradient(90deg, #fffaeb 0%, #fffdf6 45%, #ffffff 100%);
}
.row.is-top2 {
  background: linear-gradient(90deg, #f7fafd 0%, #ffffff 60%);
}
.row.is-top3 {
  background: linear-gradient(90deg, #fff9f4 0%, #ffffff 60%);
}

.row.is-rest {
  background: #ffffff;
}

.row.is-dropped {
  background: #fbfcfe;
}
.row.is-dropped .repo-name,
.row.is-dropped .desc-text {
  color: #7d8b9e;
}

/* ===== 项目列 ===== */
.c-repo {
  min-width: 0;
}

.repo {
  display: flex;
  align-items: center;
  gap: 10px;
  min-width: 0;
}

.avatar {
  flex: none;
  width: 32px;
  height: 32px;
  border-radius: 9px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 11.5px;
  font-weight: 700;
  letter-spacing: 0.3px;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.25), 0 1px 2px rgba(16, 32, 56, 0.15);
}

.repo-text {
  display: flex;
  flex-direction: column;
  min-width: 0;
  line-height: 1.25;
}

.repo-name {
  font-size: 14px;
  font-weight: 650;
  color: var(--text);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.repo:hover .repo-name {
  color: var(--brand);
}

.repo-owner {
  font-size: 11.5px;
  color: #93a1b4;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ===== 简介列 ===== */
.c-desc {
  min-width: 0;
  padding-right: 8px;
}

.desc-text {
  margin: 0;
  font-size: 12.8px;
  color: #4a5768;
  line-height: 1.45;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 3px;
}

.lang {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  font-size: 11px;
  color: #8b9aad;
}

.lang .dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  display: inline-block;
}

.badge.drop {
  font-size: 10px;
  line-height: 15px;
  padding: 0 5px;
  border-radius: 4px;
  background: #f1f4f8;
  color: #8b9aad;
}

/* ===== 数值列 ===== */
.c-today,
.c-stars,
.c-forks {
  display: flex;
  align-items: center;
  justify-content: center;
  font-variant-numeric: tabular-nums;
}

.growth {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 74px;
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 12.5px;
  font-weight: 650;
  letter-spacing: 0.2px;
}

.growth.hot {
  background: #e7f8ee;
  color: #0f8a44;
}
.growth.warm {
  background: #eef7e9;
  color: #4d7c0f;
}
.growth.cool {
  background: #f1f5f9;
  color: #64748b;
}

.c-stars,
.c-forks {
  gap: 5px;
  font-size: 12.5px;
  font-weight: 600;
  color: #5c6b7f;
}

.c-stars .ico {
  color: #f5b823;
}
.c-forks .ico {
  color: #94a3b8;
}

.c-stars .num,
.c-forks .num {
  font-variant-numeric: tabular-nums;
}

/* ===== 骨架 / 空态 ===== */
.skeleton-row {
  pointer-events: none;
}
.sk-badge {
  width: 34px;
  height: 30px;
  border-radius: 9px;
  margin: 0 auto;
}
.sk-avatar {
  width: 32px;
  height: 32px;
  border-radius: 9px;
  flex: none;
}
.sk-lines {
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}
.sk-line {
  height: 10px;
  border-radius: 5px;
}
.sk-pill {
  width: 74px;
  height: 22px;
  border-radius: 999px;
}
.w30 {
  width: 30%;
}
.w50 {
  width: 50%;
}
.w60 {
  width: 60%;
}
.w80 {
  width: 80%;
}

.empty {
  padding: 56px 20px 48px;
  text-align: center;
}
.empty-icon {
  font-size: 34px;
  margin-bottom: 8px;
}
.empty-title {
  margin: 0;
  font-size: 15px;
  font-weight: 600;
  color: #3b4a5e;
}
.empty-sub {
  margin: 6px 0 0;
  font-size: 12.5px;
  color: var(--muted);
}

.foot {
  padding: 10px 18px;
  background: var(--card-soft);
  border-top: 1px solid var(--line);
  text-align: center;
  font-size: 11.5px;
  color: #98a5b6;
}

/* ===== 响应式：窄屏转卡片 ===== */
@media (max-width: 900px) {
  .head {
    display: none;
  }

  .row {
    grid-template-columns: 44px 1fr auto;
    grid-template-areas:
      'rank repo today'
      'rank desc stars';
    row-gap: 4px;
    padding: 12px 14px;
    min-height: unset;
  }

  .c-rank {
    grid-area: rank;
    align-self: start;
  }
  .c-repo {
    grid-area: repo;
  }
  .c-desc {
    grid-area: desc;
    padding-right: 0;
  }
  .c-today {
    grid-area: today;
    justify-content: flex-end;
  }
  .c-stars {
    grid-area: stars;
    justify-content: flex-end;
  }
  .c-forks {
    display: none;
  }

  .desc-text {
    -webkit-line-clamp: 2;
    line-clamp: 2;
    font-size: 12px;
  }
}
</style>
