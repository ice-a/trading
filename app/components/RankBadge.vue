<script setup lang="ts">
/**
 * 排名徽章。
 * 前 3 名用金银铜渐变方块（第 1 名配皇冠），其余为普通数字。
 */
const props = defineProps<{
  rank: number | null
  dropped?: boolean
}>()

const medal = computed(() => {
  if (props.rank === 1) return 'gold'
  if (props.rank === 2) return 'silver'
  if (props.rank === 3) return 'bronze'
  return ''
})
</script>

<template>
  <div class="rank" :class="[medal, { dropped }]">
    <template v-if="dropped || rank == null">
      <svg class="drop-icon" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true">
        <path
          fill="currentColor"
          d="M3.47 2.47a.75.75 0 0 0-1.06 1.06L6.94 8l-4.53 4.47a.75.75 0 1 0 1.06 1.06L8 9.06l4.47 4.47a.75.75 0 0 0 1.06-1.06L9.06 8l4.47-4.47a.75.75 0 1 0-1.06-1.06L8 6.94 3.47 2.47Z"
        />
      </svg>
    </template>
    <template v-else-if="rank === 1">
      <svg class="crown" viewBox="0 0 24 24" width="24" height="24" aria-hidden="true">
        <path
          fill="currentColor"
          d="M3 8.5 6.6 11 12 5.2 17.4 11 21 8.5l-1.6 9.9a1 1 0 0 1-1 .8H5.6a1 1 0 0 1-1-.8L3 8.5Z"
        />
        <circle cx="4" cy="6" r="1.7" fill="currentColor" />
        <circle cx="20" cy="6" r="1.7" fill="currentColor" />
        <circle cx="12" cy="4" r="1.9" fill="currentColor" />
      </svg>
      <span class="num">1</span>
    </template>
    <template v-else>
      <span class="num">{{ rank }}</span>
    </template>
  </div>
</template>

<style scoped>
.rank {
  width: 38px;
  height: 34px;
  margin: 0 auto;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 1px;
  border-radius: 10px;
  font-size: 15px;
  font-weight: 700;
  color: #8a97a8;
  font-variant-numeric: tabular-nums;
  position: relative;
}

.rank.gold,
.rank.silver,
.rank.bronze {
  color: #fff;
  box-shadow: 0 4px 12px rgba(16, 32, 56, 0.18), inset 0 1px 0 rgba(255, 255, 255, 0.55);
}

.rank.gold {
  background: var(--gold);
  height: 42px;
  width: 42px;
  padding: 0;
}

.rank.gold .crown {
  width: 23px;
  height: 23px;
  filter: drop-shadow(0 1px 2px rgba(146, 64, 14, 0.55));
  color: #fffdf3;
}

.rank.gold .num {
  position: absolute;
  right: -4px;
  bottom: -4px;
  width: 16px;
  height: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: #fff;
  color: #b45309;
  font-size: 10px;
  font-weight: 800;
  line-height: 1;
  box-shadow: 0 1px 3px rgba(120, 53, 15, 0.35);
}

.rank.silver {
  background: var(--silver);
  color: #4a5a70;
}

.rank.bronze {
  background: var(--bronze);
}

.rank.dropped {
  color: #b7c2d1;
}

.drop-icon {
  opacity: 0.85;
}

.num {
  line-height: 1;
}
</style>
