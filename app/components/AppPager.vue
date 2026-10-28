<script setup lang="ts">
/** 分页器：每页 10 条，翻页才去读 Mongo 里掉出前 10 的历史记录 */
const props = defineProps<{
  page: number
  totalPages: number
  total: number
  pageSize: number
  loading?: boolean
}>()

const emit = defineEmits<{ (e: 'change', page: number): void }>()

const pages = computed(() => {
  const all = props.totalPages
  const cur = props.page
  if (all <= 7) return Array.from({ length: all }, (_, i) => i + 1)

  const set = new Set<number>([1, all, cur, cur - 1, cur + 1])
  const list = [...set].filter((p) => p >= 1 && p <= all).sort((a, b) => a - b)

  const out: Array<number | 'gap'> = []
  let prev = 0
  for (const p of list) {
    if (prev && p - prev > 1) out.push('gap')
    out.push(p)
    prev = p
  }
  return out
})

const from = computed(() => (props.total === 0 ? 0 : (props.page - 1) * props.pageSize + 1))
const to = computed(() => Math.min(props.page * props.pageSize, props.total))

function go(p: number) {
  if (props.loading) return
  if (p < 1 || p > props.totalPages || p === props.page) return
  emit('change', p)
}
</script>

<template>
  <div class="pager">
    <div class="info">
      第 <b>{{ from }}</b>–<b>{{ to }}</b> 条 · 共 <b>{{ total }}</b> 条 · 每页 {{ pageSize }} 条
    </div>

    <div class="controls">
      <button class="btn" :disabled="page <= 1 || loading" @click="go(page - 1)">
        <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
          <path fill="currentColor" d="M9.78 12.78a.75.75 0 0 1-1.06 0L4.47 8.53a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 1.06L6.06 8l3.72 3.72a.75.75 0 0 1 0 1.06Z" />
        </svg>
        上一页
      </button>

      <div class="nums">
        <template v-for="(p, i) in pages" :key="`${p}-${i}`">
          <span v-if="p === 'gap'" class="gap">…</span>
          <button
            v-else
            class="num"
            :class="{ active: p === page }"
            :disabled="loading"
            @click="go(p as number)"
          >
            {{ p }}
          </button>
        </template>
      </div>

      <button class="btn" :disabled="page >= totalPages || loading" @click="go(page + 1)">
        下一页
        <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true">
          <path fill="currentColor" d="M6.22 3.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 0 1 0-1.06Z" />
        </svg>
      </button>
    </div>
  </div>
</template>

<style scoped>
.pager {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-top: 16px;
  padding: 10px 14px;
  background: var(--card);
  border: 1px solid var(--line);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
}

.info {
  font-size: 12.5px;
  color: var(--muted);
}

.info b {
  color: #33425a;
  font-weight: 650;
}

.controls {
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  height: 32px;
  padding: 0 12px;
  border-radius: 9px;
  border: 1px solid var(--line-strong);
  background: #fff;
  color: #3d4c60;
  font-size: 12.5px;
  font-weight: 550;
  transition: all 0.15s ease;
}

.btn:hover:not(:disabled) {
  border-color: #b9cdee;
  background: #f6faff;
  color: var(--brand);
}

.btn:disabled {
  opacity: 0.45;
  cursor: not-allowed;
}

.nums {
  display: flex;
  align-items: center;
  gap: 4px;
}

.num {
  min-width: 30px;
  height: 30px;
  padding: 0 7px;
  border-radius: 8px;
  border: 1px solid transparent;
  background: transparent;
  color: #55657a;
  font-size: 12.5px;
  font-weight: 550;
  font-variant-numeric: tabular-nums;
  transition: all 0.15s ease;
}

.num:hover:not(:disabled):not(.active) {
  background: #f1f6fd;
  color: var(--brand);
}

.num.active {
  background: var(--brand);
  border-color: var(--brand);
  color: #fff;
  box-shadow: 0 2px 8px rgba(31, 111, 235, 0.32);
}

.gap {
  color: #aebbcb;
  padding: 0 2px;
  user-select: none;
}

@media (max-width: 720px) {
  .pager {
    flex-direction: column;
    align-items: stretch;
    gap: 10px;
  }
  .info {
    text-align: center;
    order: 2;
  }
  .controls {
    justify-content: center;
    flex-wrap: wrap;
  }
  .nums {
    order: 3;
  }
}
</style>
