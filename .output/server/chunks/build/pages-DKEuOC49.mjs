import { _ as _plugin_vue_export_helper_default, a as useRoute, b as useRouter, u as useHead, N as NuxtLink, $ as $fetch$1 } from '../virtual/entry.mjs';
import { u as useCachedData } from './useCachedData-ChW-i0Ev.mjs';
import { P as PeriodSwitch_default, T as TrendingTable_default, A as AppPager_default } from './AppPager-CnTT1gk3.mjs';
import { defineComponent, ref, computed, withAsyncContext, watch, mergeProps, unref, isRef, withCtx, createTextVNode, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrInterpolate, ssrRenderComponent, ssrRenderClass, ssrIncludeBooleanAttr } from 'vue/server-renderer';
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

// app/components/HitokotoBar.vue?vue&type=script&setup=true&lang.ts
var REFRESH_MS = 6e4;
var HitokotoBar_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "HitokotoBar",
	__ssrInlineRender: true,
	props: { initial: {} },
	setup(__props) {
		const quote = ref(__props.initial ?? null);
		const fading = ref(false);
		ref(0);
		const BAR_SECONDS = REFRESH_MS / 1e3;
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: ["hitokoto", { fading: unref(fading) }] }, _attrs))} data-v-e3244980><div class="left" data-v-e3244980><span class="quote-mark" data-v-e3244980>“</span><div class="body" data-v-e3244980><p class="text" data-v-e3244980>${ssrInterpolate(unref(quote)?.text || "正在装载今日一言…")}</p><p class="from" data-v-e3244980><span class="dash" data-v-e3244980>—</span><span data-v-e3244980>${ssrInterpolate(unref(quote)?.from || "一言")}</span>`);
			if (unref(quote)?.source === "local") _push(`<span class="tag" data-v-e3244980>本地兜底</span>`);
			else _push(`<!---->`);
			_push(`</p></div></div><div class="right" data-v-e3244980><span class="refresh-hint" data-v-e3244980><span class="dot" data-v-e3244980></span> ${ssrInterpolate(BAR_SECONDS)}s 后更新 </span></div><div class="bar" data-v-e3244980><div class="bar-fill" data-v-e3244980></div></div></div>`);
		};
	}
});
// app/components/HitokotoBar.vue
var _sfc_setup$1 = HitokotoBar_vue_vue_type_script_setup_true_lang_default.setup;
HitokotoBar_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/HitokotoBar.vue");
	return _sfc_setup$1 ? _sfc_setup$1(props, ctx) : void 0;
};
var HitokotoBar_default = /*#__PURE__*/ Object.assign(_plugin_vue_export_helper_default(HitokotoBar_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-e3244980"]]), { __name: "HitokotoBar" });
// app/pages/index.vue?vue&type=script&setup=true&lang.ts
var index_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "index",
	__ssrInlineRender: true,
	async setup(__props) {
		let __temp, __restore;
		const route = useRoute();
		const router = useRouter();
		const dateParam = ref(typeof route.query.date === "string" ? route.query.date : "");
		const page = ref(Math.max(1, Number(route.query.page) || 1));
		const intervalMinutes = ref(60);
		/** 榜单周期：日 / 周 / 月 */
		const periodRaw = typeof route.query.period === "string" ? route.query.period : "";
		const period = ref([
			"daily",
			"weekly",
			"monthly"
		].includes(periodRaw) ? periodRaw : "daily");
		/**
		* 一次把三个周期都取回来（/api/trending-bundle）。
		*
		* 原来按周期单独请求，切一次日/周/月就要发一次 SSR 请求 + 查一次库，
		* 部署在 Serverless 上再叠冷启动，切换就很卡。现在切换纯前端，零等待。
		*/
		const bundleKey = computed(() => `trending-bundle:${dateParam.value || "today"}:${page.value}`);
		const bundleData = useCachedData(() => bundleKey.value, () => $fetch$1("/api/trending-bundle", { query: {
			date: dateParam.value || void 0,
			pageSize: 10
		} }), { ttl: 3e5 });
		[__temp, __restore] = withAsyncContext(() => bundleData), await __temp, __restore();
		const { pending, error, refresh } = bundleData;
		/** 当前周期的数据：直接从 bundle 里切，不发任何请求 */
		const data = computed(() => {
			const b = bundleData.data.value;
			if (!b) return null;
			return b[period.value] ?? b.daily ?? null;
		});
		const hitokotoData = useCachedData(() => "hitokoto:first", () => $fetch$1("/api/hitokoto"), { ttl: 3e4 });
		[__temp, __restore] = withAsyncContext(() => hitokotoData), await __temp, __restore();
		const { data: hitokoto } = hitokotoData;
		/** URL 同步（刷新/分享能还原到同一页同一天） */
		/** 切换周期：回到第一页，保留已选日期 */
		function changePeriod(p) {
			if (period.value === p) return;
			period.value = p;
			page.value = 1;
		}
		/**
		* 只有「日期 / 页码」变化才需要重新取数（换一天、翻页）。
		* 周期切换纯前端切片，URL 用 replaceState 同步即可 —— 走 router.replace 会触发
		* 一次客户端导航会重新 SSR 取数，这正是之前「切换很卡」的原因。
		*/
		watch([dateParam, page], () => {
			const query = {};
			if (dateParam.value) query.date = dateParam.value;
			if (page.value > 1) query.page = String(page.value);
			if (period.value !== "daily") query.period = period.value;
			router.replace({ query });
		});
		watch(period, (p) => {});
		/**
		* 按需刷新：单机部署后 /api/refresh 是同步抓取 —— 请求返回就代表数据已经是新的。
		*
		*   · 打开页面  → 调一次（服务端 1 小时节流，不到点直接返回 crawled:false）
		*   · 页面停留  → 每 1 小时自动调一次
		*   · 点「刷新」→ /api/refresh?force=1 立即抓
		*
		* 抓取耗时 4~20 秒，所以客户端超时放宽到 120 秒（与 Caddy 反代超时一致）。
		* 服务端抓完会清进程内缓存，这里拿到响应后重新取数即可。
		*/
		const refreshing = ref(false);
		const refreshNote = ref("");
		const items = computed(() => data.value?.items ?? []);
		const isToday = computed(() => data.value?.isToday ?? true);
		const heroDate = computed(() => data.value?.date ?? "");
		/**
		* 「更新于 x 分钟前」不能直接用服务端算好的字符串：
		* SSR 只算一次，页面不刷新就永远停在那一刻。
		* 这里在客户端每 30 秒重算一次，时间会自己往前走。
		*/
		const clientNow = ref(Date.now());
		const updatedAgoText = computed(() => {
			const t = data.value?.updatedAt;
			if (!t) return data.value?.updatedAgo ?? "—";
			const diff = Math.max(0, clientNow.value - new Date(t).getTime());
			const min = Math.floor(diff / 6e4);
			if (min < 1) return "刚刚";
			if (min < 60) return `${min} 分钟前`;
			const hour = Math.floor(min / 60);
			if (hour < 24) return `${hour} 小时前`;
			return `${Math.floor(hour / 24)} 天前`;
		});
		function changePage(p) {
			page.value = p;
		}
		useHead({ title: () => heroDate.value ? `${heroDate.value} GitHub 日榜简报` : "GitHub 日榜简报" });
		return (_ctx, _push, _parent, _attrs) => {
			const _component_HitokotoBar = HitokotoBar_default;
			const _component_PeriodSwitch = PeriodSwitch_default;
			const _component_TrendingTable = TrendingTable_default;
			const _component_AppPager = AppPager_default;
			const _component_NuxtLink = NuxtLink;
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "page" }, _attrs))} data-v-7feb3de5><header class="hero" data-v-7feb3de5><div class="hero-main" data-v-7feb3de5><span class="gh-logo" data-v-7feb3de5><svg viewBox="0 0 16 16" width="34" height="34" aria-hidden="true" data-v-7feb3de5><path fill="currentColor" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z" data-v-7feb3de5></path></svg></span><div class="hero-text" data-v-7feb3de5><h1 data-v-7feb3de5><span class="date" data-v-7feb3de5>${ssrInterpolate(unref(heroDate) || "加载中")}</span><span class="title" data-v-7feb3de5>GitHub 日榜简报</span></h1><div class="meta-row" data-v-7feb3de5><p class="subtitle" data-v-7feb3de5> GitHub Trending Daily · Top ${ssrInterpolate(unref(data)?.topN ?? 10)} `);
			if (!unref(isToday)) _push(`<span class="history-tag" data-v-7feb3de5>历史数据</span>`);
			else _push(`<!---->`);
			_push(`</p><a class="author-chip" href="https://github.com/ice-a" target="_blank" rel="noopener noreferrer" title="GitHub @ice-a" data-v-7feb3de5><img class="chip-avatar" src="https://github.com/ice-a.png?size=32" alt="ice-a" loading="lazy" referrerpolicy="no-referrer" data-v-7feb3de5> @ice-a </a><a class="repo-chip" href="https://github.com/ice-a/trading" target="_blank" rel="noopener noreferrer" title="项目源码 ice-a/trading" data-v-7feb3de5><svg viewBox="0 0 16 16" width="10" height="10" aria-hidden="true" data-v-7feb3de5><path fill="currentColor" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z" data-v-7feb3de5></path></svg> 源码 </a></div></div></div><div class="hero-side" data-v-7feb3de5><div class="hero-deco" aria-hidden="true" data-v-7feb3de5><svg viewBox="0 0 138 58" width="138" height="58" data-v-7feb3de5><rect x="0.5" y="0.5" width="137" height="57" rx="10" fill="#f4f8ff" stroke="#dbe7f8" data-v-7feb3de5></rect><g data-v-7feb3de5><rect x="12" y="30" width="9" height="17" rx="2.5" fill="#bfd9ff" data-v-7feb3de5></rect><rect x="26" y="22" width="9" height="25" rx="2.5" fill="#9ec7fb" data-v-7feb3de5></rect><rect x="40" y="26" width="9" height="21" rx="2.5" fill="#8ab9f7" data-v-7feb3de5></rect><rect x="54" y="15" width="9" height="32" rx="2.5" fill="#6ba4f0" data-v-7feb3de5></rect><rect x="68" y="19" width="9" height="28" rx="2.5" fill="#82b4f5" data-v-7feb3de5></rect><rect x="82" y="10" width="9" height="37" rx="2.5" fill="#4b8df0" data-v-7feb3de5></rect></g><path d="M6 9.5 7.4 12.4l3.1.45-2.25 2.2.53 3.1L6 16.7l-2.78 1.45.53-3.1L1.5 12.85l3.1-.45L6 9.5Z" fill="#fbbf24" data-v-7feb3de5></path><circle cx="122" cy="14" r="3" fill="#cfe8ff" data-v-7feb3de5></circle><circle cx="130" cy="24" r="2" fill="#dbe7f8" data-v-7feb3de5></circle><path d="M104 34.5 105.6 38l3.9.35-2.9 2.6.85 3.8L104 42.7l-3.45 2.05.85-3.8-2.9-2.6 3.9-.35L104 34.5Z" fill="#fcd34d" data-v-7feb3de5></path></svg></div></div></header>`);
			_push(ssrRenderComponent(_component_HitokotoBar, { initial: unref(hitokoto) }, null, _parent));
			_push(`<div class="toolbar" data-v-7feb3de5><div class="tb-left" data-v-7feb3de5>`);
			_push(ssrRenderComponent(_component_PeriodSwitch, {
				modelValue: unref(period),
				"onUpdate:modelValue": [($event) => isRef(period) ? period.value = $event : null, changePeriod]
			}, null, _parent));
			if (!unref(isToday)) _push(`<button class="pill-btn" data-v-7feb3de5><svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true" data-v-7feb3de5><path fill="currentColor" d="M4.75 0a.75.75 0 0 1 .75.75V2h5V.75a.75.75 0 0 1 1.5 0V2h1.25c.966 0 1.75.784 1.75 1.75v10.5A1.75 1.75 0 0 1 13.25 16H2.75A1.75 1.75 0 0 1 1 14.25V3.75C1 2.784 1.784 2 2.75 2H4V.75A.75.75 0 0 1 4.75 0ZM2.5 6.5v7.75c0 .138.112.25.25.25h10.5a.25.25 0 0 0 .25-.25V6.5h-11Z" data-v-7feb3de5></path></svg> 回到今天 </button>`);
			else _push(`<!---->`);
			_push(`<button class="${ssrRenderClass([{ spinning: unref(refreshing) || unref(pending) }, "pill-btn ghost"])}"${ssrIncludeBooleanAttr(unref(refreshing)) ? " disabled" : ""} data-v-7feb3de5><svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true" data-v-7feb3de5><path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" data-v-7feb3de5></path><path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" data-v-7feb3de5></path></svg> ${ssrInterpolate(unref(refreshing) ? "抓取中…" : "刷新")}</button>`);
			if (unref(refreshNote)) _push(`<span class="refresh-note" data-v-7feb3de5>${ssrInterpolate(unref(refreshNote))}</span>`);
			else _push(`<!---->`);
			_push(`</div><div class="tb-right" data-v-7feb3de5><span class="stat" data-v-7feb3de5><span class="dot live" data-v-7feb3de5></span> 每 ${ssrInterpolate(unref(intervalMinutes))} 分钟自动更新 </span><span class="sep" data-v-7feb3de5></span><span class="stat" data-v-7feb3de5>更新于 ${ssrInterpolate(unref(updatedAgoText))}</span><span class="sep" data-v-7feb3de5></span><span class="stat" data-v-7feb3de5>已追踪 ${ssrInterpolate(unref(data)?.stats.tracked ?? 0)} 个仓库</span>`);
			if ((unref(data)?.stats.droppedCount ?? 0) > 0) _push(`<span class="stat muted" data-v-7feb3de5> · 掉榜保留 ${ssrInterpolate(unref(data)?.stats.droppedCount)}</span>`);
			else _push(`<!---->`);
			_push(`</div></div>`);
			if (unref(error)) _push(`<div class="alert" data-v-7feb3de5><b data-v-7feb3de5>数据加载失败</b><span data-v-7feb3de5>${ssrInterpolate(unref(error).message)}</span><button class="pill-btn" data-v-7feb3de5>重试</button></div>`);
			else _push(`<!---->`);
			_push(ssrRenderComponent(_component_TrendingTable, {
				items: unref(items),
				loading: unref(pending),
				"empty-hint": unref(isToday) ? "今天还没有抓取到数据，稍等片刻或点「刷新」" : "这一天没有记录"
			}, null, _parent));
			if ((unref(data)?.total ?? 0) > 0) _push(ssrRenderComponent(_component_AppPager, {
				page: unref(page),
				"total-pages": unref(data)?.totalPages ?? 1,
				total: unref(data)?.total ?? 0,
				"page-size": unref(data)?.pageSize ?? 10,
				loading: unref(pending),
				onChange: changePage
			}, null, _parent));
			else _push(`<!---->`);
			_push(`<footer class="foot" data-v-7feb3de5><span data-v-7feb3de5>数据每小时写入 SQLite（按日期分区，掉出前 10 的记录只降级、不删除）</span><span class="dot-sep" data-v-7feb3de5>·</span>`);
			_push(ssrRenderComponent(_component_NuxtLink, { to: "/history" }, {
				default: withCtx((_, _push, _parent, _scopeId) => {
					if (_push) _push(`查看历史榜单`);
					else return [createTextVNode("查看历史榜单")];
				}),
				_: 1
			}, _parent));
			_push(`<span class="dot-sep" data-v-7feb3de5>·</span><a href="https://github.com/trending" target="_blank" rel="noopener noreferrer" data-v-7feb3de5>来源 github.com/trending</a></footer></div>`);
		};
	}
});
// app/pages/index.vue
var _sfc_setup = index_vue_vue_type_script_setup_true_lang_default.setup;
index_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/index.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var pages_default = /*#__PURE__*/ _plugin_vue_export_helper_default(index_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-7feb3de5"]]);

export { pages_default as default };
//# sourceMappingURL=pages-DKEuOC49.mjs.map
