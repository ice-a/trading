#!/usr/bin/env bash
# 服务器端更新：拉最新产物 → 重启
set -euo pipefail
cd "$(dirname "$0")"

echo "→ 拉取最新产物"
git fetch --depth=1 origin dist
git reset --hard origin/dist

echo "→ 重启 pm2"
pm2 restart liaowangtai

echo "→ 健康检查"
sleep 2
for i in 1 2 3 4 5; do
  if curl -fsS http://127.0.0.1:3000/api/health; then
    echo
    echo "✓ 更新完成"
    exit 0
  fi
  sleep 3
done

echo "✗ 健康检查失败：pm2 logs liaowangtai --err"
exit 1