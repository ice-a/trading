<script setup lang="ts">
/**
 * /github —— 热门 GitHub 用户 + 公开仓库列表
 *
 * 只保留仓库搜索：默认看 ice-a，可换任意 GitHub 用户。
 */

interface Creator {
  login: string
  note: string
  avatar: string
  url: string
}

interface Repo {
  name: string
  fullName: string
  url: string
  desc: string
  language: string
  stars: number
  forks: number
  fork: boolean
  pushedAt: string
  topics: string[]
}

interface ReposResponse {
  user: string
  total: number
  error: string | null
  items: Repo[]
}

const route = useRoute()
const currentUser = ref(typeof route.query.u === 'string' && route.query.u ? route.query.u : 'ice-a')
const keyword = ref('')
const sortBy = ref<'pushed' | 'stars' | 'name'>('pushed')


const reposData = useCachedData(
  () => `repos:${currentUser.value}:${sortBy.value}`,
  () =>
    $fetch<ReposResponse>(apiUrl('/api/repos'), {
      query: { user: currentUser.value, sort: sortBy.value }
    }),
  { ttl: 600_000 }
)
const repos = reposData.data
const reposPending = reposData.pending
const reposError = reposData.error
const reposRefresh = reposData.refresh

const filteredRepos = computed<Repo[]>(() => {
  const list = repos.value?.items ?? []
  const kw = keyword.value.trim().toLowerCase()
  if (!kw) return list
  return list.filter(
    (r) =>
      r.name.toLowerCase().includes(kw) ||
      (r.desc || '').toLowerCase().includes(kw) ||
      (r.language || '').toLowerCase().includes(kw) ||
      (r.topics || []).some((t) => t.toLowerCase().includes(kw))
  )
})

const langColor: Record<string, string> = {
  TypeScript: '#3178c6',
  JavaScript: '#f1e05a',
  Vue: '#41b883',
  Python: '#3572A5',
  Go: '#00ADD8',
  Rust: '#dea584',
  Shell: '#89e051',
  HTML: '#e34c26',
  CSS: '#663399',
  Java: '#b07219',
  'C++': '#f34b7d',
  C: '#555555',
  Ruby: '#701516',
  PHP: '#4F5D95'
}

function colorOf(lang: string) {
  return langColor[lang] || '#8b949e'
}

function pushedAgo(iso: string) {
  if (!iso) return ''
  const diff = Date.now() - new Date(iso).getTime()
  const d = Math.floor(diff / 86400000)
  if (d < 1) return '今天'
  if (d < 30) return `${d} 天前`
  if (d < 365) return `${Math.floor(d / 30)} 个月前`
  return `${Math.floor(d / 365)} 年前`
}


useHead({ title: 'GitHub · 瞭望台' })
</script>

<template>
  <div class="page">
    <header class="hero">
      <div class="hero-left">
        <h1>GitHub</h1>
        <p>
          当前查看 <b>{{ currentUser }}</b> 的 <b>{{ repos?.total ?? 0 }}</b> 个公开仓库 · 最近推送优先
        </p>
      </div>
      <a class="pill-btn" href="https://github.com/" target="_blank" rel="noopener noreferrer">
        <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
          <path
            fill="currentColor"
            d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z"
          />
        </svg>
        打开 GitHub
      </a>
    </header>

    <!-- 仓库 -->
    <section class="block">
      <div class="repo-head">
        <h2 class="block-title">
          GitHub 仓库
          <span class="sub">{{ currentUser }} · 最近推送优先</span>
        </h2>

        <div class="repo-tools">
          <div class="sort">
            <button :class="{ on: sortBy === 'pushed' }" @click="sortBy = 'pushed'">最近推送</button>
            <button :class="{ on: sortBy === 'stars' }" @click="sortBy = 'stars'">最多 Star</button>
            <button :class="{ on: sortBy === 'name' }" @click="sortBy = 'name'">名称</button>
          </div>
          <button class="pill-btn small" :class="{ spinning: reposPending }" @click="reposRefresh()">刷新</button>
        </div>
      </div>

      <div class="search">
        <svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
          <path
            fill="currentColor"
            d="M10.68 11.74a6 6 0 0 1-7.922-8.982 6 6 0 0 1 8.982 7.922l3.04 3.04a.749.749 0 0 1-.326 1.275.749.749 0 0 1-.734-.215ZM11.5 7a4.499 4.499 0 1 0-8.997 0A4.499 4.499 0 0 0 11.5 7Z"
          />
        </svg>
        <input v-model="keyword" type="search" placeholder="搜索仓库名 / 描述 / 语言 / 标签…" spellcheck="false" />
        <span class="count">{{ filteredRepos.length }} 个</span>
      </div>

      <div v-if="repos?.error" class="alert">
        {{ repos.error }}
      </div>

      <div v-else-if="reposPending && !(repos?.items?.length)" class="repo-grid">
        <div v-for="i in 9" :key="`sk-${i}`" class="repo-card sk">
          <div class="skeleton" style="width: 45%; height: 13px" />
          <div class="skeleton" style="width: 85%; height: 10px; margin-top: 10px" />
        </div>
      </div>

      <div v-else-if="filteredRepos.length" class="repo-grid">
        <a
          v-for="r in filteredRepos"
          :key="r.fullName"
          class="repo-card"
          :href="r.url"
          target="_blank"
          rel="noopener noreferrer"
        >
          <header class="rc-head">
            <span class="rc-name">{{ r.name }}</span>
            <span v-if="r.fork" class="fork-tag">Fork</span>
          </header>

          <p class="rc-desc">{{ r.desc || '暂无描述' }}</p>

          <div class="rc-meta">
            <span v-if="r.language" class="lang">
              <i class="dot" :style="{ background: colorOf(r.language) }" />
              {{ r.language }}
            </span>
            <span class="stat">
              <svg viewBox="0 0 16 16" width="11" height="11" aria-hidden="true">
                <path
                  fill="currentColor"
                  d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.75.75 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z"
                />
              </svg>
              {{ r.stars }}
            </span>
            <span class="stat">⑂ {{ r.forks }}</span>
            <span class="pushed">更新 {{ pushedAgo(r.pushedAt) }}</span>
          </div>
        </a>
      </div>

      <div v-else class="empty">
        <p>没有匹配的仓库</p>
        <p class="empty-sub">换个关键词，或点上面的其他用户</p>
      </div>
    </section>
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

