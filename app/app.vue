<template>
  <div class="app-shell">
    <AppHeader />
    <NuxtPage />
  </div>
</template>

<style>
.app-shell {
  min-height: 100vh;
  padding-left: var(--rail-left);
}

@media (max-width: 900px) {
  .app-shell {
    padding-left: 0;
  }
}
</style>
