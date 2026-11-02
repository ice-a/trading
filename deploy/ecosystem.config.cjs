/**
 * PM2 进程配置（1 核 1G 单机）
 *
 * 用法（服务器上）：
 *   cd /opt/liaowangtai
 *   pm2 start ecosystem.config.cjs --env production
 *   pm2 save
 *   pm2 startup            # 按提示执行它输出的那条 sudo 命令，开机自启
 *
 * 为什么必须是单实例 fork：
 *   1. SQLite 是单文件单连接，cluster 模式多进程会抢同一把写锁，
 *      表现为 `database is locked` 与抓取卡死
 *   2. 抓取定时器在进程内（setInterval），多进程会每小时重复抓 N 次
 *   3. 1 核机器跑多进程没有吞吐收益，只有上下文切换开销
 */
module.exports = {
  apps: [
    {
      name: 'liaowangtai',
      script: '.output/server/index.mjs',
      // cwd 决定 .env 与 .output 的解析位置，必须是应用根目录。
      // 换安装目录时：在启动前 export APP_DIR=/srv/liaowangtai 即可，不用改文件。
      cwd: process.env.APP_DIR || '/opt/liaowangtai',

      // ---- 单实例（见文件头说明，不要改成 cluster/多 instances）----
      instances: 1,
      exec_mode: 'fork',

      // ---- 稳定性 ----
      autorestart: true,
      max_restarts: 10,
      min_uptime: '30s',
      restart_delay: 3000,
      // 抓取可能跑 20 秒，给足优雅退出时间（Nitro 会先停定时器再退出）
      kill_timeout: 15000,
      // RSS 实测 ~84MB，抓取峰值 ~150MB；400M 兜底，超了自动重启而不是拖垮整机
      max_memory_restart: '400M',

      // 堆上限压到 320M，避免 V8 把 1G 机器吃满
      node_args: '--max-old-space-size=320',

      env: {
        NODE_ENV: 'production',
        // 只监听回环，公网入口统一走 Caddy
        HOST: '127.0.0.1',
        PORT: 3000,
        DB_PATH: process.env.DB_PATH || '/opt/liaowangtai/data/app.db',
        // 想临时关掉定时抓取可以在这里改成 false
        ENABLE_SCHEDULER: 'true'
      },

      // ---- 日志（放 data/ 下，跟备份一起管理）----
      out_file: `${process.env.APP_DIR || '/opt/liaowangtai'}/data/pm2-out.log`,
      error_file: `${process.env.APP_DIR || '/opt/liaowangtai'}/data/pm2-error.log`,
      log_date_format: 'YYYY-MM-DD HH:mm:ss',
      merge_logs: true,
      // 单文件超过 10M 自动切（需要 pm2-logrotate 模块，见 README）
      max_size: '10M'
    }
  ]
}