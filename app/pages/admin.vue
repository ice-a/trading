<script setup lang="ts">
/**
 * /admin —— 数据后台
 *
 * 密码保护（服务端环境变量 ADMIN_PASSWORD，默认 admin123），可查看统计、列表、新增、删除。
 */
interface Stats {
  navLinks: number
  navCategories: number
  aiItems: number
  aiBoards: number
  creators: number
  dns: number
  shares: number
  trendingRepos: number
  feedSnapshots: number
  crawlRuns: number
}

interface AdminItem {
  id: string
  [k: string]: unknown
}

const STORAGE_KEY = 'liaowangtai:admin:pw'

const password = ref('')
const authed = ref(false)
const loading = ref(false)
const message = ref('')
const messageType = ref<'ok' | 'err'>('ok')

const stats = ref<Stats | null>(null)
const collections = ref<Array<{ key: string; label: string }>>([])
const activeColl = ref('nav_links')
const items = ref<AdminItem[]>([])
const total = ref(0)
const keyword = ref('')

const form = reactive<Record<string, string>>({})

const FIELDS: Record<string, Array<{ key: string; label: string; placeholder: string; required?: boolean }>> = {
  nav_links: [
    { key: 'name', label: '名称', placeholder: '站点名称', required: true },
    { key: 'url', label: '地址', placeholder: 'https://…', required: true },
    { key: 'catelog', label: '分类 key', placeholder: 'browser-ext' },
    { key: 'group', label: '大类', placeholder: '效率工具' },
    { key: 'desc', label: '描述', placeholder: '一句话说明' },
    { key: 'icon', label: '图标', placeholder: '🧩' }
  ],
  ai_items: [
    { key: 'board', label: '板块', placeholder: 'stations', required: true },
    { key: 'name', label: '名称', placeholder: '资源名称', required: true },
    { key: 'url', label: '地址', placeholder: 'https://…' },
    { key: 'models', label: '模型', placeholder: 'gpt-5 / claude-4' },
    { key: 'ratio', label: '倍率', placeholder: '0.05x' },
    { key: 'desc', label: '描述', placeholder: '一句话说明' }
  ],
  github_creators: [
    { key: 'login', label: '用户名', placeholder: 'gaearon', required: true },
    { key: 'note', label: '备注', placeholder: 'React 核心' }
  ],
  nav_categories: [
    { key: 'key', label: 'key', placeholder: 'browser-ext', required: true },
    { key: 'name', label: '名称', placeholder: '浏览器扩展', required: true },
    { key: 'group', label: '大类', placeholder: '效率工具' },
    { key: 'icon', label: '图标', placeholder: '🧩' }
  ],
  ai_boards: [
    { key: 'key', label: 'key', placeholder: 'stations', required: true },
    { key: 'name', label: '名称', placeholder: '中转站', required: true },
    { key: 'icon', label: '图标', placeholder: '☁️' }
  ]
}

const fields = computed(() => FIELDS[activeColl.value] ?? FIELDS.nav_links!)

function headers() {
  return { 'x-admin-password': password.value }
}

function flash(msg: string, type: 'ok' | 'err' = 'ok') {
  message.value = msg
  messageType.value = type
  window.setTimeout(() => (message.value = ''), 2600)
}

async function login() {
  if (!password.value.trim()) return
  loading.value = true
  try {
    const res = await $fetch<{ ok: boolean; error?: string }>(apiUrl('/api/admin/login'), {
      method: 'POST',
      body: { password: password.value }
    })
    if (res.ok) {
      authed.value = true
      localStorage.setItem(STORAGE_KEY, password.value)
      await Promise.all([loadStats(), loadList()])
    } else {
      flash(res.error || '密码不正确', 'err')
    }
  } catch {
    flash('登录失败', 'err')
  } finally {
    loading.value = false
  }
}

function logout() {
  authed.value = false
  password.value = ''
  localStorage.removeItem(STORAGE_KEY)
}

async function loadStats() {
  try {
    const res = await $fetch<{ ok: boolean; stats: Stats; collections: Array<{ key: string; label: string }> }>(
      apiUrl('/api/admin/stats'),
      { headers: headers() }
    )
    stats.value = res.stats
    if (res.collections?.length) collections.value = res.collections
  } catch {
    flash('统计加载失败', 'err')
  }
}

async function loadList() {
  loading.value = true
  try {
    const res = await $fetch<{ ok: boolean; items: AdminItem[]; total: number; label?: string }>(
      apiUrl('/api/admin/list'),
      { headers: headers(), query: { coll: activeColl.value, limit: 200, keyword: keyword.value } }
    )
    items.value = res.items || []
    total.value = res.total ?? 0
  } catch {
    flash('列表加载失败', 'err')
  } finally {
    loading.value = false
  }
}

function switchColl(key: string) {
  activeColl.value = key
  keyword.value = ''
  for (const f of fields.value) form[f.key] = ''
  loadList()
}

