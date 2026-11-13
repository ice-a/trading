<script setup lang="ts">
/**
 * 应用外壳。
 *
 * 一言栏（HitokotoBar）已移入 AppHeader 的顶栏中段（品牌与页签之间）：
 * 同样挂在 app.vue 这一层的组件树里（AppHeader 全局常驻），
 * 切页时组件不重建，60 秒计时器与进度条不会被重置。
 */
</script>

<template>
  <div class="app-shell">
    <AppHeader />

    <div class="app-body">
      <NuxtPage />
    </div>

    <AppFooter />
  </div>
</template>

<style>
.app-shell {
  min-height: 100vh;
  padding-left: var(--rail-left);
  display: flex;
  flex-direction: column;
}

/* 内容区吃掉剩余高度，页脚自然沉底 */
.app-body {
  flex: 1 0 auto;
}

@media (max-width: 900px) {
  .app-shell {
    padding-left: 0;
  }
}
</style>