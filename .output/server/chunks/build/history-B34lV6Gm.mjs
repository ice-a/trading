import { _ as _plugin_vue_export_helper_default, a as useRoute, b as useRouter, u as useHead, N as NuxtLink, s as ssrRenderList$2, $ as $fetch$1 } from '../virtual/entry.mjs';
import { u as useCachedData } from './useCachedData-ChW-i0Ev.mjs';
import { P as PeriodSwitch_default, p as plainNumber, T as TrendingTable_default, A as AppPager_default } from './AppPager-CnTT1gk3.mjs';
import { defineComponent, withAsyncContext, computed, ref, mergeProps, isRef, unref, withCtx, createTextVNode, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrRenderComponent, ssrInterpolate, ssrRenderStyle, ssrRenderClass } from 'vue/server-renderer';
import 'nostics';
import 'nostics/formatters/ansi';
import 'unhead/utils';
import '../_/nitro.mjs';
import 'unhead/server';
import 'unhead/legacy';
import 'unhead/plugins';
import 'node:http';
import 'node:https';
import 'node:events';
import 'node:buffer';
import 'node:fs';
import 'node:path';
import 'node:crypto';
import 'cheerio';
import 'node:url';
import '../routes/renderer.mjs';
import 'vue-bundle-renderer/runtime';
import 'devalue';
import 'vue-router';

