<template>
  <div class="app-shell">
    <AppHeader />
    <NuxtPage />
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
.app-shell > :nth-child(2) {
  flex: 1 0 auto;
}

@media (max-width: 900px) {
  .app-shell {
    padding-left: 0;
  }
}
</style>
