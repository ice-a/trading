<script setup lang="ts">
/**
 * 全局页脚：作者 GitHub 与项目仓库。
 *
 * 所有页面共用（挂在 app.vue），样式刻意做得很轻——一行小字 + 头像，
 * 不抢内容区注意力，也不和首页自己的技术说明页脚冲突。
 */
const AUTHOR = 'ice-a'
const REPO = 'ice-a/trading'
const REPO_URL = `https://github.com/${REPO}`
const AUTHOR_URL = `https://github.com/${AUTHOR}`

const avatarOk = ref(true)
</script>

<template>
  <footer class="site-footer">
    <div class="inner">
      <a class="author" :href="AUTHOR_URL" target="_blank" rel="noopener noreferrer" :title="`GitHub @${AUTHOR}`">
        <img
          v-if="avatarOk"
          class="avatar"
          :src="`https://github.com/${AUTHOR}.png?size=48`"
          :alt="AUTHOR"
          loading="lazy"
          referrerpolicy="no-referrer"
          @error="avatarOk = false"
        />
        <span v-else class="avatar fallback">{{ AUTHOR.slice(0, 1).toUpperCase() }}</span>
        <span class="name">@{{ AUTHOR }}</span>
      </a>

      <span class="sep">·</span>

      <a class="repo" :href="REPO_URL" target="_blank" rel="noopener noreferrer">
        <svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true">
          <path
            fill="currentColor"
            d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z"
          />
        </svg>
        {{ REPO }}
      </a>

      <span class="sep">·</span>
      <span class="meta">开源项目</span>
    </div>
  </footer>
</template>

<style scoped>
.site-footer {
  margin-top: 8px;
  padding: 18px 20px 26px;
}

.inner {
  max-width: 1240px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  flex-wrap: wrap;
  font-size: 11.5px;
  color: #a4b0bf;
}

.author {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: #7b8999;
  transition: color 0.15s ease;
}

.author:hover {
  color: var(--brand);
}

.avatar {
  width: 18px;
  height: 18px;
  border-radius: 50%;
  object-fit: cover;
  background: #f1f5fa;
  border: 1px solid var(--line);
}

.avatar.fallback {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-weight: 700;
  color: #7b8999;
}

.name {
  font-weight: 600;
}

.repo {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  color: #7b8999;
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  font-size: 11px;
  transition: color 0.15s ease;
}

.repo:hover {
  color: var(--brand);
}

.sep {
  color: #d8e2ee;
}

.meta {
  color: #b0bccb;
}

@media (max-width: 720px) {
  .site-footer {
    padding: 14px 14px 22px;
  }
  .inner {
    font-size: 11px;
    gap: 6px;
  }
}
</style>
