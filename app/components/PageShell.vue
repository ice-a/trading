<script setup lang="ts">
/**
 * 页面外壳：五个页面共用同一套骨架，保证切页时各区块位置完全不动。
 *
 * 固定三段（自上而下）：
 *   ┌ 标题区（hero）—— 图标 + 标题 + 副标题 + 右侧插槽
 *   └ 内容区（panel）—— 工具栏（slot=actions）+ 主体（default）+ 页脚（slot=foot）
 *
 * 一言栏不在这个壳里：它挂在 app.vue，才能做到切页不重建、计时器不重置。
 */
interface Props {
  /** 主标题 */
  title: string
  /** 标题左侧图标（emoji 或单个字符） */
  icon?: string
  /** 副标题一行 */
  subtitle?: string
  /** 标题前的日期/前缀，如 2026-11-03 */
  eyebrow?: string
}

const props = defineProps<Props>()
</script>

<template>
  <div class="shell">
    <!-- ── 标题区 ── -->
    <header class="hero">
      <div class="hero-main">
        <span v-if="props.icon" class="hero-icon" aria-hidden="true">{{ props.icon }}</span>
        <div class="hero-text">
          <h1>
            <span v-if="props.eyebrow" class="hero-eyebrow">{{ props.eyebrow }}</span>
            <span class="hero-title">{{ props.title }}</span>
          </h1>
          <p v-if="props.subtitle" class="hero-sub">{{ props.subtitle }}</p>
          <slot name="meta" />
        </div>
      </div>

      <div class="hero-side">
        <slot name="side" />
      </div>
    </header>

    <!-- ── 内容区 ── -->
    <div class="panel">
      <div v-if="$slots.actions" class="panel-actions">
        <slot name="actions" />
      </div>
      <div class="panel-body">
        <slot />
      </div>
      <div v-if="$slots.foot" class="panel-foot">
        <slot name="foot" />
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 全站统一宽度：五个页面用同一个 max-width，切页时左右边界不跳动 */
.shell {
  max-width: 1240px;
  margin: 0 auto;
  padding: 14px 20px 40px;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

/* ---------- 标题区 ---------- */
.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  padding: 16px 20px;
  border: 1px solid var(--line);
  border-radius: 14px;
  background: #fff;
  box-shadow: 0 1px 2px rgba(16, 24, 40, 0.04);
}

.hero-main {
  display: flex;
  align-items: center;
  gap: 14px;
  min-width: 0;
}

.hero-icon {
  flex: none;
  width: 44px;
  height: 44px;
  display: grid;
  place-items: center;
  font-size: 22px;
  line-height: 1;
  border-radius: 12px;
  background: #f4f8ff;
  border: 1px solid #e3edfa;
}

.hero-text {
  min-width: 0;
}

.hero-text h1 {
  margin: 0;
  display: flex;
  align-items: baseline;
  flex-wrap: wrap;
  gap: 8px;
  font-size: 24px;
  font-weight: 800;
  letter-spacing: -0.4px;
  color: #101828;
}

.hero-eyebrow {
  font-size: 20px;
  font-weight: 800;
  color: #1f6feb;
}

.hero-title {
  font-size: 20px;
  font-weight: 700;
  color: #101828;
}

.hero-sub {
  margin: 4px 0 0;
  font-size: 12.5px;
  color: #667085;
  line-height: 1.5;
}

.hero-side {
  flex: none;
  display: flex;
  align-items: center;
  gap: 8px;
}

/* ---------- 内容区 ---------- */
.panel {
  border: 1px solid var(--line);
  border-radius: 14px;
  background: #fff;
  box-shadow: 0 1px 2px rgba(16, 24, 40, 0.04);
  overflow: hidden;
}

.panel-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  flex-wrap: wrap;
  padding: 10px 16px;
  border-bottom: 1px solid var(--line);
  background: #fcfdff;
}

.panel-body {
  padding: 0;
}

.panel-foot {
  padding: 10px 16px;
  border-top: 1px solid var(--line);
  font-size: 12px;
  color: #667085;
  background: #fcfdff;
}

@media (max-width: 720px) {
  .shell {
    padding: 10px 12px 28px;
    gap: 10px;
  }

  .hero {
    padding: 12px 14px;
    gap: 10px;
  }

  .hero-text h1 {
    font-size: 19px;
  }

  .hero-eyebrow,
  .hero-title {
    font-size: 16px;
  }

  .hero-icon {
    width: 36px;
    height: 36px;
    font-size: 18px;
  }

  .hero-side {
    display: none;
  }
}
</style>