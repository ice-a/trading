<script setup lang="ts">
/**
 * 全局顶部导航。所有页面共享，替代原先各页面自己放的跳转按钮。
 * 布局：左侧「观澜志」艺术字（文字固定，颜色随随机定时切换）+ 右侧页签；
 * 容器宽度与 PageShell / 一言栏对齐（1240px）。
 */
const route = useRoute()

const items = [
  { to: '/', label: 'GitHub 日榜', icon: '📈' },
  { to: '/github', label: 'GitHub', icon: '🐙' },
  { to: '/avatar', label: '个性头像', icon: '🎨' },
  { to: '/history', label: '历史', icon: '🗓️' }
]

const isActive = (to: string) => {
  if (to === '/') return route.path === '/'
  return route.path === to || route.path.startsWith(`${to}/`)
}

/** 艺术字色相角度：SSR 固定 0deg，挂载后在客户端随机跳变（避免水合不一致） */
const brandHue = ref(0)
const brandStyle = computed(() => ({
  filter: `drop-shadow(0 1px 2px rgba(31, 111, 235, 0.16)) hue-rotate(${brandHue.value}deg)`
}))

let tintTimer: ReturnType<typeof setTimeout> | null = null

onMounted(() => {
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return
  // 1.5~3 秒随机间隔切换一次色相，切换本身由 CSS transition 平滑过渡
  const schedule = () => {
    tintTimer = setTimeout(() => {
      brandHue.value = Math.floor(Math.random() * 360)
      schedule()
    }, 1500 + Math.random() * 1500)
  }
  schedule()
})

onBeforeUnmount(() => {
  if (tintTimer) {
    clearTimeout(tintTimer)
    tintTimer = null
  }
})
</script>

<template>
  <header class="site-header">
    <div class="inner">
      <NuxtLink to="/" class="brand" title="观澜志 · GitHub 日榜简报" aria-label="观澜志">
        <span class="brand-icon" aria-hidden="true">🔭</span>
        <span class="brand-name" :style="brandStyle">观澜志</span>
      </NuxtLink>

      <!-- 一言：嵌在顶栏品牌与页签之间（全局常驻，切页不重建、计时不重置） -->
      <div class="header-hitokoto">
        <HitokotoBar compact />
      </div>

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
  max-width: 1240px;
  margin: 0 auto;
  padding: 8px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
}

/* 站点标识（左）：观澜志艺术字，文字固定不动 */
.brand {
  flex: none;
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.brand-icon {
  flex: none;
  font-size: 15px;
  line-height: 1;
}

/* 中段：一言（紧凑），撑满品牌与页签之间的空档 */
.header-hitokoto {
  flex: 1;
  min-width: 0;
  display: flex;
  align-self: stretch;
  align-items: center;
  padding: 0 4px;
}

/* 艺术字：毛笔楷书 + 四色渐变；色相由脚本随机赋值，transition 平滑切换 */
.brand-name {
  font-family: 'GuanlanBrush', 'Kaiti SC', KaiTi, STKaiti, serif;
  font-size: 27px;
  font-weight: 400;
  letter-spacing: 3px;
  line-height: 1.15;
  background: linear-gradient(100deg, #1f6feb 0%, #7c3aed 35%, #db2777 68%, #f59e0b 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  color: transparent;
  transition: filter 0.6s ease;
}

@media (prefers-reduced-motion: reduce) {
  .brand-name {
    transition: none;
  }
}

.tabs {
  display: flex;
  align-items: center;
  gap: 4px;
  overflow-x: auto;
  scrollbar-width: none;
  margin-left: auto;
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
  .header-hitokoto {
    display: none;
  }
  .brand-name {
    font-size: 22px;
    letter-spacing: 2px;
  }
  .tab {
    padding: 6px 9px;
    font-size: 12px;
  }
}
</style>
