import { c as defineEventHandler, f as appConfig, x as dayKeyOf, h as getQuery, n as setHeader, w as withCache, m as sqlAll, y as humanDay } from '../../_/nitro.mjs';
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

const history_get = defineEventHandler(async (event) => {
  const cfg = appConfig();
  const today = dayKeyOf(/* @__PURE__ */ new Date(), cfg.timezone);
  const q = getQuery(event);
  const periodRaw = String(q.period || "daily").toLowerCase();
  const period = ["daily", "weekly", "monthly"].includes(periodRaw) ? periodRaw : "daily";
  setHeader(event, "Cache-Control", "public, max-age=30, stale-while-revalidate=120");
  return withCache("history:overview:" + period, 65 * 6e4, async () => {
    const rows = await sqlAll(
      `select
         t.date,
         count(*) as count,
         sum(t.dropped) as dropped_count,
         sum(t.today_stars) as total_today_stars,
         max(t.last_seen_at) as last_seen,
         (select full_name from trending_repos x
            where x.date = t.date and x.period = t.period
            order by x.bucket asc, x.rank asc limit 1) as top_repo,
         (select today_stars from trending_repos x
            where x.date = t.date and x.period = t.period
            order by x.bucket asc, x.rank asc limit 1) as top_stars
       from trending_repos t
       where t.period = ?
       group by t.date, t.period
       order by t.date desc
       limit 180`,
      [period]
    );
    const days = rows.map((r) => {
      var _a, _b, _c, _d;
      return {
        date: r.date,
        label: humanDay(r.date, cfg.timezone),
        isToday: r.date === today,
        count: (_a = r.count) != null ? _a : 0,
        droppedCount: (_b = r.dropped_count) != null ? _b : 0,
        totalTodayStars: (_c = r.total_today_stars) != null ? _c : 0,
        topRepo: r.top_repo || "",
        topStars: (_d = r.top_stars) != null ? _d : 0,
        lastSeenAt: r.last_seen || null
      };
    });
    return {
      today,
      period,
      totalDays: days.length,
      totalRepos: days.reduce((s, d) => s + d.count, 0),
      days
    };
  });
});

export { history_get as default };
//# sourceMappingURL=history.get.mjs.map
