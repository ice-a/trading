<script setup lang="ts">
/**
 * /ai/tutorial/[name] —— 教程详情，渲染 markdown 正文
 */
import MarkdownIt from 'markdown-it'

interface DetailResponse {
  found: boolean
  item?: {
    board: string
    name: string
    url: string
    desc: string
    tags: string[]
    content: string
  }
}

const route = useRoute()

/** 直接读 params，避免 computed 在 SSR 早期拿到空串导致 key 与请求都错位 */
function currentName(): string {
  const raw = String(route.params.name ?? '')
  try {
    return decodeURIComponent(raw)
  } catch {
    return raw
  }
}

const name = computed(() => currentName())

/**
 * 这里不走缓存层：教程详情必须和 URL 参数严格对应，
 * 走 payload 恢复时容易拿到别的 key 的结果（表现为「找不到这篇教程」）。
 */
const { data, pending, error } = await useAsyncData<DetailResponse>(
  () => 'tutorial:' + currentName(),
  () => {
    const n = currentName()
    return $fetch<DetailResponse>(apiUrl('/api/ai/detail'), {
      query: { board: 'tutorials', name: n }
    })
  }
)

const md = new MarkdownIt({ html: false, linkify: true, breaks: true })

const item = computed(() => data.value?.item ?? null)
const html = computed(() => (item.value?.content ? md.render(item.value.content) : ''))

useHead({ title: () => (item.value?.name ? `${item.value.name} · 教程` : '教程 · 瞭望台') })
</script>

<template>
  <div class="page">
    <div class="crumb">
      <NuxtLink to="/ai?b=tutorials" class="back">
        <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
          <path
            fill="currentColor"
            d="M9.78 12.78a.75.75 0 0 1-1.06 0L4.47 8.53a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 1.06L6.06 8l3.72 3.72a.75.75 0 0 1 0 1.06Z"
          />
        </svg>
        返回 AI 资源台
      </NuxtLink>
    </div>

    <div v-if="error" class="alert">加载失败：{{ error.message }}</div>

    <div v-else-if="pending && !item" class="card">
      <div class="skeleton" style="width: 45%; height: 20px" />
      <div class="skeleton" style="width: 100%; height: 12px; margin-top: 18px" />
      <div class="skeleton" style="width: 92%; height: 12px; margin-top: 10px" />
    </div>

    <article v-else-if="item" class="card">
      <header class="head">
        <h1>{{ item.name }}</h1>
        <p v-if="item.desc" class="desc">{{ item.desc }}</p>
        <div class="tags">
          <span v-for="t in item.tags" :key="t" class="tag">{{ t }}</span>
        </div>
      </header>

      <div v-if="html" class="markdown" v-html="html" />
      <p v-else class="empty">这篇教程没有正文</p>
    </article>

    <div v-else class="card empty-card">
      <p>找不到这篇教程</p>
      <NuxtLink to="/ai?b=tutorials" class="link">回到教程列表</NuxtLink>
    </div>
  </div>
</template>

<style scoped>
.page {
  max-width: 900px;
  margin: 0 auto;
  padding: 18px 20px 40px;
}

.crumb {
  margin-bottom: 12px;
}

.back {
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

.back:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
}

.card {
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 14px;
  box-shadow: var(--shadow-md);
  padding: 24px 26px 28px;
}

.head h1 {
  margin: 0;
  font-size: 22px;
  font-weight: 800;
  letter-spacing: -0.3px;
  color: #101828;
  line-height: 1.35;
}

.desc {
  margin: 6px 0 0;
  font-size: 13px;
  color: var(--muted);
  line-height: 1.6;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 5px;
  margin-top: 10px;
}

.tag {
  font-size: 10.5px;
  padding: 1px 7px;
  border-radius: 5px;
  background: #f1f5fa;
  color: #7b8999;
  line-height: 17px;
}

.empty {
  margin: 24px 0 0;
  font-size: 13px;
  color: #b0bccb;
  text-align: center;
}

.empty-card {
  text-align: center;
  padding: 48px 24px;
  font-size: 13px;
  color: #8b9aad;
}

.link {
  display: inline-block;
  margin-top: 10px;
  color: var(--brand);
  font-size: 12.5px;
}

/* ===== markdown 正文 ===== */
.markdown {
  margin-top: 18px;
  font-size: 14px;
  line-height: 1.85;
  color: #22314a;
  word-break: break-word;
}

.markdown :deep(h1),
.markdown :deep(h2),
.markdown :deep(h3),
.markdown :deep(h4) {
  margin: 1.4em 0 0.6em;
  font-weight: 750;
  color: #101828;
  line-height: 1.4;
}

.markdown :deep(h1) {
  font-size: 20px;
  padding-bottom: 6px;
  border-bottom: 1px solid var(--line);
}

.markdown :deep(h2) {
  font-size: 17px;
}

.markdown :deep(h3) {
  font-size: 15px;
}

.markdown :deep(p) {
  margin: 0.7em 0;
}

.markdown :deep(ul),
.markdown :deep(ol) {
  margin: 0.7em 0;
  padding-left: 1.4em;
}

.markdown :deep(li) {
  margin: 0.25em 0;
}

.markdown :deep(li > ul),
.markdown :deep(li > ol) {
  margin: 0.2em 0;
}

.markdown :deep(a) {
  color: var(--brand);
  text-decoration: underline;
  text-underline-offset: 2px;
}

.markdown :deep(code) {
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  font-size: 0.88em;
  padding: 1px 5px;
  border-radius: 5px;
  background: #f1f5fa;
  color: #b4357a;
}

.markdown :deep(pre) {
  margin: 0.9em 0;
  padding: 12px 14px;
  border-radius: 10px;
  background: #f7f9fc;
  border: 1px solid var(--line);
  overflow-x: auto;
}

.markdown :deep(pre code) {
  padding: 0;
  background: transparent;
  color: #22314a;
  font-size: 12.5px;
  line-height: 1.6;
}

.markdown :deep(blockquote) {
  margin: 0.9em 0;
  padding: 6px 14px;
  border-left: 3px solid #cfe0fb;
  background: #f7fbff;
  color: #55657a;
  border-radius: 0 8px 8px 0;
}

.markdown :deep(hr) {
  margin: 1.4em 0;
  border: 0;
  border-top: 1px solid var(--line);
}

.markdown :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 0.9em 0;
  font-size: 13px;
}

.markdown :deep(th),
.markdown :deep(td) {
  border: 1px solid var(--line);
  padding: 6px 10px;
  text-align: left;
}

.markdown :deep(th) {
  background: var(--card-soft);
  font-weight: 650;
}

.markdown :deep(img) {
  max-width: 100%;
  border-radius: 8px;
}

/* 任务列表的复选框 */
.markdown :deep(input[type='checkbox']) {
  margin-right: 5px;
}

@media (max-width: 720px) {
  .page {
    padding: 14px 14px 28px;
  }
  .card {
    padding: 18px 16px 22px;
  }
  .head h1 {
    font-size: 19px;
  }
}
</style>
