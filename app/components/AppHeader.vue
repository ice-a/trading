<script setup lang="ts">
/**
 * 全局顶部导航。所有页面共享，替代原先各页面自己放的跳转按钮。
 */
const route = useRoute()

const items = [
  { to: '/', label: 'GitHub 日榜', icon: '📈' },
  { to: '/v2', label: '热门榜单', icon: '🔥' },
  { to: '/nav', label: '网站导航', icon: '🧭' },
  { to: '/ai', label: 'AI 资源台', icon: '🤖' },
  { to: '/github', label: 'GitHub', icon: '🐙' },
  { to: '/avatar', label: '个性头像', icon: '🎨' },
  { to: '/dns', label: 'Cloudflare DNS', icon: '🌐' },
  { to: '/share', label: '分享', icon: '🔗' },
  { to: '/history', label: '历史', icon: '🗓️' },
  { to: '/admin', label: '后台', icon: '⚙️' }
]

const isActive = (to: string) => {
  if (to === '/') return route.path === '/'
  return route.path === to || route.path.startsWith(`${to}/`)
}
</script>

<template>
  <header class="site-header">
    <div class="inner">
      <NuxtLink to="/" class="brand">
        <span class="brand-dot" />
        <span class="brand-text">瞭望台</span>
      </NuxtLink>

      <NuxtLink to="/" class="home-btn" :class="{ on: route.path === '/' }" title="返回首页">
        <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
          <path
            fill="currentColor"
            d="M8 1.5 1.75 6.75V14a.75.75 0 0 0 .75.75h3.5v-3.5h4v3.5h3.5A.75.75 0 0 0 14.25 14V6.75L8 1.5Z"
          />
        </svg>
        <span class="home-label">首页</span>
      </NuxtLink>

      <nav class="tabs">
        <NuxtLink
          v-for="it in items"
          :key="it.to"
          :to="it.to"
          class="tab"
          :class="{ active: isActive(it.to) }"
        >
          <span class="tab-icon">{{ it.icon }}</span>
          <span class="tab-label">{{ it.label }}</span>
        </NuxtLink>
      </nav>
    </div>
  </header>
</template>

<style scoped>
.site-header {
  position: sticky;
  top: 0;
  z-index: 50;
  background: rgba(255, 255, 255, 0.88);
  backdrop-filter: saturate(180%) blur(12px);
  border-bottom: 1px solid var(--line);
}

.inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 8px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.brand {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  flex: none;
  font-size: 14px;
  font-weight: 800;
  letter-spacing: -0.2px;
  color: #101828;
}

.brand-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: linear-gradient(135deg, #1f6feb, #4f46e5);
  box-shadow: 0 0 0 3px rgba(31, 111, 235, 0.12);
}

.home-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  flex: none;
  height: 26px;
  padding: 0 9px;
  border-radius: 8px;
  border: 1px solid var(--line);
  background: #fff;
  color: #56657a;
  font-size: 12px;
  font-weight: 550;
  transition: all 0.15s ease;
}

.home-btn:hover {
  border-color: #cfe0fb;
  color: var(--brand);
  background: #f7fbff;
}

.home-btn.on {
  border-color: transparent;
  background: #eef4ff;
  color: var(--brand);
}

.tabs {
  display: flex;
  align-items: center;
  gap: 4px;
  overflow-x: auto;
  scrollbar-width: none;
  flex: 1;
  min-width: 0;
}

.tabs::-webkit-scrollbar {
  display: none;
}

.tab {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 6px 11px;
  border-radius: 9px;
  font-size: 12.5px;
  font-weight: 550;
  color: #56657a;
  white-space: nowrap;
  transition: all 0.15s ease;
}

.tab:hover {
  background: #f1f6fd;
  color: var(--brand);
}

.tab.active {
  background: var(--brand);
  color: #fff;
  box-shadow: 0 3px 10px rgba(31, 111, 235, 0.28);
}

.tab-icon {
  font-size: 12px;
  line-height: 1;
}

@media (max-width: 720px) {
  .inner {
    padding: 8px 14px;
    gap: 10px;
  }
  .brand-text {
    display: none;
  }
  .home-label {
    display: none;
  }
  .tab {
    padding: 6px 9px;
    font-size: 12px;
  }
}
</style>
