import { c as defineEventHandler, h as getQuery, e as setResponseStatus, i as getHeader, k as env, n as setHeader, w as withCache, p as httpFetch } from '../../_/nitro.mjs';
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

const MAX_WAIT_MS = 4e3;
const MAX_ATTEMPTS = 3;
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const githubSearch_get = defineEventHandler(async (event) => {
  const q = getQuery(event);
  const keyword = String(q.q || "").trim();
  const sort = ["stars", "forks", "updated"].includes(String(q.sort)) ? String(q.sort) : "stars";
  const order = String(q.order) === "asc" ? "asc" : "desc";
  const page = Math.max(1, Number(q.page) || 1);
  const perPage = Math.min(Math.max(Number(q.perPage) || 30, 1), 50);
  if (!keyword) {
    setResponseStatus(event, 400);
    return { ok: false, error: "\u8BF7\u8F93\u5165\u641C\u7D22\u5173\u952E\u8BCD", total: 0, items: [] };
  }
  const userToken = String(getHeader(event, "x-github-token") || "").trim();
  const serverToken = env("GITHUB_TOKEN", "");
  let token = userToken || serverToken;
  let tokenSource = userToken ? "user" : serverToken ? "server" : "anonymous";
  setHeader(event, "Cache-Control", "public, max-age=120, stale-while-revalidate=600");
  return withCache(`gh-search:${keyword}:${sort}:${order}:${page}:${perPage}`, 5 * 6e4, async () => {
    var _a, _b;
    const url = "https://api.github.com/search/repositories?q=" + encodeURIComponent(keyword) + `&sort=${sort}&order=${order}&page=${page}&per_page=${perPage}`;
    const headers = {
      Accept: "application/vnd.github+json",
      "User-Agent": "liaowangtai/1.0"
    };
    const applyAuth = () => {
      if (token) headers.Authorization = `Bearer ${token}`;
      else delete headers.Authorization;
    };
    applyAuth();
    let lastRes = null;
    let waited = 0;
    for (let attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
      try {
        const res = await httpFetch(url, {
          headers,
          redirect: "follow",
          signal: AbortSignal.timeout(12e3)
        });
        if (res.ok) {
          const json = await res.json();
          const items = ((_a = json.items) != null ? _a : []).filter((r) => !r.archived);
          return {
            ok: true,
            error: null,
            keyword,
            total: (_b = json.total_count) != null ? _b : 0,
            page,
            perPage,
            tokenSource,
            waitedMs: waited,
            incomplete: Boolean(json.incomplete_results),
            items: items.map((r) => {
              var _a2, _b2, _c;
              const owner = ((_a2 = r.owner) == null ? void 0 : _a2.login) || r.full_name.split("/")[0] || "";
              const name = r.name || r.full_name.split("/")[1] || "";
              return {
                name,
                fullName: `${owner}/${name}`,
                url: r.html_url,
                desc: r.description || "",
                language: r.language || "",
                stars: (_b2 = r.stargazers_count) != null ? _b2 : 0,
                forks: (_c = r.forks_count) != null ? _c : 0,
                fork: Boolean(r.fork),
                pushedAt: r.pushed_at || r.updated_at || "",
                topics: (r.topics || []).slice(0, 4)
              };
            })
          };
        }
        lastRes = res;
        if ((res.status === 401 || res.status === 403) && tokenSource === "user") {
          token = serverToken;
          tokenSource = serverToken ? "server" : "anonymous";
          applyAuth();
          if (attempt < MAX_ATTEMPTS) {
            await sleep(300);
            continue;
          }
        }
        const isRateLimit = res.status === 403 || res.status === 429;
        if (!isRateLimit) {
          return {
            ok: false,
            error: `GitHub \u8FD4\u56DE HTTP ${res.status}`,
            total: 0,
            keyword,
            items: [],
            tokenSource
          };
        }
        if (attempt === MAX_ATTEMPTS) break;
        const resetSec2 = Number(res.headers.get("x-ratelimit-reset") || 0);
        const untilReset = resetSec2 ? resetSec2 * 1e3 - Date.now() : 0;
        const waitMs = Math.min(Math.max(untilReset, 1200), MAX_WAIT_MS);
        waited += waitMs;
        await sleep(waitMs);
      } catch (err) {
        if (attempt === MAX_ATTEMPTS) {
          return {
            ok: false,
            error: err instanceof Error ? err.message : String(err),
            total: 0,
            keyword,
            items: [],
            tokenSource
          };
        }
        await sleep(1200);
        waited += 1200;
      }
    }
    const resetSec = Number((lastRes == null ? void 0 : lastRes.headers.get("x-ratelimit-reset")) || 0);
    const resetIn = resetSec ? Math.max(0, Math.round((resetSec * 1e3 - Date.now()) / 1e3)) : null;
    return {
      ok: false,
      error: token ? "GitHub \u641C\u7D22\u914D\u989D\u5DF2\u7528\u5C3D\uFF0C\u7A0D\u540E\u518D\u8BD5" : "GitHub \u533F\u540D\u641C\u7D22\u914D\u989D\u5DF2\u7528\u5C3D\uFF0810 \u6B21/\u5206\u949F\uFF09\u3002\u586B\u5165\u81EA\u5DF1\u7684 GitHub Token \u53EF\u63D0\u5347\u5230 30 \u6B21/\u5206\u949F\uFF0C\u6216\u7A0D\u540E\u518D\u8BD5",
      total: 0,
      keyword,
      items: [],
      tokenSource,
      waitedMs: waited,
      resetIn
    };
  });
});

export { githubSearch_get as default };
//# sourceMappingURL=github-search.get.mjs.map
