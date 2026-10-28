<script setup lang="ts">
/**
 * 卡片上的分享按钮：点一下创建分享记录，并把链接复制到剪贴板。
 */
const props = defineProps<{
  type: 'nav' | 'ai' | 'repo' | 'dns' | 'custom'
  title: string
  desc?: string
  url?: string
  badge?: string
  meta?: Record<string, unknown>
}>()

const loading = ref(false)
const done = ref(false)
const copied = ref(false)

async function onShare(e: MouseEvent) {
  e.preventDefault()
  e.stopPropagation()
  if (loading.value) return

  loading.value = true
  try {
    const res = await $fetch<{ path: string }>(apiUrl('/api/share'), {
      method: 'POST',
      body: {
        type: props.type,
        title: props.title,
        desc: props.desc || '',
        url: props.url || '',
        badge: props.badge || '',
        meta: props.meta || {}
      }
    })

    const full = `${window.location.origin}${res.path}`
    try {
      await navigator.clipboard.writeText(full)
      copied.value = true
    } catch {
      copied.value = false
    }
    done.value = true
    setTimeout(() => {
      done.value = false
      copied.value = false
    }, 2000)
  } catch {
    /* 静默失败，不打扰浏览 */
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <button
    class="share-btn"
    :class="{ done }"
    :title="done ? (copied ? '链接已复制' : '已生成分享') : '分享这张卡片'"
    @click="onShare"
  >
    <svg v-if="!done" viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
      <path
        fill="currentColor"
        d="M8 1.5a.75.75 0 0 1 .53.22l2.5 2.5a.75.75 0 0 1-1.06 1.06L8.75 4.06V10a.75.75 0 0 1-1.5 0V4.06L6.03 5.28a.75.75 0 0 1-1.06-1.06l2.5-2.5A.75.75 0 0 1 8 1.5ZM3.75 9.5a.75.75 0 0 1 .75.75v2.5c0 .138.112.25.25.25h6.5a.25.25 0 0 0 .25-.25v-2.5a.75.75 0 0 1 1.5 0v2.5A1.75 1.75 0 0 1 11.25 14h-6.5A1.75 1.75 0 0 1 3 12.25v-2.5a.75.75 0 0 1 .75-.75Z"
      />
    </svg>
    <svg v-else viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
      <path fill="currentColor" d="M13.78 4.22a.75.75 0 0 1 0 1.06l-6.5 6.5a.75.75 0 0 1-1.06 0L2.72 8.28a.75.75 0 1 1 1.06-1.06L7.25 10.7l5.47-5.47a.75.75 0 0 1 1.06 0Z" />
    </svg>
  </button>
  <Teleport to="body">
    <div v-if="done" class="share-toast" :class="{ warn: !copied }">
      <svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
        <path fill="currentColor" d="M13.78 4.22a.75.75 0 0 1 0 1.06l-6.5 6.5a.75.75 0 0 1-1.06 0L2.72 8.28a.75.75 0 1 1 1.06-1.06L7.25 10.7l5.47-5.47a.75.75 0 0 1 1.06 0Z" />
      </svg>
      {{ copied ? '分享成功，链接已复制' : '分享成功，可在「分享」页查看' }}
    </div>
  </Teleport>
</template>

<style scoped>
.share-toast {
  position: fixed;
  right: 28px;
  bottom: 28px;
  z-index: 9999;
  display: inline-flex;
  align-items: center;
  gap: 7px;
  padding: 11px 18px;
  border-radius: 12px;
  background: #0f8a44;
  color: #fff;
  font-size: 13px;
  font-weight: 650;
  box-shadow: 0 10px 30px rgba(15, 138, 68, 0.32);
  animation: toast-in 0.22s cubic-bezier(0.2, 0.9, 0.3, 1.2);
}

.share-toast.warn {
  background: #1f6feb;
  box-shadow: 0 10px 30px rgba(31, 111, 235, 0.32);
}

@keyframes toast-in {
  from {
    opacity: 0;
    transform: translateY(10px) scale(0.96);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}
.share-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  padding: 0;
  border-radius: 6px;
  border: 1px solid transparent;
  background: transparent;
  color: #c3cfdf;
  cursor: pointer;
  transition: all 0.15s ease;
  flex: none;
}

.share-btn:hover {
  border-color: #cfe0fb;
  background: #f7fbff;
  color: var(--brand);
}

.share-btn.done {
  border-color: #b7e4c7;
  background: #eafaf1;
  color: #0f8a44;
}
</style>
