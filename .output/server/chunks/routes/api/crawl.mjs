import { c as defineEventHandler, g as getMethod, e as setResponseStatus, f as appConfig, h as getQuery, i as getHeader, r as runCrawl, j as invalidateCache } from '../../_/nitro.mjs';
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

const crawl = defineEventHandler(async (event) => {
  const method = getMethod(event);
  if (method !== "GET" && method !== "POST") {
    setResponseStatus(event, 405);
    return { ok: false, error: "\u4EC5\u652F\u6301 GET / POST" };
  }
  const cfg = appConfig();
  const secret = cfg.cronToken;
  const query = getQuery(event);
  if (secret) {
    const auth = getHeader(event, "authorization") || "";
    const bearer = auth.toLowerCase().startsWith("bearer ") ? auth.slice(7).trim() : "";
    const provided = String(getHeader(event, "x-cron-token") || bearer || query.token || "");
    if (provided !== secret) {
      setResponseStatus(event, 401);
      return { ok: false, error: "\u4EE4\u724C\u65E0\u6548" };
    }
  }
  const startedAt = Date.now();
  const github = await runCrawl("manual");
  invalidateCache("");
  setResponseStatus(event, github.ok ? 200 : github.skipped ? 429 : 500);
  return {
    ok: github.ok,
    wallMs: Date.now() - startedAt,
    github
  };
});

export { crawl as default };
//# sourceMappingURL=crawl.mjs.map
