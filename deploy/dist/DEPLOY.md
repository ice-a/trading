# 服务器部署（构建产物分支 dist）

这个分支**只放编译好的产物**，没有源码。服务器不需要 `npm install`、不需要 `npm run build`。

产物自包含：`.output` 里已经带了 38 个生产依赖。

---

## 首次部署

```bash
sudo mkdir -p /opt/liaowangtai && sudo chown $USER:$USER /opt/liaowangtai
git clone -b dist https://github.com/ice-a/trading.git /opt/liaowangtai
cd /opt/liaowangtai

cp .env.example .env          # 按需改 PORT / DB_PATH / ADMIN_PASSWORD

node scripts/db-cli.mjs init  # 建表
node scripts/db-cli.mjs seed  # 可选：导航 / AI 种子数据

npm i -g pm2
pm2 start deploy/ecosystem.config.cjs
pm2 save
pm2 startup                   # 执行它输出的那条 sudo 命令

# Caddy（改域名）
sudo cp deploy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

验证：

```bash
curl -s http://127.0.0.1:3000/api/health
```

期望看到 `"ok":true,"storage":"sqlite"`。

---

## 更新版本

```bash
cd /opt/liaowangtai
./update.sh
```

`update.sh` 做三件事：拉最新产物 → 覆盖本地 → `pm2 restart`。
`data/` 与 `.env` 在 `.gitignore` 里，不会被覆盖。

---

## 注意

- **单实例**：SQLite 单文件单连接，不要改 `ecosystem.config.cjs` 里的 `instances` 或 `exec_mode`
- **端口**：应用只听 `127.0.0.1:3000`，公网入口走 Caddy
- **抓取**：进程内定时器，启动抓一轮 + 每 60 分钟；`pm2 logs liaowangtai` 看日志
- **备份**：`node scripts/db-cli.mjs info` 看库状态；备份脚本在 master 分支的 `scripts/backup-db.mjs`

---

## 只想要源码？

```bash
git clone https://github.com/ice-a/trading.git   # master 分支：源码 + 部署配置
```

master 分支没有 `.output`，需要本地构建后 `HOST=user@host ./deploy/deploy.sh` 推产物，
或者本地跑 `./scripts/publish-dist.sh` 重新生成这个分支。