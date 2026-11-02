import { c as defineEventHandler, k as env, i as getHeader, e as setResponseStatus, r as runCrawl, j as invalidateCache } from '../../_/nitro.mjs';
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

const cron = defineEventHandler(async (event) => {
  const secret = env("CRON_SECRET", "") || env("CRON_TOKEN", "");
  if (secret) {
    const auth = String(getHeader(event, "authorization") || "");
    const provided = auth.toLowerCase().startsWith("bearer ") ? auth.slice(7).trim() : "";
    if (provided !== secret) {
      setResponseStatus(event, 401);
      return { ok: false, error: "\u4EE4\u724C\u65E0\u6548" };
    }
  }
  const started = Date.now();
  const gh = await runCrawl("schedule");
  invalidateCache("");
  return {
    ok: Boolean(gh == null ? void 0 : gh.ok),
    durationMs: Date.now() - started,
    github: gh && { fetched: gh.fetched, dropped: gh.dropped, skipped: Boolean(gh.skipped), error: gh.error }
  };
});

export { cron as default };
//# sourceMappingURL=cron.mjs.map
