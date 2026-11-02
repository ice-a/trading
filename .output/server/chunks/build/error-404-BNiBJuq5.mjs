import { _ as _plugin_vue_export_helper_default, u as useHead, N as NuxtLink } from '../virtual/entry.mjs';
import { useSSRContext, mergeProps, withCtx, createTextVNode, toDisplayString } from 'vue';
import { ssrRenderAttrs, ssrInterpolate, ssrRenderComponent } from 'vue/server-renderer';
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

// node_modules/nuxt/dist/app/components/error-404.vue
var _sfc_main = {
	__name: "error-404",
	__ssrInlineRender: true,
	props: {
		appName: {
			type: String,
			default: "Nuxt"
		},
		status: {
			type: Number,
			default: 404
		},
		statusText: {
			type: String,
			default: "Page not found"
		},
		description: {
			type: String,
			default: "Sorry, the page you are looking for could not be found."
		},
		backHome: {
			type: String,
			default: "Go back home"
		},
		backToPrevious: {
			type: String,
			default: "Go back"
		}
	},
	setup(__props) {
		const props = __props;
		useHead({
			title: `${props.status} - ${props.statusText} | ${props.appName}`,
			script: [{
				innerHTML: `(()=>{if(!(window.history.state&&window.history.state.back||document.referrer.startsWith(window.location.origin+"/")))return;const t=document.querySelector("[data-back-home]"),e=document.querySelector("[data-back-previous]");t&&e&&(e.onclick=()=>window.history.back(),t.hidden=!0,e.hidden=!1)})();`,
				tagPosition: "bodyClose"
			}],
			style: [{ innerHTML: `*,:after,:before{box-sizing:border-box;border-style:solid;border-width:0;border-color:var(--un-default-border-color,#e5e7eb);--un-rotate:0;--un-rotate-x:0;--un-rotate-y:0;--un-rotate-z:0;--un-scale-x:1;--un-scale-y:1;--un-scale-z:1;--un-skew-x:0;--un-skew-y:0;--un-translate-x:0;--un-translate-y:0;--un-translate-z:0;--un-pan-x: ;--un-pan-y: ;--un-pinch-zoom: ;--un-scroll-snap-strictness:proximity;--un-ordinal: ;--un-slashed-zero: ;--un-numeric-figure: ;--un-numeric-spacing: ;--un-numeric-fraction: ;--un-border-spacing-x:0;--un-border-spacing-y:0;--un-ring-offset-shadow:0 0 #0000;--un-ring-shadow:0 0 #0000;--un-shadow-inset: ;--un-shadow:0 0 #0000;--un-ring-inset: ;--un-ring-offset-width:0px;--un-ring-offset-color:#fff;--un-ring-width:0px;--un-ring-color:#93c5fd80;--un-blur: ;--un-brightness: ;--un-contrast: ;--un-drop-shadow: ;--un-grayscale: ;--un-hue-rotate: ;--un-invert: ;--un-saturate: ;--un-sepia: ;--un-backdrop-blur: ;--un-backdrop-brightness: ;--un-backdrop-contrast: ;--un-backdrop-grayscale: ;--un-backdrop-hue-rotate: ;--un-backdrop-invert: ;--un-backdrop-opacity: ;--un-backdrop-saturate: ;--un-backdrop-sepia: }:after,:before{--un-content:""}html{-webkit-text-size-adjust:100%;tab-size:4;font-feature-settings:normal;font-variation-settings:normal;-webkit-tap-highlight-color:transparent;font-family:ui-sans-serif,system-ui,sans-serif,Apple Color Emoji,Segoe UI Emoji,Segoe UI Symbol,Noto Color Emoji;line-height:1.5}body,button{line-height:inherit;margin:0}h1,h2{font-size:inherit;font-weight:inherit}a{-webkit-text-decoration:inherit;text-decoration:inherit}a,button{color:inherit}button{font-feature-settings:inherit;font-variation-settings:inherit;font-family:inherit;font-size:100%;font-weight:inherit;padding:0;text-transform:none;cursor:pointer}[type=button],button{-webkit-appearance:button;background-color:#0000;background-image:none}h1,h2,p{margin:0}[hidden]:where(:not([hidden=until-found])){display:none}` }]
		});
		return (_ctx, _push, _parent, _attrs) => {
			const _component_NuxtLink = NuxtLink;
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "antialiased bg-white dark:bg-neutral-950 dark:text-white font-sans grid min-h-screen overflow-hidden place-content-center text-neutral-950 tracking-wide" }, _attrs))} data-v-55415188><div class="max-w-520px text-center" data-v-55415188><h1 class="font-medium leading-none mb-4 sm:text-[72px] tabular-nums text-[56px]" data-v-55415188>${ssrInterpolate(__props.status)}</h1><h2 class="font-semibold mb-2 sm:text-3xl text-2xl" data-v-55415188>${ssrInterpolate(__props.statusText)}</h2><p class="mb-4 px-2 text-md text-neutral-500" data-v-55415188>${ssrInterpolate(__props.description)}</p><div class="flex items-center justify-center w-full" data-v-55415188>`);
			_push(ssrRenderComponent(_component_NuxtLink, {
				to: "/",
				"data-back-home": "",
				class: "font-medium hover:text-[#00DC82] text-sm underline underline-offset-3"
			}, {
				default: withCtx((_, _push, _parent, _scopeId) => {
					if (_push) _push(`${ssrInterpolate(__props.backHome)}`);
					else return [createTextVNode(toDisplayString(__props.backHome), 1)];
				}),
				_: 1
			}, _parent));
			_push(` <button type="button" data-back-previous hidden class="appearance-none bg-transparent border-0 cursor-pointer font-medium font-sans hover:text-[#00DC82] p-0 text-inherit text-sm underline underline-offset-3" data-v-55415188>${ssrInterpolate(__props.backToPrevious)}</button></div></div></div>`);
		};
	}
};
var _sfc_setup = _sfc_main.setup;
_sfc_main.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("../node_modules/nuxt/dist/app/components/error-404.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var error_404_default = /*#__PURE__*/ _plugin_vue_export_helper_default(_sfc_main, [["__scopeId", "data-v-55415188"]]);

export { error_404_default as default };
//# sourceMappingURL=error-404-BNiBJuq5.mjs.map
