-- ============================================================
-- 瞭望台 · 种子数据（可选，幂等）
-- 应用方式：npm run db:seed（远程：REMOTE=1 npm run db:seed）
--
-- 功能裁剪后只剩 DNS 看板需要初始记录：配了 CF_API_TOKEN + CF_ZONE_IDS
-- 的话 /dns 会自己从 Cloudflare 拉，这里只放一条示例，方便没配 token 时看效果。
-- ============================================================

insert or replace into dns_records (host, name, type, target, proxied, status, latency_ms, http_status, checked_at)
values ('example.com', 'example.com', 'A', '127.0.0.1', 1, 'unknown', 0, 0, null);