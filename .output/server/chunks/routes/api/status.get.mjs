import { c as defineEventHandler, f as appConfig, B as crawlState, m as sqlAll, z as readMeta, C as cacheStats, v as dbInfo } from '../../_/nitro.mjs';
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

const status_get = defineEventHandler(async () => {
  const cfg = appConfig();
  const state = crawlState();
  let recent = [];
  let meta = null;
  try {
    const rows = await sqlAll(
      "select started_at, date, ok, fetched, dropped, duration_ms, triggered_by, error from crawl_runs order by started_at desc limit 12"
    );
    recent = rows.map((d) => ({
      startedAt: d.started_at,
      date: d.date,
      ok: Boolean(d.ok),
      fetched: d.fetched,
      dropped: d.dropped,
      durationMs: d.duration_ms,
      trigger: d.triggered_by,
      error: d.error
    }));
    meta = await readMeta();
  } catch (err) {
    meta = { error: err instanceof Error ? err.message : String(err) };
  }
  return {
    scheduler: {
      intervalMinutes: cfg.updateIntervalMinutes,
      running: state.running,
      totalRuns: state.totalRuns,
      failStreak: state.failStreak,
      startedAt: state.startedAt ? new Date(state.startedAt).toISOString() : null,
      nextRunAt: state.nextRunAt ? new Date(state.nextRunAt).toISOString() : null,
      last: state.last
    },
    config: {
      timezone: cfg.timezone,
      storage: "sqlite",
      since: cfg.trendingSince,
      language: cfg.trendingLanguage || "(\u5168\u90E8)",
      topN: cfg.topN,
      pageSize: cfg.pageSize
    },
    db: dbInfo(),
    cache: cacheStats(),
    process: {
      uptimeSec: Math.round(process.uptime()),
      rssMB: Math.round(process.memoryUsage().rss / 1048576)
    },
    meta,
    recent
  };
});

export { status_get as default };
//# sourceMappingURL=status.get.mjs.map