async function create() {
  const doc: Record<string, unknown> = {}
  for (const f of fields.value) {
    if (form[f.key]) doc[f.key] = form[f.key]
  }
  loading.value = true
  try {
    const res = await $fetch<{ ok: boolean; error?: string }>(apiUrl('/api/admin/create'), {
      method: 'POST',
      headers: headers(),
      body: { coll: activeColl.value, doc }
    })
    if (res.ok) {
      flash('已新增')
      for (const f of fields.value) form[f.key] = ''
      await Promise.all([loadList(), loadStats()])
    } else {
      flash(res.error || '新增失败', 'err')
    }
  } catch {
    flash('新增失败', 'err')
  } finally {
    loading.value = false
  }
}

async function remove(item: AdminItem) {
  const label = String(item.name || item.login || item.key || item.id)
  if (!window.confirm(`确定删除「${label}」？`)) return
  loading.value = true
  try {
    const res = await $fetch<{ ok: boolean }>(apiUrl('/api/admin/delete'), {
      method: 'POST',
      headers: headers(),
      body: { coll: activeColl.value, id: item.id }
    })
    flash(res.ok ? '已删除' : '删除失败', res.ok ? 'ok' : 'err')
    await Promise.all([loadList(), loadStats()])
  } catch {
    flash('删除失败', 'err')
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  const saved = localStorage.getItem(STORAGE_KEY)
  if (!saved) return
  password.value = saved
  authed.value = true
  await Promise.all([loadStats(), loadList()])
})

useHead({ title: '数据后台 · 瞭望台' })
</script>

<template>
  <div class="page">
    <!-- 登录 -->
    <div v-if="!authed" class="login-card">
      <h1>数据后台</h1>
      <p class="login-tip">输入管理密码（环境变量 <code>ADMIN_PASSWORD</code>，未配置时默认 <code>admin123</code>）</p>
      <div class="login-row">
        <input
          v-model="password"
          type="password"
          placeholder="管理密码"
          @keyup.enter="login"
        />
        <button class="btn primary" :disabled="loading" @click="login">进入</button>
      </div>
      <p v-if="message" class="msg" :class="messageType">{{ message }}</p>
    </div>

    <!-- 后台主体 -->
    <template v-else>
      <header class="hero">
        <div class="hero-left">
          <h1>数据后台</h1>
          <p>可直接新增 / 删除导航与 AI 资源，改动会清缓存立即生效</p>
        </div>
        <button class="btn" @click="logout">退出登录</button>
      </header>

      <!-- 统计 -->
      <section class="stats">
        <div v-for="(v, k) in stats" :key="k" class="stat-card">
          <span class="stat-num">{{ v }}</span>
          <span class="stat-label">{{
            {
              navLinks: '导航站点',
              navCategories: '导航分类',
              aiItems: 'AI 资源',
              aiBoards: 'AI 板块',
              creators: 'GitHub 用户',
              dns: 'DNS 记录',
              shares: '分享',
              trendingRepos: '榜单仓库',
              feedSnapshots: '聚合快照',
              crawlRuns: '抓取记录'
            }[k]
          }}</span>
        </div>
      </section>

      <!-- 集合切换 -->
      <div class="tabs">
        <button
          v-for="c in collections"
          :key="c.key"
          class="tab"
          :class="{ on: activeColl === c.key }"
          @click="switchColl(c.key)"
        >
          {{ c.label }}
        </button>
      </div>

      <!-- 新增表单 -->
      <section class="panel">
        <h2 class="panel-title">新增一条</h2>
        <div class="form">
          <label v-for="f in fields" :key="f.key" class="field">
            <span>{{ f.label }}<i v-if="f.required">*</i></span>
            <input v-model="form[f.key]" :placeholder="f.placeholder" />
          </label>
        </div>
        <button class="btn primary" :disabled="loading" @click="create">新增</button>
      </section>

      <!-- 列表 -->
      <section class="panel">
        <div class="list-head">
          <h2 class="panel-title">列表 <span class="dim">共 {{ total }} 条</span></h2>
          <div class="list-tools">
            <input v-model="keyword" class="search" placeholder="搜索…" @keyup.enter="loadList" />
            <button class="btn" :disabled="loading" @click="loadList">搜索</button>
          </div>
        </div>

        <div class="rows">
          <div v-for="it in items" :key="it.id" class="row">
            <div class="row-main">
              <span class="row-title">{{ it.name || it.login || it.key }}</span>
              <span class="row-sub">{{ it.url || it.group || it.board || it.note || '' }}</span>
            </div>
            <span v-if="it.catelog" class="chip">{{ it.catelog }}</span>
            <span v-if="it.board" class="chip">{{ it.board }}</span>
            <button class="del" :disabled="loading" @click="remove(it)">删除</button>
          </div>

          <p v-if="!items.length" class="empty">这个集合还没有数据</p>
        </div>
      </section>

      <p v-if="message" class="toast" :class="messageType">{{ message }}</p>
    </template>
  </div>
</template>

<style scoped>
.page {
  max-width: 1000px;
  margin: 0 auto;
  padding: 18px 20px 40px;
}

/* 登录 */
.login-card {
  max-width: 420px;
  margin: 80px auto 0;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 16px;
  box-shadow: var(--shadow-md);
  padding: 28px 26px;
  text-align: center;
}

