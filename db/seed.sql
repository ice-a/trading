-- ============================================================
-- 瞭望台 · 种子数据（可选，幂等）
-- 应用方式：npm run db:seed（远程：REMOTE=1 npm run db:seed）
--
-- 功能裁剪后只剩 DNS 看板需要初始记录：配了 CF_API_TOKEN + CF_ZONE_IDS
-- 的话 /dns 会自己从 Cloudflare 拉，这里只放一条示例，方便没配 token 时看效果。
-- ============================================================

-- 汇率初始值（1 外币 = ? 人民币），可在 /stack 页面里随时改
insert or replace into fx_rates (currency, cny_rate, updated_at) values
  ('CNY', 1,      datetime('now')),
  ('HKD', 0.92,   datetime('now')),
  ('USD', 7.2,    datetime('now'));