// app/pages/history.vue?vue&type=script&setup=true&lang.ts
var history_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "history",
	__ssrInlineRender: true,
	async setup(__props) {
		let __temp, __restore;
		const route = useRoute();
		const router = useRouter();
		/**
		* 页面里不要无条件 top-level await：那会让组件变成 async 组件并被 Suspense 包裹，
		* 客户端导航时旧页面会一直留在 DOM 里（表现就是「URL 变了但页面不切换」）。
		* 只在 SSR 阶段 await（保证数据进 payload），客户端走响应式更新。
		*/
		const overviewData = useCachedData(() => "history:overview", () => $fetch$1("/api/history"), { ttl: 12e4 });
		[__temp, __restore] = withAsyncContext(() => overviewData), await __temp, __restore();
		const { data: overview, pending: loadingOverview } = overviewData;
		const days = computed(() => overview.value?.days ?? []);
		/** 默认选中：最近一个「非今天」的日期（进历史页先看历史更像历史页），没有就走最新 */
		const initialDate = (() => {
			const q = route.query.date;
			if (typeof q === "string" && q) return q;
			const list = days.value;
			return (list.find((d) => !d.isToday) ?? list[0])?.date ?? "";
		})();
		/** 榜单周期：日 / 周 / 月 */
		const periodRawH = typeof route.query.period === "string" ? route.query.period : "";
		const period = ref([
			"daily",
			"weekly",
			"monthly"
		].includes(periodRawH) ? periodRawH : "daily");
		const selected = ref(initialDate);
		/** 切换周期：保留已选日期，回到第一页；日期在新周期没有数据时回退到最近一天 */
		function changePeriod(p) {
			if (period.value === p) return;
			period.value = p;
			page.value = 1;
		}
		const page = ref(Math.max(1, Number(route.query.page) || 1));
		const detailData = useCachedData(() => `history:detail:${selected.value}:${page.value}`, () => $fetch$1("/api/trending", { query: {
			date: selected.value || void 0,
			page: page.value
		} }), { ttl: 6e4 });
		[__temp, __restore] = withAsyncContext(() => detailData), await __temp, __restore();
		const { data: detail, pending } = detailData;
		/**
		* URL 同步改成「仅用户主动切换时」触发。
		* 之前用 watch(selected, page) 无条件 router.replace，会在组件卸载/导航过程中改 URL，
		* 和正在进行的导航抢路由状态，导致离开本页时页面卡住不切换。
		*/
		function syncQuery() {
			const query = {};
			if (selected.value) query.date = selected.value;
			if (page.value > 1) query.page = String(page.value);
			if (period.value !== "daily") query.period = period.value;
			router.replace({ query });
		}
		const current = computed(() => days.value.find((d) => d.date === selected.value) ?? null);
		const items = computed(() => detail.value?.items ?? []);
		function changePage(p) {
			page.value = p;
			syncQuery();
		}
		useHead({ title: () => current.value ? `历史榜单 · ${current.value.date}` : "历史榜单" });
		return (_ctx, _push, _parent, _attrs) => {
			const _component_PeriodSwitch = PeriodSwitch_default;
			const _component_NuxtLink = NuxtLink;
			const _component_TrendingTable = TrendingTable_default;
			const _component_AppPager = AppPager_default;
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "page" }, _attrs))} data-v-f215893c><header class="hero" data-v-f215893c>`);
			_push(ssrRenderComponent(_component_PeriodSwitch, {
				modelValue: unref(period),
				"onUpdate:modelValue": [($event) => isRef(period) ? period.value = $event : null, changePeriod]
			}, null, _parent));
			_push(`<div class="hero-left" data-v-f215893c><div class="titles" data-v-f215893c><h1 data-v-f215893c>历史榜单</h1><p data-v-f215893c> 共 <b data-v-f215893c>${ssrInterpolate(unref(overview)?.totalDays ?? 0)}</b> 天 · <b data-v-f215893c>${ssrInterpolate(unref(overview)?.totalRepos ?? 0)}</b> 条仓库记录 <span class="hint" data-v-f215893c>· 掉出前 10 的记录也按日期留在这里</span></p></div></div></header>`);
			if (!unref(loadingOverview) && !unref(days).length) {
				_push(`<div class="empty-card" data-v-f215893c><div class="empty-icon" data-v-f215893c>🗂️</div><p class="empty-title" data-v-f215893c>还没有历史数据</p><p class="empty-sub" data-v-f215893c>抓取任务每天落一份数据，第二天起这里就会出现记录</p>`);
				_push(ssrRenderComponent(_component_NuxtLink, {
					to: "/",
					class: "pill-btn"
				}, {
					default: withCtx((_, _push, _parent, _scopeId) => {
						if (_push) _push(`回到今日`);
						else return [createTextVNode("回到今日")];
					}),
					_: 1
				}, _parent));
				_push(`</div>`);
			} else {
				_push(`<div class="layout" data-v-f215893c><aside class="sidebar" data-v-f215893c><div class="sidebar-head" data-v-f215893c>日期</div><div class="day-list" data-v-f215893c>`);
				if (unref(loadingOverview) && !unref(days).length) {
					_push(`<!--[-->`);
					ssrRenderList$2(6, (i) => {
						_push(`<div class="day-item skeleton-item" data-v-f215893c><div class="skeleton" style="${ssrRenderStyle({
							"width": "62%",
							"height": "12px"
						})}" data-v-f215893c></div><div class="skeleton" style="${ssrRenderStyle({
							"width": "40%",
							"height": "10px",
							"margin-top": "8px"
						})}" data-v-f215893c></div></div>`);
					});
					_push(`<!--]-->`);
				} else _push(`<!---->`);
				_push(`<!--[-->`);
				ssrRenderList$2(unref(days), (d) => {
					_push(`<button class="${ssrRenderClass([{
						active: d.date === unref(selected),
						"is-today": d.isToday
					}, "day-item"])}" data-v-f215893c><div class="day-top" data-v-f215893c><span class="day-date" data-v-f215893c>${ssrInterpolate(d.date)}</span>`);
					if (d.isToday) _push(`<span class="tag-today" data-v-f215893c>今日</span>`);
					else _push(`<!---->`);
					_push(`</div><div class="day-meta" data-v-f215893c><span data-v-f215893c>${ssrInterpolate(d.count)} 条</span><span class="dot-sep" data-v-f215893c>·</span><span class="growth" data-v-f215893c>+${ssrInterpolate(("plainNumber" in _ctx ? _ctx.plainNumber : unref(plainNumber))(d.totalTodayStars))}</span>`);
					if (d.droppedCount > 0) _push(`<span class="dot-sep" data-v-f215893c>·</span>`);
					else _push(`<!---->`);
					if (d.droppedCount > 0) _push(`<span class="dropped" data-v-f215893c>掉榜 ${ssrInterpolate(d.droppedCount)}</span>`);
					else _push(`<!---->`);
					_push(`</div>`);
					if (d.topRepo) _push(`<div class="day-top-repo" data-v-f215893c><svg viewBox="0 0 24 24" width="11" height="11" aria-hidden="true" data-v-f215893c><path fill="currentColor" d="M3 8.5 6.6 11 12 5.2 17.4 11 21 8.5l-1.6 9.9a1 1 0 0 1-1 .8H5.6a1 1 0 0 1-1-.8L3 8.5Z" data-v-f215893c></path></svg><span class="ellipsis" data-v-f215893c>${ssrInterpolate(d.topRepo)}</span></div>`);
					else _push(`<!---->`);
					_push(`</button>`);
				});
				_push(`<!--]--></div></aside><section class="main" data-v-f215893c><div class="detail-head" data-v-f215893c><div class="detail-titles" data-v-f215893c><h2 data-v-f215893c>${ssrInterpolate(unref(current)?.label || unref(detail)?.humanDate || "—")}</h2><p data-v-f215893c><b data-v-f215893c>${ssrInterpolate(unref(detail)?.total ?? 0)}</b> 条记录 · 今日增长合计 <b data-v-f215893c>${ssrInterpolate(("plainNumber" in _ctx ? _ctx.plainNumber : unref(plainNumber))(unref(current)?.totalTodayStars ?? unref(detail)?.stats.totalTodayStars ?? 0))}</b>`);
				if (unref(current)?.droppedCount) _push(`<span class="dropped" data-v-f215893c> · 掉榜保留 ${ssrInterpolate(unref(current).droppedCount)}</span>`);
				else _push(`<!---->`);
				_push(`</p></div>`);
				if (unref(current) && !unref(current).isToday) _push(ssrRenderComponent(_component_NuxtLink, {
					to: "/",
					class: "pill-btn"
				}, {
					default: withCtx((_, _push, _parent, _scopeId) => {
						if (_push) _push(` 回到今日 `);
						else return [createTextVNode(" 回到今日 ")];
					}),
					_: 1
				}, _parent));
				else _push(`<!---->`);
				_push(`</div>`);
				_push(ssrRenderComponent(_component_TrendingTable, {
					items: unref(items),
					loading: unref(pending),
					"empty-hint": `${unref(selected) || "这一天"} 没有记录`
				}, null, _parent));
				if ((unref(detail)?.total ?? 0) > 0) _push(ssrRenderComponent(_component_AppPager, {
					page: unref(page),
					"total-pages": unref(detail)?.totalPages ?? 1,
					total: unref(detail)?.total ?? 0,
					"page-size": unref(detail)?.pageSize ?? 10,
					loading: unref(pending),
					onChange: changePage
				}, null, _parent));
				else _push(`<!---->`);
				_push(`</section></div>`);
			}
			_push(`<footer class="foot" data-v-f215893c><span data-v-f215893c>历史数据全部来自 SQLite，按日期分区留存</span><span class="dot-sep" data-v-f215893c>·</span>`);
			_push(ssrRenderComponent(_component_NuxtLink, { to: "/" }, {
				default: withCtx((_, _push, _parent, _scopeId) => {
					if (_push) _push(`返回今日榜单`);
					else return [createTextVNode("返回今日榜单")];
				}),
				_: 1
			}, _parent));
			_push(`</footer></div>`);
		};
	}
});
// app/pages/history.vue
var _sfc_setup = history_vue_vue_type_script_setup_true_lang_default.setup;
history_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/history.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var history_default = /*#__PURE__*/ _plugin_vue_export_helper_default(history_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-f215893c"]]);

export { history_default as default };
//# sourceMappingURL=history-B34lV6Gm.mjs.map