.login-card h1 {
  margin: 0;
  font-size: 20px;
  font-weight: 800;
  color: #101828;
}

.login-tip {
  margin: 8px 0 18px;
  font-size: 12px;
  color: var(--muted);
  line-height: 1.6;
}

.login-tip code {
  font-family: ui-monospace, Menlo, monospace;
  background: #f1f5fa;
  padding: 1px 5px;
  border-radius: 4px;
  color: #b4357a;
}

.login-row {
  display: flex;
  gap: 8px;
}

.login-row input {
  flex: 1;
  height: 38px;
  padding: 0 12px;
  border-radius: 10px;
  border: 1px solid var(--line-strong);
  font-size: 13px;
  outline: 0;
}

.login-row input:focus {
  border-color: var(--brand);
  box-shadow: 0 0 0 3px rgba(31, 111, 235, 0.12);
}

/* 头部 */
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

/* 统计 */
.stats {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(112px, 1fr));
  gap: 10px;
  margin-bottom: 14px;
}

.stat-card {
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 11px 13px;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 11px;
  box-shadow: var(--shadow-sm);
}

.stat-num {
  font-size: 20px;
  font-weight: 800;
  color: #101828;
  font-variant-numeric: tabular-nums;
  line-height: 1.2;
}

.stat-label {
  font-size: 11px;
  color: var(--muted);
}

/* Tabs */
.tabs {
  display: flex;
  gap: 7px;
  margin-bottom: 12px;
  flex-wrap: wrap;
}

.tab {
  padding: 6px 12px;
  border-radius: 9px;
  border: 1px solid var(--line);
  background: #fff;
  color: #4a5768;
  font-size: 12.5px;
  font-weight: 550;
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
}

/* 面板 */
.panel {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 13px;
  box-shadow: var(--shadow-sm);
  padding: 16px;
  margin-bottom: 14px;
}

.panel-title {
  margin: 0 0 12px;
  font-size: 13.5px;
  font-weight: 700;
  color: #22314a;
}

.dim {
  font-size: 11px;
  font-weight: 500;
  color: var(--muted);
}

.form {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 10px;
  margin-bottom: 12px;
}

.field {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.field span {
  font-size: 11px;
  color: var(--muted);
  font-weight: 600;
}

.field i {
  color: #f76c6c;
  font-style: normal;
  margin-left: 2px;
}

.field input {
  height: 34px;
  padding: 0 10px;
  border-radius: 8px;
  border: 1px solid var(--line-strong);
  font-size: 12.5px;
  outline: 0;
}

.field input:focus {
  border-color: var(--brand);
}

/* 列表 */
.list-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 10px;
  flex-wrap: wrap;
}

.list-tools {
  display: flex;
  gap: 7px;
}

.search {
  height: 32px;
  padding: 0 10px;
  border-radius: 8px;
  border: 1px solid var(--line-strong);
  font-size: 12.5px;
  outline: 0;
  width: 180px;
}

.rows {
  display: flex;
  flex-direction: column;
}

.row {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 4px;
  border-bottom: 1px dashed var(--line);
}

.row:last-child {
  border-bottom: 0;
}

.row-main {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.row-title {
  font-size: 12.8px;
  font-weight: 600;
  color: #22314a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.row-sub {
  font-size: 10.5px;
  color: #a4b0bf;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.chip {
  flex: none;
  font-size: 10px;
  padding: 0 6px;
  border-radius: 5px;
  background: #f1f5fa;
  color: #7b8999;
  line-height: 17px;
}

.del {
  flex: none;
  padding: 3px 9px;
  border-radius: 7px;
  border: 1px solid #ffd9d9;
  background: #fff5f5;
  color: #b42318;
  font-size: 11.5px;
  cursor: pointer;
}

.del:hover {
  background: #ffecec;
}

.empty {
  padding: 24px;
  text-align: center;
  font-size: 12.5px;
  color: #b0bccb;
}

.btn {
  height: 34px;
  padding: 0 14px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12.5px;
  font-weight: 600;
  cursor: pointer;
}

.btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
}

.btn.primary {
  border-color: var(--brand);
  background: var(--brand);
  color: #fff;
}

.btn.primary:hover {
  background: #1a5fd0;
  color: #fff;
}

.btn:disabled {
  opacity: 0.6;
  cursor: default;
}

.msg {
  margin: 12px 0 0;
  font-size: 12px;
}

.msg.err {
  color: #b42318;
}

.msg.ok {
  color: #0f8a44;
}

.toast {
  position: fixed;
  right: 24px;
  bottom: 24px;
  padding: 10px 16px;
  border-radius: 10px;
  font-size: 12.5px;
  font-weight: 600;
  box-shadow: var(--shadow-md);
  background: #101828;
  color: #fff;
  z-index: 100;
}

.toast.err {
  background: #b42318;
}

.toast.ok {
  background: #0f8a44;
}

@media (max-width: 720px) {
  .page {
    padding: 14px 14px 32px;
  }
  .search {
    width: 120px;
  }
}
</style>
