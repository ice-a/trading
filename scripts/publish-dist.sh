#!/usr/bin/env bash
#
# 本地构建 → 把产物推到 GitHub 的 dist 分支
#
# 用途：服务器只要 `git clone -b dist` 就能跑，不需要在 1C1G 上 build。
#
# 用法：
#   ./scripts/publish-dist.sh
#   ORIGIN=git@github.com:ice-a/trading.git ./scripts/publish-dist.sh
#
# 每次都是「新仓库 + force push」，所以 dist 分支的历史不会无限增长。
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_dir"

ORIGIN="${ORIGIN:-$(git remote get-url origin)}"
echo "→ origin: $ORIGIN"

echo "→ [1/3] 构建"
npm run build

echo "→ [2/3] 组装产物目录"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

cp -r .output db deploy "$tmp"/
mkdir -p "$tmp/scripts"
cp scripts/db-cli.mjs "$tmp/scripts/"
cp .env.example "$tmp"/

# dist 分支专用的部署说明与更新脚本
cp deploy/dist/DEPLOY.md "$tmp/DEPLOY.md"
cp deploy/dist/update.sh "$tmp/update.sh"
# dist 分支只有产物、没有 package.json：必须显式禁用 Vercel 自动部署，
# 否则 Vercel 会试着跑 nuxt build 然后 exit 127
cat > "$tmp/vercel.json" <<'JSON'
{
  "git": {
    "deploymentEnabled": false
  }
}
JSON
chmod +x "$tmp/update.sh"
cat > "$tmp/.gitignore" <<'EOF'
# 服务器本地状态，不进仓库
data/
.env
EOF

echo "→ [3/3] 推送 dist"
cd "$tmp"
git init -q -b dist
git add -A
git -c user.name="$(git -C "$repo_dir" config user.name || echo deploy)" \
    -c user.email="$(git -C "$repo_dir" config user.email || echo deploy@localhost)" \
    commit -q -m "build: $(date -u +%Y-%m-%dT%H:%M:%SZ) 单机部署产物"
git remote add origin "$ORIGIN"
git push -f origin dist

echo
echo "✓ 已推送 dist 分支"
echo "  服务器更新：ssh 到服务器后执行 ./update.sh"
echo "  首次部署：见 dist 分支的 DEPLOY.md"