import { l as sqlRun, m as sqlAll, c as defineEventHandler, h as getQuery, n as setHeader, w as withCache, j as invalidateCache, k as env, o as sqlBatch } from '../../_/nitro.mjs';
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

async function listDnsRecords() {
  const rows = await sqlAll("select * from dns_records order by name asc");
  return rows.map((r) => ({
    name: r.name,
    host: r.host,
    type: r.type,
    target: r.target,
    proxied: Boolean(r.proxied),
    status: r.status,
    latencyMs: r.latency_ms,
    httpStatus: r.http_status,
    checkedAt: r.checked_at
  }));
}
async function updateDnsStatus(host, patch) {
  const now = (/* @__PURE__ */ new Date()).toISOString();
  await sqlRun(
    "update dns_records set status = ?, latency_ms = ?, http_status = ?, checked_at = ?, updated_at = ? where host = ?",
    [patch.status, patch.latencyMs, patch.httpStatus, now, now, host]
  );
}

function envToken() {
  return env("CF_API_TOKEN", "");
}
function envZones() {
  return env("CF_ZONE_IDS", "").split(",").map((s) => s.trim()).filter(Boolean);
}
async function fetchZoneRecords(zoneId, token) {
  var _a, _b;
  try {
    const res = await fetch(
      `https://api.cloudflare.com/client/v4/zones/${encodeURIComponent(zoneId)}/dns_records?per_page=200`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        },
        signal: AbortSignal.timeout(12e3)
      }
    );
    const body = await res.json().catch(() => null);
    if (!res.ok || !(body == null ? void 0 : body.success)) {
      const msg = ((_b = (_a = body == null ? void 0 : body.errors) == null ? void 0 : _a[0]) == null ? void 0 : _b.message) || `Cloudflare API ${res.status}`;
      return { records: [], error: msg };
    }
    return { records: body.result || [] };
  } catch (err) {
    return { records: [], error: err instanceof Error ? err.message : String(err) };
  }
}
function toDoc(r) {
  var _a;
  const host = r.name;
  const firstLabel = host.split(".")[0] || host;
  return {
    name: ((_a = r.comment) == null ? void 0 : _a.trim()) || (firstLabel === "@" ? host : firstLabel),
    host,
    type: r.type,
    target: r.content,
    proxied: Boolean(r.proxied),
    cfId: r.id
  };
}
async function persist(records) {
  if (!records.length) return;
  const nowIso = (/* @__PURE__ */ new Date()).toISOString();
  const stmts = records.map((r) => {
    const doc = toDoc(r);
    return {
      sql: "insert into dns_records (host, name, type, target, proxied, updated_at, created_at) values (?,?,?,?,?,?,?) on conflict (host) do update set name=excluded.name, type=excluded.type, target=excluded.target, proxied=excluded.proxied, updated_at=excluded.updated_at",
      params: [doc.host, doc.name, doc.type, doc.target, doc.proxied ? 1 : 0, nowIso, nowIso]
    };
  });
  try {
    await sqlBatch(stmts);
  } catch {
  }
}
async function probeOne(host) {
  const started = Date.now();
  try {
    const res = await fetch(`https://${host}/`, {
      method: "HEAD",
      redirect: "follow",
      signal: AbortSignal.timeout(8e3),
      headers: { "User-Agent": "liaowangtai/dns-probe" }
    });
    const ms = Date.now() - started;
    const reachable = res.status < 500;
    return { status: reachable ? "online" : "offline", latencyMs: ms, httpStatus: res.status };
  } catch {
    return { status: "offline", latencyMs: Date.now() - started, httpStatus: 0 };
  }
}
const dns_get = defineEventHandler(async (event) => {
  const q = getQuery(event);
  const shouldProbe = q.probe === "1" || q.probe === "true";
  const token = envToken();
  const zones = envZones();
  setHeader(event, "Cache-Control", "no-store");
  let items = [];
  let source = "cache";
  let cfError = null;
  let zoneCount = 0;
  if (token && zones.length) {
    const results = await Promise.all(zones.map((z) => fetchZoneRecords(z, token)));
    const allRecords = [];
    const errors = [];
    for (const r of results) {
      if (r.error) errors.push(r.error);
      allRecords.push(...r.records);
    }
    if (allRecords.length) {
      source = "cloudflare";
      zoneCount = zones.length;
      await persist(allRecords);
      cfError = errors.length ? errors.join("; ") : null;
    } else {
      cfError = errors.length ? errors.join("; ") : "Cloudflare \u672A\u8FD4\u56DE\u8BB0\u5F55";
    }
  }
  const rows = await withCache("dns:rows", 6e4, () => listDnsRecords());
  if (shouldProbe && rows.length) {
    const CONCURRENCY = 5;
    const resultMap = /* @__PURE__ */ new Map();
    for (let i = 0; i < rows.length; i += CONCURRENCY) {
      const batch = rows.slice(i, i + CONCURRENCY);
      const settled = await Promise.all(
        batch.map(async (r) => {
          const p = await probeOne(r.host);
          await updateDnsStatus(r.host, p).catch(() => null);
          return { host: r.host, ...p };
        })
      );
      for (const s of settled) resultMap.set(s.host, s);
    }
    items = rows.map((r) => {
      const p = resultMap.get(r.host);
      return p ? { ...r, status: p.status, latencyMs: p.latencyMs, httpStatus: p.httpStatus, checkedAt: /* @__PURE__ */ new Date() } : r;
    });
  } else {
    items = rows;
  }
  if (shouldProbe) invalidateCache("dns:");
  const online = items.filter((r) => r.status === "online").length;
  const checked = items.map((r) => r.checkedAt ? new Date(r.checkedAt).getTime() : 0).reduce((a, b) => Math.max(a, b), 0);
  return {
    total: items.length,
    online,
    offline: items.length - online,
    checkedAt: checked ? new Date(checked).toISOString() : null,
    probed: Boolean(shouldProbe),
    source,
    zoneCount,
    cfError,
    cfConfigured: Boolean(token && zones.length),
    items
  };
});

export { dns_get as default };
//# sourceMappingURL=dns.get.mjs.map
