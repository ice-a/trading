import { _ as _plugin_vue_export_helper_default, u as useHead, s as ssrRenderList$2, $ as $fetch$1 } from '../virtual/entry.mjs';
import { u as useCachedData } from './useCachedData-ChW-i0Ev.mjs';
import { defineComponent, ref, withAsyncContext, computed, mergeProps, unref, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrInterpolate, ssrRenderClass, ssrIncludeBooleanAttr, ssrLooseContain, ssrRenderStyle, ssrRenderAttr } from 'vue/server-renderer';
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

// app/pages/dns.vue?vue&type=script&setup=true&lang.ts
var dns_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "dns",
	__ssrInlineRender: true,
	async setup(__props) {
		let __temp, __restore;
		/**
		* /dns —— Cloudflare DNS 记录缓存
		*
		* 记录来自 SQLite（dns_records）。没有 CF Token 也能用：
		* 直接展示库里缓存的状态与延迟，点「探活」会并发请求一次并写回结果。
		*/
		const probing = ref(false);
		const showOffline = ref(true);
		const { data, pending, error, refresh } = ([__temp, __restore] = withAsyncContext(() => useCachedData(() => "dns:list", () => $fetch$1("/api/dns"), { ttl: 12e4 })), __temp = await __temp, __restore(), __temp);
		const items = computed(() => data.value?.items ?? []);
		const visible = computed(() => showOffline.value ? items.value : items.value.filter((i) => i.status === "online"));
		const updatedLabel = computed(() => {
			const t = data.value?.checkedAt;
			if (!t) return "暂无记录";
			return new Date(t).toLocaleTimeString("zh-CN", { hour12: false });
		});
		function latencyClass(ms) {
			if (!ms) return "off";
			if (ms < 300) return "fast";
			if (ms < 1e3) return "mid";
			return "slow";
		}
		useHead({ title: "Cloudflare DNS · 瞭望台" });
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "page" }, _attrs))} data-v-bbb6e64e><header class="hero" data-v-bbb6e64e><div class="hero-left" data-v-bbb6e64e><h1 data-v-bbb6e64e>Cloudflare DNS</h1><p data-v-bbb6e64e> 共 <b data-v-bbb6e64e>${ssrInterpolate(unref(data)?.total ?? 0)}</b> 条记录 · <span class="ok" data-v-bbb6e64e>${ssrInterpolate(unref(data)?.online ?? 0)}</span> 在线 · <span class="bad" data-v-bbb6e64e>${ssrInterpolate(unref(data)?.offline ?? 0)}</span> 离线 <span class="dot-sep" data-v-bbb6e64e>·</span> 最后更新 ${ssrInterpolate(unref(updatedLabel))} <span class="dot-sep" data-v-bbb6e64e>·</span><span class="${ssrRenderClass([unref(data)?.source === "cloudflare" ? "live" : "cached", "src"])}" data-v-bbb6e64e>${ssrInterpolate(unref(data)?.source === "cloudflare" ? "Cloudflare API" : "本地缓存")}</span></p></div><div class="hero-actions" data-v-bbb6e64e><label class="switch" data-v-bbb6e64e><input${ssrIncludeBooleanAttr(Array.isArray(unref(showOffline)) ? ssrLooseContain(unref(showOffline), null) : unref(showOffline)) ? " checked" : ""} type="checkbox" data-v-bbb6e64e><span class="slider" data-v-bbb6e64e></span><span class="switch-label" data-v-bbb6e64e>显示离线站点</span></label><button class="${ssrRenderClass([{ spinning: unref(probing) }, "pill-btn primary"])}"${ssrIncludeBooleanAttr(unref(probing)) ? " disabled" : ""} data-v-bbb6e64e><svg viewBox="0 0 16 16" width="12" height="12" aria-hidden="true" data-v-bbb6e64e><path fill="currentColor" d="M8 3a5 5 0 1 0 4.546 2.914.75.75 0 0 1 1.364-.626A6.5 6.5 0 1 1 8 1.5v1.5Z" data-v-bbb6e64e></path><path fill="currentColor" d="M8 .5 11 3 8 5.5v-5Z" data-v-bbb6e64e></path></svg> ${ssrInterpolate(unref(probing) ? "探活中…" : "手动刷新")}</button></div></header>`);
			if (unref(error)) _push(`<div class="alert" data-v-bbb6e64e>加载失败：${ssrInterpolate(unref(error).message)}</div>`);
			else if (unref(pending) && !unref(items).length) {
				_push(`<div class="grid" data-v-bbb6e64e><!--[-->`);
				ssrRenderList$2(8, (i) => {
					_push(`<div class="card sk" data-v-bbb6e64e><div class="skeleton" style="${ssrRenderStyle({
						"width": "55%",
						"height": "13px"
					})}" data-v-bbb6e64e></div><div class="skeleton" style="${ssrRenderStyle({
						"width": "40%",
						"height": "10px",
						"margin-top": "10px"
					})}" data-v-bbb6e64e></div></div>`);
				});
				_push(`<!--]--></div>`);
			} else if (unref(visible).length) {
				_push(`<div class="grid" data-v-bbb6e64e><!--[-->`);
				ssrRenderList$2(unref(visible), (it) => {
					_push(`<article class="${ssrRenderClass([{ offline: it.status === "offline" }, "card"])}" data-v-bbb6e64e><header class="card-head" data-v-bbb6e64e><h3 class="name" data-v-bbb6e64e>${ssrInterpolate(it.name)}</h3><svg class="ext" viewBox="0 0 16 16" width="11" height="11" aria-hidden="true" data-v-bbb6e64e><path fill="currentColor" d="M3.75 2h3.5a.75.75 0 0 1 0 1.5h-3.5a.25.25 0 0 0-.25.25v8.5c0 .138.112.25.25.25h8.5a.25.25 0 0 0 .25-.25v-3.5a.75.75 0 0 1 1.5 0v3.5A1.75 1.75 0 0 1 12.25 14h-8.5A1.75 1.75 0 0 1 2 12.25v-8.5C2 2.784 2.784 2 3.75 2Zm6.5-1.5h4.5a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0V2.56L8.28 8.28a.75.75 0 0 1-1.06-1.06L12.94 1.5h-2.69a.75.75 0 0 1 0-1.5Z" data-v-bbb6e64e></path></svg></header><p class="host" data-v-bbb6e64e>${ssrInterpolate(it.host)}</p><div class="status" data-v-bbb6e64e><span class="${ssrRenderClass([it.status, "badge"])}" data-v-bbb6e64e><span class="dot" data-v-bbb6e64e></span> ${ssrInterpolate(it.status === "online" ? "在线" : it.status === "offline" ? "离线" : "未知")}</span>`);
					if (it.latencyMs) _push(`<span class="${ssrRenderClass([latencyClass(it.latencyMs), "latency"])}" data-v-bbb6e64e>${ssrInterpolate(it.latencyMs)}ms</span>`);
					else _push(`<!---->`);
					if (it.httpStatus) _push(`<span class="http" data-v-bbb6e64e>HTTP ${ssrInterpolate(it.httpStatus)}</span>`);
					else _push(`<!---->`);
					_push(`</div><div class="meta" data-v-bbb6e64e>`);
					if (it.type) _push(`<span class="type" data-v-bbb6e64e>${ssrInterpolate(it.type)}</span>`);
					else _push(`<!---->`);
					if (it.proxied) _push(`<span class="proxy" data-v-bbb6e64e>CF 代理</span>`);
					else _push(`<!---->`);
					_push(`</div><footer class="card-foot" data-v-bbb6e64e><a class="open-btn"${ssrRenderAttr("href", `https://${it.host}`)} target="_blank" rel="noopener noreferrer" data-v-bbb6e64e> 打开 <svg viewBox="0 0 16 16" width="10" height="10" aria-hidden="true" data-v-bbb6e64e><path fill="currentColor" d="M6 3.75 10.25 8 6 12.25V3.75Z" data-v-bbb6e64e></path></svg></a></footer></article>`);
				});
				_push(`<!--]--></div>`);
			} else _push(`<div class="empty" data-v-bbb6e64e><p data-v-bbb6e64e>没有可显示的记录</p><p class="empty-sub" data-v-bbb6e64e>往 dns_records 表里插入数据即可，或跑 npm run db:seed 生成样例</p></div>`);
			_push(`</div>`);
		};
	}
});
// app/pages/dns.vue
var _sfc_setup = dns_vue_vue_type_script_setup_true_lang_default.setup;
dns_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/dns.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var dns_default = /*#__PURE__*/ _plugin_vue_export_helper_default(dns_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-bbb6e64e"]]);

export { dns_default as default };
//# sourceMappingURL=dns-DRj2O0Ff.mjs.map
