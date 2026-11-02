import { _ as _plugin_vue_export_helper_default, u as useHead, s as ssrRenderList$2 } from '../virtual/entry.mjs';
import { defineComponent, ref, computed, mergeProps, unref, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrRenderClass, ssrRenderAttr, ssrInterpolate, ssrIncludeBooleanAttr } from 'vue/server-renderer';
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

// app/pages/avatar.vue?vue&type=script&setup=true&lang.ts
var avatar_vue_vue_type_script_setup_true_lang_default = /*@__PURE__*/ defineComponent({
	__name: "avatar",
	__ssrInlineRender: true,
	setup(__props) {
		/**
		* /avatar —— 个性头像生成器
		*
		* 纯前端：一个 seed 唯一确定一张头像（同 seed 永远同一张），
		* 支持 4 种风格、深/浅背景、随机轮播、导出 1024px PNG。
		*/
		const STYLES = [
			{
				key: "blob",
				name: "圆润怪"
			},
			{
				key: "square",
				name: "方块脸"
			},
			{
				key: "bean",
				name: "豆豆怪"
			},
			{
				key: "splat",
				name: "涂鸦派"
			}
		];
		const BGS = [{
			key: "light",
			name: "浅色"
		}, {
			key: "dark",
			name: "深色"
		}];
		const seed = ref(0);
		const style = ref("blob");
		const bg = ref("light");
		const playing = ref(false);
		const downloading = ref(false);
		function mulberry32(a) {
			return () => {
				a |= 0;
				a = a + 1831565813 | 0;
				let t = Math.imul(a ^ a >>> 15, 1 | a);
				t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t;
				return ((t ^ t >>> 14) >>> 0) / 4294967296;
			};
		}
		const SKIN = [
			"#7fd6f0",
			"#9ee7c6",
			"#ffd166",
			"#ff9ec7",
			"#c3b1ff",
			"#ffb27a",
			"#8fd3ff",
			"#b8e986"
		];
		const INK = [
			"#1b2a41",
			"#22314a",
			"#2d3a52"
		];
		const ACCENT = [
			"#4b7bec",
			"#f76c6c",
			"#f7b731",
			"#26de81",
			"#a55eea",
			"#fd9644"
		];
		const BG_LIGHT = [
			"#f5f8ff",
			"#f7f4ff",
			"#f2fbf6",
			"#fff7f0"
		];
		const BG_DARK = [
			"#1b2436",
			"#221d33",
			"#16261f",
			"#2a1f2d"
		];
		function buildSvg(s, st, bgKey) {
			const rnd = mulberry32(s);
			const pick = (arr) => arr[Math.floor(rnd() * arr.length)];
			const between = (a, b) => a + rnd() * (b - a);
			const skin = pick(SKIN);
			const ink = pick(INK);
			const accent = pick(ACCENT);
			const bgColor = bgKey === "dark" ? pick(BG_DARK) : pick(BG_LIGHT);
			const cx = 128;
			const cy = 132;
			const rot = between(-8, 8);
			const eyeGap = between(28, 38);
			const eyeY = cy - between(2, 12);
			const eyeR = between(7, 12);
			const mouthY = cy + between(22, 32);
			const eyeStyle = Math.floor(rnd() * 4);
			const eye = (x) => {
				switch (eyeStyle) {
					case 0: return `<circle cx="${x}" cy="${eyeY}" r="${eyeR}" fill="${ink}"/>`;
					case 1: return `<ellipse cx="${x}" cy="${eyeY}" rx="${eyeR * .55}" ry="${eyeR * 1.15}" fill="${ink}"/>`;
					case 2: return `<path d="M${x - eyeR * .8} ${eyeY - eyeR * .8} l${eyeR * 1.6} ${eyeR * 1.6} M${x + eyeR * .8} ${eyeY - eyeR * .8} l${-eyeR * 1.6} ${eyeR * 1.6}" stroke="${ink}" stroke-width="3.4" stroke-linecap="round" fill="none"/>`;
					default: return `<path d="M${x - eyeR} ${eyeY} a${eyeR} ${eyeR} 0 0 1 ${eyeR * 2} 0 Z" fill="${ink}"/>`;
				}
			};
			const mouthStyle = Math.floor(rnd() * 5);
			const mouth = (() => {
				switch (mouthStyle) {
					case 0: return `<path d="M115 ${mouthY} q13 11 26 0" stroke="${ink}" stroke-width="3.2" stroke-linecap="round" fill="none"/>`;
					case 1: return `<ellipse cx="${cx}" cy="${mouthY + 2}" rx="8" ry="6" fill="${ink}"/>`;
					case 2: return `<path d="M118 ${mouthY} h20" stroke="${ink}" stroke-width="3.2" stroke-linecap="round"/>`;
					case 3: return `<path d="M117 ${mouthY - 3} q11 14 22 0" stroke="${ink}" stroke-width="3" stroke-linecap="round" fill="${accent}" fill-opacity="0.35"/>`;
					default: return `<path d="M119 ${mouthY} q9 -9 18 0" stroke="${ink}" stroke-width="3.2" stroke-linecap="round" fill="none"/>`;
				}
			})();
			const blush = rnd() > .45 ? `<ellipse cx="${cx - eyeGap - 6}" cy="${eyeY + 20}" rx="8" ry="5" fill="${accent}" opacity="0.45"/>
         <ellipse cx="${cx + eyeGap + 6}" cy="${eyeY + 20}" rx="8" ry="5" fill="${accent}" opacity="0.45"/>` : "";
			const decorType = Math.floor(rnd() * 3);
			const decor = decorType === 0 ? `<path d="M106 70 q8 -18 16 0 M134 68 q8 -20 16 0" stroke="${ink}" stroke-width="2.6" fill="none" stroke-linecap="round"/>` : decorType === 1 ? `<circle cx="${cx + between(-6, 10)}" cy="66" r="${between(3, 6)}" fill="${accent}"/>` : "";
			let body = "";
			if (st === "blob") {
				const r = between(58, 68);
				body = `<path d="M${cx - r} ${cy} a${r} ${r * between(.94, 1.06)} 0 1 0 ${r * 2} 0 a${r} ${r * between(.94, 1.06)} 0 1 0 ${-r * 2} 0 Z" fill="${skin}"/>`;
			} else if (st === "square") {
				const w = between(56, 64);
				const rr = between(12, 22);
				body = `<rect x="${cx - w}" y="${cy - w}" width="${w * 2}" height="${w * 2}" rx="${rr}" ry="${rr}" fill="${skin}"/>`;
			} else if (st === "bean") body = `<ellipse cx="${cx}" cy="${cy}" rx="${between(50, 58)}" ry="${between(64, 74)}" fill="${skin}"/>`;
			else {
				const n = 9;
				const base = between(58, 70);
				const pts = [];
				for (let i = 0; i < n; i++) {
					const ang = Math.PI * 2 * i / n;
					const rad = base * between(.86, 1.14);
					pts.push(`${(cx + Math.cos(ang) * rad).toFixed(1)},${(cy + Math.sin(ang) * rad).toFixed(1)}`);
				}
				body = `<polygon points="${pts.join(" ")}" fill="${skin}"/>`;
			}
			return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="512" height="512">
  <rect width="256" height="256" rx="40" fill="${bgColor}"/>
  ${Array.from({ length: 3 }, () => {
				const ang = between(0, Math.PI * 2);
				const rad = between(78, 104);
				const x = cx + Math.cos(ang) * rad;
				const y = cy + Math.sin(ang) * rad;
				return `<circle cx="${x.toFixed(1)}" cy="${y.toFixed(1)}" r="${between(2, 4).toFixed(1)}" fill="${accent}" opacity="0.65"/>`;
			}).join("")}
  <g transform="rotate(${rot.toFixed(1)} ${cx} ${cy})">
    ${body}
    ${decor}
    ${eye(cx - eyeGap)}
    ${eye(cx + eyeGap)}
    ${blush}
    ${mouth}
  </g>
</svg>`;
		}
		const svgMarkup = computed(() => buildSvg(seed.value, style.value, bg.value));
		useHead({ title: "个性头像 · 瞭望台" });
		return (_ctx, _push, _parent, _attrs) => {
			_push(`<div${ssrRenderAttrs(mergeProps({ class: "page" }, _attrs))} data-v-536ae946><header class="hero" data-v-536ae946><div class="hero-left" data-v-536ae946><h1 data-v-536ae946>个性头像</h1><p data-v-536ae946>seed 可复现 · 可导出 1024 × 1024 PNG</p></div></header><div class="panel" data-v-536ae946><div class="${ssrRenderClass([unref(bg), "preview"])}" data-v-536ae946><div class="avatar-wrap" data-v-536ae946>${unref(svgMarkup) ?? ""}</div></div><div class="controls" data-v-536ae946><div class="field" data-v-536ae946><label data-v-536ae946>物种 / 风格</label><div class="chips" data-v-536ae946><!--[-->`);
			ssrRenderList$2(STYLES, (s) => {
				_push(`<button class="${ssrRenderClass([{ on: unref(style) === s.key }, "chip"])}" data-v-536ae946>${ssrInterpolate(s.name)}</button>`);
			});
			_push(`<!--]--></div></div><div class="field" data-v-536ae946><label data-v-536ae946>Seed</label><div class="seed-row" data-v-536ae946><input${ssrRenderAttr("value", unref(seed))} type="number" min="0" max="99999999" data-v-536ae946><button class="mini" data-v-536ae946>按 Seed 生成</button></div></div><div class="field" data-v-536ae946><label data-v-536ae946>背景</label><div class="chips" data-v-536ae946><!--[-->`);
			ssrRenderList$2(BGS, (b) => {
				_push(`<button class="${ssrRenderClass([{ on: unref(bg) === b.key }, "chip"])}" data-v-536ae946>${ssrInterpolate(b.name)}</button>`);
			});
			_push(`<!--]--></div></div><div class="actions" data-v-536ae946><button class="btn primary" data-v-536ae946>${ssrInterpolate(unref(playing) ? "暂停动画" : "🎲 随机一张")}</button><button class="btn"${ssrIncludeBooleanAttr(unref(downloading)) ? " disabled" : ""} data-v-536ae946>${ssrInterpolate(unref(downloading) ? "导出中…" : "⬇ 下载 PNG")}</button></div><p class="tip" data-v-536ae946> 同一个 Seed 永远生成同一张头像。觉得好看就把 Seed 记下来，填回输入框即可复现。 </p></div></div></div>`);
		};
	}
});
// app/pages/avatar.vue
var _sfc_setup = avatar_vue_vue_type_script_setup_true_lang_default.setup;
avatar_vue_vue_type_script_setup_true_lang_default.setup = (props, ctx) => {
	const ssrContext = useSSRContext();
	(ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/avatar.vue");
	return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
var avatar_default = /*#__PURE__*/ _plugin_vue_export_helper_default(avatar_vue_vue_type_script_setup_true_lang_default, [["__scopeId", "data-v-536ae946"]]);

export { avatar_default as default };
//# sourceMappingURL=avatar-Dhbc79e6.mjs.map
