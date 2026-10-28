<script setup lang="ts">
/**
 * /nav —— 网站导航
 *
 * 数据全部来自 MongoDB（nav_categories / nav_links），往集合里插数据即可更新页面。
 */

interface NavLink {
  name: string
  url: string
  desc: string
  icon: string
  catelog: string
  group: string
}

interface NavCategory {
  key: string
  name: string
  icon: string
  count: number
}

interface NavGroup {
  group: string
  categories: NavCategory[]
}

interface NavResponse {
  total: number
  totalCategories: number
  groups: NavGroup[]
  links: NavLink[]
}

const keyword = ref('')
const activeCat = ref('all')

const { data, pending, error, refresh } = await useCachedData(
  () => 'nav:all',
  () => $fetch<NavResponse>(apiUrl('/api/nav')),
  { ttl: 300_000 }
)

const allLinks = computed<NavLink[]>(() => data.value?.links ?? [])
const groups = computed<NavGroup[]>(() => data.value?.groups ?? [])

const filtered = computed<NavLink[]>(() => {
  let list = allLinks.value
  if (activeCat.value !== 'all') list = list.filter((l) => l.catelog === activeCat.value)

  const kw = keyword.value.trim().toLowerCase()
  if (kw) {
    list = list.filter(
      (l) =>
        l.name.toLowerCase().includes(kw) ||
        l.desc.toLowerCase().includes(kw) ||
        l.url.toLowerCase().includes(kw)
    )
  }
  return list
})

/** 按大类分组展示 */
const sections = computed(() => {
  const map = new Map<string, NavLink[]>()
  for (const l of filtered.value) {
    const g = l.group || '其他'
    if (!map.has(g)) map.set(g, [])
    map.get(g)!.push(l)
  }
  return [...map.entries()].map(([group, items]) => ({ group, items }))
})

const activeCatName = computed(() => {
  if (activeCat.value === 'all') return '全部'
  for (const g of groups.value) {
    const hit = g.categories.find((c) => c.key === activeCat.value)
    if (hit) return hit.name
  }
  return '全部'
})

/** 分组默认全部折叠，点大类名展开 */
const collapsed = ref<Set<string>>(new Set())
const groupsReady = ref(false)

watch(
  groups,
  (g) => {
    if (!groupsReady.value && g.length) {
      collapsed.value = new Set(g.map((x) => x.group))
      groupsReady.value = true
    }
  },
  { immediate: true }
)

const isCollapsed = (name: string) => collapsed.value.has(name)

function toggleGroup(name: string) {
  const next = new Set(collapsed.value)
  if (next.has(name)) next.delete(name)
  else next.add(name)
  collapsed.value = next
}

function pickCat(key: string) {
  activeCat.value = key
  // 选中分类时把所属分组展开，避免选完看不到高亮
  for (const g of groups.value) {
    if (g.categories.some((c) => c.key === key)) {
      const next = new Set(collapsed.value)
      next.delete(g.group)
      collapsed.value = next
      break
    }
  }
  if (import.meta.client) window.scrollTo({ top: 0, behavior: 'smooth' })
}

useHead({ title: '网站导航 · 瞭望台' })
</script>

