<script setup lang="ts">
/**
 * 日 / 周 / 月 榜单切换（首页与历史页共用）
 */
const props = defineProps<{ modelValue: 'daily' | 'weekly' | 'monthly' }>()
const emit = defineEmits<{ (e: 'update:modelValue', v: 'daily' | 'weekly' | 'monthly'): void }>()

const OPTIONS = [
  { key: 'daily' as const, label: '日榜' },
  { key: 'weekly' as const, label: '周榜' },
  { key: 'monthly' as const, label: '月榜' }
]

function pick(key: 'daily' | 'weekly' | 'monthly') {
  if (props.modelValue === key) return
  emit('update:modelValue', key)
}
</script>

<template>
  <div class="seg">
    <button
      v-for="o in OPTIONS"
      :key="o.key"
      class="seg-btn"
      :class="{ on: modelValue === o.key }"
      @click="pick(o.key)"
    >
      {{ o.label }}
    </button>
  </div>
</template>

<style scoped>
.seg {
  display: inline-flex;
  padding: 2px;
  border-radius: 9px;
  background: #eef2f8;
  border: 1px solid var(--line);
}

.seg-btn {
  padding: 4px 11px;
  border: 0;
  border-radius: 7px;
  background: transparent;
  color: #6b7a90;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.15s ease;
  white-space: nowrap;
}

.seg-btn:hover {
  color: var(--brand);
}

.seg-btn.on {
  background: #fff;
  color: var(--brand);
  box-shadow: 0 1px 4px rgba(16, 32, 56, 0.12);
}
</style>