.pill-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
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

.pill-btn.small {
  height: 28px;
  padding: 0 10px;
  font-size: 11.5px;
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

.block + .block {
  margin-top: 20px;
}

.block-title {
  margin: 0 0 10px;
  font-size: 14px;
  font-weight: 700;
  color: #22314a;
  display: flex;
  align-items: baseline;
  gap: 8px;
  flex-wrap: wrap;
}

.sub {
  font-size: 11px;
  font-weight: 500;
  color: #a4b0bf;
}

/* 用户墙 */
.creators {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(112px, 1fr));
  gap: 8px;
}

.creator {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
  padding: 10px 6px 8px;
  border-radius: 11px;
  border: 1px solid var(--line);
  background: var(--card);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all 0.15s ease;
}

.creator:hover {
  border-color: #cfe0fb;
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}

.creator.active {
  border-color: var(--brand);
  box-shadow: 0 0 0 2px rgba(31, 111, 235, 0.15);
}

.creator img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #f1f5fa;
  object-fit: cover;
}

.c-login {
  font-size: 11.5px;
  font-weight: 650;
  color: #22314a;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.c-note {
  font-size: 10px;
  color: #a4b0bf;
  max-width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 仓库 */
.repo-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 8px;
}

.repo-head .block-title {
  margin: 0;
}

.repo-tools {
  display: flex;
  align-items: center;
  gap: 8px;
}

.sort {
  display: inline-flex;
  padding: 2px;
  border-radius: 9px;
  background: #f1f5fa;
}

.sort button {
  padding: 4px 9px;
  border: 0;
  border-radius: 7px;
  background: transparent;
  font-size: 11.5px;
  color: #6b7a90;
  cursor: pointer;
}

.sort button.on {
  background: #fff;
  color: var(--brand);
  font-weight: 650;
  box-shadow: var(--shadow-sm);
}

.search {
  display: flex;
  align-items: center;
  gap: 8px;
  height: 36px;
  padding: 0 12px;
  margin-bottom: 12px;
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

.repo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(268px, 1fr));
  gap: 12px;
}

.repo-card {
  display: flex;
  flex-direction: column;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  padding: 11px 12px;
  min-height: 116px;
  transition: all 0.15s ease;
}

.repo-card:hover {
  border-color: #cfe0fb;
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}

.repo-card.sk {
  min-height: 80px;
}

.rc-head {
  display: flex;
  align-items: center;
  gap: 6px;
}

.rc-name {
  font-size: 13.5px;
  font-weight: 700;
  color: #16233a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.fork-tag {
  flex: none;
  font-size: 9.5px;
  padding: 0 5px;
  border-radius: 4px;
  background: #f1f5fa;
  color: #8b9aad;
  line-height: 15px;
}

.rc-desc {
  margin: 5px 0 0;
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

.rc-meta {
  display: flex;
  align-items: center;
  gap: 7px;
  margin-top: auto;
  padding-top: 8px;
  font-size: 10.5px;
  color: #93a1b4;
  flex-wrap: wrap;
}

.lang {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.lang .dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
}

.stat {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  font-variant-numeric: tabular-nums;
}

.pushed {
  margin-left: auto;
}

.alert {
  padding: 10px 14px;
  border-radius: 10px;
  border: 1px solid #ffe1b8;
  background: #fffaf0;
  color: #b45309;
  font-size: 12.5px;
}

.empty {
  padding: 40px 20px;
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
  .repo-grid {
    grid-template-columns: minmax(0, 1fr);
  }
  .creators {
    grid-template-columns: repeat(auto-fill, minmax(96px, 1fr));
  }
}
</style>
