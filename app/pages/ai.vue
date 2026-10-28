<script setup lang="ts">
/**
 * /ai —— AI 资源台
 *
 * 板块（Tab）与条目都来自 MongoDB（ai_boards / ai_items）。
 */

interface AiBoard {
  key: string
  name: string
  icon: string
  count: number
}

interface AiItem {
  board: string
  name: string
  url: string
  desc: string
  models: string
  ratio: string
  tags: string[]
}

interface AiResponse {
  total: number
  boards: AiBoard[]
  items: AiItem[]
}

const route = useRoute()
const board = ref(typeof route.query.b === 'string' && route.query.b ? route.query.b : 'stations')
const keyword = ref('')

const { data, pending, error, refresh } = await useCachedData(
  () => `ai:${board.value}`,
  () => $fetch<AiResponse>(apiUrl('/api/ai'), { query: { board: board.value } }),
  { ttl: 300_000 }
)

const boards = computed<AiBoard[]>(() => data.value?.boards ?? [])
const items = computed<AiItem[]>(() => data.value?.items ?? [])

const filtered = computed<AiItem[]>(() => {
  const kw = keyword.value.trim().toLowerCase()
  if (!kw) return items.value
  return items.value.filter(
    (it) =>
      it.name.toLowerCase().includes(kw) ||
      (it.desc || '').toLowerCase().includes(kw) ||
      (it.models || '').toLowerCase().includes(kw) ||
      (it.tags || []).some((t) => t.toLowerCase().includes(kw))
  )
})

const activeBoard = computed(() => boards.value.find((b) => b.key === board.value))

function pick(key: string) {
  if (board.value === key) return
  board.value = key
  keyword.value = ''
  const query: Record<string, string> = {}
  if (key !== 'stations') query.b = key
  useRouter().replace({ query })
}

useHead({ title: 'AI 资源台 · 瞭望台' })
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
        <h1>AI 资源台</h1>
        <p>
          <b>{{ data?.total ?? 0 }}</b> 条资源 · 板块与条目均存于 MongoDB
        </p>
      </div>
      <button class="pill-btn" :class="{ spinning: pending }" @click="refresh()">
        <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
          <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
          <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
        </svg>
        刷新
      </button>
    </header>

    <!-- 板块 Tab -->
    <nav class="tabs">
      <button
        v-for="b in boards"
        :key="b.key"
        class="tab"
        :class="{ active: board === b.key }"
        @click="pick(b.key)"
      >
        <span class="tab-icon">{{ b.icon || '•' }}</span>
        <span>{{ b.name }}</span>
        <span class="cnt">{{ b.count }}</span>
      </button>
    </nav>

    <div class="toolbar">
      <div class="search">
        <svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
          <path
            fill="currentColor"
            d="M10.68 11.74a6 6 0 0 1-7.922-8.982 6 6 0 0 1 8.982 7.922l3.04 3.04a.749.749 0 0 1-.326 1.275.749.749 0 0 1-.734-.215ZM11.5 7a4.499 4.499 0 1 0-8.997 0A4.499 4.499 0 0 0 11.5 7Z"
          />
        </svg>
        <input v-model="keyword" type="search" placeholder="搜索名称 / 模型 / 标签…" spellcheck="false" />
        <span class="count">{{ filtered.length }} 条</span>
      </div>
    </div>

    <div v-if="error" class="alert">加载失败：{{ error.message }}</div>

    <div v-else-if="pending && !items.length" class="grid">
      <div v-for="i in 9" :key="`sk-${i}`" class="card sk">
        <div class="skeleton" style="width: 45%; height: 13px" />
        <div class="skeleton" style="width: 85%; height: 10px; margin-top: 10px" />
      </div>
    </div>

    <div v-else-if="filtered.length" class="grid">
      <article v-for="it in filtered" :key="`${it.board}-${it.name}`" class="card" :class="{ tutorial: it.board === 'tutorials' }">
        <header class="card-head">
          <h3 class="name">{{ it.name }}</h3>
          <div class="head-right">
            <span v-if="it.ratio" class="ratio">{{ it.ratio }}</span>
            <ShareButton
              type="ai"
              :title="it.name"
              :desc="it.desc"
              :url="it.url"
              :badge="'🤖 ' + (activeBoard?.name || 'AI 资源')"
              :meta="{ board: it.board, models: it.models, tags: it.tags }"
            />
          </div>
        </header>

        <p v-if="it.models" class="models">{{ it.models }}</p>
        <p v-else-if="it.desc" class="models">{{ it.desc }}</p>

        <div class="tags">
          <span v-for="t in it.tags" :key="t" class="tag">{{ t }}</span>
        </div>

        <footer class="card-foot">
          <NuxtLink
            v-if="it.board === 'tutorials'"
            class="open-btn"
            :to="'/ai/tutorial/' + encodeURIComponent(it.name)"
          >
            阅读全文
            <svg viewBox="0 0 16 16" width="10" height="10" aria-hidden="true">
              <path fill="currentColor" d="M6 3.75 10.25 8 6 12.25V3.75Z" />
            </svg>
          </NuxtLink>
          <a v-else-if="it.url" class="open-btn" :href="it.url" target="_blank" rel="noopener noreferrer">
            <svg viewBox="0 0 16 16" width="11" height="11" aria-hidden="true">
              <path
                fill="currentColor"
                d="M3.75 2h3.5a.75.75 0 0 1 0 1.5h-3.5a.25.25 0 0 0-.25.25v8.5c0 .138.112.25.25.25h8.5a.25.25 0 0 0 .25-.25v-3.5a.75.75 0 0 1 1.5 0v3.5A1.75 1.75 0 0 1 12.25 14h-8.5A1.75 1.75 0 0 1 2 12.25v-8.5C2 2.784 2.784 2 3.75 2Zm6.5-1.5h4.5a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0V2.56L8.28 8.28a.75.75 0 0 1-1.06-1.06L12.94 1.5h-2.69a.75.75 0 0 1 0-1.5Z"
              />
            </svg>
            打开
          </a>
          <span v-else class="open-btn disabled">无地址</span>
        </footer>
      </article>
    </div>

    <div v-else class="empty">
      <p>「{{ activeBoard?.name || '当前板块' }}」下没有匹配的资源</p>
      <p class="empty-sub">换个关键词，或切换到其他板块</p>
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
  margin-bottom: 12px;
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

