import { c as defineEventHandler, f as appConfig, h as getQuery, x as dayKeyOf, D as isValidDayKey, n as setHeader, w as withCache, E as getDayRepos, F as listDays, G as relativeTime, y as humanDay } from '../../_/nitro.mjs';
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

const trending_get = defineEventHandler(async (event) => {
  const cfg = appConfig();
  const query = getQuery(event);
  const today = dayKeyOf(/* @__PURE__ */ new Date(), cfg.timezone);
  const date = isValidDayKey(query.date) ? query.date : today;
  const rawPage = Number(query.page);
  const page = Number.isFinite(rawPage) && rawPage >= 1 ? Math.floor(rawPage) : 1;
  const periodRaw = String(query.period || "daily").toLowerCase();
  const period = ["daily", "weekly", "monthly"].includes(periodRaw) ? periodRaw : "daily";
  const rawPageSize = Number(query.pageSize);
  const pageSize = Math.min(
    Math.max(Number.isFinite(rawPageSize) && rawPageSize > 0 ? Math.floor(rawPageSize) : cfg.pageSize, 1),
    50
  );
  setHeader(event, "Cache-Control", "public, max-age=30, stale-while-revalidate=120");
  const payload = await withCache(
    `trending:${date}:${period}:${page}:${pageSize}`,
    65 * 6e4,
    async () => {
      const [docs, days] = await Promise.all([getDayRepos(date, period), listDays(60, period)]);
      const total = docs.length;
      const topCount = docs.filter((d) => d.bucket === 0).length;
      const droppedCount = docs.filter((d) => d.dropped).length;
      const totalTodayStars = docs.reduce((s, d) => s + (d.todayStars || 0), 0);
      const latest = docs.reduce((max, d) => {
        var _a, _b;
        return Math.max(max, (_b = (_a = d.lastSeenAt) == null ? void 0 : _a.getTime()) != null ? _b : 0);
      }, 0);
      const updatedAt = latest ? new Date(latest) : null;
      const items = docs.slice((page - 1) * pageSize, page * pageSize).map(toView);
      return {
        date,
        period,
        humanDate: humanDay(date, cfg.timezone),
        isToday: date === today,
        page,
        pageSize,
        total,
        totalPages: Math.max(1, Math.ceil(total / pageSize)),
        updatedAt: updatedAt ? updatedAt.toISOString() : null,
        updatedAgo: updatedAt ? relativeTime(updatedAt) : "\u6682\u65E0\u6570\u636E",
        topN: cfg.topN,
        items,
        days,
        stats: {
          tracked: total,
          topCount,
          droppedCount,
          totalTodayStars
        }
      };
    }
  );
  if (payload.total === 0) {
    setHeader(event, "X-Trending-Empty", "1");
  }
  return payload;
});
function toView(doc) {
  var _a, _b, _c, _d, _e;
  return {
    rank: (_a = doc.rank) != null ? _a : null,
    owner: doc.owner,
    name: doc.name,
    fullName: doc.fullName,
    url: doc.url,
    description: doc.description || "",
    language: doc.language || "Unknown",
    languageColor: doc.languageColor || "#8b949e",
    totalStars: (_b = doc.totalStars) != null ? _b : 0,
    forks: (_c = doc.forks) != null ? _c : 0,
    todayStars: (_d = doc.todayStars) != null ? _d : 0,
    bucket: (_e = doc.bucket) != null ? _e : 0,
    dropped: Boolean(doc.dropped),
    firstSeenAt: doc.firstSeenAt ? new Date(doc.firstSeenAt).toISOString() : null,
    lastSeenAt: doc.lastSeenAt ? new Date(doc.lastSeenAt).toISOString() : null
  };
}

export { trending_get as default };
//# sourceMappingURL=trending.get.mjs.map
