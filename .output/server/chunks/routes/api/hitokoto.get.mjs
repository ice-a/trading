import { c as defineEventHandler, n as setHeader, f as appConfig } from '../../_/nitro.mjs';
import 'unhead/server';
import 'vue';
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

const FALLBACK = [
  { text: "\u4EE3\u7801\u5199\u5F97\u597D\uFF0C\u4E0D\u5982\u65E5\u5FD7\u6253\u5F97\u597D\u3002", from: "\u5DE5\u7A0B\u5E08\u683C\u8A00" },
  { text: "\u5148\u8BA9\u5B83\u8DD1\u8D77\u6765\uFF0C\u518D\u8BA9\u5B83\u8DD1\u5F97\u5FEB\u3002", from: "Kent Beck" },
  { text: "\u4ECA\u5929\u4E0D\u91CD\u6784\uFF0C\u660E\u5929\u91CD\u6784\u4E24\u5929\u3002", from: "\u6280\u672F\u503A\u5B88\u6052" },
  { text: "\u7B80\u5355\u6027\u662F\u53EF\u9760\u6027\u7684\u524D\u63D0\u3002", from: "Edsger W. Dijkstra" },
  { text: "\u8FC7\u65E9\u4F18\u5316\u662F\u4E07\u6076\u4E4B\u6E90\u3002", from: "Donald Knuth" },
  { text: "\u80FD\u8FD0\u884C\u7684\u4EE3\u7801\uFF0C\u80DC\u8FC7\u5B8C\u7F8E\u7684\u8BBE\u8BA1\u6587\u6863\u3002", from: "\u5B9E\u7528\u4E3B\u4E49" },
  { text: "\u6BCF\u4E00\u6B21\u63D0\u4EA4\uFF0C\u90FD\u8BE5\u8BA9\u660E\u5929\u7684\u81EA\u5DF1\u611F\u8C22\u4ECA\u5929\u3002", from: "Git \u54F2\u5B66" },
  { text: "\u4E16\u754C\u5F88\u5927\uFF0C\u5148\u628A index \u5EFA\u597D\u3002", from: "DBA \u8BED\u5F55" },
  { text: "\u4E0E\u5176\u62C5\u5FC3\u6D41\u91CF\uFF0C\u4E0D\u5982\u5148\u62C5\u5FC3\u5355\u70B9\u3002", from: "\u67B6\u6784\u7B14\u8BB0" },
  { text: "\u4E07\u822C\u7686\u4E0B\u54C1\uFF0C\u552F\u6709\u590D\u76D8\u9AD8\u3002", from: "\u8FD0\u7EF4\u8001\u8BDD" },
  { text: "\u53EA\u8981\u5B66\u4E0D\u6B7B\uFF0C\u5C31\u5F80\u6B7B\u91CC\u5B66\u3002", from: "\u8003\u7814\u4EBA" },
  { text: "\u661F\u5149\u4E0D\u95EE\u8D76\u8DEF\u4EBA\uFF0C\u65F6\u5149\u4E0D\u8D1F\u6709\u5FC3\u4EBA\u3002", from: "\u7F51\u7EDC" }
];
let cache = null;
const CACHE_MS = 3e3;
function pickFallback() {
  const item = FALLBACK[Math.floor(Math.random() * FALLBACK.length)];
  return { text: item.text, from: item.from, source: "local", at: (/* @__PURE__ */ new Date()).toISOString() };
}
const hitokoto_get = defineEventHandler(async (event) => {
  setHeader(event, "Cache-Control", "no-store");
  if (cache && Date.now() - cache.at < CACHE_MS) return cache.payload;
  const cfg = appConfig();
  const endpoints = [
    cfg.hitokotoEndpoint,
    "https://v1.hitokoto.cn/?c=d&c=i&c=k&encode=json",
    "https://v1.hitokoto.cn/?encode=json"
  ].filter(Boolean);
  for (const url of endpoints) {
    try {
      const res = await fetch(url, {
        headers: { Accept: "application/json", "User-Agent": "github-trending-daily/1.0" },
        signal: AbortSignal.timeout(4e3)
      });
      if (!res.ok) continue;
      const data = await res.json();
      const text = (data.hitokoto || "").trim();
      if (!text) continue;
      const from = (data.from_who || data.from || "\u4E00\u8A00").trim();
      const payload = {
        text,
        from,
        source: "remote",
        at: (/* @__PURE__ */ new Date()).toISOString()
      };
      cache = { payload, at: Date.now() };
      return payload;
    } catch {
    }
  }
  const fallback = pickFallback();
  cache = { payload: fallback, at: Date.now() };
  return fallback;
});

export { hitokoto_get as default };
//# sourceMappingURL=hitokoto.get.mjs.map