<template>
  <div class="page">
    <div class="layout">
      <!-- 侧栏：分类 -->
      <aside class="sidebar">
        <div class="side-head">
          <span class="side-title">分类</span>
          <button class="mini-btn" :class="{ on: activeCat === 'all' }" @click="pickCat('all')">
            全部
            <span class="cnt">{{ data?.total ?? 0 }}</span>
          </button>
        </div>

        <div class="side-body">
          <div v-for="g in groups" :key="g.group" class="group">
            <button class="group-name" :class="{ collapsed: isCollapsed(g.group) }" @click="toggleGroup(g.group)">
              <svg class="chev" viewBox="0 0 16 16" width="10" height="10" aria-hidden="true">
                <path fill="currentColor" d="M6 3.75 10.25 8 6 12.25V3.75Z" />
              </svg>
              <span class="g-label">{{ g.group }}</span>
              <span class="g-count">{{ g.categories.length }}</span>
            </button>

            <div v-show="!isCollapsed(g.group)" class="group-body">
            <button
              v-for="c in g.categories"
              :key="c.key"
              class="cat-btn"
              :class="{ active: activeCat === c.key }"
              @click="pickCat(c.key)"
            >
              <span class="cat-icon">{{ c.icon || '•' }}</span>
              <span class="cat-label">{{ c.name }}</span>
              <span class="cnt">{{ c.count }}</span>
            </button>
            </div>
          </div>
        </div>
      </aside>

      <!-- 主区 -->
      <section class="main">
        <div class="toolbar">
          <div class="search">
            <svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
              <path
                fill="currentColor"
                d="M10.68 11.74a6 6 0 0 1-7.922-8.982 6 6 0 0 1 8.982 7.922l3.04 3.04a.749.749 0 0 1-.326 1.275.749.749 0 0 1-.734-.215ZM11.5 7a4.499 4.499 0 1 0-8.997 0A4.499 4.499 0 0 0 11.5 7Z"
              />
            </svg>
            <input v-model="keyword" type="search" placeholder="搜索名称 / 描述 / 地址…" spellcheck="false" />
            <span class="count">共 {{ filtered.length }} 条</span>
          </div>
          <button class="pill-btn" :class="{ spinning: pending }" @click="refresh()">
            <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
              <path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" />
              <path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" />
            </svg>
            刷新
          </button>
        </div>

        <div v-if="error" class="alert">加载失败：{{ error.message }}</div>

        <div v-else-if="pending && !allLinks.length" class="grid">
          <div v-for="i in 12" :key="`sk-${i}`" class="card sk">
            <div class="skeleton" style="width: 40%; height: 12px" />
            <div class="skeleton" style="width: 80%; height: 10px; margin-top: 8px" />
          </div>
        </div>

        <template v-else>
          <section v-for="sec in sections" :key="sec.group" class="section">
            <h2 class="sec-title">
              {{ sec.group }}
              <span class="sec-count">{{ sec.items.length }} 条</span>
            </h2>

            <div class="grid">
              <a
                v-for="l in sec.items"
                :key="l.url"
                class="card"
                :href="l.url"
                target="_blank"
                rel="noopener noreferrer"
              >
                <span class="icon">{{ l.icon || l.name.slice(0, 1).toUpperCase() }}</span>
                <span class="text">
                  <span class="name">{{ l.name }}</span>
                  <span class="desc">{{ l.desc || l.url }}</span>
                </span>
                <ShareButton
                  class="card-share"
                  type="nav"
                  :title="l.name"
                  :desc="l.desc"
                  :url="l.url"
                  badge="🧭 网站导航"
                  :meta="{ catelog: l.catelog, group: l.group }"
                />
              </a>
            </div>
          </section>

          <div v-if="!sections.length" class="empty">
            <p>「{{ activeCatName }}」下没有匹配的站点</p>
            <p class="empty-sub">换个关键词，或点左侧「全部」</p>
          </div>
        </template>
      </section>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 1240px;
  margin: 0 auto;
  padding: 18px 20px 28px;
}

.layout {
  display: grid;
  grid-template-columns: 188px minmax(0, 1fr);
  gap: 16px;
  align-items: start;
}

/* ===== 侧栏 ===== */
.sidebar {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 14px;
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  position: sticky;
  top: 62px;
}

.side-head {
  padding: 10px 12px;
  background: var(--card-soft);
  border-bottom: 1px solid var(--line);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.side-title {
  font-size: 11.5px;
  font-weight: 650;
  color: var(--muted);
  letter-spacing: 0.4px;
}

.mini-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 7px;
  border-radius: 6px;
  border: 1px solid var(--line);
  background: #fff;
  font-size: 11px;
  color: #4a5768;
  cursor: pointer;
}

.mini-btn.on {
  background: var(--brand);
  border-color: var(--brand);
  color: #fff;
}

.side-body {
  max-height: calc(100vh - 140px);
  overflow-y: auto;
  padding: 6px;
}

