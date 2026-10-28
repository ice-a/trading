<script setup lang="ts">
/**
 * /s/[sid] —— 分享展示页（模板）
 *
 * 从任意卡片点「分享」生成，展示一张排版好的卡片，可直接把链接发给别人。
 */

interface ShareBody {
  found: boolean
  share?: {
    sid: string
    type: string
    title: string
    desc: string
    url: string
    badge: string
    meta: Record<string, unknown>
    views: number
    createdAt: string | null
  }
}

const route = useRoute()
const sid = computed(() => String(route.params.sid || ''))

const { data, error } = await useAsyncData(
  () => `share:${sid.value}`,
  () => $fetch<ShareBody>(apiUrl(`/api/share/${sid.value}`)),
  { server: true }
)

const share = computed(() => data.value?.share ?? null)

const createdLabel = computed(() => {
  const t = share.value?.createdAt
  if (!t) return ''
  const d = new Date(t)
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
})

const typeLabel: Record<string, string> = {
  nav: '网站导航',
  ai: 'AI 资源',
  repo: 'GitHub 仓库',
  dns: 'DNS 记录',
  custom: '分享'
}

useHead({ title: () => (share.value ? `${share.value.title} · 分享` : '分享 · 瞭望台') })
</script>

<template>
  <div class="wrap">
    <div v-if="error" class="err">加载失败</div>

    <template v-else-if="share">
      <div class="card" :class="`t-${share.type}`">
        <div class="glow" />

        <div class="head">
          <span class="badge">{{ share.badge || '🔗 ' + (typeLabel[share.type] || '分享') }}</span>
          <span class="views">{{ share.views }} 次浏览</span>
        </div>

        <h1 class="title">{{ share.title }}</h1>

        <p v-if="share.desc" class="desc">{{ share.desc }}</p>

        <p v-if="share.url" class="url">{{ share.url }}</p>

        <div class="actions">
          <a v-if="share.url" class="btn primary" :href="share.url" target="_blank" rel="noopener noreferrer">
            打开链接
            <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
              <path
                fill="currentColor"
                d="M3.75 2h3.5a.75.75 0 0 1 0 1.5h-3.5a.25.25 0 0 0-.25.25v8.5c0 .138.112.25.25.25h8.5a.25.25 0 0 0 .25-.25v-3.5a.75.75 0 0 1 1.5 0v3.5A1.75 1.75 0 0 1 12.25 14h-8.5A1.75 1.75 0 0 1 2 12.25v-8.5C2 2.784 2.784 2 3.75 2Zm6.5-1.5h4.5a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0V2.56L8.28 8.28a.75.75 0 0 1-1.06-1.06L12.94 1.5h-2.69a.75.75 0 0 1 0-1.5Z"
              />
            </svg>
          </a>
          <NuxtLink to="/share" class="btn">更多分享</NuxtLink>
        </div>

        <div class="foot">
          <span v-if="createdLabel">分享于 {{ createdLabel }}</span>
          <span class="dot-sep">·</span>
          <span>瞭望台</span>
        </div>
      </div>
    </template>

    <div v-else class="card empty-card">
      <p>这份分享不存在或已失效</p>
      <NuxtLink to="/share" class="link">去看看其他分享</NuxtLink>
    </div>
  </div>
</template>

<style scoped>
.wrap {
  max-width: 680px;
  margin: 0 auto;
  padding: 40px 20px 60px;
}

.card {
  position: relative;
  overflow: hidden;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 20px;
  box-shadow: var(--shadow-lg);
  padding: 28px 30px 24px;
}

.glow {
  position: absolute;
  top: -90px;
  right: -70px;
  width: 240px;
  height: 240px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(31, 111, 235, 0.14) 0%, rgba(31, 111, 235, 0) 70%);
  pointer-events: none;
}

.card.t-ai .glow {
  background: radial-gradient(circle, rgba(124, 58, 237, 0.15) 0%, rgba(124, 58, 237, 0) 70%);
}
.card.t-repo .glow {
  background: radial-gradient(circle, rgba(16, 185, 129, 0.15) 0%, rgba(16, 185, 129, 0) 70%);
}
.card.t-dns .glow {
  background: radial-gradient(circle, rgba(245, 158, 11, 0.16) 0%, rgba(245, 158, 11, 0) 70%);
}

.head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  position: relative;
}

.badge {
  display: inline-flex;
  align-items: center;
  padding: 3px 10px;
  border-radius: 999px;
  background: #eef4ff;
  color: #3f6fd8;
  font-size: 11.5px;
  font-weight: 650;
}

.views {
  font-size: 11px;
  color: #a4b0bf;
}

.title {
  position: relative;
  margin: 16px 0 0;
  font-size: 26px;
  font-weight: 800;
  letter-spacing: -0.5px;
  line-height: 1.3;
  color: #101828;
  word-break: break-word;
}

.desc {
  position: relative;
  margin: 12px 0 0;
  font-size: 14px;
  line-height: 1.75;
  color: #4a5768;
  word-break: break-word;
}

.url {
  position: relative;
  margin: 14px 0 0;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  font-size: 11.5px;
  color: #93a1b4;
  word-break: break-all;
}

.actions {
  position: relative;
  display: flex;
  gap: 10px;
  margin-top: 22px;
  flex-wrap: wrap;
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 38px;
  padding: 0 16px;
  border-radius: 10px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 13px;
  font-weight: 600;
  transition: all 0.15s ease;
}

.btn:hover {
  border-color: #b9cdee;
  color: var(--brand);
  background: #f7fbff;
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

.foot {
  position: relative;
  display: flex;
  align-items: center;
  gap: 6px;
  margin-top: 24px;
  padding-top: 14px;
  border-top: 1px dashed var(--line);
  font-size: 11px;
  color: #b0bccb;
}

.dot-sep {
  color: #d8e2ee;
}

.empty-card {
  text-align: center;
  padding: 56px 24px;
  font-size: 13.5px;
  color: #8b9aad;
}

.link {
  display: inline-block;
  margin-top: 12px;
  color: var(--brand);
  font-size: 13px;
}

.err {
  text-align: center;
  padding: 40px;
  color: #b42318;
  font-size: 13px;
}

@media (max-width: 720px) {
  .wrap {
    padding: 24px 14px 40px;
  }
  .card {
    padding: 22px 18px 20px;
  }
  .title {
    font-size: 21px;
  }
}
</style>
