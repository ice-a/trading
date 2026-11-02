#!/usr/bin/env bash
#
# 本地构建 → 同步到 1C1G 服务器 → pm2 重载 → 健康检查
#
# 用法：
#   HOST=root@1.2.3.4 ./deploy/deploy.sh
#   HOST=root@1.2.3.4 APP_DIR=/srv/liaowangtai ./deploy/deploy.sh
#
# 为什么在本地构建：nuxt build 峰值内存 1.2~1.8GB，1C1G 的机器会 OOM。
# 只把 .output（≈5MB）传过去，服务器上永远不跑构建。
set -euo pipefail

HOST="${HOST:?用法: HOST=user@host ./deploy/deploy.sh}"
APP_DIR="${APP_DIR:-/opt/liaowangtai}"
PORT="${PORT:-3000}"
PM2_APP="${PM2_APP:-liaowangtai}"

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
rsync -az deploy/ecosystem.config.cjs "$HOST:$APP_DIR/ecosystem.config.cjs"

echo "→ [3/5] 首次初始化（已存在则跳过）"
# .output 是自包含的（自带 38 个生产依赖），服务器不需要 npm install；
# db-cli 只用 Node 内置模块，所以直接 node 执行，不依赖 npm scripts
ssh "$HOST" "cd '$APP_DIR' && test -f data/app.db || (node scripts/db-cli.mjs init && node scripts/db-cli.mjs seed)"

echo "→ [4/5] pm2 重载"
# startOrReload：进程不存在就启动，存在就原子重载（fork 模式下等价于优雅 restart）
ssh "$HOST" "cd '$APP_DIR' && pm2 startOrReload ecosystem.config.cjs && pm2 save"

echo "→ [5/5] 健康检查"
sleep 3
for i in 1 2 3 4 5; do
  if ssh "$HOST" "curl -fsS http://127.0.0.1:$PORT/api/health"; then
    echo
    echo "✓ 部署完成"
    echo "  查看日志：ssh $HOST 'pm2 logs $PM2_APP --lines 60'"
    exit 0
  fi
  echo "  第 $i 次还没起来，等 3 秒…"
  sleep 3
done

echo "✗ 健康检查失败，看日志："
echo "  ssh $HOST 'pm2 logs $PM2_APP --err'"
echo "  ssh $HOST 'pm2 describe $PM2_APP'"
exit 1