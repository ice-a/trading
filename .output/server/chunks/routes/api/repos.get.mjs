import { c as defineEventHandler, h as getQuery, n as setHeader, w as withCache, k as env, p as httpFetch } from '../../_/nitro.mjs';
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

const repos_get = defineEventHandler(async (event) => {
  const q = getQuery(event);
  const user = String(q.user || "ice-a").trim();
  const keyword = String(q.q || "").trim().toLowerCase();
  const sort = ["pushed", "updated", "stars", "name"].includes(String(q.sort)) ? String(q.sort) : "pushed";
  setHeader(event, "Cache-Control", "public, max-age=300, stale-while-revalidate=600");
  return withCache(`repos:${user}:${sort}`, 10 * 6e4, async () => {
    const headers = {
      Accept: "application/vnd.github+json",
      "User-Agent": "github-trending-daily"
    };
    const token = env("GITHUB_TOKEN", "");
    if (token) headers.Authorization = `Bearer ${token}`;
    let repos = [];
    let error = null;
    try {
      const res = await httpFetch(
        `https://api.github.com/users/${encodeURIComponent(user)}/repos?per_page=100&sort=${sort}`,
        { headers }
      );
      if (res.ok) {
        repos = await res.json();
      } else if (res.status === 403 || res.status === 429) {
        error = "GitHub API \u5DF2\u8FBE\u9650\u6D41\u4E0A\u9650\uFF0C\u8BF7\u914D\u7F6E GITHUB_TOKEN \u6216\u7A0D\u540E\u518D\u8BD5";
      } else {
        error = `GitHub API \u8FD4\u56DE ${res.status}`;
      }
    } catch (err) {
      error = err instanceof Error ? err.message : String(err);
    }
    let list = repos.filter((r) => !r.archived);
    if (keyword) {
      list = list.filter(
        (r) => r.name.toLowerCase().includes(keyword) || (r.description || "").toLowerCase().includes(keyword) || (r.language || "").toLowerCase().includes(keyword) || (r.topics || []).some((t) => t.toLowerCase().includes(keyword))
      );
    }
    if (sort === "stars") list = [...list].sort((a, b) => b.stargazers_count - a.stargazers_count);
    return {
      user,
      total: list.length,
      error,
      items: list.map((r) => ({
        name: r.name,
        fullName: r.full_name,
        url: r.html_url,
        desc: r.description || "",
        language: r.language || "",
        stars: r.stargazers_count,
        forks: r.forks_count,
        fork: r.fork,
        pushedAt: r.pushed_at,
        topics: (r.topics || []).slice(0, 4)
      }))
    };
  });
});

export { repos_get as default };
//# sourceMappingURL=repos.get.mjs.map
