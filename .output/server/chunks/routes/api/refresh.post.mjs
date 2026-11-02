import { c as defineEventHandler, g as getMethod, e as setResponseStatus, h as getQuery, z as readMeta, r as runCrawl, A as touchMeta, j as invalidateCache } from '../../_/nitro.mjs';
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

const MIN_INTERVAL_MS = 60 * 6e4;
const refresh_post = defineEventHandler(async (event) => {
  const method = getMethod(event);
  if (method !== "POST" && method !== "GET") {
    setResponseStatus(event, 405);
    return { ok: false, error: "\u4EC5\u652F\u6301 POST / GET" };
  }
  const q = getQuery(event);
  const force = q.force === "1" || q.force === "true";
  const meta = await readMeta() || {};
  const lastAt = Math.max(
    meta.lastAutoCrawlAt ? new Date(meta.lastAutoCrawlAt).getTime() : 0,
    meta.lastTriggeredAt ? new Date(meta.lastTriggeredAt).getTime() : 0
  );
  const elapsed = Date.now() - lastAt;
  const due = force || elapsed >= MIN_INTERVAL_MS;
  if (!due) {
    return {
      ok: true,
      crawled: false,
      reason: "\u8DDD\u79BB\u4E0A\u6B21\u6293\u53D6\u4E0D\u8DB3 1 \u5C0F\u65F6",
      remainingMs: Math.max(0, MIN_INTERVAL_MS - elapsed)
    };
  }
  const started = Date.now();
  const github = await runCrawl(force ? "manual" : "schedule");
  await touchMeta({ lastAutoCrawlAt: (/* @__PURE__ */ new Date()).toISOString() });
  invalidateCache("");
  return {
    ok: Boolean(github.ok),
    crawled: true,
    durationMs: Date.now() - started,
    github: {
      fetched: github.fetched,
      dropped: github.dropped,
      skipped: Boolean(github.skipped),
      error: github.error
    }
  };
});

export { refresh_post as default };
//# sourceMappingURL=refresh.post.mjs.map
