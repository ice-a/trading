import { _ as _plugin_vue_export_helper_default, a as useRoute, u as useHead, s as ssrRenderList$2, $ as $fetch$1 } from '../virtual/entry.mjs';
import { u as useCachedData } from './useCachedData-ChW-i0Ev.mjs';
import { defineComponent, ref, computed, mergeProps, unref, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrInterpolate, ssrRenderClass, ssrRenderAttr, ssrIncludeBooleanAttr, ssrRenderStyle } from 'vue/server-renderer';
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

// app/pages/github.vue?vue&type=script&setup=true&lang.ts
var github_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "github",
	__ssrInlineRender: true,
	setup(__props) {
		/**
		* /github —— 热门 GitHub 用户 + 公开仓库列表
		*
		* 只保留仓库搜索：默认看 ice-a，可换任意 GitHub 用户。
		*/
		const route = useRoute();
		const currentUser = ref(typeof route.query.u === "string" && route.query.u ? route.query.u : "ice-a");
		const keyword = ref("");
		const sortBy = ref("pushed");
		const ghToken = ref("");
		const searchInput = ref(typeof route.query.q === "string" ? route.query.q : "");
		const searchQuery = ref(typeof route.query.q === "string" ? route.query.q : "");
		const searchResult = ref(null);
		const searching = ref(false);
		/** 当前是否处于「全站搜索」模式 */
		const isSearchMode = computed(() => Boolean(searchQuery.value));
		/** 搜索结果里的仓库（服务端已按相关度/star 排好，不再本地二次过滤） */
		const searchRepos = computed(() => searchResult.value?.items ?? []);
		/** 模板统一用这三个：搜索模式走搜索数据，否则走当前用户仓库 */
		const displayRepos = computed(() => isSearchMode.value ? searchRepos.value : filteredRepos.value);
		const displayLoading = computed(() => isSearchMode.value ? searching.value : reposPending.value);
		const displayError = computed(() => isSearchMode.value ? searchResult.value?.error : repos.value?.error);
		const reposData = useCachedData(() => `repos:${currentUser.value}:${sortBy.value}`, () => $fetch$1("/api/repos", { query: {
			user: currentUser.value,
			sort: sortBy.value
		} }), { ttl: 6e5 });
		const repos = reposData.data;
		const reposPending = reposData.pending;
		reposData.error;
		reposData.refresh;
		const filteredRepos = computed(() => {
			const list = repos.value?.items ?? [];
			const kw = keyword.value.trim().toLowerCase();
			if (!kw) return list;
			return list.filter((r) => r.name.toLowerCase().includes(kw) || (r.desc || "").toLowerCase().includes(kw) || (r.language || "").toLowerCase().includes(kw) || (r.topics || []).some((t) => t.toLowerCase().includes(kw)));
		});
		const langColor = {
			TypeScript: "#3178c6",
			JavaScript: "#f1e05a",
			Vue: "#41b883",
			Python: "#3572A5",
			Go: "#00ADD8",
			Rust: "#dea584",
			Shell: "#89e051",
			HTML: "#e34c26",
			CSS: "#663399",
			Java: "#b07219",
			"C++": "#f34b7d",
			C: "#555555",
			Ruby: "#701516",
			PHP: "#4F5D95"
		};
		function colorOf(lang) {
			return langColor[lang] || "#8b949e";
		}
		function pushedAgo(iso) {
			if (!iso) return "";
			const diff = Date.now() - new Date(iso).getTime();
			const d = Math.floor(diff / 864e5);
			if (d < 1) return "今天";
			if (d < 30) return `${d} 天前`;
			if (d < 365) return `${Math.floor(d / 30)} 个月前`;
			return `${Math.floor(d / 365)} 年前`;
		}
		useHead({ title: "GitHub · 瞭望台" });
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "page" }, _attrs))} data-v-e28a00c5><header class="hero" data-v-e28a00c5><div class="hero-left" data-v-e28a00c5><h1 data-v-e28a00c5>GitHub</h1><p data-v-e28a00c5> 当前查看 <b data-v-e28a00c5>${ssrInterpolate(unref(currentUser))}</b> 的 <b data-v-e28a00c5>${ssrInterpolate(unref(repos)?.total ?? 0)}</b> 个公开仓库 · 最近推送优先 </p></div><a class="pill-btn" href="https://github.com/" target="_blank" rel="noopener noreferrer" data-v-e28a00c5><svg viewBox="0 0 16 16" width="13" height="13" aria-hidden="true" data-v-e28a00c5><path fill="currentColor" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8Z" data-v-e28a00c5></path></svg> 打开 GitHub </a></header><section class="block" data-v-e28a00c5><div class="repo-head" data-v-e28a00c5><h2 class="block-title" data-v-e28a00c5>${ssrInterpolate(unref(isSearchMode) ? "搜索结果" : "GitHub 仓库")} <span class="sub" data-v-e28a00c5>${ssrInterpolate(unref(isSearchMode) ? `关键词「${unref(searchQuery)}」· 共 ${unref(searchResult)?.total ?? 0} 个` : `${unref(currentUser)} · 最近推送优先`)}</span></h2><div class="repo-tools" data-v-e28a00c5><div class="sort" data-v-e28a00c5><button class="${ssrRenderClass({ on: unref(sortBy) === "pushed" })}" data-v-e28a00c5>最近推送</button><button class="${ssrRenderClass({ on: unref(sortBy) === "stars" })}" data-v-e28a00c5>最多 Star</button><button class="${ssrRenderClass({ on: unref(sortBy) === "name" })}" data-v-e28a00c5>名称</button></div><button class="${ssrRenderClass([{ spinning: unref(reposPending) }, "pill-btn small"])}" data-v-e28a00c5>刷新</button></div></div><div class="search" data-v-e28a00c5><svg viewBox="0 0 16 16" width="14" height="14" aria-hidden="true" data-v-e28a00c5><path fill="currentColor" d="M10.68 11.74a6 6 0 0 1-7.922-8.982 6 6 0 0 1 8.982 7.922l3.04 3.04a.749.749 0 0 1-.326 1.275.749.749 0 0 1-.734-.215ZM11.5 7a4.499 4.499 0 1 0-8.997 0A4.499 4.499 0 0 0 11.5 7Z" data-v-e28a00c5></path></svg><input${ssrRenderAttr("value", unref(searchInput))} type="search" placeholder="搜索 GitHub 全站仓库，回车执行（如 react / vue / rust cli）" spellcheck="false" data-v-e28a00c5><span class="count" data-v-e28a00c5>${ssrInterpolate(unref(isSearchMode) ? `${unref(searchResult)?.total ?? 0} 个结果` : `${unref(filteredRepos).length} 个`)}</span>`);
			if (unref(isSearchMode)) _push(`<button class="search-act ghost" data-v-e28a00c5>返回</button>`);
			else _push(`<button class="search-act"${ssrIncludeBooleanAttr(unref(searching)) ? " disabled" : ""} data-v-e28a00c5>${ssrInterpolate(unref(searching) ? "搜索中…" : "搜索")}</button>`);
			_push(`</div><div class="token-row" data-v-e28a00c5><svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true" data-v-e28a00c5><path fill="currentColor" d="M8 1a3.5 3.5 0 0 0-3.5 3.5V6H4a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1h-.5V4.5A3.5 3.5 0 0 0 8 1Zm2 5H6V4.5a2 2 0 1 1 4 0V6Z" data-v-e28a00c5></path></svg><input${ssrRenderAttr("value", unref(ghToken))} type="password" class="token-input" placeholder="可选：填入你自己的 GitHub Token（配额从 10 次/分钟提升到 30 次/分钟）" spellcheck="false" autocomplete="off" data-v-e28a00c5>`);
			if (unref(ghToken)) _push(`<span class="token-state on" data-v-e28a00c5>已启用</span>`);
			else _push(`<span class="token-state" data-v-e28a00c5>未填 · 共用公共配额</span>`);
			if (unref(ghToken)) _push(`<button class="token-clear" data-v-e28a00c5>清除</button>`);
			else _push(`<!---->`);
			_push(`</div>`);
			if (unref(displayError)) _push(`<div class="alert" data-v-e28a00c5>${ssrInterpolate(unref(displayError))}</div>`);
			else if (unref(displayLoading) && !unref(displayRepos).length) _push(`<div class="search-wait" data-v-e28a00c5><span class="spin" data-v-e28a00c5></span> ${ssrInterpolate(unref(ghToken) ? "正在搜索…" : "正在搜索，公共配额紧张时会排队等待…")}</div>`);
			else if (unref(displayRepos).length) {
				_push(`<div class="repo-grid" data-v-e28a00c5><!--[-->`);
				ssrRenderList$2(unref(displayRepos), (r) => {
					_push(`<a class="repo-card"${ssrRenderAttr("href", r.url)} target="_blank" rel="noopener noreferrer" data-v-e28a00c5><header class="rc-head" data-v-e28a00c5><span class="rc-name" data-v-e28a00c5>${ssrInterpolate(r.name)}</span>`);
					if (r.fork) _push(`<span class="fork-tag" data-v-e28a00c5>Fork</span>`);
					else _push(`<!---->`);
					_push(`</header><p class="rc-desc" data-v-e28a00c5>${ssrInterpolate(r.desc || "暂无描述")}</p><div class="rc-meta" data-v-e28a00c5>`);
					if (r.language) _push(`<span class="lang" data-v-e28a00c5><i class="dot" style="${ssrRenderStyle({ background: colorOf(r.language) })}" data-v-e28a00c5></i> ${ssrInterpolate(r.language)}</span>`);
					else _push(`<!---->`);
					_push(`<span class="stat" data-v-e28a00c5><svg viewBox="0 0 16 16" width="11" height="11" aria-hidden="true" data-v-e28a00c5><path fill="currentColor" d="M8 .25a.75.75 0 0 1 .673.418l1.882 3.815 4.21.612a.75.75 0 0 1 .416 1.279l-3.046 2.97.719 4.192a.75.75 0 0 1-1.088.791L8 12.347l-3.766 1.98a.75.75 0 0 1-1.088-.79l.72-4.194L.818 6.374a.75.75 0 0 1 .416-1.28l4.21-.611L7.327.668A.75.75 0 0 1 8 .25Z" data-v-e28a00c5></path></svg> ${ssrInterpolate(r.stars)}</span><span class="stat" data-v-e28a00c5>⑂ ${ssrInterpolate(r.forks)}</span><span class="pushed" data-v-e28a00c5>更新 ${ssrInterpolate(pushedAgo(r.pushedAt))}</span></div></a>`);
				});
				_push(`<!--]--></div>`);
			} else _push(`<div class="empty" data-v-e28a00c5><p data-v-e28a00c5>${ssrInterpolate(unref(isSearchMode) ? "没有搜到相关仓库" : "没有匹配的仓库")}</p><p class="empty-sub" data-v-e28a00c5>${ssrInterpolate(unref(isSearchMode) ? "换个关键词试试，或点「返回」看当前用户的仓库" : "换个关键词，或点上面的其他用户")}</p></div>`);
			_push(`</section></div>`);
		};
	}
});
// app/pages/github.vue
var _sfc_setup = github_vue_vue_type_script_setup_true_lang_default.setup;
github_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/github.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var github_default = /*#__PURE__*/ _plugin_vue_export_helper_default(github_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-e28a00c5"]]);

export { github_default as default };
//# sourceMappingURL=github-Ipbw6vcd.mjs.map
