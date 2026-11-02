#!/usr/bin/env bash
#
# Turso 一键初始化（Vercel 部署用）
#
# 做四件事：
#   1. 检查 turso CLI 与登录状态
#   2. 建库（已存在则复用）
#   3. 取 URL、生成 access token，并就地执行 db/schema.sql + db/seed.sql
#   4. 打印要填到 Vercel 的环境变量清单
#
# 用法：
#   ./scripts/init-turso.sh
#   DB_NAME=my-db ./scripts/init-turso.sh
#
set -euo pipefail

DB_NAME="${DB_NAME:-liaowangtai}"
cd "$(dirname "$0")/.."

echo "→ 目标库：$DB_NAME"

# ---------- 1. 前置检查 ----------
if ! command -v turso >/dev/null 2>&1; then
  echo "✗ 没装 turso CLI。先执行："
  echo "    curl -sSfL https://get.tur.so/install.sh | bash"
  exit 1
fi

if ! turso auth whoami >/dev/null 2>&1; then
  echo "✗ 未登录。先执行：turso auth signup   （或 turso auth login）"
  exit 1
fi
echo "✓ turso CLI 就绪（$(turso auth whoami 2>/dev/null | head -1)）"

# ---------- 2. 建库（幂等） ----------
if turso db show "$DB_NAME" >/dev/null 2>&1; then
  echo "✓ 库已存在，复用"
else
  echo "→ 创建库 $DB_NAME"
  turso db create "$DB_NAME"
fi

# ---------- 3. 取凭据 ----------
DB_URL="$(turso db show "$DB_NAME" --url)"
echo "→ URL: $DB_URL"

# 已有 token 优先复用（.env 里配过的）
if [ -f .env ]; then
  EXISTING_TOKEN="$(grep -E '^TURSO_AUTH_TOKEN=' .env 2>/dev/null | cut -d= -f2- || true)"
else
  EXISTING_TOKEN=""
fi

if [ -n "${EXISTING_TOKEN:-}" ]; then
  TOKEN="$EXISTING_TOKEN"
  echo "✓ 复用 .env 里的 TURSO_AUTH_TOKEN"
else
  echo "→ 生成 access token"
  TOKEN="$(turso db tokens create "$DB_NAME")"
fi

# ---------- 4. 建表 + 种子 ----------
echo "→ 应用 schema"
TURSO_DATABASE_URL="$DB_URL" TURSO_AUTH_TOKEN="$TOKEN" node scripts/db-cli.mjs init

echo "→ 应用 seed（可选数据，幂等）"
TURSO_DATABASE_URL="$DB_URL" TURSO_AUTH_TOKEN="$TOKEN" node scripts/db-cli.mjs seed || true

# ---------- 5. 写回本地 .env（方便本地跑 db:info 之类） ----------
if [ -f .env ]; then
  python3 - "$DB_URL" "$TOKEN" <<'PY' 2>/dev/null || true
import io, re, sys
url, token = sys.argv[1], sys.argv[2]
p = '.env'
s = io.open(p, encoding='utf-8').read()
s = re.sub(r'(?m)^TURSO_DATABASE_URL=.*$', 'TURSO_DATABASE_URL=' + url, s)
if 'TURSO_DATABASE_URL=' not in s:
    s += '\nTURSO_DATABASE_URL=' + url + '\n'
s = re.sub(r'(?m)^TURSO_AUTH_TOKEN=.*$', 'TURSO_AUTH_TOKEN=' + token, s)
if 'TURSO_AUTH_TOKEN=' not in s:
    s += 'TURSO_AUTH_TOKEN=' + token + '\n'
io.open(p, 'w', encoding='utf-8', newline='\n').write(s)
print('✓ 已写回 .env')
PY
fi

# ---------- 6. 打印 Vercel 环境变量 ----------
CRON_SECRET="${CRON_SECRET:-$(node -e "console.log(require('crypto').randomBytes(24).toString('hex'))")}"

cat <<EOF

────────────────────────────────────────────────────────
去 Vercel → Project Settings → Environment Variables 填这三条：

TURSO_DATABASE_URL=$DB_URL
TURSO_AUTH_TOKEN=$TOKEN
CRON_SECRET=$CRON_SECRET

生产环境也勾上（Production），加完必须 Redeploy 一次。

复制项目仓库里还要加两条（用于每小时抓取）：
  Repository variable  APP_URL       = https://<你的域名>
  Repository secret    CRON_TOKEN    = $CRON_SECRET

验证（部署完成后）：
  curl https://<你的域名>/api/health
  期望 "storage":"libsql","db":{"mode":"remote"}

第一次灌数据：
  curl -X POST "https://<你的域名>/api/crawl?token=\$CRON_TOKEN" \\
    -H "Authorization: Bearer \$CRON_SECRET"
────────────────────────────────────────────────────────
EOF

echo
echo "✓ 完成。token 只在这里显示一次，记得先存进 Vercel 再关终端。"