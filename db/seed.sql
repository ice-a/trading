-- ============================================================
-- 瞭望台 · 种子数据（可选）
--
-- 用途：新库灌完 schema 后，让 /nav /ai 页面立刻有内容，
--       不必等抓取、也不必先登录 /admin 一条条录。
-- 应用：
--   npm run db:seed
-- 幂等：全部使用 insert or replace，重复执行不会报错。
-- ============================================================

-- ---------- 导航分类 ----------
insert or replace into nav_categories (key, name, grp, icon, sort, status) values
  ('dev',       '开发工具',     '技术',   '🛠',  1, 'active'),
  ('docs',      '文档手册',     '技术',   '📚', 2, 'active'),
  ('ai',        'AI 工具',      'AI',     '🤖', 3, 'active'),
  ('design',    '设计资源',     '设计',   '🎨', 4, 'active'),
  ('media',     '影音娱乐',     '生活',   '🎬', 5, 'active'),
  ('study',     '学习成长',     '生活',   '📖', 6, 'active'),
  ('ops',       '运维监控',     '技术',   '📈', 7, 'active'),
  ('misc',      '杂项',         '其他',   '📦', 8, 'active');

-- ---------- 导航站点 ----------
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status) values
  ('GitHub',            'https://github.com',                 'dev',    '技术', '代码托管与协作',              '🐙', 1,  'active'),
  ('GitHub Trending',   'https://github.com/trending',        'dev',    '技术', '每日热门仓库',                '📈', 2,  'active'),
  ('GitLab',            'https://gitlab.com',                 'dev',    '技术', '代码托管',                    '🦊', 3,  'active'),
  ('MDN',               'https://developer.mozilla.org',      'docs',   '技术', 'Web 技术权威文档',            '📘', 1,  'active'),
  ('Node.js Docs',      'https://nodejs.org/docs',            'docs',   '技术', 'Node 官方文档',               '🟩', 2,  'active'),
  ('Vue 3 Docs',        'https://cn.vuejs.org',               'docs',   '技术', 'Vue 中文文档',                '💚', 3,  'active'),
  ('Nuxt Docs',         'https://nuxt.com/docs',              'docs',   '技术', 'Nuxt 官方文档',               '🏔',  4,  'active'),
  ('Cloudflare Docs',   'https://developers.cloudflare.com',  'docs',   '技术', 'Workers / 边缘计算文档',           '🟠', 5,  'active'),
  ('SQLite Docs',       'https://sqlite.org/docs.html',       'docs',   '技术', 'SQLite 语法手册',            '🗄',  6,  'active'),
  ('ChatGPT',           'https://chat.openai.com',            'ai',     'AI',   '对话模型',                    '💬', 1,  'active'),
  ('Claude',            'https://claude.ai',                  'ai',     'AI',   '长文本对话',                  '🧡', 2,  'active'),
  ('Gemini',            'https://gemini.google.com',          'ai',     'AI',   'Google 多模态',               '✨', 3,  'active'),
  ('Hugging Face',      'https://huggingface.co',             'ai',     'AI',   '模型与数据集',                '🤗', 4,  'active'),
  ('OpenRouter',        'https://openrouter.ai',              'ai',     'AI',   '多模型统一网关',              '🔀', 5,  'active'),
  ('Figma',             'https://figma.com',                  'design', '设计', '界面设计',                    '🎨', 1,  'active'),
  ('Coolors',           'https://coolors.co',                 'design', '设计', '配色生成',                    '🌈', 2,  'active'),
  ('Unsplash',          'https://unsplash.com',               'design', '设计', '免费高清图库',                '📷', 3,  'active'),
  ('Bilibili',          'https://www.bilibili.com',           'media',  '生活', '视频社区',                    '📺', 1,  'active'),
  ('YouTube',           'https://www.youtube.com',            'media',  '生活', '视频平台',                    '▶️', 2,  'active'),
  ('网易云音乐',         'https://music.163.com',              'media',  '生活', '音乐',                        '🎵', 3,  'active'),
  ('豆瓣',              'https://www.douban.com',             'media',  '生活', '书影音标记',                  '📚', 4,  'active'),
  ('知乎',              'https://www.zhihu.com',              'study',  '生活', '问答社区',                    '❓', 1,  'active'),
  ('少数派',            'https://sspai.com',                  'study',  '生活', '效率与工具',                  '✍️', 2,  'active'),
  ('arXiv',             'https://arxiv.org',                  'study',  '生活', '预印本论文',                  '📄', 3,  'active'),
  ('Cloudflare Dashboard', 'https://dash.cloudflare.com',     'ops',    '技术', '域名与边缘服务',         '☁️', 1,  'active'),
  ('Workers Status',    'https://www.cloudflarestatus.com',   'ops',    '技术', 'Cloudflare 状态页',           '🩺', 2,  'active'),
  ('Cron 表达式',        'https://crontab.guru',               'ops',    '技术', '定时表达式校验',              '⏰', 3,  'active'),
  ('Can I Use',         'https://caniuse.com',                'misc',   '其他', '浏览器兼容性',                '🧪', 1,  'active'),
  ('Regex101',          'https://regex101.com',               'misc',   '其他', '正则调试',                    '🔍', 2,  'active'),
  ('JSON Formatter',    'https://jsonformatter.org',          'misc',   '其他', 'JSON 格式化',                 '🧾', 3,  'active');

