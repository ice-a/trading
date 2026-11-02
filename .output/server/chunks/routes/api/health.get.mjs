import { c as defineEventHandler, q as pingDb, v as dbInfo, e as setResponseStatus } from '../../_/nitro.mjs';
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

const health_get = defineEventHandler(async (event) => {
  var _a;
  const ping = await pingDb();
  const info = dbInfo();
  setResponseStatus(event, ping.ok ? 200 : 503);
  return {
    ok: ping.ok,
    runtime: process.env.VERCEL ? "vercel" : "node",
    storage: info.mode === "remote" ? "libsql" : "sqlite",
    db: info,
    latencyMs: ping.latencyMs,
    uptimeSec: Math.round(process.uptime()),
    rssMB: Math.round(process.memoryUsage().rss / 1048576),
    error: (_a = ping.error) != null ? _a : null,
    at: (/* @__PURE__ */ new Date()).toISOString()
  };
});

export { health_get as default };
//# sourceMappingURL=health.get.mjs.map
