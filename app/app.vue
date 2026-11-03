<script setup lang="ts">
/**
 * 应用外壳。
 *
 * 一言栏（HitokotoBar）挂在这一层，而不是挂在 PageShell 里：
 *   · 挂在页面 → 每次切页都会重建组件，60 秒计时器被重置，进度条从头开始
 *   · 挂在 app.vue → 整个会话只创建一次，切页时同一句话继续读秒，到点才换
 */
</script>

<template>
  <div class="app-shell">
    <AppHeader />

    <div class="app-body">
      <!-- 一言：全局常驻，切页不重建、不重置计时 -->
      <div class="app-hitokoto">
        <HitokotoBar />
      </div>

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

/* 与 PageShell 的容器宽度严格对齐，保证一言和内容左右边界完全一致 */
.app-hitokoto {
  max-width: 1240px;
  margin: 22px auto 0;
  padding: 0 20px;
}

@media (max-width: 900px) {
  .app-shell {
    padding-left: 0;
  }
}

@media (max-width: 720px) {
  .app-hitokoto {
    margin-top: 14px;
    padding: 0 12px;
  }
}
</style>