/* Tab */
.tabs {
  display: flex;
  gap: 7px;
  padding-bottom: 10px;
  overflow-x: auto;
  scrollbar-width: none;
}

.tabs::-webkit-scrollbar {
  display: none;
}

.tab {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 11px;
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

.tab.active {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
  box-shadow: 0 3px 12px rgba(31, 111, 235, 0.28);
}

.tab-icon {
  font-size: 12px;
  line-height: 1;
}

.cnt {
  font-size: 10.5px;
  padding: 0 5px;
  border-radius: 5px;
  background: #f1f5fa;
  color: #8b9aad;
  line-height: 15px;
}

.tab.active .cnt {
  background: rgba(255, 255, 255, 0.22);
  color: #fff;
}

/* 搜索 */
.toolbar {
  margin-bottom: 12px;
}

.search {
  display: flex;
  align-items: center;
  gap: 8px;
  height: 36px;
  padding: 0 12px;
  border-radius: 10px;
  border: 1px solid var(--line-strong);
  background: #fff;
  box-shadow: var(--shadow-sm);
  color: #8b9aad;
}

.search input {
  flex: 1;
  min-width: 0;
  border: 0;
  outline: 0;
  font-size: 13px;
  color: #22314a;
  background: transparent;
}

.count {
  font-size: 11.5px;
  color: #a4b0bf;
  flex: none;
}

/* 卡片 */
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
  padding: 11px 12px;
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

.name {
  margin: 0;
  font-size: 13.5px;
  font-weight: 700;
  color: #16233a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.head-right {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  flex: none;
}

.card.tutorial {
  border-color: #e3edfb;
  background: linear-gradient(180deg, #fbfdff 0%, #ffffff 60%);
}
.ratio {
  flex: none;
  padding: 1px 6px;
  border-radius: 5px;
  background: #e8f8ee;
  color: #0f8a44;
  font-size: 10.5px;
  font-weight: 700;
  line-height: 16px;
}

.models {
  margin: 6px 0 0;
  font-size: 11.5px;
  color: #7b8999;
  line-height: 1.45;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  min-height: 33px;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  margin-top: 6px;
  min-height: 18px;
}

.tag {
  font-size: 10px;
  padding: 0 5px;
  border-radius: 4px;
  background: #f1f5fa;
  color: #7b8999;
  line-height: 16px;
}

.card-foot {
  margin-top: auto;
  padding-top: 8px;
}

.open-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
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

.open-btn.disabled {
  border-color: var(--line);
  background: #f7f9fc;
  color: #b0bccb;
  cursor: default;
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
