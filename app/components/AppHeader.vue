<script setup lang="ts">
/**
 * 全局顶部导航。所有页面共享，替代原先各页面自己放的跳转按钮。
 */
const route = useRoute()

const items = [
  { to: '/', label: 'GitHub 日榜', icon: '📈' },
  { to: '/github', label: 'GitHub', icon: '🐙' },
  { to: '/avatar', label: '个性头像', icon: '🎨' },
  { to: '/stack', label: '行情', icon: '📊' },
  { to: '/history', label: '历史', icon: '🗓️' }
]

const isActive = (to: string) => {
  if (to === '/') return route.path === '/'
  return route.path === to || route.path.startsWith(`${to}/`)
}
</script>

<template>
  <header class="site-header">
    <div class="inner">
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
  .tab {
    padding: 6px 9px;
    font-size: 12px;
  }
}
</style>