-- ---------- AI 板块 ----------
insert or replace into ai_boards (key, name, icon, sort, status) values
  ('chat',   '对话模型',   '💬', 1, 'active'),
  ('image',  '图像生成',   '🖼', 2, 'active'),
  ('code',   '编程助手',   '⌨️', 3, 'active'),
  ('audio',  '语音音频',   '🎧', 4, 'active'),
  ('video',  '视频生成',   '🎬', 5, 'active'),
  ('tutorial','使用教程',  '📘', 6, 'active');

-- ---------- AI 资源 ----------
insert or replace into ai_items (board, name, url, descr, models, ratio, tags, content, sort, status) values
  ('chat', 'ChatGPT',      'https://chat.openai.com', '通用对话，插件生态成熟',        'GPT 系列',  '-',       '["对话","通用"]', '', 1, 'active'),
  ('chat', 'Claude',       'https://claude.ai',       '长上下文与代码阅读体验好',      'Claude',    '-',       '["对话","长文本"]', '', 2, 'active'),
  ('chat', 'Gemini',       'https://gemini.google.com','多模态，图片理解强',            'Gemini',    '-',       '["对话","多模态"]', '', 3, 'active'),
  ('image', 'Midjourney',  'https://midjourney.com',  '风格化出图，社区素材多',        'MJ',        '-',       '["出图","艺术"]', '', 1, 'active'),
  ('image', 'Stable Diffusion', 'https://stability.ai', '本地可跑，可控性最高',        'SD 系列',   '-',       '["出图","本地"]', '', 2, 'active'),
  ('code', 'GitHub Copilot','https://github.com/features/copilot', 'IDE 内补全与对话',    'Codex',     '-',       '["补全","IDE"]', '', 1, 'active'),
  ('code', 'Cursor',       'https://cursor.com',       'AI 优先的编辑器',              '多模型',    '-',       '["IDE","重构"]', '', 2, 'active'),
  ('audio', 'ElevenLabs',  'https://elevenlabs.io',    '语音克隆与配音',                'EL',        '-',       '["TTS","克隆"]', '', 1, 'active'),
  ('video', 'Runway',      'https://runwayml.com',     '文生视频与视频编辑',            'Gen 系列',  '-',       '["视频","生成"]', '', 1, 'active'),
  ('tutorial','SQLite 入门', 'https://sqlite.org/lang.html', '本项目用的数据库，纯 SQL 语法', '—', '-', '["SQLite","SQL"]',
    '# SQLite 速览

- 单文件数据库：零服务、零端口、零账号
- 语法是标准 SQL 的子集，查询直接走索引
- 本项目用 Node 内置 node:sqlite 驱动，不需要 node-gyp 编译
- WAL 模式下读不阻塞写，抓取时页面照样能翻
- 本地查看：sqlite3 data/app.db', 1, 'active');

-- ---------- 关注列表 ----------
insert or replace into github_creators (login, note, sort) values
  ('ice-a',  '站长',        1),
  ('nuxt',   'Nuxt 官方',   2),
  ('vuejs',  'Vue 官方',    3);