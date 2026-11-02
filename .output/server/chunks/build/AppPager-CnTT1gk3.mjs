import { _ as _plugin_vue_export_helper_default, s as ssrRenderList$2 } from '../virtual/entry.mjs';
import { defineComponent, mergeProps, unref, computed, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrRenderClass, ssrInterpolate, ssrRenderComponent, ssrRenderAttr, ssrRenderStyle, ssrIncludeBooleanAttr } from 'vue/server-renderer';

// app/components/PeriodSwitch.vue?vue&type=script&setup=true&lang.ts
var PeriodSwitch_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "PeriodSwitch",
	__ssrInlineRender: true,
	props: { modelValue: {} },
	emits: ["update:modelValue"],
	setup(__props, { emit: __emit }) {
		const OPTIONS = [
			{
				key: "daily",
				label: "日榜"
			},
			{
				key: "weekly",
				label: "周榜"
			},
			{
				key: "monthly",
				label: "月榜"
			}
		];
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "seg" }, _attrs))} data-v-c7bef612><!--[-->`);
			ssrRenderList$2(OPTIONS, (o) => {
				_push(`<button class="${ssrRenderClass([{ on: __props.modelValue === o.key }, "seg-btn"])}" data-v-c7bef612>${ssrInterpolate(o.label)}</button>`);
			});
			_push(`<!--]--></div>`);
		};
	}
});
// app/components/PeriodSwitch.vue
var _sfc_setup$3 = PeriodSwitch_vue_vue_type_script_setup_true_lang_default.setup;
PeriodSwitch_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/PeriodSwitch.vue");
	return _sfc_setup$3 ? _sfc_setup$3(props, ctx) : void 0;
};
var PeriodSwitch_default = /*#__PURE__*/ Object.assign(_plugin_vue_export_helper_default(PeriodSwitch_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-c7bef612"]]), { __name: "PeriodSwitch" });
// app/components/RankBadge.vue?vue&type=script&setup=true&lang.ts
var RankBadge_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "RankBadge",
	__ssrInlineRender: true,
	props: {
		rank: {},
		dropped: { type: Boolean }
	},
	setup(__props) {
		/**
		* 排名徽章。
		* 前 3 名用金银铜渐变方块（第 1 名配皇冠），其余为普通数字。
		*/
		const props = __props;
		const medal = computed(() => {
			if (props.rank === 1) return "gold";
			if (props.rank === 2) return "silver";
			if (props.rank === 3) return "bronze";
			return "";
		});
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: ["rank", [unref(medal), { dropped: __props.dropped }]] }, _attrs))} data-v-44609107>`);
			if (__props.dropped || __props.rank == null) _push(`<svg class="drop-icon" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true" data-v-44609107><path fill="currentColor" d="M3.47 2.47a.75.75 0 0 0-1.06 1.06L6.94 8l-4.53 4.47a.75.75 0 1 0 1.06 1.06L8 9.06l4.47 4.47a.75.75 0 0 0 1.06-1.06L9.06 8l4.47-4.47a.75.75 0 1 0-1.06-1.06L8 6.94 3.47 2.47Z" data-v-44609107></path></svg>`);
			else if (__props.rank === 1) _push(`<!--[--><svg class="crown" viewBox="0 0 24 24" width="24" height="24" aria-hidden="true" data-v-44609107><path fill="currentColor" d="M3 8.5 6.6 11 12 5.2 17.4 11 21 8.5l-1.6 9.9a1 1 0 0 1-1 .8H5.6a1 1 0 0 1-1-.8L3 8.5Z" data-v-44609107></path><circle cx="4" cy="6" r="1.7" fill="currentColor" data-v-44609107></circle><circle cx="20" cy="6" r="1.7" fill="currentColor" data-v-44609107></circle><circle cx="12" cy="4" r="1.9" fill="currentColor" data-v-44609107></circle></svg><span class="num" data-v-44609107>1</span><!--]-->`);
			else _push(`<span class="num" data-v-44609107>${ssrInterpolate(__props.rank)}</span>`);
			_push(`</div>`);
		};
	}
});
// app/components/RankBadge.vue
var _sfc_setup$2 = RankBadge_vue_vue_type_script_setup_true_lang_default.setup;
RankBadge_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/RankBadge.vue");
	return _sfc_setup$2 ? _sfc_setup$2(props, ctx) : void 0;
};
var RankBadge_default = /*#__PURE__*/ Object.assign(_plugin_vue_export_helper_default(RankBadge_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-44609107"]]), { __name: "RankBadge" });
// app/utils/format.ts
/** 数字格式化工具（自动导入，模板里直接用） */
/** 36600 → 36.6k */
function compactNumber(n) {
	const v = Number(n ?? 0);
	if (!Number.isFinite(v) || v <= 0) return "0";
	if (v >= 1e6) return `${trim(v / 1e6)}m`;
	if (v >= 1e3) return `${trim(v / 1e3)}k`;
	return String(v);
}
/** 2244 → 2,244 */
function plainNumber(n) {
	const v = Math.round(Number(n ?? 0));
	if (!Number.isFinite(v)) return "0";
	return v.toLocaleString("en-US");
}
function trim(v) {
	return v >= 100 ? String(Math.round(v)) : v.toFixed(1).replace(/\.0$/, "");
}
/** 今日增长的分级配色：越高越绿 */
function growthLevel(n) {
	if (n >= 1e3) return "hot";
	if (n >= 300) return "warm";
	return "cool";
}
// app/components/TrendingTable.vue?vue&type=script&setup=true&lang.ts
var TrendingTable_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "TrendingTable",
	__ssrInlineRender: true,
	props: {
		items: {},
		loading: { type: Boolean },
		emptyHint: {}
	},
	setup(__props) {
		const PALETTE = [
			"#f59e0b",
			"#111827",
			"#7c3aed",
			"#ec4899",
			"#374151",
			"#60a5fa",
			"#2563eb",
			"#0ea5e9",
			"#6366f1",
			"#9f1239",
			"#059669",
			"#c2410c"
		];
		function hashCode(s) {
			let h = 0;
			for (let i = 0; i < s.length; i++) h = h * 31 + s.charCodeAt(i) >>> 0;
			return h;
		}
		function avatarColor(owner) {
			return PALETTE[hashCode(owner.toLowerCase()) % PALETTE.length];
		}
		function initials(owner) {
			return (owner.replace(/[-_.]/g, "").slice(0, 2) || "GH").toUpperCase();
		}
		function rowClass(item) {
			return {
				"is-top1": item.rank === 1,
				"is-top2": item.rank === 2,
				"is-top3": item.rank === 3,
				"is-dropped": item.dropped,
				"is-rest": item.bucket > 0 && !item.dropped
			};
		}
		return (_ctx, _push, _parent, _attrs) => {
			const _component_RankBadge = RankBadge_default;
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "table" }, _attrs))} data-v-4809725c><div class="head" data-v-4809725c><div class="c-rank" data-v-4809725c>排名</div><div class="c-repo" data-v-4809725c>项目</div><div class="c-desc" data-v-4809725c>简介</div><div class="c-today" data-v-4809725c>今日增长</div><div class="c-stars" data-v-4809725c>总 Star</div><div class="c-forks" data-v-4809725c>Fork</div></div>`);
			if (__props.loading && !__props.items.length) {
				_push(`<!--[-->`);
				ssrRenderList$2(8, (i) => {
					_push(`<div class="row skeleton-row" data-v-4809725c><div class="c-rank" data-v-4809725c><div class="skeleton sk-badge" data-v-4809725c></div></div><div class="c-repo" data-v-4809725c><div class="skeleton sk-avatar" data-v-4809725c></div><div class="sk-lines" data-v-4809725c><div class="skeleton sk-line w60" data-v-4809725c></div><div class="skeleton sk-line w30" data-v-4809725c></div></div></div><div class="c-desc" data-v-4809725c><div class="skeleton sk-line w80" data-v-4809725c></div></div><div class="c-today" data-v-4809725c><div class="skeleton sk-pill" data-v-4809725c></div></div><div class="c-stars" data-v-4809725c><div class="skeleton sk-line w50" data-v-4809725c></div></div><div class="c-forks" data-v-4809725c><div class="skeleton sk-line w50" data-v-4809725c></div></div></div>`);
				});
				_push(`<!--]-->`);
			} else if (__props.items.length) {
				_push(`<!--[-->`);
				ssrRenderList$2(__props.items, (item) => {
					_push(`<div class="${ssrRenderClass([rowClass(item), "row"])}" data-v-4809725c><div class="c-rank" data-v-4809725c>`);
					_push(ssrRenderComponent(_component_RankBadge, {
						rank: item.rank,
						dropped: item.dropped
					}, null, _parent));
					_push(`</div><div class="c-repo" data-v-4809725c><a class="repo"${ssrRenderAttr("href", item.url)} target="_blank" rel="noopener noreferrer" data-v-4809725c><span class="avatar" style="${ssrRenderStyle({ background: avatarColor(item.owner) })}" data-v-4809725c>${ssrInterpolate(initials(item.owner))}</span><span class="repo-text" data-v-4809725c><span class="repo-name" data-v-4809725c>${ssrInterpolate(item.name)}</span><span class="repo-owner" data-v-4809725c>${ssrInterpolate(item.owner)}</span></span></a></div><div class="c-desc" data-v-4809725c><p class="desc-text" data-v-4809725c>${ssrInterpolate(item.description || "暂无简介")}</p><div class="meta" data-v-4809725c><span class="lang" data-v-4809725c><i class="dot" style="${ssrRenderStyle({ background: item.languageColor })}" data-v-4809725c></i> ${ssrInterpolate(item.language)}</span>`);
					if (item.dropped) _push(`<span class="badge drop" data-v-4809725c>已掉榜</span>`);
					else _push(`<!---->`);
					_push(`</div></div><div class="c-today" data-v-4809725c><span class="${ssrRenderClass([("growthLevel" in _ctx ? _ctx.growthLevel : unref(growthLevel))(item.todayStars), "growth"])}" data-v-4809725c> +${ssrInterpolate(("plainNumber" in _ctx ? _ctx.plainNumber : unref(plainNumber))(item.todayStars))}</span></div><div class="c-stars" data-v-4809725c><svg class="ico star" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true" data-v-4809725c><path fill="currentColor" d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.75.75 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z" data-v-4809725c></path></svg><span class="num" data-v-4809725c>${ssrInterpolate(("compactNumber" in _ctx ? _ctx.compactNumber : unref(compactNumber))(item.totalStars))}</span></div><div class="c-forks" data-v-4809725c><svg class="ico" viewBox="0 0 16 16" width="14" height="14" aria-hidden="true" data-v-4809725c><path fill="currentColor" d="M5 5.372v.878c0 .414.336.75.75.75h4.5a.75.75 0 0 0 .75-.75v-.878a2.25 2.25 0 1 1 1.5 0v.878a2.25 2.25 0 0 1-2.25 2.25h-1.5v2.128a2.251 2.251 0 1 1-1.5 0V8.5h-1.5A2.25 2.25 0 0 1 3.5 6.25v-.878a2.25 2.25 0 1 1 1.5 0ZM5 3.25a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Zm6.75.75a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm-3 8.75a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z" data-v-4809725c></path></svg><span class="num" data-v-4809725c>${ssrInterpolate(("compactNumber" in _ctx ? _ctx.compactNumber : unref(compactNumber))(item.forks))}</span></div></div>`);
				});
				_push(`<!--]-->`);
			} else _push(`<div class="empty" data-v-4809725c><div class="empty-icon" data-v-4809725c>📭</div><p class="empty-title" data-v-4809725c>${ssrInterpolate(__props.emptyHint || "这一天还没有数据")}</p><p class="empty-sub" data-v-4809725c>抓取任务会按 .env 里的 UPDATE_INTERVAL_MINUTES 自动运行</p></div>`);
			_push(`<div class="foot" data-v-4809725c> 数据源：GitHub Trending（Daily）· 今日增长为 GitHub 官方滚动统计，非自然日增量 </div></div>`);
		};
	}
});
// app/components/TrendingTable.vue
var _sfc_setup$1 = TrendingTable_vue_vue_type_script_setup_true_lang_default.setup;
TrendingTable_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/TrendingTable.vue");
	return _sfc_setup$1 ? _sfc_setup$1(props, ctx) : void 0;
};
var TrendingTable_default = /*#__PURE__*/ Object.assign(_plugin_vue_export_helper_default(TrendingTable_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-4809725c"]]), { __name: "TrendingTable" });
// app/components/AppPager.vue?vue&type=script&setup=true&lang.ts
var AppPager_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "AppPager",
	__ssrInlineRender: true,
	props: {
		page: {},
		totalPages: {},
		total: {},
		pageSize: {},
		loading: { type: Boolean }
	},
	emits: ["change"],
	setup(__props, { emit: __emit }) {
		/** 分页器：每页 10 条，翻页才去读 Mongo 里掉出前 10 的历史记录 */
		const props = __props;
		const pages = computed(() => {
			const all = props.totalPages;
			const cur = props.page;
			if (all <= 7) return Array.from({ length: all }, (_, i) => i + 1);
			const list = [.../* @__PURE__ */ new Set([
				1,
				all,
				cur,
				cur - 1,
				cur + 1
			])].filter((p) => p >= 1 && p <= all).sort((a, b) => a - b);
			const out = [];
			let prev = 0;
			for (const p of list) {
				if (prev && p - prev > 1) out.push("gap");
				out.push(p);
				prev = p;
			}
			return out;
		});
		const from = computed(() => props.total === 0 ? 0 : (props.page - 1) * props.pageSize + 1);
		const to = computed(() => Math.min(props.page * props.pageSize, props.total));
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "pager" }, _attrs))} data-v-8ba15209><div class="info" data-v-8ba15209> 第 <b data-v-8ba15209>${ssrInterpolate(unref(from))}</b>–<b data-v-8ba15209>${ssrInterpolate(unref(to))}</b> 条 · 共 <b data-v-8ba15209>${ssrInterpolate(__props.total)}</b> 条 · 每页 ${ssrInterpolate(__props.pageSize)} 条 </div><div class="controls" data-v-8ba15209><button class="btn"${ssrIncludeBooleanAttr(__props.page <= 1 || __props.loading) ? " disabled" : ""} data-v-8ba15209><svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true" data-v-8ba15209><path fill="currentColor" d="M9.78 12.78a.75.75 0 0 1-1.06 0L4.47 8.53a.75.75 0 0 1 0-1.06l4.25-4.25a.75.75 0 0 1 1.06 1.06L6.06 8l3.72 3.72a.75.75 0 0 1 0 1.06Z" data-v-8ba15209></path></svg> 上一页 </button><div class="nums" data-v-8ba15209><!--[-->`);
			ssrRenderList$2(unref(pages), (p, i) => {
				_push(`<!--[-->`);
				if (p === "gap") _push(`<span class="gap" data-v-8ba15209>…</span>`);
				else _push(`<button class="${ssrRenderClass([{ active: p === __props.page }, "num"])}"${ssrIncludeBooleanAttr(__props.loading) ? " disabled" : ""} data-v-8ba15209>${ssrInterpolate(p)}</button>`);
				_push(`<!--]-->`);
			});
			_push(`<!--]--></div><button class="btn"${ssrIncludeBooleanAttr(__props.page >= __props.totalPages || __props.loading) ? " disabled" : ""} data-v-8ba15209> 下一页 <svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true" data-v-8ba15209><path fill="currentColor" d="M6.22 3.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 0 1 0-1.06Z" data-v-8ba15209></path></svg></button></div></div>`);
		};
	}
});
// app/components/AppPager.vue
var _sfc_setup = AppPager_vue_vue_type_script_setup_true_lang_default.setup;
AppPager_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/AppPager.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var AppPager_default = /*#__PURE__*/ Object.assign(_plugin_vue_export_helper_default(AppPager_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-8ba15209"]]), { __name: "AppPager" });

export { AppPager_default as A, PeriodSwitch_default as P, TrendingTable_default as T, plainNumber as p };
//# sourceMappingURL=AppPager-CnTT1gk3.mjs.map
