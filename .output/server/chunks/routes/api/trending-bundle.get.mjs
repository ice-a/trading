import { c as defineEventHandler, f as appConfig, h as getQuery, x as dayKeyOf, D as isValidDayKey, n as setHeader, w as withCache, E as getDayRepos, F as listDays, y as humanDay, G as relativeTime } from '../../_/nitro.mjs';
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

const trendingBundle_get = defineEventHandler(async (event) => {
  const cfg = appConfig();
  const query = getQuery(event);
  const today = dayKeyOf(/* @__PURE__ */ new Date(), cfg.timezone);
  const date = isValidDayKey(query.date) ? query.date : today;
  const rawPageSize = Number(query.pageSize);
  const pageSize = Math.min(
    Math.max(Number.isFinite(rawPageSize) && rawPageSize > 0 ? Math.floor(rawPageSize) : cfg.pageSize, 1),
    50
  );
  setHeader(event, "Cache-Control", "public, max-age=60, stale-while-revalidate=300");
  return withCache(`trending-bundle:${date}:${pageSize}`, 10 * 6e4, async () => {
    const [daily, weekly, monthly, days] = await Promise.all([
      getDayRepos(date, "daily"),
      getDayRepos(date, "weekly"),
      getDayRepos(date, "monthly"),
      listDays(60)
    ]);
    const grouped = { daily, weekly, monthly };
    const build = (p) => {
      var _a;
      const docs = (_a = grouped[p]) != null ? _a : [];
      const topCount = docs.filter((d) => d.bucket === 0).length;
      const latest = docs.reduce((max, d) => {
        var _a2, _b;
        return Math.max(max, (_b = (_a2 = d.lastSeenAt) == null ? void 0 : _a2.getTime()) != null ? _b : 0);
      }, 0);
      const updatedAt = latest ? new Date(latest) : null;
      return {
        date,
        period: p,
        humanDate: humanDay(date, cfg.timezone),
        isToday: date === today,
        page: 1,
        pageSize,
        total: docs.length,
        totalPages: Math.max(1, Math.ceil(topCount / pageSize)),
        updatedAt: updatedAt ? updatedAt.toISOString() : null,
        updatedAgo: updatedAt ? relativeTime(updatedAt) : "\u6682\u65E0\u6570\u636E",
        topN: cfg.topN,
        days,
        stats: {
          tracked: docs.length,
          topCount,
          droppedCount: docs.filter((d) => d.dropped).length,
          totalTodayStars: docs.reduce((s, d) => s + (d.todayStars || 0), 0)
        },
        items: docs.filter((d) => d.bucket === 0).slice(0, pageSize).map(toView)
      };
    };
    return {
      date,
      humanDate: humanDay(date, cfg.timezone),
      isToday: date === today,
      pageSize,
      daily: build("daily"),
      weekly: build("weekly"),
      monthly: build("monthly")
    };
  });
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

export { trendingBundle_get as default };
//# sourceMappingURL=trending-bundle.get.mjs.map
