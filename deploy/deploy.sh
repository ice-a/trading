#!/usr/bin/env bash
#
# 本地构建 → 同步到 512M/1G 服务器 → systemd 重载 → 健康检查
#
# 用法：
#   HOST=root@1.2.3.4 ./deploy/deploy.sh
#   HOST=root@1.2.3.4 APP_DIR=/srv/liaowangtai ./deploy/deploy.sh
#
# 为什么在本地构建：nuxt build 峰值内存 1.2~1.8GB，小机器会 OOM。
# 只把 .output（几 MB）传过去，服务器上永远不跑构建、不装 npm 依赖。
set -euo pipefail

HOST="${HOST:?用法: HOST=user@host ./deploy/deploy.sh}"
APP_DIR="${APP_DIR:-/opt/liaowangtai}"
PORT="${PORT:-3000}"
SERVICE=liaowangtai

cd "$(dirname "$0")/.."

echo "→ [1/5] 本地构建"
npm run build

echo "→ [2/5] 同步产物到 $HOST:$APP_DIR"
ssh "$HOST" "mkdir -p '$APP_DIR/data'"
# .output 整体替换；data/ 在服务器上，不受影响
rsync -az --delete .output/ "$HOST:$APP_DIR/.output/"
# 部署配置与 schema/seed 也带上，方便服务器上直接 db:init
rsync -az db/ "$HOST:$APP_DIR/db/"
rsync -az scripts/db-cli.mjs "$HOST:$APP_DIR/scripts/db-cli.mjs"
rsync -az deploy/liaowangtai.systemd.service "$HOST:$APP_DIR/liaowangtai.service"

echo "→ [3/5] 首次初始化（已存在则跳过）"
# .output 自包含；db-cli 只用 Node 内置模块，直接 node 执行
ssh "$HOST" "cd '$APP_DIR' && test -f data/app.db || (node scripts/db-cli.mjs init && node scripts/db-cli.mjs seed)"

echo "→ [4/5] systemd 重载"
ssh "$HOST" "install -m 644 '$APP_DIR/liaowangtai.service' /etc/systemd/system/liaowangtai.service && \
  systemctl daemon-reload && \
  systemctl enable '$SERVICE' && \
  (systemctl is-active --quiet '$SERVICE' && systemctl restart '$SERVICE' || systemctl start '$SERVICE')"

echo "→ [5/5] 健康检查"
sleep 3
for i in 1 2 3 4 5; do
  if ssh "$HOST" "curl -fsS http://127.0.0.1:$PORT/api/health"; then
    echo
    echo "✓ 部署完成"
    echo "  查看日志：ssh $HOST 'journalctl -u $SERVICE -n 60 --no-pager'"
    exit 0
  fi
  echo "  第 $i 次还没起来，等 3 秒…"
  sleep 3
done

echo "✗ 健康检查失败，看日志："
echo "  ssh $HOST 'journalctl -u $SERVICE -n 100 --no-pager'"
exit 1