.group + .group {
  margin-top: 6px;
  border-top: 1px dashed var(--line);
  padding-top: 6px;
}

.group-name {
  display: flex;
  align-items: center;
  gap: 5px;
  width: 100%;
  margin: 2px 0 3px;
  padding: 5px 7px;
  border: 0;
  border-radius: 7px;
  background: transparent;
  font-size: 11px;
  font-weight: 650;
  color: #7b8999;
  letter-spacing: 0.3px;
  cursor: pointer;
  text-align: left;
  transition: background 0.14s ease, color 0.14s ease;
}

.group-name:hover {
  background: #f4f8fd;
  color: var(--brand);
}

.group-name .chev {
  flex: none;
  color: #b3bfcd;
  transition: transform 0.16s ease;
  transform: rotate(90deg);
}

.group-name.collapsed .chev {
  transform: rotate(0deg);
}

.g-label {
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.g-count {
  font-size: 10px;
  font-weight: 500;
  color: #c3cfdf;
  font-variant-numeric: tabular-nums;
}

.group-body {
  padding-bottom: 2px;
}

.cat-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  width: 100%;
  padding: 5px 8px;
  border: 1px solid transparent;
  border-radius: 7px;
  background: transparent;
  font-size: 12.5px;
  color: #3d4c60;
  cursor: pointer;
  text-align: left;
}

.cat-btn:hover {
  background: #f6faff;
}

.cat-btn.active {
  background: #edf4ff;
  border-color: #cfe0fb;
  color: var(--brand);
  font-weight: 600;
}

.cat-icon {
  font-size: 12px;
  width: 16px;
  flex: none;
  text-align: center;
}

.cat-label {
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.cnt {
  font-size: 10.5px;
  color: #a4b0bf;
  font-variant-numeric: tabular-nums;
}

.cat-btn.active .cnt {
  color: var(--brand);
}

/* ===== 主区 ===== */
.main {
  min-width: 0;
}

.toolbar {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 12px;
}

.search {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1;
  min-width: 0;
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

.search .count {
  font-size: 11.5px;
  color: #a4b0bf;
  flex: none;
}

.pill-btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 36px;
  padding: 0 13px;
  border-radius: 10px;
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

.section + .section {
  margin-top: 18px;
}

.sec-title {
  margin: 0 0 8px;
  font-size: 14px;
  font-weight: 700;
  color: #22314a;
  display: flex;
  align-items: baseline;
  gap: 8px;
}

.sec-count {
  font-size: 11px;
  font-weight: 500;
  color: #a4b0bf;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(238px, 1fr));
  gap: 10px;
}

.card {
  display: flex;
  align-items: flex-start;
  gap: 9px;
  padding: 10px 11px;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 11px;
  box-shadow: var(--shadow-sm);
  transition: all 0.15s ease;
  position: relative;
  min-width: 0;
}

.card:hover {
  border-color: #cfe0fb;
  box-shadow: var(--shadow-md);
  transform: translateY(-1px);
}

.card.sk {
  flex-direction: column;
  align-items: stretch;
  height: 62px;
}

.icon {
  flex: none;
  width: 28px;
  height: 28px;
  border-radius: 8px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(180deg, #f7fbff 0%, #eef5ff 100%);
  border: 1px solid #e3edfb;
  font-size: 14px;
  font-weight: 700;
  color: #4a7bd0;
}

.text {
  display: flex;
  flex-direction: column;
  min-width: 0;
  gap: 2px;
}

.name {
  font-size: 12.8px;
  font-weight: 650;
  color: #16233a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.desc {
  font-size: 11px;
  color: #8b9aad;
  line-height: 1.35;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
}

.card-share {
  position: absolute;
  top: 6px;
  right: 6px;
  opacity: 0;
  transition: opacity 0.15s ease;
}

.card:hover .card-share {
  opacity: 1;
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

@media (max-width: 900px) {
  .page {
    padding: 14px 14px 24px;
  }
  .layout {
    grid-template-columns: minmax(0, 1fr);
  }
  .sidebar {
    position: static;
  }
  .side-body {
    max-height: 220px;
  }
  .grid {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  }
}
</style>
