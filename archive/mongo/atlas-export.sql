-- 瞭望台 Atlas → D1 迁移（生成于 2026-11-02T01:50:47.353Z）
-- 前置：先执行 cloudflare/schema.sql

insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-10-28','daily','elayadesign/ai-design-skills','elayadesign','ai-design-skills','elayadesign/ai-design-skills','https://github.com/elayadesign/ai-design-skills','','Unknown','#8b949e',10133,734,1395,1,1,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1395,"totalStars":9358,"rank":1},{"at":"2026-10-28T01:02:22.189Z","todayStars":1395,"totalStars":9358,"rank":1},{"at":"2026-10-28T01:02:57.689Z","todayStars":1395,"totalStars":9358,"rank":1},{"at":"2026-10-28T01:07:29.419Z","todayStars":1395,"totalStars":9365,"rank":1},{"at":"2026-10-28T01:15:01.443Z","todayStars":1395,"totalStars":9376,"rank":1},{"at":"2026-10-28T01:15:36.751Z","todayStars":1395,"totalStars":9376,"rank":1},{"at":"2026-10-28T01:16:00.697Z","todayStars":1395,"totalStars":9378,"rank":1},{"at":"2026-10-28T01:16:02.565Z","todayStars":1395,"totalStars":9383,"rank":1},{"at":"2026-10-28T01:17:20.026Z","todayStars":1395,"totalStars":9384,"rank":1},{"at":"2026-10-28T01:24:06.995Z","todayStars":1395,"totalStars":9401,"rank":1},{"at":"2026-10-28T01:28:13.302Z","todayStars":1395,"totalStars":9416,"rank":1},{"at":"2026-10-28T01:28:22.476Z","todayStars":1395,"totalStars":9416,"rank":1},{"at":"2026-10-28T01:33:13.974Z","todayStars":1395,"totalStars":9426,"rank":1},{"at":"2026-10-28T01:33:28.182Z","todayStars":1395,"totalStars":9426,"rank":1},{"at":"2026-10-28T01:35:35.936Z","todayStars":1395,"totalStars":9430,"rank":1},{"at":"2026-10-28T01:40:46.724Z","todayStars":1395,"totalStars":9438,"rank":1},{"at":"2026-10-28T01:56:00.145Z","todayStars":1395,"totalStars":9470,"rank":1},{"at":"2026-10-28T02:01:47.418Z","todayStars":1395,"totalStars":9485,"rank":1},{"at":"2026-10-28T02:12:21.548Z","todayStars":1395,"totalStars":9505,"rank":1},{"at":"2026-10-28T02:25:51.895Z","todayStars":1395,"totalStars":9541,"rank":1},{"at":"2026-10-28T02:32:00.556Z","todayStars":1395,"totalStars":9551,"rank":1},{"at":"2026-10-28T02:39:45.562Z","todayStars":1395,"totalStars":9567,"rank":1},{"at":"2026-10-28T02:46:34.199Z","todayStars":1395,"totalStars":9582,"rank":1},{"at":"2026-10-28T02:52:07.619Z","todayStars":1395,"totalStars":9600,"rank":1},{"at":"2026-10-28T02:59:41.099Z","todayStars":1395,"totalStars":9620,"rank":1},{"at":"2026-10-28T03:05:32.121Z","todayStars":1395,"totalStars":9636,"rank":1},{"at":"2026-10-28T03:16:09.860Z","todayStars":1395,"totalStars":9660,"rank":1},{"at":"2026-10-28T03:26:57.860Z","todayStars":1395,"totalStars":9672,"rank":1},{"at":"2026-10-28T03:43:48.028Z","todayStars":1395,"totalStars":9693,"rank":1},{"at":"2026-10-28T04:00:33.946Z","todayStars":1395,"totalStars":9721,"rank":1},{"at":"2026-10-28T04:50:49.444Z","todayStars":1395,"totalStars":9789,"rank":1},{"at":"2026-10-28T04:56:52.098Z","todayStars":1395,"totalStars":9800,"rank":1},{"at":"2026-10-28T05:00:25.765Z","todayStars":1395,"totalStars":9806,"rank":1},{"at":"2026-10-28T05:26:13.365Z","todayStars":1395,"totalStars":9842,"rank":1},{"at":"2026-10-28T05:47:52.312Z","todayStars":1395,"totalStars":9873,"rank":1},{"at":"2026-10-28T05:55:12.520Z","todayStars":1395,"totalStars":9884,"rank":1},{"at":"2026-10-28T06:00:24.561Z","todayStars":1395,"totalStars":9893,"rank":1},{"at":"2026-10-28T06:36:14.489Z","todayStars":1395,"totalStars":9956,"rank":1},{"at":"2026-10-28T06:53:02.065Z","todayStars":1395,"totalStars":9980,"rank":1},{"at":"2026-10-28T07:00:25.709Z","todayStars":1395,"totalStars":9991,"rank":1},{"at":"2026-10-28T07:14:01.056Z","todayStars":1395,"totalStars":10011,"rank":1},{"at":"2026-10-28T08:00:25.483Z","todayStars":1395,"totalStars":10133,"rank":1}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',39547,2066,2830,2,2,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":2830,"totalStars":39014,"rank":2},{"at":"2026-10-28T01:02:22.189Z","todayStars":2830,"totalStars":39014,"rank":2},{"at":"2026-10-28T01:02:57.689Z","todayStars":2830,"totalStars":39014,"rank":2},{"at":"2026-10-28T01:07:29.419Z","todayStars":2830,"totalStars":39018,"rank":2},{"at":"2026-10-28T01:15:01.443Z","todayStars":2830,"totalStars":39030,"rank":2},{"at":"2026-10-28T01:15:36.751Z","todayStars":2830,"totalStars":39030,"rank":2},{"at":"2026-10-28T01:16:00.697Z","todayStars":2830,"totalStars":39030,"rank":2},{"at":"2026-10-28T01:16:02.565Z","todayStars":2830,"totalStars":39030,"rank":2},{"at":"2026-10-28T01:17:20.026Z","todayStars":2830,"totalStars":39032,"rank":2},{"at":"2026-10-28T01:24:06.995Z","todayStars":2830,"totalStars":39040,"rank":2},{"at":"2026-10-28T01:28:13.302Z","todayStars":2830,"totalStars":39042,"rank":2},{"at":"2026-10-28T01:28:22.476Z","todayStars":2830,"totalStars":39042,"rank":2},{"at":"2026-10-28T01:33:13.974Z","todayStars":2830,"totalStars":39050,"rank":2},{"at":"2026-10-28T01:33:28.182Z","todayStars":2830,"totalStars":39050,"rank":2},{"at":"2026-10-28T01:35:35.936Z","todayStars":2830,"totalStars":39054,"rank":2},{"at":"2026-10-28T01:40:46.724Z","todayStars":2830,"totalStars":39066,"rank":2},{"at":"2026-10-28T01:56:00.145Z","todayStars":2830,"totalStars":39091,"rank":2},{"at":"2026-10-28T02:01:47.418Z","todayStars":2830,"totalStars":39101,"rank":2},{"at":"2026-10-28T02:12:21.548Z","todayStars":2830,"totalStars":39118,"rank":2},{"at":"2026-10-28T02:25:51.895Z","todayStars":2830,"totalStars":39138,"rank":2},{"at":"2026-10-28T02:32:00.556Z","todayStars":2830,"totalStars":39151,"rank":2},{"at":"2026-10-28T02:39:45.562Z","todayStars":2830,"totalStars":39162,"rank":2},{"at":"2026-10-28T02:46:34.199Z","todayStars":2830,"totalStars":39173,"rank":2},{"at":"2026-10-28T02:52:07.619Z","todayStars":2830,"totalStars":39180,"rank":2},{"at":"2026-10-28T02:59:41.099Z","todayStars":2830,"totalStars":39192,"rank":2},{"at":"2026-10-28T03:05:32.121Z","todayStars":2830,"totalStars":39204,"rank":2},{"at":"2026-10-28T03:16:09.860Z","todayStars":2830,"totalStars":39213,"rank":2},{"at":"2026-10-28T03:26:57.860Z","todayStars":2830,"totalStars":39222,"rank":2},{"at":"2026-10-28T03:43:48.028Z","todayStars":2830,"totalStars":39240,"rank":2},{"at":"2026-10-28T04:00:33.946Z","todayStars":2830,"totalStars":39266,"rank":2},{"at":"2026-10-28T04:50:49.444Z","todayStars":2830,"totalStars":39316,"rank":2},{"at":"2026-10-28T04:56:52.098Z","todayStars":2830,"totalStars":39320,"rank":2},{"at":"2026-10-28T05:00:25.765Z","todayStars":2830,"totalStars":39328,"rank":2},{"at":"2026-10-28T05:26:13.365Z","todayStars":2830,"totalStars":39352,"rank":2},{"at":"2026-10-28T05:47:52.312Z","todayStars":2830,"totalStars":39376,"rank":2},{"at":"2026-10-28T05:55:12.520Z","todayStars":2830,"totalStars":39385,"rank":2},{"at":"2026-10-28T06:00:24.561Z","todayStars":2830,"totalStars":39394,"rank":2},{"at":"2026-10-28T06:36:14.489Z","todayStars":2830,"totalStars":39443,"rank":2},{"at":"2026-10-28T06:53:02.065Z","todayStars":2830,"totalStars":39464,"rank":2},{"at":"2026-10-28T07:00:25.709Z","todayStars":2830,"totalStars":39470,"rank":2},{"at":"2026-10-28T07:14:01.056Z","todayStars":2830,"totalStars":39488,"rank":2},{"at":"2026-10-28T08:00:25.483Z","todayStars":2830,"totalStars":39547,"rank":2}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','nightly-labs/openbot','nightly-labs','openbot','nightly-labs/openbot','https://github.com/nightly-labs/openbot','A local-first desktop workspace for persistent AI teammates. Run Codex, Claude, and Grok with dedicated workspaces, task queues, file sharing, browser control, and agent-to-agent collaboration.','TypeScript','#3178c6',2733,276,777,3,3,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":777,"totalStars":2446,"rank":3},{"at":"2026-10-28T01:02:22.189Z","todayStars":777,"totalStars":2446,"rank":3},{"at":"2026-10-28T01:02:57.689Z","todayStars":777,"totalStars":2446,"rank":3},{"at":"2026-10-28T01:07:29.419Z","todayStars":777,"totalStars":2448,"rank":3},{"at":"2026-10-28T01:15:01.443Z","todayStars":777,"totalStars":2454,"rank":3},{"at":"2026-10-28T01:15:36.751Z","todayStars":777,"totalStars":2454,"rank":3},{"at":"2026-10-28T01:16:00.697Z","todayStars":777,"totalStars":2454,"rank":3},{"at":"2026-10-28T01:16:02.565Z","todayStars":777,"totalStars":2454,"rank":3},{"at":"2026-10-28T01:17:20.026Z","todayStars":777,"totalStars":2455,"rank":3},{"at":"2026-10-28T01:24:06.995Z","todayStars":777,"totalStars":2463,"rank":3},{"at":"2026-10-28T01:28:13.302Z","todayStars":777,"totalStars":2466,"rank":3},{"at":"2026-10-28T01:28:22.476Z","todayStars":777,"totalStars":2466,"rank":3},{"at":"2026-10-28T01:33:13.974Z","todayStars":777,"totalStars":2469,"rank":3},{"at":"2026-10-28T01:33:28.182Z","todayStars":777,"totalStars":2469,"rank":3},{"at":"2026-10-28T01:35:35.936Z","todayStars":777,"totalStars":2470,"rank":3},{"at":"2026-10-28T01:40:46.724Z","todayStars":777,"totalStars":2476,"rank":3},{"at":"2026-10-28T01:56:00.145Z","todayStars":777,"totalStars":2493,"rank":3},{"at":"2026-10-28T02:01:47.418Z","todayStars":777,"totalStars":2498,"rank":3},{"at":"2026-10-28T02:12:21.548Z","todayStars":777,"totalStars":2507,"rank":3},{"at":"2026-10-28T02:25:51.895Z","todayStars":777,"totalStars":2521,"rank":3},{"at":"2026-10-28T02:32:00.556Z","todayStars":777,"totalStars":2528,"rank":3},{"at":"2026-10-28T02:39:45.562Z","todayStars":777,"totalStars":2535,"rank":3},{"at":"2026-10-28T02:46:34.199Z","todayStars":777,"totalStars":2538,"rank":3},{"at":"2026-10-28T02:52:07.619Z","todayStars":777,"totalStars":2544,"rank":3},{"at":"2026-10-28T02:59:41.099Z","todayStars":777,"totalStars":2548,"rank":3},{"at":"2026-10-28T03:05:32.121Z","todayStars":777,"totalStars":2552,"rank":3},{"at":"2026-10-28T03:16:09.860Z","todayStars":777,"totalStars":2556,"rank":3},{"at":"2026-10-28T03:26:57.860Z","todayStars":777,"totalStars":2563,"rank":3},{"at":"2026-10-28T03:43:48.028Z","todayStars":777,"totalStars":2573,"rank":3},{"at":"2026-10-28T04:00:33.946Z","todayStars":777,"totalStars":2585,"rank":3},{"at":"2026-10-28T04:50:49.444Z","todayStars":777,"totalStars":2617,"rank":3},{"at":"2026-10-28T04:56:52.098Z","todayStars":777,"totalStars":2621,"rank":3},{"at":"2026-10-28T05:00:25.765Z","todayStars":777,"totalStars":2621,"rank":3},{"at":"2026-10-28T05:26:13.365Z","todayStars":777,"totalStars":2637,"rank":3},{"at":"2026-10-28T05:47:52.312Z","todayStars":777,"totalStars":2648,"rank":3},{"at":"2026-10-28T05:55:12.520Z","todayStars":777,"totalStars":2652,"rank":3},{"at":"2026-10-28T06:00:24.561Z","todayStars":777,"totalStars":2653,"rank":3},{"at":"2026-10-28T06:36:14.489Z","todayStars":777,"totalStars":2673,"rank":3},{"at":"2026-10-28T06:53:02.065Z","todayStars":777,"totalStars":2680,"rank":3},{"at":"2026-10-28T07:00:25.709Z","todayStars":777,"totalStars":2685,"rank":3},{"at":"2026-10-28T07:14:01.056Z","todayStars":777,"totalStars":2693,"rank":3},{"at":"2026-10-28T08:00:25.483Z","todayStars":777,"totalStars":2733,"rank":3}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',306745,27303,617,4,4,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":617,"totalStars":306447,"rank":4},{"at":"2026-10-28T01:02:22.189Z","todayStars":617,"totalStars":306447,"rank":4},{"at":"2026-10-28T01:02:57.689Z","todayStars":617,"totalStars":306447,"rank":4},{"at":"2026-10-28T01:07:29.419Z","todayStars":617,"totalStars":306448,"rank":4},{"at":"2026-10-28T01:15:01.443Z","todayStars":617,"totalStars":306450,"rank":4},{"at":"2026-10-28T01:15:36.751Z","todayStars":617,"totalStars":306450,"rank":4},{"at":"2026-10-28T01:16:00.697Z","todayStars":617,"totalStars":306450,"rank":4},{"at":"2026-10-28T01:16:02.565Z","todayStars":617,"totalStars":306450,"rank":4},{"at":"2026-10-28T01:17:20.026Z","todayStars":617,"totalStars":306451,"rank":4},{"at":"2026-10-28T01:24:06.995Z","todayStars":617,"totalStars":306455,"rank":4},{"at":"2026-10-28T01:28:13.302Z","todayStars":617,"totalStars":306459,"rank":4},{"at":"2026-10-28T01:28:22.476Z","todayStars":617,"totalStars":306459,"rank":4},{"at":"2026-10-28T01:33:13.974Z","todayStars":617,"totalStars":306462,"rank":4},{"at":"2026-10-28T01:33:28.182Z","todayStars":617,"totalStars":306462,"rank":4},{"at":"2026-10-28T01:35:35.936Z","todayStars":617,"totalStars":306462,"rank":4},{"at":"2026-10-28T01:40:46.724Z","todayStars":617,"totalStars":306465,"rank":4},{"at":"2026-10-28T01:56:00.145Z","todayStars":617,"totalStars":306476,"rank":4},{"at":"2026-10-28T02:01:47.418Z","todayStars":617,"totalStars":306479,"rank":4},{"at":"2026-10-28T02:12:21.548Z","todayStars":617,"totalStars":306488,"rank":4},{"at":"2026-10-28T02:25:51.895Z","todayStars":617,"totalStars":306504,"rank":4},{"at":"2026-10-28T02:32:00.556Z","todayStars":617,"totalStars":306506,"rank":4},{"at":"2026-10-28T02:39:45.562Z","todayStars":617,"totalStars":306512,"rank":4},{"at":"2026-10-28T02:46:34.199Z","todayStars":617,"totalStars":306520,"rank":4},{"at":"2026-10-28T02:52:07.619Z","todayStars":617,"totalStars":306525,"rank":4},{"at":"2026-10-28T02:59:41.099Z","todayStars":617,"totalStars":306528,"rank":4},{"at":"2026-10-28T03:05:32.121Z","todayStars":617,"totalStars":306535,"rank":4},{"at":"2026-10-28T03:16:09.860Z","todayStars":617,"totalStars":306543,"rank":4},{"at":"2026-10-28T03:26:57.860Z","todayStars":617,"totalStars":306556,"rank":4},{"at":"2026-10-28T03:43:48.028Z","todayStars":617,"totalStars":306569,"rank":4},{"at":"2026-10-28T04:00:33.946Z","todayStars":617,"totalStars":306583,"rank":4},{"at":"2026-10-28T04:50:49.444Z","todayStars":617,"totalStars":306612,"rank":4},{"at":"2026-10-28T04:56:52.098Z","todayStars":617,"totalStars":306613,"rank":4},{"at":"2026-10-28T05:00:25.765Z","todayStars":617,"totalStars":306615,"rank":4},{"at":"2026-10-28T05:26:13.365Z","todayStars":617,"totalStars":306627,"rank":4},{"at":"2026-10-28T05:47:52.312Z","todayStars":617,"totalStars":306637,"rank":4},{"at":"2026-10-28T05:55:12.520Z","todayStars":617,"totalStars":306644,"rank":4},{"at":"2026-10-28T06:00:24.561Z","todayStars":617,"totalStars":306649,"rank":4},{"at":"2026-10-28T06:36:14.489Z","todayStars":617,"totalStars":306691,"rank":4},{"at":"2026-10-28T06:53:02.065Z","todayStars":617,"totalStars":306701,"rank":4},{"at":"2026-10-28T07:00:25.709Z","todayStars":617,"totalStars":306705,"rank":4},{"at":"2026-10-28T07:14:01.056Z","todayStars":617,"totalStars":306713,"rank":4},{"at":"2026-10-28T08:00:25.483Z","todayStars":617,"totalStars":306745,"rank":4}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',91063,5394,1449,5,5,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1449,"totalStars":90539,"rank":5},{"at":"2026-10-28T01:02:22.189Z","todayStars":1449,"totalStars":90539,"rank":5},{"at":"2026-10-28T01:02:57.689Z","todayStars":1449,"totalStars":90539,"rank":5},{"at":"2026-10-28T01:07:29.419Z","todayStars":1449,"totalStars":90544,"rank":5},{"at":"2026-10-28T01:15:01.443Z","todayStars":1449,"totalStars":90550,"rank":5},{"at":"2026-10-28T01:15:36.751Z","todayStars":1449,"totalStars":90550,"rank":5},{"at":"2026-10-28T01:16:00.697Z","todayStars":1449,"totalStars":90550,"rank":5},{"at":"2026-10-28T01:16:02.565Z","todayStars":1449,"totalStars":90550,"rank":5},{"at":"2026-10-28T01:17:20.026Z","todayStars":1449,"totalStars":90551,"rank":5},{"at":"2026-10-28T01:24:06.995Z","todayStars":1449,"totalStars":90570,"rank":5},{"at":"2026-10-28T01:28:13.302Z","todayStars":1449,"totalStars":90575,"rank":5},{"at":"2026-10-28T01:28:22.476Z","todayStars":1449,"totalStars":90575,"rank":5},{"at":"2026-10-28T01:33:13.974Z","todayStars":1449,"totalStars":90582,"rank":5},{"at":"2026-10-28T01:33:28.182Z","todayStars":1449,"totalStars":90582,"rank":5},{"at":"2026-10-28T01:35:35.936Z","todayStars":1449,"totalStars":90583,"rank":5},{"at":"2026-10-28T01:40:46.724Z","todayStars":1449,"totalStars":90592,"rank":5},{"at":"2026-10-28T01:56:00.145Z","todayStars":1449,"totalStars":90620,"rank":5},{"at":"2026-10-28T02:01:47.418Z","todayStars":1449,"totalStars":90632,"rank":5},{"at":"2026-10-28T02:12:21.548Z","todayStars":1449,"totalStars":90645,"rank":5},{"at":"2026-10-28T02:25:51.895Z","todayStars":1449,"totalStars":90674,"rank":5},{"at":"2026-10-28T02:32:00.556Z","todayStars":1449,"totalStars":90681,"rank":5},{"at":"2026-10-28T02:39:45.562Z","todayStars":1449,"totalStars":90692,"rank":5},{"at":"2026-10-28T02:46:34.199Z","todayStars":1449,"totalStars":90702,"rank":5},{"at":"2026-10-28T02:52:07.619Z","todayStars":1449,"totalStars":90712,"rank":5},{"at":"2026-10-28T02:59:41.099Z","todayStars":1449,"totalStars":90721,"rank":5},{"at":"2026-10-28T03:05:32.121Z","todayStars":1449,"totalStars":90733,"rank":5},{"at":"2026-10-28T03:16:09.860Z","todayStars":1449,"totalStars":90750,"rank":5},{"at":"2026-10-28T03:26:57.860Z","todayStars":1449,"totalStars":90764,"rank":5},{"at":"2026-10-28T03:43:48.028Z","todayStars":1449,"totalStars":90788,"rank":5},{"at":"2026-10-28T04:00:33.946Z","todayStars":1449,"totalStars":90809,"rank":5},{"at":"2026-10-28T04:50:49.444Z","todayStars":1449,"totalStars":90852,"rank":5},{"at":"2026-10-28T04:56:52.098Z","todayStars":1449,"totalStars":90858,"rank":5},{"at":"2026-10-28T05:00:25.765Z","todayStars":1449,"totalStars":90860,"rank":5},{"at":"2026-10-28T05:26:13.365Z","todayStars":1449,"totalStars":90882,"rank":5},{"at":"2026-10-28T05:47:52.312Z","todayStars":1449,"totalStars":90909,"rank":5},{"at":"2026-10-28T05:55:12.520Z","todayStars":1449,"totalStars":90915,"rank":5},{"at":"2026-10-28T06:00:24.561Z","todayStars":1449,"totalStars":90923,"rank":5},{"at":"2026-10-28T06:36:14.489Z","todayStars":1449,"totalStars":90972,"rank":5},{"at":"2026-10-28T06:53:02.065Z","todayStars":1449,"totalStars":90987,"rank":5},{"at":"2026-10-28T07:00:25.709Z","todayStars":1449,"totalStars":90997,"rank":5},{"at":"2026-10-28T07:14:01.056Z","todayStars":1449,"totalStars":91018,"rank":5},{"at":"2026-10-28T08:00:25.483Z","todayStars":1449,"totalStars":91063,"rank":5}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','makecindy/cindy','makecindy','cindy','makecindy/cindy','https://github.com/makecindy/cindy','Consider it done. The open-source AI agent that works out of the box · 想到，就能做到。开源、开箱即用的 AI Agent。','TypeScript','#3178c6',7719,917,1465,6,6,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1465,"totalStars":7473,"rank":6},{"at":"2026-10-28T01:02:22.189Z","todayStars":1465,"totalStars":7473,"rank":6},{"at":"2026-10-28T01:02:57.689Z","todayStars":1465,"totalStars":7473,"rank":6},{"at":"2026-10-28T01:07:29.419Z","todayStars":1465,"totalStars":7475,"rank":6},{"at":"2026-10-28T01:15:01.443Z","todayStars":1465,"totalStars":7484,"rank":6},{"at":"2026-10-28T01:15:36.751Z","todayStars":1465,"totalStars":7484,"rank":6},{"at":"2026-10-28T01:16:00.697Z","todayStars":1465,"totalStars":7484,"rank":6},{"at":"2026-10-28T01:16:02.565Z","todayStars":1465,"totalStars":7484,"rank":6},{"at":"2026-10-28T01:17:20.026Z","todayStars":1465,"totalStars":7484,"rank":6},{"at":"2026-10-28T01:24:06.995Z","todayStars":1465,"totalStars":7487,"rank":6},{"at":"2026-10-28T01:28:13.302Z","todayStars":1465,"totalStars":7490,"rank":6},{"at":"2026-10-28T01:28:22.476Z","todayStars":1465,"totalStars":7490,"rank":6},{"at":"2026-10-28T01:33:13.974Z","todayStars":1465,"totalStars":7493,"rank":6},{"at":"2026-10-28T01:33:28.182Z","todayStars":1465,"totalStars":7493,"rank":6},{"at":"2026-10-28T01:35:35.936Z","todayStars":1465,"totalStars":7494,"rank":6},{"at":"2026-10-28T01:40:46.724Z","todayStars":1465,"totalStars":7495,"rank":6},{"at":"2026-10-28T01:56:00.145Z","todayStars":1465,"totalStars":7506,"rank":6},{"at":"2026-10-28T02:01:47.418Z","todayStars":1465,"totalStars":7511,"rank":6},{"at":"2026-10-28T02:12:21.548Z","todayStars":1465,"totalStars":7520,"rank":6},{"at":"2026-10-28T02:25:51.895Z","todayStars":1465,"totalStars":7530,"rank":6},{"at":"2026-10-28T02:32:00.556Z","todayStars":1465,"totalStars":7535,"rank":6},{"at":"2026-10-28T02:39:45.562Z","todayStars":1465,"totalStars":7542,"rank":6},{"at":"2026-10-28T02:46:34.199Z","todayStars":1465,"totalStars":7548,"rank":6},{"at":"2026-10-28T02:52:07.619Z","todayStars":1465,"totalStars":7551,"rank":6},{"at":"2026-10-28T02:59:41.099Z","todayStars":1465,"totalStars":7561,"rank":6},{"at":"2026-10-28T03:05:32.121Z","todayStars":1465,"totalStars":7563,"rank":6},{"at":"2026-10-28T03:16:09.860Z","todayStars":1465,"totalStars":7570,"rank":6},{"at":"2026-10-28T03:26:57.860Z","todayStars":1465,"totalStars":7579,"rank":6},{"at":"2026-10-28T03:43:48.028Z","todayStars":1465,"totalStars":7591,"rank":6},{"at":"2026-10-28T04:00:33.946Z","todayStars":1465,"totalStars":7601,"rank":6},{"at":"2026-10-28T04:50:49.444Z","todayStars":1465,"totalStars":7625,"rank":6},{"at":"2026-10-28T04:56:52.098Z","todayStars":1465,"totalStars":7627,"rank":6},{"at":"2026-10-28T05:00:25.765Z","todayStars":1465,"totalStars":7628,"rank":6},{"at":"2026-10-28T05:26:13.365Z","todayStars":1465,"totalStars":7643,"rank":6},{"at":"2026-10-28T05:47:52.312Z","todayStars":1465,"totalStars":7657,"rank":6},{"at":"2026-10-28T05:55:12.520Z","todayStars":1465,"totalStars":7661,"rank":6},{"at":"2026-10-28T06:00:24.561Z","todayStars":1465,"totalStars":7665,"rank":6},{"at":"2026-10-28T06:36:14.489Z","todayStars":1465,"totalStars":7681,"rank":6},{"at":"2026-10-28T06:53:02.065Z","todayStars":1465,"totalStars":7690,"rank":6},{"at":"2026-10-28T07:00:25.709Z","todayStars":1465,"totalStars":7691,"rank":6},{"at":"2026-10-28T07:14:01.056Z","todayStars":1465,"totalStars":7698,"rank":6},{"at":"2026-10-28T08:00:25.483Z","todayStars":1465,"totalStars":7719,"rank":6}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','gitroomhq/postiz-app','gitroomhq','postiz-app','gitroomhq/postiz-app','https://github.com/gitroomhq/postiz-app','📨 The ultimate agentic social media scheduling tool 🤖','TypeScript','#3178c6',39691,7539,951,7,7,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":951,"totalStars":39385,"rank":7},{"at":"2026-10-28T01:02:22.189Z","todayStars":951,"totalStars":39385,"rank":7},{"at":"2026-10-28T01:02:57.689Z","todayStars":951,"totalStars":39385,"rank":7},{"at":"2026-10-28T01:07:29.419Z","todayStars":951,"totalStars":39388,"rank":7},{"at":"2026-10-28T01:15:01.443Z","todayStars":951,"totalStars":39393,"rank":7},{"at":"2026-10-28T01:15:36.751Z","todayStars":951,"totalStars":39393,"rank":7},{"at":"2026-10-28T01:16:00.697Z","todayStars":951,"totalStars":39393,"rank":7},{"at":"2026-10-28T01:16:02.565Z","todayStars":951,"totalStars":39394,"rank":7},{"at":"2026-10-28T01:17:20.026Z","todayStars":951,"totalStars":39396,"rank":7},{"at":"2026-10-28T01:24:06.995Z","todayStars":951,"totalStars":39399,"rank":7},{"at":"2026-10-28T01:28:13.302Z","todayStars":951,"totalStars":39400,"rank":7},{"at":"2026-10-28T01:28:22.476Z","todayStars":951,"totalStars":39400,"rank":7},{"at":"2026-10-28T01:33:13.974Z","todayStars":951,"totalStars":39406,"rank":7},{"at":"2026-10-28T01:33:28.182Z","todayStars":951,"totalStars":39406,"rank":7},{"at":"2026-10-28T01:35:35.936Z","todayStars":951,"totalStars":39406,"rank":7},{"at":"2026-10-28T01:40:46.724Z","todayStars":951,"totalStars":39410,"rank":7},{"at":"2026-10-28T01:56:00.145Z","todayStars":951,"totalStars":39422,"rank":7},{"at":"2026-10-28T02:01:47.418Z","todayStars":951,"totalStars":39429,"rank":7},{"at":"2026-10-28T02:12:21.548Z","todayStars":951,"totalStars":39437,"rank":7},{"at":"2026-10-28T02:25:51.895Z","todayStars":951,"totalStars":39448,"rank":7},{"at":"2026-10-28T02:32:00.556Z","todayStars":951,"totalStars":39455,"rank":7},{"at":"2026-10-28T02:39:45.562Z","todayStars":951,"totalStars":39458,"rank":7},{"at":"2026-10-28T02:46:34.199Z","todayStars":951,"totalStars":39464,"rank":7},{"at":"2026-10-28T02:52:07.619Z","todayStars":951,"totalStars":39467,"rank":7},{"at":"2026-10-28T02:59:41.099Z","todayStars":951,"totalStars":39470,"rank":7},{"at":"2026-10-28T03:05:32.121Z","todayStars":951,"totalStars":39471,"rank":7},{"at":"2026-10-28T03:16:09.860Z","todayStars":951,"totalStars":39477,"rank":7},{"at":"2026-10-28T03:26:57.860Z","todayStars":951,"totalStars":39486,"rank":7},{"at":"2026-10-28T03:43:48.028Z","todayStars":951,"totalStars":39500,"rank":7},{"at":"2026-10-28T04:00:33.946Z","todayStars":951,"totalStars":39517,"rank":7},{"at":"2026-10-28T04:50:49.444Z","todayStars":951,"totalStars":39549,"rank":7},{"at":"2026-10-28T04:56:52.098Z","todayStars":951,"totalStars":39555,"rank":7},{"at":"2026-10-28T05:00:25.765Z","todayStars":951,"totalStars":39559,"rank":7},{"at":"2026-10-28T05:26:13.365Z","todayStars":951,"totalStars":39575,"rank":7},{"at":"2026-10-28T05:47:52.312Z","todayStars":951,"totalStars":39587,"rank":7},{"at":"2026-10-28T05:55:12.520Z","todayStars":951,"totalStars":39593,"rank":7},{"at":"2026-10-28T06:00:24.561Z","todayStars":951,"totalStars":39597,"rank":7},{"at":"2026-10-28T06:36:14.489Z","todayStars":951,"totalStars":39627,"rank":7},{"at":"2026-10-28T06:53:02.065Z","todayStars":951,"totalStars":39641,"rank":7},{"at":"2026-10-28T07:00:25.709Z","todayStars":951,"totalStars":39647,"rank":7},{"at":"2026-10-28T07:14:01.056Z","todayStars":951,"totalStars":39657,"rank":7},{"at":"2026-10-28T08:00:25.483Z","todayStars":951,"totalStars":39691,"rank":7}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',291166,43101,1165,8,8,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1165,"totalStars":290897,"rank":8},{"at":"2026-10-28T01:02:22.189Z","todayStars":1165,"totalStars":290897,"rank":8},{"at":"2026-10-28T01:02:57.689Z","todayStars":1165,"totalStars":290897,"rank":8},{"at":"2026-10-28T01:07:29.419Z","todayStars":1165,"totalStars":290903,"rank":8},{"at":"2026-10-28T01:15:01.443Z","todayStars":1165,"totalStars":290905,"rank":8},{"at":"2026-10-28T01:15:36.751Z","todayStars":1165,"totalStars":290905,"rank":8},{"at":"2026-10-28T01:16:00.697Z","todayStars":1165,"totalStars":290905,"rank":8},{"at":"2026-10-28T01:16:02.565Z","todayStars":1165,"totalStars":290905,"rank":8},{"at":"2026-10-28T01:17:20.026Z","todayStars":1165,"totalStars":290905,"rank":8},{"at":"2026-10-28T01:24:06.995Z","todayStars":1165,"totalStars":290908,"rank":8},{"at":"2026-10-28T01:28:13.302Z","todayStars":1165,"totalStars":290909,"rank":8},{"at":"2026-10-28T01:28:22.476Z","todayStars":1165,"totalStars":290909,"rank":8},{"at":"2026-10-28T01:33:13.974Z","todayStars":1165,"totalStars":290910,"rank":8},{"at":"2026-10-28T01:33:28.182Z","todayStars":1165,"totalStars":290910,"rank":8},{"at":"2026-10-28T01:35:35.936Z","todayStars":1165,"totalStars":290911,"rank":8},{"at":"2026-10-28T01:40:46.724Z","todayStars":1165,"totalStars":290917,"rank":8},{"at":"2026-10-28T01:56:00.145Z","todayStars":1165,"totalStars":290926,"rank":8},{"at":"2026-10-28T02:01:47.418Z","todayStars":1165,"totalStars":290931,"rank":8},{"at":"2026-10-28T02:12:21.548Z","todayStars":1165,"totalStars":290937,"rank":8},{"at":"2026-10-28T02:25:51.895Z","todayStars":1165,"totalStars":290951,"rank":8},{"at":"2026-10-28T02:32:00.556Z","todayStars":1165,"totalStars":290956,"rank":8},{"at":"2026-10-28T02:39:45.562Z","todayStars":1165,"totalStars":290958,"rank":8},{"at":"2026-10-28T02:46:34.199Z","todayStars":1165,"totalStars":290962,"rank":8},{"at":"2026-10-28T02:52:07.619Z","todayStars":1165,"totalStars":290972,"rank":8},{"at":"2026-10-28T02:59:41.099Z","todayStars":1165,"totalStars":290980,"rank":8},{"at":"2026-10-28T03:05:32.121Z","todayStars":1165,"totalStars":290983,"rank":8},{"at":"2026-10-28T03:16:09.860Z","todayStars":1165,"totalStars":290991,"rank":8},{"at":"2026-10-28T03:26:57.860Z","todayStars":1165,"totalStars":290996,"rank":8},{"at":"2026-10-28T03:43:48.028Z","todayStars":1165,"totalStars":291004,"rank":8},{"at":"2026-10-28T04:00:33.946Z","todayStars":1165,"totalStars":291014,"rank":8},{"at":"2026-10-28T04:50:49.444Z","todayStars":1165,"totalStars":291041,"rank":8},{"at":"2026-10-28T04:56:52.098Z","todayStars":1165,"totalStars":291044,"rank":8},{"at":"2026-10-28T05:00:25.765Z","todayStars":1165,"totalStars":291044,"rank":8},{"at":"2026-10-28T05:26:13.365Z","todayStars":1165,"totalStars":291057,"rank":8},{"at":"2026-10-28T05:47:52.312Z","todayStars":1165,"totalStars":291078,"rank":8},{"at":"2026-10-28T05:55:12.520Z","todayStars":1165,"totalStars":291082,"rank":8},{"at":"2026-10-28T06:00:24.561Z","todayStars":1165,"totalStars":291083,"rank":8},{"at":"2026-10-28T06:36:14.489Z","todayStars":1165,"totalStars":291110,"rank":8},{"at":"2026-10-28T06:53:02.065Z","todayStars":1165,"totalStars":291117,"rank":8},{"at":"2026-10-28T07:00:25.709Z","todayStars":1165,"totalStars":291122,"rank":8},{"at":"2026-10-28T07:14:01.056Z","todayStars":1165,"totalStars":291130,"rank":8},{"at":"2026-10-28T08:00:25.483Z","todayStars":1165,"totalStars":291166,"rank":8}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',46727,5835,1598,9,9,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1598,"totalStars":45915,"rank":9},{"at":"2026-10-28T01:02:22.189Z","todayStars":1598,"totalStars":45915,"rank":9},{"at":"2026-10-28T01:02:57.689Z","todayStars":1598,"totalStars":45915,"rank":9},{"at":"2026-10-28T01:07:29.419Z","todayStars":1598,"totalStars":45918,"rank":9},{"at":"2026-10-28T01:15:01.443Z","todayStars":1598,"totalStars":45926,"rank":9},{"at":"2026-10-28T01:15:36.751Z","todayStars":1598,"totalStars":45926,"rank":9},{"at":"2026-10-28T01:16:00.697Z","todayStars":1598,"totalStars":45928,"rank":9},{"at":"2026-10-28T01:16:02.565Z","todayStars":1598,"totalStars":45928,"rank":9},{"at":"2026-10-28T01:17:20.026Z","todayStars":1598,"totalStars":45933,"rank":9},{"at":"2026-10-28T01:24:06.995Z","todayStars":1598,"totalStars":45942,"rank":9},{"at":"2026-10-28T01:28:13.302Z","todayStars":1598,"totalStars":45952,"rank":9},{"at":"2026-10-28T01:28:22.476Z","todayStars":1598,"totalStars":45952,"rank":9},{"at":"2026-10-28T01:33:13.974Z","todayStars":1598,"totalStars":45965,"rank":9},{"at":"2026-10-28T01:33:28.182Z","todayStars":1598,"totalStars":45965,"rank":9},{"at":"2026-10-28T01:35:35.936Z","todayStars":1598,"totalStars":45970,"rank":9},{"at":"2026-10-28T01:40:46.724Z","todayStars":1598,"totalStars":45980,"rank":9},{"at":"2026-10-28T01:56:00.145Z","todayStars":1598,"totalStars":46012,"rank":9},{"at":"2026-10-28T02:01:47.418Z","todayStars":1598,"totalStars":46023,"rank":9},{"at":"2026-10-28T02:12:21.548Z","todayStars":1598,"totalStars":46044,"rank":9},{"at":"2026-10-28T02:25:51.895Z","todayStars":1598,"totalStars":46068,"rank":9},{"at":"2026-10-28T02:32:00.556Z","todayStars":1598,"totalStars":46081,"rank":9},{"at":"2026-10-28T02:39:45.562Z","todayStars":1598,"totalStars":46099,"rank":9},{"at":"2026-10-28T02:46:34.199Z","todayStars":1598,"totalStars":46111,"rank":9},{"at":"2026-10-28T02:52:07.619Z","todayStars":1598,"totalStars":46123,"rank":9},{"at":"2026-10-28T02:59:41.099Z","todayStars":1598,"totalStars":46139,"rank":9},{"at":"2026-10-28T03:05:32.121Z","todayStars":1598,"totalStars":46154,"rank":9},{"at":"2026-10-28T03:16:09.860Z","todayStars":1598,"totalStars":46170,"rank":9},{"at":"2026-10-28T03:26:57.860Z","todayStars":1598,"totalStars":46200,"rank":9},{"at":"2026-10-28T03:43:48.028Z","todayStars":1598,"totalStars":46235,"rank":9},{"at":"2026-10-28T04:00:33.946Z","todayStars":1598,"totalStars":46262,"rank":9},{"at":"2026-10-28T04:50:49.444Z","todayStars":1598,"totalStars":46346,"rank":9},{"at":"2026-10-28T04:56:52.098Z","todayStars":1598,"totalStars":46355,"rank":9},{"at":"2026-10-28T05:00:25.765Z","todayStars":1598,"totalStars":46364,"rank":9},{"at":"2026-10-28T05:26:13.365Z","todayStars":1598,"totalStars":46414,"rank":9},{"at":"2026-10-28T05:47:52.312Z","todayStars":1598,"totalStars":46457,"rank":9},{"at":"2026-10-28T05:55:12.520Z","todayStars":1598,"totalStars":46472,"rank":9},{"at":"2026-10-28T06:00:24.561Z","todayStars":1598,"totalStars":46473,"rank":9},{"at":"2026-10-28T06:36:14.489Z","todayStars":1598,"totalStars":46552,"rank":9},{"at":"2026-10-28T06:53:02.065Z","todayStars":1598,"totalStars":46582,"rank":9},{"at":"2026-10-28T07:00:25.709Z","todayStars":1598,"totalStars":46600,"rank":9},{"at":"2026-10-28T07:14:01.056Z","todayStars":1598,"totalStars":46625,"rank":9},{"at":"2026-10-28T08:00:25.483Z","todayStars":1598,"totalStars":46727,"rank":9}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',4388,232,1204,10,10,0,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":1204,"totalStars":4012,"rank":10},{"at":"2026-10-28T01:02:22.189Z","todayStars":1204,"totalStars":4012,"rank":10},{"at":"2026-10-28T01:02:57.689Z","todayStars":1204,"totalStars":4012,"rank":10},{"at":"2026-10-28T01:07:29.419Z","todayStars":1204,"totalStars":4016,"rank":10},{"at":"2026-10-28T01:15:01.443Z","todayStars":1204,"totalStars":4021,"rank":10},{"at":"2026-10-28T01:15:36.751Z","todayStars":1204,"totalStars":4021,"rank":10},{"at":"2026-10-28T01:16:00.697Z","todayStars":1204,"totalStars":4021,"rank":10},{"at":"2026-10-28T01:16:02.565Z","todayStars":1204,"totalStars":4021,"rank":10},{"at":"2026-10-28T01:17:20.026Z","todayStars":1204,"totalStars":4023,"rank":10},{"at":"2026-10-28T01:24:06.995Z","todayStars":1204,"totalStars":4033,"rank":10},{"at":"2026-10-28T01:28:13.302Z","todayStars":1204,"totalStars":4038,"rank":10},{"at":"2026-10-28T01:28:22.476Z","todayStars":1204,"totalStars":4038,"rank":10},{"at":"2026-10-28T01:33:13.974Z","todayStars":1204,"totalStars":4041,"rank":10},{"at":"2026-10-28T01:33:28.182Z","todayStars":1204,"totalStars":4041,"rank":10},{"at":"2026-10-28T01:35:35.936Z","todayStars":1204,"totalStars":4043,"rank":10},{"at":"2026-10-28T01:40:46.724Z","todayStars":1204,"totalStars":4046,"rank":10},{"at":"2026-10-28T01:56:00.145Z","todayStars":1204,"totalStars":4061,"rank":10},{"at":"2026-10-28T02:01:47.418Z","todayStars":1204,"totalStars":4068,"rank":10},{"at":"2026-10-28T02:12:21.548Z","todayStars":1204,"totalStars":4083,"rank":10},{"at":"2026-10-28T02:25:51.895Z","todayStars":1204,"totalStars":4103,"rank":10},{"at":"2026-10-28T02:32:00.556Z","todayStars":1204,"totalStars":4115,"rank":10},{"at":"2026-10-28T02:39:45.562Z","todayStars":1204,"totalStars":4122,"rank":10},{"at":"2026-10-28T02:46:34.199Z","todayStars":1204,"totalStars":4133,"rank":10},{"at":"2026-10-28T02:52:07.619Z","todayStars":1204,"totalStars":4134,"rank":10},{"at":"2026-10-28T02:59:41.099Z","todayStars":1204,"totalStars":4146,"rank":10},{"at":"2026-10-28T03:05:32.121Z","todayStars":1204,"totalStars":4147,"rank":10},{"at":"2026-10-28T03:16:09.860Z","todayStars":1204,"totalStars":4156,"rank":10},{"at":"2026-10-28T03:26:57.860Z","todayStars":1204,"totalStars":4164,"rank":10},{"at":"2026-10-28T03:43:48.028Z","todayStars":1204,"totalStars":4180,"rank":10},{"at":"2026-10-28T04:00:33.946Z","todayStars":1204,"totalStars":4191,"rank":10},{"at":"2026-10-28T04:50:49.444Z","todayStars":1204,"totalStars":4224,"rank":10},{"at":"2026-10-28T04:56:52.098Z","todayStars":1204,"totalStars":4229,"rank":10},{"at":"2026-10-28T05:00:25.765Z","todayStars":1204,"totalStars":4229,"rank":10},{"at":"2026-10-28T05:26:13.365Z","todayStars":1204,"totalStars":4248,"rank":10},{"at":"2026-10-28T05:47:52.312Z","todayStars":1204,"totalStars":4269,"rank":10},{"at":"2026-10-28T05:55:12.520Z","todayStars":1204,"totalStars":4278,"rank":10},{"at":"2026-10-28T06:00:24.561Z","todayStars":1204,"totalStars":4282,"rank":10},{"at":"2026-10-28T06:36:14.489Z","todayStars":1204,"totalStars":4325,"rank":10},{"at":"2026-10-28T06:53:02.065Z","todayStars":1204,"totalStars":4338,"rank":10},{"at":"2026-10-28T07:00:25.709Z","todayStars":1204,"totalStars":4343,"rank":10},{"at":"2026-10-28T07:14:01.056Z","todayStars":1204,"totalStars":4357,"rank":10},{"at":"2026-10-28T08:00:25.483Z","todayStars":1204,"totalStars":4388,"rank":10}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',6065,880,902,11,11,1,0,NULL,'2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z','[{"at":"2026-10-28T01:02:18.769Z","todayStars":902,"totalStars":5548,"rank":11},{"at":"2026-10-28T01:02:22.189Z","todayStars":902,"totalStars":5548,"rank":11},{"at":"2026-10-28T01:02:57.689Z","todayStars":902,"totalStars":5548,"rank":11},{"at":"2026-10-28T01:07:29.419Z","todayStars":902,"totalStars":5551,"rank":11},{"at":"2026-10-28T01:15:01.443Z","todayStars":902,"totalStars":5562,"rank":11},{"at":"2026-10-28T01:15:36.751Z","todayStars":902,"totalStars":5562,"rank":11},{"at":"2026-10-28T01:16:00.697Z","todayStars":902,"totalStars":5562,"rank":11},{"at":"2026-10-28T01:16:02.565Z","todayStars":902,"totalStars":5562,"rank":11},{"at":"2026-10-28T01:17:20.026Z","todayStars":902,"totalStars":5568,"rank":11},{"at":"2026-10-28T01:24:06.995Z","todayStars":902,"totalStars":5576,"rank":11},{"at":"2026-10-28T01:28:13.302Z","todayStars":902,"totalStars":5582,"rank":11},{"at":"2026-10-28T01:28:22.476Z","todayStars":902,"totalStars":5582,"rank":11},{"at":"2026-10-28T01:33:13.974Z","todayStars":902,"totalStars":5585,"rank":11},{"at":"2026-10-28T01:33:28.182Z","todayStars":902,"totalStars":5585,"rank":11},{"at":"2026-10-28T01:35:35.936Z","todayStars":902,"totalStars":5586,"rank":11},{"at":"2026-10-28T01:40:46.724Z","todayStars":902,"totalStars":5593,"rank":11},{"at":"2026-10-28T01:56:00.145Z","todayStars":902,"totalStars":5621,"rank":11},{"at":"2026-10-28T02:01:47.418Z","todayStars":902,"totalStars":5628,"rank":11},{"at":"2026-10-28T02:12:21.548Z","todayStars":902,"totalStars":5650,"rank":11},{"at":"2026-10-28T02:25:51.895Z","todayStars":902,"totalStars":5670,"rank":11},{"at":"2026-10-28T02:32:00.556Z","todayStars":902,"totalStars":5681,"rank":11},{"at":"2026-10-28T02:39:45.562Z","todayStars":902,"totalStars":5691,"rank":11},{"at":"2026-10-28T02:46:34.199Z","todayStars":902,"totalStars":5701,"rank":11},{"at":"2026-10-28T02:52:07.619Z","todayStars":902,"totalStars":5708,"rank":11},{"at":"2026-10-28T02:59:41.099Z","todayStars":902,"totalStars":5723,"rank":11},{"at":"2026-10-28T03:05:32.121Z","todayStars":902,"totalStars":5729,"rank":11},{"at":"2026-10-28T03:16:09.860Z","todayStars":902,"totalStars":5737,"rank":11},{"at":"2026-10-28T03:26:57.860Z","todayStars":902,"totalStars":5756,"rank":11},{"at":"2026-10-28T03:43:48.028Z","todayStars":902,"totalStars":5779,"rank":11},{"at":"2026-10-28T04:00:33.946Z","todayStars":902,"totalStars":5789,"rank":11},{"at":"2026-10-28T04:50:49.444Z","todayStars":902,"totalStars":5834,"rank":11},{"at":"2026-10-28T04:56:52.098Z","todayStars":902,"totalStars":5838,"rank":11},{"at":"2026-10-28T05:00:25.765Z","todayStars":902,"totalStars":5840,"rank":11},{"at":"2026-10-28T05:26:13.365Z","todayStars":902,"totalStars":5867,"rank":11},{"at":"2026-10-28T05:47:52.312Z","todayStars":902,"totalStars":5894,"rank":11},{"at":"2026-10-28T05:55:12.520Z","todayStars":902,"totalStars":5903,"rank":11},{"at":"2026-10-28T06:00:24.561Z","todayStars":902,"totalStars":5908,"rank":11},{"at":"2026-10-28T06:36:14.489Z","todayStars":902,"totalStars":5960,"rank":11},{"at":"2026-10-28T06:53:02.065Z","todayStars":902,"totalStars":5983,"rank":11},{"at":"2026-10-28T07:00:25.709Z","todayStars":902,"totalStars":5995,"rank":11},{"at":"2026-10-28T07:14:01.056Z","todayStars":902,"totalStars":6011,"rank":11},{"at":"2026-10-28T08:00:25.483Z","todayStars":902,"totalStars":6065,"rank":11}]','2026-10-28T01:02:18.769Z','2026-10-28T08:00:25.483Z'),
('2026-10-28','daily','elayadesign/ai-design-skills','elayadesign','ai-design-skills','elayadesign/ai-design-skills','https://github.com/elayadesign/ai-design-skills','','Unknown','#8b949e',10548,752,1395,2,1,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1395,"totalStars":10019,"rank":1},{"at":"2026-10-28T07:23:20.500Z","todayStars":1395,"totalStars":10038,"rank":1},{"at":"2026-10-28T07:30:06.898Z","todayStars":1395,"totalStars":10054,"rank":1},{"at":"2026-10-28T07:32:32.912Z","todayStars":1395,"totalStars":10060,"rank":1},{"at":"2026-10-28T07:56:39.096Z","todayStars":1395,"totalStars":10126,"rank":1},{"at":"2026-10-28T08:15:26.810Z","todayStars":1395,"totalStars":10170,"rank":1},{"at":"2026-10-28T08:43:41.792Z","todayStars":1395,"totalStars":10242,"rank":1},{"at":"2026-10-28T09:40:55.157Z","todayStars":1395,"totalStars":10357,"rank":1},{"at":"2026-10-28T10:22:11.744Z","todayStars":1395,"totalStars":10429,"rank":1},{"at":"2026-10-28T10:23:08.902Z","todayStars":1395,"totalStars":10431,"rank":1},{"at":"2026-10-28T10:30:21.010Z","todayStars":1395,"totalStars":10444,"rank":1},{"at":"2026-10-28T11:54:11.281Z","todayStars":1395,"totalStars":10548,"rank":2}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',39919,2082,2109,6,2,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":2830,"totalStars":39493,"rank":2},{"at":"2026-10-28T07:23:20.500Z","todayStars":2830,"totalStars":39497,"rank":2},{"at":"2026-10-28T07:30:06.898Z","todayStars":2830,"totalStars":39505,"rank":2},{"at":"2026-10-28T07:32:32.912Z","todayStars":2830,"totalStars":39507,"rank":2},{"at":"2026-10-28T07:56:39.096Z","todayStars":2830,"totalStars":39543,"rank":2},{"at":"2026-10-28T08:15:26.810Z","todayStars":2830,"totalStars":39574,"rank":2},{"at":"2026-10-28T08:43:41.792Z","todayStars":2830,"totalStars":39619,"rank":2},{"at":"2026-10-28T09:40:55.157Z","todayStars":2830,"totalStars":39706,"rank":2},{"at":"2026-10-28T10:22:11.744Z","todayStars":2830,"totalStars":39756,"rank":2},{"at":"2026-10-28T10:23:08.902Z","todayStars":2830,"totalStars":39756,"rank":2},{"at":"2026-10-28T10:30:21.010Z","todayStars":2830,"totalStars":39766,"rank":2},{"at":"2026-10-28T11:54:11.281Z","todayStars":2109,"totalStars":39919,"rank":6}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','nightly-labs/openbot','nightly-labs','openbot','nightly-labs/openbot','https://github.com/nightly-labs/openbot','A local-first desktop workspace for persistent AI teammates. Run Codex, Claude, and Grok with dedicated workspaces, task queues, file sharing, browser control, and agent-to-agent collaboration.','TypeScript','#3178c6',2895,286,1053,9,3,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":777,"totalStars":2694,"rank":3},{"at":"2026-10-28T07:23:20.500Z","todayStars":777,"totalStars":2701,"rank":3},{"at":"2026-10-28T07:30:06.898Z","todayStars":777,"totalStars":2704,"rank":3},{"at":"2026-10-28T07:32:32.912Z","todayStars":777,"totalStars":2704,"rank":3},{"at":"2026-10-28T07:56:39.096Z","todayStars":777,"totalStars":2727,"rank":3},{"at":"2026-10-28T08:15:26.810Z","todayStars":777,"totalStars":2741,"rank":3},{"at":"2026-10-28T08:43:41.792Z","todayStars":777,"totalStars":2762,"rank":3},{"at":"2026-10-28T09:40:55.157Z","todayStars":777,"totalStars":2807,"rank":3},{"at":"2026-10-28T10:22:11.744Z","todayStars":777,"totalStars":2836,"rank":3},{"at":"2026-10-28T10:23:08.902Z","todayStars":777,"totalStars":2836,"rank":3},{"at":"2026-10-28T10:30:21.010Z","todayStars":777,"totalStars":2838,"rank":3},{"at":"2026-10-28T11:54:11.281Z","todayStars":1053,"totalStars":2895,"rank":9}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',306919,27316,1096,3,3,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":617,"totalStars":306715,"rank":4},{"at":"2026-10-28T07:23:20.500Z","todayStars":617,"totalStars":306725,"rank":4},{"at":"2026-10-28T07:30:06.898Z","todayStars":617,"totalStars":306727,"rank":4},{"at":"2026-10-28T07:32:32.912Z","todayStars":617,"totalStars":306728,"rank":4},{"at":"2026-10-28T07:56:39.096Z","todayStars":617,"totalStars":306741,"rank":4},{"at":"2026-10-28T08:15:26.810Z","todayStars":617,"totalStars":306761,"rank":4},{"at":"2026-10-28T08:43:41.792Z","todayStars":617,"totalStars":306784,"rank":4},{"at":"2026-10-28T09:40:55.157Z","todayStars":617,"totalStars":306832,"rank":4},{"at":"2026-10-28T10:22:11.744Z","todayStars":617,"totalStars":306862,"rank":4},{"at":"2026-10-28T10:23:08.902Z","todayStars":617,"totalStars":306862,"rank":4},{"at":"2026-10-28T10:30:21.010Z","todayStars":617,"totalStars":306870,"rank":4},{"at":"2026-10-28T11:54:11.281Z","todayStars":1096,"totalStars":306919,"rank":3}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',91292,5401,1471,7,5,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1449,"totalStars":91025,"rank":5},{"at":"2026-10-28T07:23:20.500Z","todayStars":1449,"totalStars":91030,"rank":5},{"at":"2026-10-28T07:30:06.898Z","todayStars":1449,"totalStars":91037,"rank":5},{"at":"2026-10-28T07:32:32.912Z","todayStars":1449,"totalStars":91038,"rank":5},{"at":"2026-10-28T07:56:39.096Z","todayStars":1449,"totalStars":91059,"rank":5},{"at":"2026-10-28T08:15:26.810Z","todayStars":1449,"totalStars":91074,"rank":5},{"at":"2026-10-28T08:43:41.792Z","todayStars":1449,"totalStars":91100,"rank":5},{"at":"2026-10-28T09:40:55.157Z","todayStars":1449,"totalStars":91165,"rank":5},{"at":"2026-10-28T10:22:11.744Z","todayStars":1449,"totalStars":91205,"rank":5},{"at":"2026-10-28T10:23:08.902Z","todayStars":1449,"totalStars":91205,"rank":5},{"at":"2026-10-28T10:30:21.010Z","todayStars":1449,"totalStars":91212,"rank":5},{"at":"2026-10-28T11:54:11.281Z","todayStars":1471,"totalStars":91292,"rank":7}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','makecindy/cindy','makecindy','cindy','makecindy/cindy','https://github.com/makecindy/cindy','Consider it done. The open-source AI agent that works out of the box · 想到，就能做到。开源、开箱即用的 AI Agent。','TypeScript','#3178c6',7824,921,740,8,6,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1465,"totalStars":7700,"rank":6},{"at":"2026-10-28T07:23:20.500Z","todayStars":1465,"totalStars":7702,"rank":6},{"at":"2026-10-28T07:30:06.898Z","todayStars":1465,"totalStars":7706,"rank":6},{"at":"2026-10-28T07:32:32.912Z","todayStars":1465,"totalStars":7707,"rank":6},{"at":"2026-10-28T07:56:39.096Z","todayStars":1465,"totalStars":7717,"rank":6},{"at":"2026-10-28T08:15:26.810Z","todayStars":1465,"totalStars":7725,"rank":6},{"at":"2026-10-28T08:43:41.792Z","todayStars":1465,"totalStars":7738,"rank":6},{"at":"2026-10-28T09:40:55.157Z","todayStars":1465,"totalStars":7769,"rank":6},{"at":"2026-10-28T10:22:11.744Z","todayStars":1465,"totalStars":7785,"rank":6},{"at":"2026-10-28T10:23:08.902Z","todayStars":1465,"totalStars":7786,"rank":6},{"at":"2026-10-28T10:30:21.010Z","todayStars":1465,"totalStars":7789,"rank":6},{"at":"2026-10-28T11:54:11.281Z","todayStars":740,"totalStars":7824,"rank":8}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','gitroomhq/postiz-app','gitroomhq','postiz-app','gitroomhq/postiz-app','https://github.com/gitroomhq/postiz-app','📨 The ultimate agentic social media scheduling tool 🤖','TypeScript','#3178c6',39800,7548,951,NULL,7,2,1,'2026-10-28T11:54:11.281Z','2026-10-28T07:18:06.192Z','2026-10-28T10:30:21.010Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":951,"totalStars":39661,"rank":7},{"at":"2026-10-28T07:23:20.500Z","todayStars":951,"totalStars":39665,"rank":7},{"at":"2026-10-28T07:30:06.898Z","todayStars":951,"totalStars":39667,"rank":7},{"at":"2026-10-28T07:32:32.912Z","todayStars":951,"totalStars":39670,"rank":7},{"at":"2026-10-28T07:56:39.096Z","todayStars":951,"totalStars":39689,"rank":7},{"at":"2026-10-28T08:15:26.810Z","todayStars":951,"totalStars":39700,"rank":7},{"at":"2026-10-28T08:43:41.792Z","todayStars":951,"totalStars":39727,"rank":7},{"at":"2026-10-28T09:40:55.157Z","todayStars":951,"totalStars":39770,"rank":7},{"at":"2026-10-28T10:22:11.744Z","todayStars":951,"totalStars":39795,"rank":7},{"at":"2026-10-28T10:23:08.902Z","todayStars":951,"totalStars":39798,"rank":7},{"at":"2026-10-28T10:30:21.010Z","todayStars":951,"totalStars":39800,"rank":7}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',291277,43121,1165,NULL,8,2,1,'2026-10-28T11:54:11.281Z','2026-10-28T07:18:06.192Z','2026-10-28T10:30:21.010Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1165,"totalStars":291130,"rank":8},{"at":"2026-10-28T07:23:20.500Z","todayStars":1165,"totalStars":291133,"rank":8},{"at":"2026-10-28T07:30:06.898Z","todayStars":1165,"totalStars":291139,"rank":8},{"at":"2026-10-28T07:32:32.912Z","todayStars":1165,"totalStars":291141,"rank":8},{"at":"2026-10-28T07:56:39.096Z","todayStars":1165,"totalStars":291162,"rank":8},{"at":"2026-10-28T08:15:26.810Z","todayStars":1165,"totalStars":291179,"rank":8},{"at":"2026-10-28T08:43:41.792Z","todayStars":1165,"totalStars":291198,"rank":8},{"at":"2026-10-28T09:40:55.157Z","todayStars":1165,"totalStars":291235,"rank":8},{"at":"2026-10-28T10:22:11.744Z","todayStars":1165,"totalStars":291269,"rank":8},{"at":"2026-10-28T10:23:08.902Z","todayStars":1165,"totalStars":291269,"rank":8},{"at":"2026-10-28T10:30:21.010Z","todayStars":1165,"totalStars":291277,"rank":8}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',47141,5869,2376,4,4,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1598,"totalStars":46632,"rank":9},{"at":"2026-10-28T07:23:20.500Z","todayStars":1598,"totalStars":46649,"rank":9},{"at":"2026-10-28T07:30:06.898Z","todayStars":1598,"totalStars":46668,"rank":9},{"at":"2026-10-28T07:32:32.912Z","todayStars":1598,"totalStars":46668,"rank":9},{"at":"2026-10-28T07:56:39.096Z","todayStars":1598,"totalStars":46726,"rank":9},{"at":"2026-10-28T08:15:26.810Z","todayStars":1598,"totalStars":46760,"rank":9},{"at":"2026-10-28T08:43:41.792Z","todayStars":1598,"totalStars":46828,"rank":9},{"at":"2026-10-28T09:40:55.157Z","todayStars":1598,"totalStars":46955,"rank":9},{"at":"2026-10-28T10:22:11.744Z","todayStars":1598,"totalStars":47016,"rank":9},{"at":"2026-10-28T10:23:08.902Z","todayStars":1598,"totalStars":47019,"rank":9},{"at":"2026-10-28T10:30:21.010Z","todayStars":1598,"totalStars":47028,"rank":9},{"at":"2026-10-28T11:54:11.281Z","todayStars":2376,"totalStars":47141,"rank":4}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',4543,236,1075,1,1,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":1204,"totalStars":4357,"rank":10},{"at":"2026-10-28T07:23:20.500Z","todayStars":1204,"totalStars":4362,"rank":10},{"at":"2026-10-28T07:30:06.898Z","todayStars":1204,"totalStars":4366,"rank":10},{"at":"2026-10-28T07:32:32.912Z","todayStars":1204,"totalStars":4366,"rank":10},{"at":"2026-10-28T07:56:39.096Z","todayStars":1204,"totalStars":4386,"rank":10},{"at":"2026-10-28T08:15:26.810Z","todayStars":1204,"totalStars":4395,"rank":10},{"at":"2026-10-28T08:43:41.792Z","todayStars":1204,"totalStars":4412,"rank":10},{"at":"2026-10-28T09:40:55.157Z","todayStars":1204,"totalStars":4454,"rank":10},{"at":"2026-10-28T10:22:11.744Z","todayStars":1204,"totalStars":4486,"rank":10},{"at":"2026-10-28T10:23:08.902Z","todayStars":1204,"totalStars":4486,"rank":10},{"at":"2026-10-28T10:30:21.010Z","todayStars":1204,"totalStars":4489,"rank":10},{"at":"2026-10-28T11:54:11.281Z","todayStars":1075,"totalStars":4543,"rank":1}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',6338,914,1478,10,10,0,0,NULL,'2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T07:18:06.192Z","todayStars":902,"totalStars":6015,"rank":11},{"at":"2026-10-28T07:23:20.500Z","todayStars":902,"totalStars":6023,"rank":11},{"at":"2026-10-28T07:30:06.898Z","todayStars":902,"totalStars":6031,"rank":11},{"at":"2026-10-28T07:32:32.912Z","todayStars":902,"totalStars":6035,"rank":11},{"at":"2026-10-28T07:56:39.096Z","todayStars":902,"totalStars":6058,"rank":11},{"at":"2026-10-28T08:15:26.810Z","todayStars":902,"totalStars":6091,"rank":11},{"at":"2026-10-28T08:43:41.792Z","todayStars":902,"totalStars":6134,"rank":11},{"at":"2026-10-28T09:40:55.157Z","todayStars":902,"totalStars":6188,"rank":11},{"at":"2026-10-28T10:22:11.744Z","todayStars":902,"totalStars":6231,"rank":11},{"at":"2026-10-28T10:23:08.902Z","todayStars":902,"totalStars":6231,"rank":11},{"at":"2026-10-28T10:30:21.010Z","todayStars":902,"totalStars":6239,"rank":11},{"at":"2026-10-28T11:54:11.281Z","todayStars":1478,"totalStars":6338,"rank":10}]','2026-10-28T07:18:06.192Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',50886,3208,16388,1,1,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":16388,"totalStars":50587,"rank":1},{"at":"2026-10-28T07:23:23.017Z","todayStars":16388,"totalStars":50594,"rank":1},{"at":"2026-10-28T07:30:09.475Z","todayStars":16388,"totalStars":50603,"rank":1},{"at":"2026-10-28T07:32:35.394Z","todayStars":16388,"totalStars":50605,"rank":1},{"at":"2026-10-28T07:56:41.557Z","todayStars":16388,"totalStars":50630,"rank":1},{"at":"2026-10-28T08:15:29.303Z","todayStars":16388,"totalStars":50657,"rank":1},{"at":"2026-10-28T08:43:44.404Z","todayStars":16388,"totalStars":50678,"rank":1},{"at":"2026-10-28T09:40:58.018Z","todayStars":16388,"totalStars":50748,"rank":1},{"at":"2026-10-28T10:22:14.146Z","todayStars":16388,"totalStars":50785,"rank":1},{"at":"2026-10-28T10:23:11.363Z","todayStars":16388,"totalStars":50787,"rank":1},{"at":"2026-10-28T10:30:21.317Z","todayStars":16388,"totalStars":50797,"rank":1},{"at":"2026-10-28T11:54:11.436Z","todayStars":16388,"totalStars":50886,"rank":1}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33541,3684,2789,4,2,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":2789,"totalStars":33507,"rank":2},{"at":"2026-10-28T07:23:23.017Z","todayStars":2789,"totalStars":33508,"rank":2},{"at":"2026-10-28T07:30:09.475Z","todayStars":2789,"totalStars":33509,"rank":2},{"at":"2026-10-28T07:32:35.394Z","todayStars":2789,"totalStars":33509,"rank":2},{"at":"2026-10-28T07:56:41.557Z","todayStars":2789,"totalStars":33511,"rank":2},{"at":"2026-10-28T08:15:29.303Z","todayStars":2789,"totalStars":33515,"rank":2},{"at":"2026-10-28T08:43:44.404Z","todayStars":2789,"totalStars":33518,"rank":2},{"at":"2026-10-28T09:40:58.018Z","todayStars":2789,"totalStars":33525,"rank":2},{"at":"2026-10-28T10:22:14.146Z","todayStars":2789,"totalStars":33533,"rank":2},{"at":"2026-10-28T10:23:11.363Z","todayStars":2789,"totalStars":33533,"rank":2},{"at":"2026-10-28T10:30:21.317Z","todayStars":2789,"totalStars":33533,"rank":2},{"at":"2026-10-28T11:54:11.436Z","todayStars":2789,"totalStars":33541,"rank":4}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',23003,3125,3081,2,2,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":3081,"totalStars":22898,"rank":3},{"at":"2026-10-28T07:23:23.017Z","todayStars":3081,"totalStars":22900,"rank":3},{"at":"2026-10-28T07:30:09.475Z","todayStars":3081,"totalStars":22901,"rank":3},{"at":"2026-10-28T07:32:35.394Z","todayStars":3081,"totalStars":22903,"rank":3},{"at":"2026-10-28T07:56:41.557Z","todayStars":3081,"totalStars":22907,"rank":3},{"at":"2026-10-28T08:15:29.303Z","todayStars":3081,"totalStars":22918,"rank":3},{"at":"2026-10-28T08:43:44.404Z","todayStars":3081,"totalStars":22924,"rank":3},{"at":"2026-10-28T09:40:58.018Z","todayStars":3081,"totalStars":22947,"rank":3},{"at":"2026-10-28T10:22:14.146Z","todayStars":3081,"totalStars":22961,"rank":3},{"at":"2026-10-28T10:23:11.363Z","todayStars":3081,"totalStars":22961,"rank":3},{"at":"2026-10-28T10:30:21.317Z","todayStars":3081,"totalStars":22964,"rank":3},{"at":"2026-10-28T11:54:11.436Z","todayStars":3081,"totalStars":23003,"rank":2}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',225741,22548,4039,3,3,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":4039,"totalStars":225636,"rank":4},{"at":"2026-10-28T07:23:23.017Z","todayStars":4039,"totalStars":225637,"rank":4},{"at":"2026-10-28T07:30:09.475Z","todayStars":4039,"totalStars":225640,"rank":4},{"at":"2026-10-28T07:32:35.394Z","todayStars":4039,"totalStars":225642,"rank":4},{"at":"2026-10-28T07:56:41.557Z","todayStars":4039,"totalStars":225651,"rank":4},{"at":"2026-10-28T08:15:29.303Z","todayStars":4039,"totalStars":225662,"rank":4},{"at":"2026-10-28T08:43:44.404Z","todayStars":4039,"totalStars":225668,"rank":4},{"at":"2026-10-28T09:40:58.018Z","todayStars":4039,"totalStars":225687,"rank":4},{"at":"2026-10-28T10:22:14.146Z","todayStars":4039,"totalStars":225713,"rank":4},{"at":"2026-10-28T10:23:11.363Z","todayStars":4039,"totalStars":225713,"rank":4},{"at":"2026-10-28T10:30:21.317Z","todayStars":4039,"totalStars":225714,"rank":4},{"at":"2026-10-28T11:54:11.436Z","todayStars":4039,"totalStars":225741,"rank":3}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',117626,22510,4882,5,5,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":4882,"totalStars":117503,"rank":5},{"at":"2026-10-28T07:23:23.017Z","todayStars":4882,"totalStars":117509,"rank":5},{"at":"2026-10-28T07:30:09.475Z","todayStars":4882,"totalStars":117512,"rank":5},{"at":"2026-10-28T07:32:35.394Z","todayStars":4882,"totalStars":117512,"rank":5},{"at":"2026-10-28T07:56:41.557Z","todayStars":4882,"totalStars":117522,"rank":5},{"at":"2026-10-28T08:15:29.303Z","todayStars":4882,"totalStars":117532,"rank":5},{"at":"2026-10-28T08:43:44.404Z","todayStars":4882,"totalStars":117551,"rank":5},{"at":"2026-10-28T09:40:58.018Z","todayStars":4882,"totalStars":117575,"rank":5},{"at":"2026-10-28T10:22:14.146Z","todayStars":4882,"totalStars":117593,"rank":5},{"at":"2026-10-28T10:23:11.363Z","todayStars":4882,"totalStars":117593,"rank":5},{"at":"2026-10-28T10:30:21.317Z","todayStars":4882,"totalStars":117596,"rank":5},{"at":"2026-10-28T11:54:11.436Z","todayStars":4882,"totalStars":117626,"rank":5}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','graphify-labs/graphify','Graphify-Labs','graphify','Graphify-Labs/graphify','https://github.com/Graphify-Labs/graphify','Turn any codebase, with its docs, SQL schemas, configs, and PDFs, into a queryable knowledge graph. A /graphify skill for Claude Code, Cursor, Codex, and Gemini CLI: local deterministic AST parsing, every edge explained, no vector store.','Python','#3572A5',137352,13101,7268,7,6,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":7268,"totalStars":137188,"rank":6},{"at":"2026-10-28T07:23:23.017Z","todayStars":7268,"totalStars":137190,"rank":6},{"at":"2026-10-28T07:30:09.475Z","todayStars":7268,"totalStars":137195,"rank":6},{"at":"2026-10-28T07:32:35.394Z","todayStars":7268,"totalStars":137196,"rank":6},{"at":"2026-10-28T07:56:41.557Z","todayStars":7268,"totalStars":137214,"rank":6},{"at":"2026-10-28T08:15:29.303Z","todayStars":7268,"totalStars":137229,"rank":6},{"at":"2026-10-28T08:43:44.404Z","todayStars":7268,"totalStars":137237,"rank":6},{"at":"2026-10-28T09:40:58.018Z","todayStars":7268,"totalStars":137270,"rank":6},{"at":"2026-10-28T10:22:14.146Z","todayStars":7268,"totalStars":137296,"rank":6},{"at":"2026-10-28T10:23:11.363Z","todayStars":7268,"totalStars":137297,"rank":6},{"at":"2026-10-28T10:30:21.317Z","todayStars":7268,"totalStars":137302,"rank":6},{"at":"2026-10-28T11:54:11.436Z","todayStars":7268,"totalStars":137352,"rank":7}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','ruvnet/ruflo','ruvnet','ruflo','ruvnet/ruflo','https://github.com/ruvnet/ruflo','🌊 The original agent harness. Deploy intelligent multi-player swarms, coordinate autonomous workflows, and build conversational AI systems. Features adaptive memory, self-learning intelligence, federation, vector RAG integration, and native Claude Code / Codex / Hermes and many more Integrated','TypeScript','#3178c6',79874,9369,2296,8,7,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":2296,"totalStars":79839,"rank":7},{"at":"2026-10-28T07:23:23.017Z","todayStars":2296,"totalStars":79839,"rank":7},{"at":"2026-10-28T07:30:09.475Z","todayStars":2296,"totalStars":79840,"rank":7},{"at":"2026-10-28T07:32:35.394Z","todayStars":2296,"totalStars":79840,"rank":7},{"at":"2026-10-28T07:56:41.557Z","todayStars":2296,"totalStars":79843,"rank":7},{"at":"2026-10-28T08:15:29.303Z","todayStars":2296,"totalStars":79848,"rank":7},{"at":"2026-10-28T08:43:44.404Z","todayStars":2296,"totalStars":79854,"rank":7},{"at":"2026-10-28T09:40:58.018Z","todayStars":2296,"totalStars":79865,"rank":7},{"at":"2026-10-28T10:22:14.146Z","todayStars":2296,"totalStars":79867,"rank":7},{"at":"2026-10-28T10:23:11.363Z","todayStars":2296,"totalStars":79866,"rank":7},{"at":"2026-10-28T10:30:21.317Z","todayStars":2296,"totalStars":79865,"rank":7},{"at":"2026-10-28T11:54:11.436Z","todayStars":2296,"totalStars":79874,"rank":8}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','anomalyco/opencode','anomalyco','opencode','anomalyco/opencode','https://github.com/anomalyco/opencode','The open source coding agent.','TypeScript','#3178c6',222581,29798,4334,9,8,0,0,NULL,'2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":4334,"totalStars":222494,"rank":8},{"at":"2026-10-28T07:23:23.017Z","todayStars":4334,"totalStars":222494,"rank":8},{"at":"2026-10-28T07:30:09.475Z","todayStars":4334,"totalStars":222495,"rank":8},{"at":"2026-10-28T07:32:35.394Z","todayStars":4334,"totalStars":222496,"rank":8},{"at":"2026-10-28T07:56:41.557Z","todayStars":4334,"totalStars":222509,"rank":8},{"at":"2026-10-28T08:15:29.303Z","todayStars":4334,"totalStars":222512,"rank":8},{"at":"2026-10-28T08:43:44.404Z","todayStars":4334,"totalStars":222518,"rank":8},{"at":"2026-10-28T09:40:58.018Z","todayStars":4334,"totalStars":222533,"rank":8},{"at":"2026-10-28T10:22:14.146Z","todayStars":4334,"totalStars":222544,"rank":8},{"at":"2026-10-28T10:23:11.363Z","todayStars":4334,"totalStars":222543,"rank":8},{"at":"2026-10-28T10:30:21.317Z","todayStars":4334,"totalStars":222546,"rank":8},{"at":"2026-10-28T11:54:11.436Z","todayStars":4334,"totalStars":222581,"rank":9}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','stablyai/orca','stablyai','orca','stablyai/orca','https://github.com/stablyai/orca','Orca is the place for working with a fleet of agents (e.g. Grok Bot, Claude Code). Run any coding agent with your own subscription. Available on desktop, mobile and remote runtime.','TypeScript','#3178c6',108508,6852,8802,NULL,9,2,1,'2026-10-28T11:54:11.436Z','2026-10-28T07:18:08.874Z','2026-10-28T10:30:21.317Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":8802,"totalStars":108343,"rank":9},{"at":"2026-10-28T07:23:23.017Z","todayStars":8802,"totalStars":108346,"rank":9},{"at":"2026-10-28T07:30:09.475Z","todayStars":8802,"totalStars":108352,"rank":9},{"at":"2026-10-28T07:32:35.394Z","todayStars":8802,"totalStars":108356,"rank":9},{"at":"2026-10-28T07:56:41.557Z","todayStars":8802,"totalStars":108385,"rank":9},{"at":"2026-10-28T08:15:29.303Z","todayStars":8802,"totalStars":108406,"rank":9},{"at":"2026-10-28T08:43:44.404Z","todayStars":8802,"totalStars":108431,"rank":9},{"at":"2026-10-28T09:40:58.018Z","todayStars":8802,"totalStars":108464,"rank":9},{"at":"2026-10-28T10:22:14.146Z","todayStars":8802,"totalStars":108502,"rank":9},{"at":"2026-10-28T10:23:11.363Z","todayStars":8802,"totalStars":108502,"rank":9},{"at":"2026-10-28T10:30:21.317Z","todayStars":8802,"totalStars":108508,"rank":9}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','android/skills','android','skills','android/skills','https://github.com/android/skills','','Kotlin','#A97BFF',9955,643,873,NULL,10,2,1,'2026-10-28T11:54:11.436Z','2026-10-28T07:18:08.874Z','2026-10-28T10:30:21.317Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":873,"totalStars":9936,"rank":10},{"at":"2026-10-28T07:23:23.017Z","todayStars":873,"totalStars":9937,"rank":10},{"at":"2026-10-28T07:30:09.475Z","todayStars":873,"totalStars":9937,"rank":10},{"at":"2026-10-28T07:32:35.394Z","todayStars":873,"totalStars":9937,"rank":10},{"at":"2026-10-28T07:56:41.557Z","todayStars":873,"totalStars":9940,"rank":10},{"at":"2026-10-28T08:15:29.303Z","todayStars":873,"totalStars":9943,"rank":10},{"at":"2026-10-28T08:43:44.404Z","todayStars":873,"totalStars":9946,"rank":10},{"at":"2026-10-28T09:40:58.018Z","todayStars":873,"totalStars":9950,"rank":10},{"at":"2026-10-28T10:22:14.146Z","todayStars":873,"totalStars":9955,"rank":10},{"at":"2026-10-28T10:23:11.363Z","todayStars":873,"totalStars":9955,"rank":10},{"at":"2026-10-28T10:30:21.317Z","todayStars":873,"totalStars":9955,"rank":10}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','akitaonrails/ai-memory','akitaonrails','ai-memory','akitaonrails/ai-memory','https://github.com/akitaonrails/ai-memory','Solution for long term memory for agent coding CLIs and to facilitate handoff between different agent vendors','Rust','#dea584',14195,1009,2239,NULL,11,2,1,'2026-10-28T11:54:11.436Z','2026-10-28T07:18:08.874Z','2026-10-28T10:30:21.317Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":2239,"totalStars":14162,"rank":11},{"at":"2026-10-28T07:23:23.017Z","todayStars":2239,"totalStars":14161,"rank":11},{"at":"2026-10-28T07:30:09.475Z","todayStars":2239,"totalStars":14161,"rank":11},{"at":"2026-10-28T07:32:35.394Z","todayStars":2239,"totalStars":14161,"rank":11},{"at":"2026-10-28T07:56:41.557Z","todayStars":2239,"totalStars":14166,"rank":11},{"at":"2026-10-28T08:15:29.303Z","todayStars":2239,"totalStars":14170,"rank":11},{"at":"2026-10-28T08:43:44.404Z","todayStars":2239,"totalStars":14176,"rank":11},{"at":"2026-10-28T09:40:58.018Z","todayStars":2239,"totalStars":14186,"rank":11},{"at":"2026-10-28T10:22:14.146Z","todayStars":2239,"totalStars":14193,"rank":11},{"at":"2026-10-28T10:23:11.363Z","todayStars":2239,"totalStars":14193,"rank":11},{"at":"2026-10-28T10:30:21.317Z","todayStars":2239,"totalStars":14195,"rank":11}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',30958,8290,1988,NULL,12,2,1,'2026-10-28T11:54:11.436Z','2026-10-28T07:18:08.874Z','2026-10-28T10:30:21.317Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":1988,"totalStars":30920,"rank":12},{"at":"2026-10-28T07:23:23.017Z","todayStars":1988,"totalStars":30921,"rank":12},{"at":"2026-10-28T07:30:09.475Z","todayStars":1988,"totalStars":30921,"rank":12},{"at":"2026-10-28T07:32:35.394Z","todayStars":1988,"totalStars":30922,"rank":12},{"at":"2026-10-28T07:56:41.557Z","todayStars":1988,"totalStars":30927,"rank":12},{"at":"2026-10-28T08:15:29.303Z","todayStars":1988,"totalStars":30933,"rank":12},{"at":"2026-10-28T08:43:44.404Z","todayStars":1988,"totalStars":30938,"rank":12},{"at":"2026-10-28T09:40:58.018Z","todayStars":1988,"totalStars":30945,"rank":12},{"at":"2026-10-28T10:22:14.146Z","todayStars":1988,"totalStars":30957,"rank":12},{"at":"2026-10-28T10:23:11.363Z","todayStars":1988,"totalStars":30957,"rank":12},{"at":"2026-10-28T10:30:21.317Z","todayStars":1988,"totalStars":30958,"rank":12}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','fastapi/fastapi','fastapi','fastapi','fastapi/fastapi','https://github.com/fastapi/fastapi','FastAPI framework, high performance, easy to learn, fast to code, ready for production','Python','#3572A5',104230,10135,1089,NULL,13,2,1,'2026-10-28T11:54:11.436Z','2026-10-28T07:18:08.874Z','2026-10-28T10:30:21.317Z','[{"at":"2026-10-28T07:18:08.874Z","todayStars":1089,"totalStars":104213,"rank":13},{"at":"2026-10-28T07:23:23.017Z","todayStars":1089,"totalStars":104213,"rank":13},{"at":"2026-10-28T07:30:09.475Z","todayStars":1089,"totalStars":104214,"rank":13},{"at":"2026-10-28T07:32:35.394Z","todayStars":1089,"totalStars":104214,"rank":13},{"at":"2026-10-28T07:56:41.557Z","todayStars":1089,"totalStars":104215,"rank":13},{"at":"2026-10-28T08:15:29.303Z","todayStars":1089,"totalStars":104218,"rank":13},{"at":"2026-10-28T08:43:44.404Z","todayStars":1089,"totalStars":104220,"rank":13},{"at":"2026-10-28T09:40:58.018Z","todayStars":1089,"totalStars":104226,"rank":13},{"at":"2026-10-28T10:22:14.146Z","todayStars":1089,"totalStars":104230,"rank":13},{"at":"2026-10-28T10:23:11.363Z","todayStars":1089,"totalStars":104230,"rank":13},{"at":"2026-10-28T10:30:21.317Z","todayStars":1089,"totalStars":104230,"rank":13}]','2026-10-28T07:18:08.874Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',74348,6751,20501,1,1,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":20501,"totalStars":74171,"rank":1},{"at":"2026-10-28T07:23:26.230Z","todayStars":20501,"totalStars":74173,"rank":1},{"at":"2026-10-28T07:30:12.108Z","todayStars":20501,"totalStars":74176,"rank":1},{"at":"2026-10-28T07:32:38.167Z","todayStars":20501,"totalStars":74177,"rank":1},{"at":"2026-10-28T07:56:44.181Z","todayStars":20501,"totalStars":74197,"rank":1},{"at":"2026-10-28T08:15:31.813Z","todayStars":20501,"totalStars":74211,"rank":1},{"at":"2026-10-28T08:43:49.465Z","todayStars":20501,"totalStars":74232,"rank":1},{"at":"2026-10-28T09:41:01.556Z","todayStars":20501,"totalStars":74270,"rank":1},{"at":"2026-10-28T10:22:16.534Z","todayStars":20501,"totalStars":74291,"rank":1},{"at":"2026-10-28T10:23:14.174Z","todayStars":20501,"totalStars":74292,"rank":1},{"at":"2026-10-28T10:30:21.570Z","todayStars":20501,"totalStars":74294,"rank":1},{"at":"2026-10-28T11:54:11.565Z","todayStars":20501,"totalStars":74348,"rank":1}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',50886,3208,27415,2,2,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":27415,"totalStars":50587,"rank":2},{"at":"2026-10-28T07:23:26.230Z","todayStars":27415,"totalStars":50594,"rank":2},{"at":"2026-10-28T07:30:12.108Z","todayStars":27415,"totalStars":50603,"rank":2},{"at":"2026-10-28T07:32:38.167Z","todayStars":27415,"totalStars":50605,"rank":2},{"at":"2026-10-28T07:56:44.181Z","todayStars":27415,"totalStars":50630,"rank":2},{"at":"2026-10-28T08:15:31.813Z","todayStars":27415,"totalStars":50657,"rank":2},{"at":"2026-10-28T08:43:49.465Z","todayStars":27415,"totalStars":50678,"rank":2},{"at":"2026-10-28T09:41:01.556Z","todayStars":27415,"totalStars":50748,"rank":2},{"at":"2026-10-28T10:22:16.534Z","todayStars":27415,"totalStars":50785,"rank":2},{"at":"2026-10-28T10:23:14.174Z","todayStars":27415,"totalStars":50787,"rank":2},{"at":"2026-10-28T10:30:21.570Z","todayStars":27415,"totalStars":50797,"rank":2},{"at":"2026-10-28T11:54:11.565Z","todayStars":27415,"totalStars":50886,"rank":2}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',92235,10205,52726,6,3,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":52726,"totalStars":91878,"rank":3},{"at":"2026-10-28T07:23:26.230Z","todayStars":52726,"totalStars":91883,"rank":3},{"at":"2026-10-28T07:30:12.108Z","todayStars":52726,"totalStars":91889,"rank":3},{"at":"2026-10-28T07:32:38.167Z","todayStars":52726,"totalStars":91894,"rank":3},{"at":"2026-10-28T07:56:44.181Z","todayStars":52726,"totalStars":91931,"rank":3},{"at":"2026-10-28T08:15:31.813Z","todayStars":52726,"totalStars":91961,"rank":3},{"at":"2026-10-28T08:43:49.465Z","todayStars":52726,"totalStars":92002,"rank":3},{"at":"2026-10-28T09:41:01.556Z","todayStars":52726,"totalStars":92081,"rank":3},{"at":"2026-10-28T10:22:16.534Z","todayStars":52726,"totalStars":92147,"rank":3},{"at":"2026-10-28T10:23:14.174Z","todayStars":52726,"totalStars":92148,"rank":3},{"at":"2026-10-28T10:30:21.570Z","todayStars":52726,"totalStars":92159,"rank":3},{"at":"2026-10-28T11:54:11.565Z","todayStars":52726,"totalStars":92235,"rank":6}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33541,3684,7792,3,3,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":7792,"totalStars":33507,"rank":4},{"at":"2026-10-28T07:23:26.230Z","todayStars":7792,"totalStars":33508,"rank":4},{"at":"2026-10-28T07:30:12.108Z","todayStars":7792,"totalStars":33509,"rank":4},{"at":"2026-10-28T07:32:38.167Z","todayStars":7792,"totalStars":33509,"rank":4},{"at":"2026-10-28T07:56:44.181Z","todayStars":7792,"totalStars":33511,"rank":4},{"at":"2026-10-28T08:15:31.813Z","todayStars":7792,"totalStars":33515,"rank":4},{"at":"2026-10-28T08:43:49.465Z","todayStars":7792,"totalStars":33518,"rank":4},{"at":"2026-10-28T09:41:01.556Z","todayStars":7792,"totalStars":33526,"rank":4},{"at":"2026-10-28T10:22:16.534Z","todayStars":7792,"totalStars":33533,"rank":4},{"at":"2026-10-28T10:23:14.174Z","todayStars":7792,"totalStars":33533,"rank":4},{"at":"2026-10-28T10:30:21.570Z","todayStars":7792,"totalStars":33533,"rank":4},{"at":"2026-10-28T11:54:11.565Z","todayStars":7792,"totalStars":33541,"rank":3}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',91292,5401,18683,5,5,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":18683,"totalStars":91025,"rank":5},{"at":"2026-10-28T07:23:26.230Z","todayStars":18683,"totalStars":91031,"rank":5},{"at":"2026-10-28T07:30:12.108Z","todayStars":18683,"totalStars":91037,"rank":5},{"at":"2026-10-28T07:32:38.167Z","todayStars":18683,"totalStars":91038,"rank":5},{"at":"2026-10-28T07:56:44.181Z","todayStars":18683,"totalStars":91059,"rank":5},{"at":"2026-10-28T08:15:31.813Z","todayStars":18683,"totalStars":91074,"rank":5},{"at":"2026-10-28T08:43:49.465Z","todayStars":18683,"totalStars":91100,"rank":5},{"at":"2026-10-28T09:41:01.556Z","todayStars":18683,"totalStars":91165,"rank":5},{"at":"2026-10-28T10:22:16.534Z","todayStars":18683,"totalStars":91205,"rank":5},{"at":"2026-10-28T10:23:14.174Z","todayStars":18683,"totalStars":91205,"rank":5},{"at":"2026-10-28T10:30:21.570Z","todayStars":18683,"totalStars":91212,"rank":5},{"at":"2026-10-28T11:54:11.565Z","todayStars":18683,"totalStars":91292,"rank":5}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',23748,2293,7192,4,4,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":7192,"totalStars":23676,"rank":6},{"at":"2026-10-28T07:23:26.230Z","todayStars":7192,"totalStars":23678,"rank":6},{"at":"2026-10-28T07:30:12.108Z","todayStars":7192,"totalStars":23678,"rank":6},{"at":"2026-10-28T07:32:38.167Z","todayStars":7192,"totalStars":23679,"rank":6},{"at":"2026-10-28T07:56:44.181Z","todayStars":7192,"totalStars":23685,"rank":6},{"at":"2026-10-28T08:15:31.813Z","todayStars":7192,"totalStars":23688,"rank":6},{"at":"2026-10-28T08:43:49.465Z","todayStars":7192,"totalStars":23696,"rank":6},{"at":"2026-10-28T09:41:01.556Z","todayStars":7192,"totalStars":23709,"rank":6},{"at":"2026-10-28T10:22:16.534Z","todayStars":7192,"totalStars":23720,"rank":6},{"at":"2026-10-28T10:23:14.174Z","todayStars":7192,"totalStars":23720,"rank":6},{"at":"2026-10-28T10:30:21.570Z","todayStars":7192,"totalStars":23721,"rank":6},{"at":"2026-10-28T11:54:11.565Z","todayStars":7192,"totalStars":23748,"rank":4}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',32629,2254,8586,9,7,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":8586,"totalStars":32590,"rank":7},{"at":"2026-10-28T07:23:26.230Z","todayStars":8586,"totalStars":32592,"rank":7},{"at":"2026-10-28T07:30:12.108Z","todayStars":8586,"totalStars":32594,"rank":7},{"at":"2026-10-28T07:32:38.167Z","todayStars":8586,"totalStars":32595,"rank":7},{"at":"2026-10-28T07:56:44.181Z","todayStars":8586,"totalStars":32594,"rank":7},{"at":"2026-10-28T08:15:31.813Z","todayStars":8586,"totalStars":32599,"rank":7},{"at":"2026-10-28T08:43:49.465Z","todayStars":8586,"totalStars":32605,"rank":7},{"at":"2026-10-28T09:41:01.556Z","todayStars":8586,"totalStars":32611,"rank":7},{"at":"2026-10-28T10:22:16.534Z","todayStars":8586,"totalStars":32619,"rank":7},{"at":"2026-10-28T10:23:14.174Z","todayStars":8586,"totalStars":32619,"rank":7},{"at":"2026-10-28T10:30:21.570Z","todayStars":8586,"totalStars":32619,"rank":7},{"at":"2026-10-28T11:54:11.565Z","todayStars":8586,"totalStars":32629,"rank":9}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',14417,1448,5597,7,7,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":5597,"totalStars":14393,"rank":8},{"at":"2026-10-28T07:23:26.230Z","todayStars":5597,"totalStars":14393,"rank":8},{"at":"2026-10-28T07:30:12.108Z","todayStars":5597,"totalStars":14394,"rank":8},{"at":"2026-10-28T07:32:38.167Z","todayStars":5597,"totalStars":14394,"rank":8},{"at":"2026-10-28T07:56:44.181Z","todayStars":5597,"totalStars":14396,"rank":8},{"at":"2026-10-28T08:15:31.813Z","todayStars":5597,"totalStars":14399,"rank":8},{"at":"2026-10-28T08:43:49.465Z","todayStars":5597,"totalStars":14403,"rank":8},{"at":"2026-10-28T09:41:01.556Z","todayStars":5597,"totalStars":14408,"rank":8},{"at":"2026-10-28T10:22:16.534Z","todayStars":5597,"totalStars":14410,"rank":8},{"at":"2026-10-28T10:23:14.174Z","todayStars":5597,"totalStars":14410,"rank":8},{"at":"2026-10-28T10:30:21.570Z","todayStars":5597,"totalStars":14410,"rank":8},{"at":"2026-10-28T11:54:11.565Z","todayStars":5597,"totalStars":14417,"rank":7}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45035,4698,8017,8,8,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":8017,"totalStars":44998,"rank":9},{"at":"2026-10-28T07:23:26.230Z","todayStars":8017,"totalStars":44999,"rank":9},{"at":"2026-10-28T07:30:12.108Z","todayStars":8017,"totalStars":45000,"rank":9},{"at":"2026-10-28T07:32:38.167Z","todayStars":8017,"totalStars":45000,"rank":9},{"at":"2026-10-28T07:56:44.181Z","todayStars":8017,"totalStars":45003,"rank":9},{"at":"2026-10-28T08:15:31.813Z","todayStars":8017,"totalStars":45005,"rank":9},{"at":"2026-10-28T08:43:49.465Z","todayStars":8017,"totalStars":45009,"rank":9},{"at":"2026-10-28T09:41:01.556Z","todayStars":8017,"totalStars":45019,"rank":9},{"at":"2026-10-28T10:22:16.534Z","todayStars":8017,"totalStars":45023,"rank":9},{"at":"2026-10-28T10:23:14.174Z","todayStars":8017,"totalStars":45023,"rank":9},{"at":"2026-10-28T10:30:21.570Z","todayStars":8017,"totalStars":45023,"rank":9},{"at":"2026-10-28T11:54:11.565Z","todayStars":8017,"totalStars":45035,"rank":8}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','nvidia/openshell','NVIDIA','OpenShell','NVIDIA/OpenShell','https://github.com/NVIDIA/OpenShell','OpenShell is the safe, private runtime for autonomous AI agents.','Rust','#dea584',20411,2007,11510,14,10,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":11510,"totalStars":20355,"rank":10},{"at":"2026-10-28T07:23:26.230Z","todayStars":11510,"totalStars":20357,"rank":10},{"at":"2026-10-28T07:30:12.108Z","todayStars":11510,"totalStars":20359,"rank":10},{"at":"2026-10-28T07:32:38.167Z","todayStars":11510,"totalStars":20359,"rank":10},{"at":"2026-10-28T07:56:44.181Z","todayStars":11510,"totalStars":20369,"rank":10},{"at":"2026-10-28T08:15:31.813Z","todayStars":11510,"totalStars":20372,"rank":10},{"at":"2026-10-28T08:43:49.465Z","todayStars":11510,"totalStars":20377,"rank":10},{"at":"2026-10-28T09:41:01.556Z","todayStars":11510,"totalStars":20396,"rank":10},{"at":"2026-10-28T10:22:16.534Z","todayStars":11510,"totalStars":20401,"rank":10},{"at":"2026-10-28T10:23:14.174Z","todayStars":11510,"totalStars":20401,"rank":10},{"at":"2026-10-28T10:30:21.570Z","todayStars":11510,"totalStars":20401,"rank":10},{"at":"2026-10-28T11:54:11.565Z","todayStars":11510,"totalStars":20411,"rank":14}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',291328,43129,23998,11,11,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":23998,"totalStars":291132,"rank":11},{"at":"2026-10-28T07:23:26.230Z","todayStars":23998,"totalStars":291134,"rank":11},{"at":"2026-10-28T07:30:12.108Z","todayStars":23998,"totalStars":291139,"rank":11},{"at":"2026-10-28T07:32:38.167Z","todayStars":23998,"totalStars":291141,"rank":11},{"at":"2026-10-28T07:56:44.181Z","todayStars":23998,"totalStars":291162,"rank":11},{"at":"2026-10-28T08:15:31.813Z","todayStars":23998,"totalStars":291179,"rank":11},{"at":"2026-10-28T08:43:49.465Z","todayStars":23998,"totalStars":291198,"rank":11},{"at":"2026-10-28T09:41:01.556Z","todayStars":23998,"totalStars":291235,"rank":11},{"at":"2026-10-28T10:22:16.534Z","todayStars":23998,"totalStars":291269,"rank":11},{"at":"2026-10-28T10:23:14.174Z","todayStars":23998,"totalStars":291269,"rank":11},{"at":"2026-10-28T10:30:21.570Z","todayStars":23998,"totalStars":291277,"rank":11},{"at":"2026-10-28T11:54:11.565Z","todayStars":23998,"totalStars":291328,"rank":11}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',103868,9166,9345,10,10,0,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":9345,"totalStars":103804,"rank":12},{"at":"2026-10-28T07:23:26.230Z","todayStars":9345,"totalStars":103805,"rank":12},{"at":"2026-10-28T07:30:12.108Z","todayStars":9345,"totalStars":103806,"rank":12},{"at":"2026-10-28T07:32:38.167Z","todayStars":9345,"totalStars":103806,"rank":12},{"at":"2026-10-28T07:56:44.181Z","todayStars":9345,"totalStars":103809,"rank":12},{"at":"2026-10-28T08:15:31.813Z","todayStars":9345,"totalStars":103815,"rank":12},{"at":"2026-10-28T08:43:49.465Z","todayStars":9345,"totalStars":103819,"rank":12},{"at":"2026-10-28T09:41:01.556Z","todayStars":9345,"totalStars":103836,"rank":12},{"at":"2026-10-28T10:22:16.534Z","todayStars":9345,"totalStars":103845,"rank":12},{"at":"2026-10-28T10:23:14.174Z","todayStars":9345,"totalStars":103845,"rank":12},{"at":"2026-10-28T10:30:21.570Z","todayStars":9345,"totalStars":103848,"rank":12},{"at":"2026-10-28T11:54:11.565Z","todayStars":9345,"totalStars":103868,"rank":10}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',95227,10709,15456,12,12,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":15456,"totalStars":95161,"rank":13},{"at":"2026-10-28T07:23:26.230Z","todayStars":15456,"totalStars":95161,"rank":13},{"at":"2026-10-28T07:30:12.108Z","todayStars":15456,"totalStars":95162,"rank":13},{"at":"2026-10-28T07:32:38.167Z","todayStars":15456,"totalStars":95162,"rank":13},{"at":"2026-10-28T07:56:44.181Z","todayStars":15456,"totalStars":95169,"rank":13},{"at":"2026-10-28T08:15:31.813Z","todayStars":15456,"totalStars":95172,"rank":13},{"at":"2026-10-28T08:43:49.465Z","todayStars":15456,"totalStars":95180,"rank":13},{"at":"2026-10-28T09:41:01.556Z","todayStars":15456,"totalStars":95187,"rank":13},{"at":"2026-10-28T10:22:16.534Z","todayStars":15456,"totalStars":95196,"rank":13},{"at":"2026-10-28T10:23:14.174Z","todayStars":15456,"totalStars":95196,"rank":13},{"at":"2026-10-28T10:30:21.570Z","todayStars":15456,"totalStars":95198,"rank":13},{"at":"2026-10-28T11:54:11.565Z","todayStars":15456,"totalStars":95227,"rank":12}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',30977,8293,7188,13,13,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":7188,"totalStars":30920,"rank":14},{"at":"2026-10-28T07:23:26.230Z","todayStars":7188,"totalStars":30921,"rank":14},{"at":"2026-10-28T07:30:12.108Z","todayStars":7188,"totalStars":30921,"rank":14},{"at":"2026-10-28T07:32:38.167Z","todayStars":7188,"totalStars":30922,"rank":14},{"at":"2026-10-28T07:56:44.181Z","todayStars":7188,"totalStars":30927,"rank":14},{"at":"2026-10-28T08:15:31.813Z","todayStars":7188,"totalStars":30933,"rank":14},{"at":"2026-10-28T08:43:49.465Z","todayStars":7188,"totalStars":30938,"rank":14},{"at":"2026-10-28T09:41:01.556Z","todayStars":7188,"totalStars":30945,"rank":14},{"at":"2026-10-28T10:22:16.534Z","todayStars":7188,"totalStars":30957,"rank":14},{"at":"2026-10-28T10:23:14.174Z","todayStars":7188,"totalStars":30957,"rank":14},{"at":"2026-10-28T10:30:21.570Z","todayStars":7188,"totalStars":30958,"rank":14},{"at":"2026-10-28T11:54:11.565Z","todayStars":7188,"totalStars":30977,"rank":13}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','dietrichgebert/ponytail','DietrichGebert','ponytail','DietrichGebert/ponytail','https://github.com/DietrichGebert/ponytail','Makes your AI agent think like the laziest senior dev in the room. The best code is the code you never wrote.','JavaScript','#f1e05a',178640,9787,32214,16,15,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":32214,"totalStars":178421,"rank":15},{"at":"2026-10-28T07:23:26.230Z","todayStars":32214,"totalStars":178424,"rank":15},{"at":"2026-10-28T07:30:12.108Z","todayStars":32214,"totalStars":178430,"rank":15},{"at":"2026-10-28T07:32:38.167Z","todayStars":32214,"totalStars":178431,"rank":15},{"at":"2026-10-28T07:56:44.181Z","todayStars":32214,"totalStars":178448,"rank":15},{"at":"2026-10-28T08:15:31.813Z","todayStars":32214,"totalStars":178465,"rank":15},{"at":"2026-10-28T08:43:49.465Z","todayStars":32214,"totalStars":178482,"rank":15},{"at":"2026-10-28T09:41:01.556Z","todayStars":32214,"totalStars":178533,"rank":15},{"at":"2026-10-28T10:22:16.534Z","todayStars":32214,"totalStars":178561,"rank":15},{"at":"2026-10-28T10:23:14.174Z","todayStars":32214,"totalStars":178561,"rank":15},{"at":"2026-10-28T10:30:21.570Z","todayStars":32214,"totalStars":178566,"rank":15},{"at":"2026-10-28T11:54:11.565Z","todayStars":32214,"totalStars":178640,"rank":16}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z');
insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-10-28','monthly','tashfeenahmed/freellmapi','tashfeenahmed','freellmapi','tashfeenahmed/freellmapi','https://github.com/tashfeenahmed/freellmapi','7.4 billion tokens per month. 34 free LLM providers. 635 free model endpoints. All behind one /v1 endpoint, plus any custom OpenAI-compatible endpoint. Smart routing, automatic failover, encrypted keys. Personal experimentation only.','TypeScript','#3178c6',43003,5802,13636,17,16,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":13636,"totalStars":42882,"rank":16},{"at":"2026-10-28T07:23:26.230Z","todayStars":13636,"totalStars":42882,"rank":16},{"at":"2026-10-28T07:30:12.108Z","todayStars":13636,"totalStars":42883,"rank":16},{"at":"2026-10-28T07:32:38.167Z","todayStars":13636,"totalStars":42883,"rank":16},{"at":"2026-10-28T07:56:44.181Z","todayStars":13636,"totalStars":42894,"rank":16},{"at":"2026-10-28T08:15:31.813Z","todayStars":13636,"totalStars":42905,"rank":16},{"at":"2026-10-28T08:43:49.465Z","todayStars":13636,"totalStars":42919,"rank":16},{"at":"2026-10-28T09:41:01.556Z","todayStars":13636,"totalStars":42939,"rank":16},{"at":"2026-10-28T10:22:16.534Z","todayStars":13636,"totalStars":42957,"rank":16},{"at":"2026-10-28T10:23:14.174Z","todayStars":13636,"totalStars":42957,"rank":16},{"at":"2026-10-28T10:30:21.570Z","todayStars":13636,"totalStars":42961,"rank":16},{"at":"2026-10-28T11:54:11.565Z","todayStars":13636,"totalStars":43003,"rank":17}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','paperclipai/paperclip','paperclipai','paperclip','paperclipai/paperclip','https://github.com/paperclipai/paperclip','The open-source app everyone uses to manage agents at work','TypeScript','#3178c6',108138,17922,19922,NULL,17,2,1,'2026-10-28T11:54:11.565Z','2026-10-28T07:18:11.659Z','2026-10-28T10:30:21.570Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":19922,"totalStars":108099,"rank":17},{"at":"2026-10-28T07:23:26.230Z","todayStars":19922,"totalStars":108101,"rank":17},{"at":"2026-10-28T07:30:12.108Z","todayStars":19922,"totalStars":108103,"rank":17},{"at":"2026-10-28T07:32:38.167Z","todayStars":19922,"totalStars":108103,"rank":17},{"at":"2026-10-28T07:56:44.181Z","todayStars":19922,"totalStars":108110,"rank":17},{"at":"2026-10-28T08:15:31.813Z","todayStars":19922,"totalStars":108114,"rank":17},{"at":"2026-10-28T08:43:49.465Z","todayStars":19922,"totalStars":108121,"rank":17},{"at":"2026-10-28T09:41:01.556Z","todayStars":19922,"totalStars":108128,"rank":17},{"at":"2026-10-28T10:22:16.534Z","todayStars":19922,"totalStars":108136,"rank":17},{"at":"2026-10-28T10:23:14.174Z","todayStars":19922,"totalStars":108136,"rank":17},{"at":"2026-10-28T10:30:21.570Z","todayStars":19922,"totalStars":108138,"rank":17}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','panniantong/agent-reach','Panniantong','Agent-Reach','Panniantong/Agent-Reach','https://github.com/Panniantong/Agent-Reach','Give your AI agent eyes to see the entire internet. Read & search Twitter, Reddit, YouTube, GitHub, Bilibili, XiaoHongShu — one CLI, zero API fees.','Python','#3572A5',105278,9329,19461,15,15,1,0,NULL,'2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":19461,"totalStars":105141,"rank":18},{"at":"2026-10-28T07:23:26.230Z","todayStars":19461,"totalStars":105142,"rank":18},{"at":"2026-10-28T07:30:12.108Z","todayStars":19461,"totalStars":105144,"rank":18},{"at":"2026-10-28T07:32:38.167Z","todayStars":19461,"totalStars":105144,"rank":18},{"at":"2026-10-28T07:56:44.181Z","todayStars":19461,"totalStars":105155,"rank":18},{"at":"2026-10-28T08:15:31.813Z","todayStars":19461,"totalStars":105167,"rank":18},{"at":"2026-10-28T08:43:49.465Z","todayStars":19461,"totalStars":105184,"rank":18},{"at":"2026-10-28T09:41:01.556Z","todayStars":19461,"totalStars":105219,"rank":18},{"at":"2026-10-28T10:22:16.534Z","todayStars":19461,"totalStars":105237,"rank":18},{"at":"2026-10-28T10:23:14.174Z","todayStars":19461,"totalStars":105237,"rank":18},{"at":"2026-10-28T10:30:21.570Z","todayStars":19461,"totalStars":105238,"rank":18},{"at":"2026-10-28T11:54:11.565Z","todayStars":19461,"totalStars":105278,"rank":15}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','supabase/supabase','supabase','supabase','supabase/supabase','https://github.com/supabase/supabase','The Postgres development platform. Supabase gives you a dedicated Postgres database to build your web, mobile, and AI applications.','TypeScript','#3178c6',114240,16321,3634,NULL,19,2,1,'2026-10-28T11:54:11.565Z','2026-10-28T07:18:11.659Z','2026-10-28T10:30:21.570Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":3634,"totalStars":114220,"rank":19},{"at":"2026-10-28T07:23:26.230Z","todayStars":3634,"totalStars":114220,"rank":19},{"at":"2026-10-28T07:30:12.108Z","todayStars":3634,"totalStars":114221,"rank":19},{"at":"2026-10-28T07:32:38.167Z","todayStars":3634,"totalStars":114221,"rank":19},{"at":"2026-10-28T07:56:44.181Z","todayStars":3634,"totalStars":114223,"rank":19},{"at":"2026-10-28T08:15:31.813Z","todayStars":3634,"totalStars":114224,"rank":19},{"at":"2026-10-28T08:43:49.465Z","todayStars":3634,"totalStars":114227,"rank":19},{"at":"2026-10-28T09:41:01.556Z","todayStars":3634,"totalStars":114233,"rank":19},{"at":"2026-10-28T10:22:16.534Z","todayStars":3634,"totalStars":114238,"rank":19},{"at":"2026-10-28T10:23:14.174Z","todayStars":3634,"totalStars":114238,"rank":19},{"at":"2026-10-28T10:30:21.570Z","todayStars":3634,"totalStars":114240,"rank":19}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','hkuds/cli-anything','HKUDS','CLI-Anything','HKUDS/CLI-Anything','https://github.com/HKUDS/CLI-Anything','"CLI-Anything: Making ALL Software Agent-Native" -- CLI-Hub: https://clianything.cc/','Python','#3572A5',57526,5178,6879,NULL,20,2,1,'2026-10-28T11:54:11.565Z','2026-10-28T07:18:11.659Z','2026-10-28T10:30:21.570Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":6879,"totalStars":57501,"rank":20},{"at":"2026-10-28T07:23:26.230Z","todayStars":6879,"totalStars":57501,"rank":20},{"at":"2026-10-28T07:30:12.108Z","todayStars":6879,"totalStars":57503,"rank":20},{"at":"2026-10-28T07:32:38.167Z","todayStars":6879,"totalStars":57503,"rank":20},{"at":"2026-10-28T07:56:44.181Z","todayStars":6879,"totalStars":57506,"rank":20},{"at":"2026-10-28T08:15:31.813Z","todayStars":6879,"totalStars":57507,"rank":20},{"at":"2026-10-28T08:43:49.465Z","todayStars":6879,"totalStars":57510,"rank":20},{"at":"2026-10-28T09:41:01.556Z","todayStars":6879,"totalStars":57521,"rank":20},{"at":"2026-10-28T10:22:16.534Z","todayStars":6879,"totalStars":57524,"rank":20},{"at":"2026-10-28T10:23:14.174Z","todayStars":6879,"totalStars":57524,"rank":20},{"at":"2026-10-28T10:30:21.570Z","todayStars":6879,"totalStars":57526,"rank":20}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','monthly','flutter/flutter','flutter','flutter','flutter/flutter','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful apps for mobile and beyond','Dart','#00B4AB',180509,33335,1855,NULL,21,2,1,'2026-10-28T11:54:11.565Z','2026-10-28T07:18:11.659Z','2026-10-28T10:30:21.570Z','[{"at":"2026-10-28T07:18:11.659Z","todayStars":1855,"totalStars":180494,"rank":21},{"at":"2026-10-28T07:23:26.230Z","todayStars":1855,"totalStars":180494,"rank":21},{"at":"2026-10-28T07:30:12.108Z","todayStars":1855,"totalStars":180494,"rank":21},{"at":"2026-10-28T07:32:38.167Z","todayStars":1855,"totalStars":180494,"rank":21},{"at":"2026-10-28T07:56:44.181Z","todayStars":1855,"totalStars":180496,"rank":21},{"at":"2026-10-28T08:15:31.813Z","todayStars":1855,"totalStars":180497,"rank":21},{"at":"2026-10-28T08:43:49.465Z","todayStars":1855,"totalStars":180500,"rank":21},{"at":"2026-10-28T09:41:01.556Z","todayStars":1855,"totalStars":180505,"rank":21},{"at":"2026-10-28T10:22:16.534Z","todayStars":1855,"totalStars":180508,"rank":21},{"at":"2026-10-28T10:23:14.174Z","todayStars":1855,"totalStars":180508,"rank":21},{"at":"2026-10-28T10:30:21.570Z","todayStars":1855,"totalStars":180509,"rank":21}]','2026-10-28T07:18:11.659Z','2026-10-28T11:54:11.565Z'),
('2026-10-28','daily','macro-inc/macro','macro-inc','macro','macro-inc/macro','https://github.com/macro-inc/macro','Macro is a unified workspace for teams: email, chat, docs, tasks, agents, calls, and CRM — @-linked together with shared AI memory.','Rust','#dea584',5175,505,106,5,5,0,0,NULL,'2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T11:54:11.281Z","todayStars":106,"totalStars":5175,"rank":5}]','2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','hmjz100/linkswift','hmjz100','LinkSwift','hmjz100/LinkSwift','https://github.com/hmjz100/LinkSwift','一个基于 JavaScript 的网盘文件下载地址获取工具。基于【网盘直链下载助手】修改 ，支持 百度网盘 / 阿里云盘 / 中国移动云盘 / 天翼云盘 / 迅雷云盘 / 夸克网盘 / UC网盘 / 123云盘 八大网盘','JavaScript','#f1e05a',33768,2382,3209,11,11,1,0,NULL,'2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T11:54:11.281Z","todayStars":3209,"totalStars":33768,"rank":11}]','2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','expo/skills','expo','skills','expo/skills','https://github.com/expo/skills','A collection of AI agent skills for working with Expo projects and Expo Application Services','Shell','#89e051',3352,216,212,12,12,1,0,NULL,'2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T11:54:11.281Z","todayStars":212,"totalStars":3352,"rank":12}]','2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','ruvnet/ruview','ruvnet','RuView','ruvnet/RuView','https://github.com/ruvnet/RuView','π RuView turns commodity WiFi signals into real-time spatial intelligence, vital sign monitoring, and presence detection — all without a single pixel of video.','Rust','#dea584',100531,13122,415,13,13,1,0,NULL,'2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T11:54:11.281Z","todayStars":415,"totalStars":100531,"rank":13}]','2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','daily','xiaolai/the-craft-of-selfteaching','xiaolai','the-craft-of-selfteaching','xiaolai/the-craft-of-selfteaching','https://github.com/xiaolai/the-craft-of-selfteaching','One has no future if one couldn''t teach themself.','Jupyter Notebook','#DA5B0B',18256,17861,143,14,14,1,0,NULL,'2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z','[{"at":"2026-10-28T11:54:11.281Z","todayStars":143,"totalStars":18256,"rank":14}]','2026-10-28T11:54:11.281Z','2026-10-28T11:54:11.281Z'),
('2026-10-28','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',91292,5401,6713,6,6,0,0,NULL,'2026-10-28T11:54:11.436Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T11:54:11.436Z","todayStars":6713,"totalStars":91292,"rank":6}]','2026-10-28T11:54:11.436Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',8865,336,746,10,10,0,0,NULL,'2026-10-28T11:54:11.436Z','2026-10-28T11:54:11.436Z','[{"at":"2026-10-28T11:54:11.436Z","todayStars":746,"totalStars":8865,"rank":10}]','2026-10-28T11:54:11.436Z','2026-10-28T11:54:11.436Z'),
('2026-10-28','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',39919,2082,9965,18,18,1,0,NULL,'2026-10-28T11:54:11.565Z','2026-10-28T11:54:11.565Z','[{"at":"2026-10-28T11:54:11.565Z","todayStars":9965,"totalStars":39919,"rank":18}]','2026-10-28T11:54:11.565Z','2026-10-28T11:54:11.565Z'),
('2026-10-29','daily','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',5575,285,1068,1,1,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1075,"totalStars":4968,"rank":1},{"at":"2026-10-29T01:34:38.144Z","todayStars":1068,"totalStars":5101,"rank":1},{"at":"2026-10-29T03:45:18.623Z","todayStars":1068,"totalStars":5232,"rank":1},{"at":"2026-10-29T04:47:11.081Z","todayStars":1068,"totalStars":5275,"rank":1},{"at":"2026-10-29T06:23:52.362Z","todayStars":1068,"totalStars":5359,"rank":1},{"at":"2026-10-29T07:34:00.099Z","todayStars":1068,"totalStars":5444,"rank":1},{"at":"2026-10-29T09:24:53.951Z","todayStars":1068,"totalStars":5550,"rank":1},{"at":"2026-10-29T09:54:03.969Z","todayStars":1068,"totalStars":5575,"rank":1}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','elayadesign/ai-design-skills','elayadesign','ai-design-skills','elayadesign/ai-design-skills','https://github.com/elayadesign/ai-design-skills','','Unknown','#8b949e',11619,840,2139,2,2,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1938,"totalStars":11014,"rank":2},{"at":"2026-10-29T01:34:38.144Z","todayStars":2139,"totalStars":11163,"rank":2},{"at":"2026-10-29T03:45:18.623Z","todayStars":2139,"totalStars":11297,"rank":2},{"at":"2026-10-29T04:47:11.081Z","todayStars":2139,"totalStars":11332,"rank":2},{"at":"2026-10-29T06:23:52.362Z","todayStars":2139,"totalStars":11408,"rank":2},{"at":"2026-10-29T07:34:00.099Z","todayStars":2139,"totalStars":11471,"rank":2},{"at":"2026-10-29T09:24:53.951Z","todayStars":2139,"totalStars":11583,"rank":2},{"at":"2026-10-29T09:54:03.969Z","todayStars":2139,"totalStars":11619,"rank":2}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',307822,27378,1095,3,3,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1096,"totalStars":307366,"rank":3},{"at":"2026-10-29T01:34:38.144Z","todayStars":1095,"totalStars":307476,"rank":3},{"at":"2026-10-29T03:45:18.623Z","todayStars":1095,"totalStars":307556,"rank":3},{"at":"2026-10-29T04:47:11.081Z","todayStars":1095,"totalStars":307590,"rank":3},{"at":"2026-10-29T06:23:52.362Z","todayStars":1095,"totalStars":307660,"rank":3},{"at":"2026-10-29T07:34:00.099Z","todayStars":1095,"totalStars":307698,"rank":3},{"at":"2026-10-29T09:24:53.951Z","todayStars":1095,"totalStars":307808,"rank":3},{"at":"2026-10-29T09:54:03.969Z","todayStars":1095,"totalStars":307822,"rank":3}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',48885,6049,2371,4,4,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":2376,"totalStars":47845,"rank":4},{"at":"2026-10-29T01:34:38.144Z","todayStars":2371,"totalStars":48057,"rank":4},{"at":"2026-10-29T03:45:18.623Z","todayStars":2371,"totalStars":48288,"rank":4},{"at":"2026-10-29T04:47:11.081Z","todayStars":2371,"totalStars":48378,"rank":4},{"at":"2026-10-29T06:23:52.362Z","todayStars":2371,"totalStars":48529,"rank":4},{"at":"2026-10-29T07:34:00.099Z","todayStars":2371,"totalStars":48653,"rank":4},{"at":"2026-10-29T09:24:53.951Z","todayStars":2371,"totalStars":48840,"rank":4},{"at":"2026-10-29T09:54:03.969Z","todayStars":2371,"totalStars":48885,"rank":4}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','macro-inc/macro','macro-inc','macro','macro-inc/macro','https://github.com/macro-inc/macro','Macro is a unified workspace for teams: email, chat, docs, tasks, agents, calls, and CRM — @-linked together with shared AI memory.','Rust','#dea584',5614,529,117,5,5,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":106,"totalStars":5375,"rank":5},{"at":"2026-10-29T01:34:38.144Z","todayStars":117,"totalStars":5437,"rank":5},{"at":"2026-10-29T03:45:18.623Z","todayStars":117,"totalStars":5489,"rank":5},{"at":"2026-10-29T04:47:11.081Z","todayStars":117,"totalStars":5507,"rank":5},{"at":"2026-10-29T06:23:52.362Z","todayStars":117,"totalStars":5540,"rank":5},{"at":"2026-10-29T07:34:00.099Z","todayStars":117,"totalStars":5571,"rank":5},{"at":"2026-10-29T09:24:53.951Z","todayStars":117,"totalStars":5602,"rank":5},{"at":"2026-10-29T09:54:03.969Z","todayStars":117,"totalStars":5614,"rank":5}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',41323,2143,2110,6,6,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":2109,"totalStars":40597,"rank":6},{"at":"2026-10-29T01:34:38.144Z","todayStars":2110,"totalStars":40764,"rank":6},{"at":"2026-10-29T03:45:18.623Z","todayStars":2110,"totalStars":40898,"rank":6},{"at":"2026-10-29T04:47:11.081Z","todayStars":2110,"totalStars":40957,"rank":6},{"at":"2026-10-29T06:23:52.362Z","todayStars":2110,"totalStars":41037,"rank":6},{"at":"2026-10-29T07:34:00.099Z","todayStars":2110,"totalStars":41126,"rank":6},{"at":"2026-10-29T09:24:53.951Z","todayStars":2110,"totalStars":41281,"rank":6},{"at":"2026-10-29T09:54:03.969Z","todayStars":2110,"totalStars":41323,"rank":6}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',93928,5550,1472,7,7,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1471,"totalStars":92465,"rank":7},{"at":"2026-10-29T01:34:38.144Z","todayStars":1472,"totalStars":92758,"rank":7},{"at":"2026-10-29T03:45:18.623Z","todayStars":1472,"totalStars":93085,"rank":7},{"at":"2026-10-29T04:47:11.081Z","todayStars":1472,"totalStars":93204,"rank":7},{"at":"2026-10-29T06:23:52.362Z","todayStars":1472,"totalStars":93394,"rank":7},{"at":"2026-10-29T07:34:00.099Z","todayStars":1472,"totalStars":93570,"rank":7},{"at":"2026-10-29T09:24:53.951Z","todayStars":1472,"totalStars":93856,"rank":7},{"at":"2026-10-29T09:54:03.969Z","todayStars":1472,"totalStars":93928,"rank":7}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','makecindy/cindy','makecindy','cindy','makecindy/cindy','https://github.com/makecindy/cindy','Consider it done. The open-source AI agent that works out of the box · 想到，就能做到。开源、开箱即用的 AI Agent。','TypeScript','#3178c6',8426,984,728,8,8,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":740,"totalStars":8026,"rank":8},{"at":"2026-10-29T01:34:38.144Z","todayStars":728,"totalStars":8119,"rank":8},{"at":"2026-10-29T03:45:18.623Z","todayStars":728,"totalStars":8202,"rank":8},{"at":"2026-10-29T04:47:11.081Z","todayStars":728,"totalStars":8241,"rank":8},{"at":"2026-10-29T06:23:52.362Z","todayStars":728,"totalStars":8287,"rank":8},{"at":"2026-10-29T07:34:00.099Z","todayStars":728,"totalStars":8335,"rank":8},{"at":"2026-10-29T09:24:53.951Z","todayStars":728,"totalStars":8409,"rank":8},{"at":"2026-10-29T09:54:03.969Z","todayStars":728,"totalStars":8426,"rank":8}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','nightly-labs/openbot','nightly-labs','openbot','nightly-labs/openbot','https://github.com/nightly-labs/openbot','A local-first desktop workspace for persistent AI teammates. Run Codex, Claude, and Grok with dedicated workspaces, task queues, file sharing, browser control, and agent-to-agent collaboration.','TypeScript','#3178c6',3538,336,1054,9,9,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1053,"totalStars":3175,"rank":9},{"at":"2026-10-29T01:34:38.144Z","todayStars":1054,"totalStars":3282,"rank":9},{"at":"2026-10-29T03:45:18.623Z","todayStars":1054,"totalStars":3355,"rank":9},{"at":"2026-10-29T04:47:11.081Z","todayStars":1054,"totalStars":3386,"rank":9},{"at":"2026-10-29T06:23:52.362Z","todayStars":1054,"totalStars":3433,"rank":9},{"at":"2026-10-29T07:34:00.099Z","todayStars":1054,"totalStars":3471,"rank":9},{"at":"2026-10-29T09:24:53.951Z","todayStars":1054,"totalStars":3524,"rank":9},{"at":"2026-10-29T09:54:03.969Z","todayStars":1054,"totalStars":3538,"rank":9}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',7770,1099,1477,10,10,0,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1478,"totalStars":6987,"rank":10},{"at":"2026-10-29T01:34:38.144Z","todayStars":1477,"totalStars":7155,"rank":10},{"at":"2026-10-29T03:45:18.623Z","todayStars":1477,"totalStars":7332,"rank":10},{"at":"2026-10-29T04:47:11.081Z","todayStars":1477,"totalStars":7405,"rank":10},{"at":"2026-10-29T06:23:52.362Z","todayStars":1477,"totalStars":7505,"rank":10},{"at":"2026-10-29T07:34:00.099Z","todayStars":1477,"totalStars":7583,"rank":10},{"at":"2026-10-29T09:24:53.951Z","todayStars":1477,"totalStars":7735,"rank":10},{"at":"2026-10-29T09:54:03.969Z","todayStars":1477,"totalStars":7770,"rank":10}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','hmjz100/linkswift','hmjz100','LinkSwift','hmjz100/LinkSwift','https://github.com/hmjz100/LinkSwift','一个基于 JavaScript 的网盘文件下载地址获取工具。基于【网盘直链下载助手】修改 ，支持 百度网盘 / 阿里云盘 / 中国移动云盘 / 天翼云盘 / 迅雷云盘 / 夸克网盘 / UC网盘 / 123云盘 八大网盘','JavaScript','#f1e05a',35882,2542,1616,11,11,1,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":1380,"totalStars":34374,"rank":11},{"at":"2026-10-29T01:34:38.144Z","todayStars":1616,"totalStars":34810,"rank":11},{"at":"2026-10-29T03:45:18.623Z","todayStars":1616,"totalStars":35190,"rank":11},{"at":"2026-10-29T04:47:11.081Z","todayStars":1616,"totalStars":35313,"rank":11},{"at":"2026-10-29T06:23:52.362Z","todayStars":1616,"totalStars":35447,"rank":11},{"at":"2026-10-29T07:34:00.099Z","todayStars":1616,"totalStars":35600,"rank":11},{"at":"2026-10-29T09:24:53.951Z","todayStars":1616,"totalStars":35833,"rank":11},{"at":"2026-10-29T09:54:03.969Z","todayStars":1616,"totalStars":35882,"rank":11}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','expo/skills','expo','skills','expo/skills','https://github.com/expo/skills','A collection of AI agent skills for working with Expo projects and Expo Application Services','Shell','#89e051',3721,235,90,12,12,1,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":216,"totalStars":3535,"rank":12},{"at":"2026-10-29T01:34:38.144Z","todayStars":90,"totalStars":3594,"rank":12},{"at":"2026-10-29T03:45:18.623Z","todayStars":90,"totalStars":3629,"rank":12},{"at":"2026-10-29T04:47:11.081Z","todayStars":90,"totalStars":3639,"rank":12},{"at":"2026-10-29T06:23:52.362Z","todayStars":90,"totalStars":3672,"rank":12},{"at":"2026-10-29T07:34:00.099Z","todayStars":90,"totalStars":3682,"rank":12},{"at":"2026-10-29T09:24:53.951Z","todayStars":90,"totalStars":3713,"rank":12},{"at":"2026-10-29T09:54:03.969Z","todayStars":90,"totalStars":3721,"rank":12}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','ruvnet/ruview','ruvnet','RuView','ruvnet/RuView','https://github.com/ruvnet/RuView','π RuView turns commodity WiFi signals into real-time spatial intelligence, vital sign monitoring, and presence detection — all without a single pixel of video.','Rust','#dea584',101415,13182,557,13,13,1,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":596,"totalStars":100957,"rank":13},{"at":"2026-10-29T01:34:38.144Z","todayStars":557,"totalStars":101076,"rank":13},{"at":"2026-10-29T03:45:18.623Z","todayStars":557,"totalStars":101172,"rank":13},{"at":"2026-10-29T04:47:11.081Z","todayStars":557,"totalStars":101203,"rank":13},{"at":"2026-10-29T06:23:52.362Z","todayStars":557,"totalStars":101258,"rank":13},{"at":"2026-10-29T07:34:00.099Z","todayStars":557,"totalStars":101310,"rank":13},{"at":"2026-10-29T09:24:53.951Z","todayStars":557,"totalStars":101399,"rank":13},{"at":"2026-10-29T09:54:03.969Z","todayStars":557,"totalStars":101415,"rank":13}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','daily','xiaolai/the-craft-of-selfteaching','xiaolai','the-craft-of-selfteaching','xiaolai/the-craft-of-selfteaching','https://github.com/xiaolai/the-craft-of-selfteaching','One has no future if one couldn''t teach themself.','Jupyter Notebook','#DA5B0B',18783,17924,148,14,14,1,0,NULL,'2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z','[{"at":"2026-10-28T22:03:23.869Z","todayStars":295,"totalStars":18460,"rank":14},{"at":"2026-10-29T01:34:38.144Z","todayStars":148,"totalStars":18531,"rank":14},{"at":"2026-10-29T03:45:18.623Z","todayStars":148,"totalStars":18609,"rank":14},{"at":"2026-10-29T04:47:11.081Z","todayStars":148,"totalStars":18634,"rank":14},{"at":"2026-10-29T06:23:52.362Z","todayStars":148,"totalStars":18680,"rank":14},{"at":"2026-10-29T07:34:00.099Z","todayStars":148,"totalStars":18715,"rank":14},{"at":"2026-10-29T09:24:53.951Z","todayStars":148,"totalStars":18766,"rank":14},{"at":"2026-10-29T09:54:03.969Z","todayStars":148,"totalStars":18783,"rank":14}]','2026-10-28T22:03:23.869Z','2026-10-29T09:54:03.969Z'),
('2026-10-29','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',52159,3339,16002,1,1,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":16388,"totalStars":51552,"rank":1},{"at":"2026-10-29T01:34:38.529Z","todayStars":16002,"totalStars":51710,"rank":1},{"at":"2026-10-29T03:45:17.600Z","todayStars":16002,"totalStars":51822,"rank":1},{"at":"2026-10-29T04:47:11.464Z","todayStars":16002,"totalStars":51861,"rank":1},{"at":"2026-10-29T06:23:52.718Z","todayStars":16002,"totalStars":51934,"rank":1},{"at":"2026-10-29T07:34:01.454Z","todayStars":16002,"totalStars":52007,"rank":1},{"at":"2026-10-29T09:24:54.105Z","todayStars":16002,"totalStars":52132,"rank":1},{"at":"2026-10-29T09:54:04.294Z","todayStars":16002,"totalStars":52159,"rank":1}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',23638,3175,3516,2,2,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":3081,"totalStars":23317,"rank":2},{"at":"2026-10-29T01:34:38.529Z","todayStars":3516,"totalStars":23400,"rank":2},{"at":"2026-10-29T03:45:17.600Z","todayStars":3516,"totalStars":23462,"rank":2},{"at":"2026-10-29T04:47:11.464Z","todayStars":3516,"totalStars":23480,"rank":2},{"at":"2026-10-29T06:23:52.718Z","todayStars":3516,"totalStars":23526,"rank":2},{"at":"2026-10-29T07:34:01.454Z","todayStars":3516,"totalStars":23559,"rank":2},{"at":"2026-10-29T09:24:54.105Z","todayStars":3516,"totalStars":23619,"rank":2},{"at":"2026-10-29T09:54:04.294Z","todayStars":3516,"totalStars":23638,"rank":2}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',226168,22586,4293,3,3,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":4039,"totalStars":225941,"rank":3},{"at":"2026-10-29T01:34:38.529Z","todayStars":4293,"totalStars":226004,"rank":3},{"at":"2026-10-29T03:45:17.600Z","todayStars":4293,"totalStars":226031,"rank":3},{"at":"2026-10-29T04:47:11.464Z","todayStars":4293,"totalStars":226045,"rank":3},{"at":"2026-10-29T06:23:52.718Z","todayStars":4293,"totalStars":226068,"rank":3},{"at":"2026-10-29T07:34:01.454Z","todayStars":4293,"totalStars":226100,"rank":3},{"at":"2026-10-29T09:24:54.105Z","todayStars":4293,"totalStars":226158,"rank":3},{"at":"2026-10-29T09:54:04.294Z","todayStars":4293,"totalStars":226168,"rank":3}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33735,3711,2612,4,4,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":2789,"totalStars":33633,"rank":4},{"at":"2026-10-29T01:34:38.529Z","todayStars":2612,"totalStars":33658,"rank":4},{"at":"2026-10-29T03:45:17.600Z","todayStars":2612,"totalStars":33680,"rank":4},{"at":"2026-10-29T04:47:11.464Z","todayStars":2612,"totalStars":33687,"rank":4},{"at":"2026-10-29T06:23:52.718Z","todayStars":2612,"totalStars":33700,"rank":4},{"at":"2026-10-29T07:34:01.454Z","todayStars":2612,"totalStars":33717,"rank":4},{"at":"2026-10-29T09:24:54.105Z","todayStars":2612,"totalStars":33733,"rank":4},{"at":"2026-10-29T09:54:04.294Z","todayStars":2612,"totalStars":33735,"rank":4}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',118082,22584,5322,5,5,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":4882,"totalStars":117844,"rank":5},{"at":"2026-10-29T01:34:38.529Z","todayStars":5322,"totalStars":117911,"rank":5},{"at":"2026-10-29T03:45:17.600Z","todayStars":5322,"totalStars":117960,"rank":5},{"at":"2026-10-29T04:47:11.464Z","todayStars":5322,"totalStars":117973,"rank":5},{"at":"2026-10-29T06:23:52.718Z","todayStars":5322,"totalStars":118001,"rank":5},{"at":"2026-10-29T07:34:01.454Z","todayStars":5322,"totalStars":118029,"rank":5},{"at":"2026-10-29T09:24:54.105Z","todayStars":5322,"totalStars":118074,"rank":5},{"at":"2026-10-29T09:54:04.294Z","todayStars":5322,"totalStars":118082,"rank":5}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',93928,5550,7283,6,6,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":6713,"totalStars":92465,"rank":6},{"at":"2026-10-29T01:34:38.529Z","todayStars":7283,"totalStars":92758,"rank":6},{"at":"2026-10-29T03:45:17.600Z","todayStars":7283,"totalStars":93085,"rank":6},{"at":"2026-10-29T04:47:11.464Z","todayStars":7283,"totalStars":93204,"rank":6},{"at":"2026-10-29T06:23:52.718Z","todayStars":7283,"totalStars":93394,"rank":6},{"at":"2026-10-29T07:34:01.454Z","todayStars":7283,"totalStars":93571,"rank":6},{"at":"2026-10-29T09:24:54.105Z","todayStars":7283,"totalStars":93856,"rank":6},{"at":"2026-10-29T09:54:04.294Z","todayStars":7283,"totalStars":93928,"rank":6}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','graphify-labs/graphify','Graphify-Labs','graphify','Graphify-Labs/graphify','https://github.com/Graphify-Labs/graphify','Turn any codebase, with its docs, SQL schemas, configs, and PDFs, into a queryable knowledge graph. A /graphify skill for Claude Code, Cursor, Codex, and Gemini CLI: local deterministic AST parsing, every edge explained, no vector store.','Python','#3572A5',138177,13174,6662,7,7,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":7268,"totalStars":137759,"rank":7},{"at":"2026-10-29T01:34:38.529Z","todayStars":6662,"totalStars":137880,"rank":7},{"at":"2026-10-29T03:45:17.600Z","todayStars":6662,"totalStars":137964,"rank":7},{"at":"2026-10-29T04:47:11.464Z","todayStars":6662,"totalStars":137989,"rank":7},{"at":"2026-10-29T06:23:52.718Z","todayStars":6662,"totalStars":138046,"rank":7},{"at":"2026-10-29T07:34:01.454Z","todayStars":6662,"totalStars":138091,"rank":7},{"at":"2026-10-29T09:24:54.105Z","todayStars":6662,"totalStars":138158,"rank":7},{"at":"2026-10-29T09:54:04.294Z","todayStars":6662,"totalStars":138177,"rank":7}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',104977,7098,3940,8,8,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":3941,"totalStars":104353,"rank":8},{"at":"2026-10-29T01:34:38.529Z","todayStars":3940,"totalStars":104511,"rank":8},{"at":"2026-10-29T03:45:17.600Z","todayStars":3940,"totalStars":104655,"rank":8},{"at":"2026-10-29T04:47:11.464Z","todayStars":3940,"totalStars":104706,"rank":8},{"at":"2026-10-29T06:23:52.718Z","todayStars":3940,"totalStars":104772,"rank":8},{"at":"2026-10-29T07:34:01.454Z","todayStars":3940,"totalStars":104836,"rank":8},{"at":"2026-10-29T09:24:54.105Z","todayStars":3940,"totalStars":104950,"rank":8},{"at":"2026-10-29T09:54:04.294Z","todayStars":3940,"totalStars":104977,"rank":8}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','ruvnet/ruflo','ruvnet','ruflo','ruvnet/ruflo','https://github.com/ruvnet/ruflo','🌊 The original agent harness. Deploy intelligent multi-player swarms, coordinate autonomous workflows, and build conversational AI systems. Features adaptive memory, self-learning intelligence, federation, vector RAG integration, and native Claude Code / Codex / Hermes and many more Integrated','TypeScript','#3178c6',80046,9390,1930,9,9,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":2296,"totalStars":79961,"rank":9},{"at":"2026-10-29T01:34:38.529Z","todayStars":1930,"totalStars":79981,"rank":9},{"at":"2026-10-29T03:45:17.600Z","todayStars":1930,"totalStars":80002,"rank":9},{"at":"2026-10-29T04:47:11.464Z","todayStars":1930,"totalStars":80010,"rank":9},{"at":"2026-10-29T06:23:52.718Z","todayStars":1930,"totalStars":80020,"rank":9},{"at":"2026-10-29T07:34:01.454Z","todayStars":1930,"totalStars":80028,"rank":9},{"at":"2026-10-29T09:24:54.105Z","todayStars":1930,"totalStars":80040,"rank":9},{"at":"2026-10-29T09:54:04.294Z","todayStars":1930,"totalStars":80046,"rank":9}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','anomalyco/opencode','anomalyco','opencode','anomalyco/opencode','https://github.com/anomalyco/opencode','The open source coding agent.','TypeScript','#3178c6',222897,29870,3498,10,10,0,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":4334,"totalStars":222724,"rank":10},{"at":"2026-10-29T01:34:38.529Z","todayStars":3498,"totalStars":222772,"rank":10},{"at":"2026-10-29T03:45:17.600Z","todayStars":3498,"totalStars":222807,"rank":10},{"at":"2026-10-29T04:47:11.464Z","todayStars":3498,"totalStars":222816,"rank":10},{"at":"2026-10-29T06:23:52.718Z","todayStars":3498,"totalStars":222833,"rank":10},{"at":"2026-10-29T07:34:01.454Z","todayStars":3498,"totalStars":222851,"rank":10},{"at":"2026-10-29T09:24:54.105Z","todayStars":3498,"totalStars":222888,"rank":10},{"at":"2026-10-29T09:54:04.294Z","todayStars":3498,"totalStars":222897,"rank":10}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',9084,345,776,11,11,1,0,NULL,'2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z','[{"at":"2026-10-28T22:03:24.085Z","todayStars":746,"totalStars":8953,"rank":11},{"at":"2026-10-29T01:34:38.529Z","todayStars":776,"totalStars":8988,"rank":11},{"at":"2026-10-29T03:45:17.600Z","todayStars":776,"totalStars":9007,"rank":11},{"at":"2026-10-29T04:47:11.464Z","todayStars":776,"totalStars":9022,"rank":11},{"at":"2026-10-29T06:23:52.718Z","todayStars":776,"totalStars":9044,"rank":11},{"at":"2026-10-29T07:34:01.454Z","todayStars":776,"totalStars":9059,"rank":11},{"at":"2026-10-29T09:24:54.105Z","todayStars":776,"totalStars":9079,"rank":11},{"at":"2026-10-29T09:54:04.294Z","todayStars":776,"totalStars":9084,"rank":11}]','2026-10-28T22:03:24.085Z','2026-10-29T09:54:04.294Z'),
('2026-10-29','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',75064,6818,21015,1,1,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":20501,"totalStars":74672,"rank":1},{"at":"2026-10-29T01:34:38.427Z","todayStars":21015,"totalStars":74765,"rank":1},{"at":"2026-10-29T03:45:18.966Z","todayStars":21015,"totalStars":74846,"rank":1},{"at":"2026-10-29T04:47:11.691Z","todayStars":21015,"totalStars":74872,"rank":1},{"at":"2026-10-29T06:23:52.583Z","todayStars":21015,"totalStars":74921,"rank":1},{"at":"2026-10-29T07:34:01.584Z","todayStars":21015,"totalStars":74960,"rank":1},{"at":"2026-10-29T09:24:54.231Z","todayStars":21015,"totalStars":75043,"rank":1},{"at":"2026-10-29T09:54:04.471Z","todayStars":21015,"totalStars":75064,"rank":1}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',52159,3339,28617,2,2,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":27415,"totalStars":51552,"rank":2},{"at":"2026-10-29T01:34:38.427Z","todayStars":28617,"totalStars":51710,"rank":2},{"at":"2026-10-29T03:45:18.966Z","todayStars":28617,"totalStars":51822,"rank":2},{"at":"2026-10-29T04:47:11.691Z","todayStars":28617,"totalStars":51861,"rank":2},{"at":"2026-10-29T06:23:52.583Z","todayStars":28617,"totalStars":51934,"rank":2},{"at":"2026-10-29T07:34:01.584Z","todayStars":28617,"totalStars":52007,"rank":2},{"at":"2026-10-29T09:24:54.231Z","todayStars":28617,"totalStars":52132,"rank":2},{"at":"2026-10-29T09:54:04.471Z","todayStars":28617,"totalStars":52159,"rank":2}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33735,3711,7899,3,3,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":7792,"totalStars":33633,"rank":3},{"at":"2026-10-29T01:34:38.427Z","todayStars":7899,"totalStars":33658,"rank":3},{"at":"2026-10-29T03:45:18.966Z","todayStars":7899,"totalStars":33680,"rank":3},{"at":"2026-10-29T04:47:11.691Z","todayStars":7899,"totalStars":33687,"rank":3},{"at":"2026-10-29T06:23:52.583Z","todayStars":7899,"totalStars":33700,"rank":3},{"at":"2026-10-29T07:34:01.584Z","todayStars":7899,"totalStars":33717,"rank":3},{"at":"2026-10-29T09:24:54.231Z","todayStars":7899,"totalStars":33733,"rank":3},{"at":"2026-10-29T09:54:04.471Z","todayStars":7899,"totalStars":33735,"rank":3}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',24001,2311,7453,4,4,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":7192,"totalStars":23862,"rank":4},{"at":"2026-10-29T01:34:38.427Z","todayStars":7453,"totalStars":23897,"rank":4},{"at":"2026-10-29T03:45:18.966Z","todayStars":7453,"totalStars":23927,"rank":4},{"at":"2026-10-29T04:47:11.691Z","todayStars":7453,"totalStars":23939,"rank":4},{"at":"2026-10-29T06:23:52.583Z","todayStars":7453,"totalStars":23955,"rank":4},{"at":"2026-10-29T07:34:01.584Z","todayStars":7453,"totalStars":23969,"rank":4},{"at":"2026-10-29T09:24:54.231Z","todayStars":7453,"totalStars":23995,"rank":4},{"at":"2026-10-29T09:54:04.471Z","todayStars":7453,"totalStars":24001,"rank":4}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',93928,5550,19821,5,5,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":18683,"totalStars":92465,"rank":5},{"at":"2026-10-29T01:34:38.427Z","todayStars":19821,"totalStars":92758,"rank":5},{"at":"2026-10-29T03:45:18.966Z","todayStars":19821,"totalStars":93085,"rank":5},{"at":"2026-10-29T04:47:11.691Z","todayStars":19821,"totalStars":93204,"rank":5},{"at":"2026-10-29T06:23:52.583Z","todayStars":19821,"totalStars":93394,"rank":5},{"at":"2026-10-29T07:34:01.584Z","todayStars":19821,"totalStars":93571,"rank":5},{"at":"2026-10-29T09:24:54.231Z","todayStars":19821,"totalStars":93856,"rank":5},{"at":"2026-10-29T09:54:04.471Z","todayStars":19821,"totalStars":93928,"rank":5}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',93545,10342,51430,6,6,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":52726,"totalStars":92863,"rank":6},{"at":"2026-10-29T01:34:38.427Z","todayStars":51430,"totalStars":93049,"rank":6},{"at":"2026-10-29T03:45:18.966Z","todayStars":51430,"totalStars":93178,"rank":6},{"at":"2026-10-29T04:47:11.691Z","todayStars":51430,"totalStars":93224,"rank":6},{"at":"2026-10-29T06:23:52.583Z","todayStars":51430,"totalStars":93297,"rank":6},{"at":"2026-10-29T07:34:01.584Z","todayStars":51430,"totalStars":93382,"rank":6},{"at":"2026-10-29T09:24:54.231Z","todayStars":51430,"totalStars":93506,"rank":6},{"at":"2026-10-29T09:54:04.471Z","todayStars":51430,"totalStars":93545,"rank":6}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',14527,1472,5652,7,7,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":5597,"totalStars":14477,"rank":7},{"at":"2026-10-29T01:34:38.427Z","todayStars":5652,"totalStars":14490,"rank":7},{"at":"2026-10-29T03:45:18.966Z","todayStars":5652,"totalStars":14499,"rank":7},{"at":"2026-10-29T04:47:11.691Z","todayStars":5652,"totalStars":14504,"rank":7},{"at":"2026-10-29T06:23:52.583Z","todayStars":5652,"totalStars":14514,"rank":7},{"at":"2026-10-29T07:34:01.584Z","todayStars":5652,"totalStars":14516,"rank":7},{"at":"2026-10-29T09:24:54.231Z","todayStars":5652,"totalStars":14525,"rank":7},{"at":"2026-10-29T09:54:04.471Z","todayStars":5652,"totalStars":14527,"rank":7}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45196,4717,8154,8,8,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":8017,"totalStars":45117,"rank":8},{"at":"2026-10-29T01:34:38.427Z","todayStars":8154,"totalStars":45140,"rank":8},{"at":"2026-10-29T03:45:18.966Z","todayStars":8154,"totalStars":45157,"rank":8},{"at":"2026-10-29T04:47:11.691Z","todayStars":8154,"totalStars":45161,"rank":8},{"at":"2026-10-29T06:23:52.583Z","todayStars":8154,"totalStars":45172,"rank":8},{"at":"2026-10-29T07:34:01.584Z","todayStars":8154,"totalStars":45178,"rank":8},{"at":"2026-10-29T09:24:54.231Z","todayStars":8154,"totalStars":45191,"rank":8},{"at":"2026-10-29T09:54:04.471Z","todayStars":8154,"totalStars":45196,"rank":8}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',32771,2266,8679,9,9,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":8586,"totalStars":32693,"rank":9},{"at":"2026-10-29T01:34:38.427Z","todayStars":8679,"totalStars":32713,"rank":9},{"at":"2026-10-29T03:45:18.966Z","todayStars":8679,"totalStars":32730,"rank":9},{"at":"2026-10-29T04:47:11.691Z","todayStars":8679,"totalStars":32740,"rank":9},{"at":"2026-10-29T06:23:52.583Z","todayStars":8679,"totalStars":32745,"rank":9},{"at":"2026-10-29T07:34:01.584Z","todayStars":8679,"totalStars":32754,"rank":9},{"at":"2026-10-29T09:24:54.231Z","todayStars":8679,"totalStars":32768,"rank":9},{"at":"2026-10-29T09:54:04.471Z","todayStars":8679,"totalStars":32771,"rank":9}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',104144,9190,9592,10,10,0,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":9345,"totalStars":104014,"rank":10},{"at":"2026-10-29T01:34:38.427Z","todayStars":9592,"totalStars":104047,"rank":10},{"at":"2026-10-29T03:45:18.966Z","todayStars":9592,"totalStars":104069,"rank":10},{"at":"2026-10-29T04:47:11.691Z","todayStars":9592,"totalStars":104086,"rank":10},{"at":"2026-10-29T06:23:52.583Z","todayStars":9592,"totalStars":104106,"rank":10},{"at":"2026-10-29T07:34:01.584Z","todayStars":9592,"totalStars":104123,"rank":10},{"at":"2026-10-29T09:24:54.231Z","todayStars":9592,"totalStars":104141,"rank":10},{"at":"2026-10-29T09:54:04.471Z","todayStars":9592,"totalStars":104144,"rank":10}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',292117,43243,24428,11,11,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":23998,"totalStars":291698,"rank":11},{"at":"2026-10-29T01:34:38.427Z","todayStars":24428,"totalStars":291788,"rank":11},{"at":"2026-10-29T03:45:18.966Z","todayStars":24428,"totalStars":291869,"rank":11},{"at":"2026-10-29T04:47:11.691Z","todayStars":24428,"totalStars":291904,"rank":11},{"at":"2026-10-29T06:23:52.583Z","todayStars":24428,"totalStars":291968,"rank":11},{"at":"2026-10-29T07:34:01.584Z","todayStars":24428,"totalStars":292024,"rank":11},{"at":"2026-10-29T09:24:54.231Z","todayStars":24428,"totalStars":292103,"rank":11},{"at":"2026-10-29T09:54:04.471Z","todayStars":24428,"totalStars":292117,"rank":11}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z');
insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-10-29','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',95652,10781,15700,12,12,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":15456,"totalStars":95491,"rank":12},{"at":"2026-10-29T01:34:38.427Z","todayStars":15700,"totalStars":95535,"rank":12},{"at":"2026-10-29T03:45:18.966Z","todayStars":15700,"totalStars":95561,"rank":12},{"at":"2026-10-29T04:47:11.691Z","todayStars":15700,"totalStars":95583,"rank":12},{"at":"2026-10-29T06:23:52.583Z","todayStars":15700,"totalStars":95603,"rank":12},{"at":"2026-10-29T07:34:01.584Z","todayStars":15700,"totalStars":95623,"rank":12},{"at":"2026-10-29T09:24:54.231Z","todayStars":15700,"totalStars":95646,"rank":12},{"at":"2026-10-29T09:54:04.471Z","todayStars":15700,"totalStars":95652,"rank":12}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',31303,8369,7410,13,13,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":7188,"totalStars":31145,"rank":13},{"at":"2026-10-29T01:34:38.427Z","todayStars":7410,"totalStars":31181,"rank":13},{"at":"2026-10-29T03:45:18.966Z","todayStars":7410,"totalStars":31206,"rank":13},{"at":"2026-10-29T04:47:11.691Z","todayStars":7410,"totalStars":31217,"rank":13},{"at":"2026-10-29T06:23:52.583Z","todayStars":7410,"totalStars":31231,"rank":13},{"at":"2026-10-29T07:34:01.584Z","todayStars":7410,"totalStars":31253,"rank":13},{"at":"2026-10-29T09:24:54.231Z","todayStars":7410,"totalStars":31293,"rank":13},{"at":"2026-10-29T09:54:04.471Z","todayStars":7410,"totalStars":31303,"rank":13}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','nvidia/openshell','NVIDIA','OpenShell','NVIDIA/OpenShell','https://github.com/NVIDIA/OpenShell','OpenShell is the safe, private runtime for autonomous AI agents.','Rust','#dea584',20647,2023,11650,14,14,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":11510,"totalStars":20555,"rank":14},{"at":"2026-10-29T01:34:38.427Z","todayStars":11650,"totalStars":20584,"rank":14},{"at":"2026-10-29T03:45:18.966Z","todayStars":11650,"totalStars":20603,"rank":14},{"at":"2026-10-29T04:47:11.691Z","todayStars":11650,"totalStars":20613,"rank":14},{"at":"2026-10-29T06:23:52.583Z","todayStars":11650,"totalStars":20621,"rank":14},{"at":"2026-10-29T07:34:01.584Z","todayStars":11650,"totalStars":20625,"rank":14},{"at":"2026-10-29T09:24:54.231Z","todayStars":11650,"totalStars":20644,"rank":14},{"at":"2026-10-29T09:54:04.471Z","todayStars":11650,"totalStars":20647,"rank":14}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',104977,7098,13933,15,15,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":13933,"totalStars":104353,"rank":15},{"at":"2026-10-29T01:34:38.427Z","todayStars":13933,"totalStars":104511,"rank":15},{"at":"2026-10-29T03:45:18.966Z","todayStars":13933,"totalStars":104655,"rank":15},{"at":"2026-10-29T04:47:11.691Z","todayStars":13933,"totalStars":104706,"rank":15},{"at":"2026-10-29T06:23:52.583Z","todayStars":13933,"totalStars":104772,"rank":15},{"at":"2026-10-29T07:34:01.584Z","todayStars":13933,"totalStars":104836,"rank":15},{"at":"2026-10-29T09:24:54.231Z","todayStars":13933,"totalStars":104950,"rank":15},{"at":"2026-10-29T09:54:04.471Z","todayStars":13933,"totalStars":104977,"rank":15}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','panniantong/agent-reach','Panniantong','Agent-Reach','Panniantong/Agent-Reach','https://github.com/Panniantong/Agent-Reach','Give your AI agent eyes to see the entire internet. Read & search Twitter, Reddit, YouTube, GitHub, Bilibili, XiaoHongShu — one CLI, zero API fees.','Python','#3572A5',105919,9392,20047,16,16,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":19461,"totalStars":105569,"rank":16},{"at":"2026-10-29T01:34:38.427Z","todayStars":20047,"totalStars":105652,"rank":16},{"at":"2026-10-29T03:45:18.966Z","todayStars":20047,"totalStars":105722,"rank":16},{"at":"2026-10-29T04:47:11.691Z","todayStars":20047,"totalStars":105747,"rank":16},{"at":"2026-10-29T06:23:52.583Z","todayStars":20047,"totalStars":105792,"rank":16},{"at":"2026-10-29T07:34:01.584Z","todayStars":20047,"totalStars":105840,"rank":16},{"at":"2026-10-29T09:24:54.231Z","todayStars":20047,"totalStars":105901,"rank":16},{"at":"2026-10-29T09:54:04.471Z","todayStars":20047,"totalStars":105919,"rank":16}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','dietrichgebert/ponytail','DietrichGebert','ponytail','DietrichGebert/ponytail','https://github.com/DietrichGebert/ponytail','Makes your AI agent think like the laziest senior dev in the room. The best code is the code you never wrote.','JavaScript','#f1e05a',179572,9842,32691,17,17,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":32214,"totalStars":179099,"rank":17},{"at":"2026-10-29T01:34:38.427Z","todayStars":32691,"totalStars":179229,"rank":17},{"at":"2026-10-29T03:45:18.966Z","todayStars":32691,"totalStars":179315,"rank":17},{"at":"2026-10-29T04:47:11.691Z","todayStars":32691,"totalStars":179350,"rank":17},{"at":"2026-10-29T06:23:52.583Z","todayStars":32691,"totalStars":179404,"rank":17},{"at":"2026-10-29T07:34:01.584Z","todayStars":32691,"totalStars":179454,"rank":17},{"at":"2026-10-29T09:24:54.231Z","todayStars":32691,"totalStars":179549,"rank":17},{"at":"2026-10-29T09:54:04.471Z","todayStars":32691,"totalStars":179572,"rank":17}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','tashfeenahmed/freellmapi','tashfeenahmed','freellmapi','tashfeenahmed/freellmapi','https://github.com/tashfeenahmed/freellmapi','7.4 billion tokens per month. 34 free LLM providers. 635 free model endpoints. All behind one /v1 endpoint, plus any custom OpenAI-compatible endpoint. Smart routing, automatic failover, encrypted keys. Personal experimentation only.','TypeScript','#3178c6',43612,5904,13983,18,18,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":13636,"totalStars":43315,"rank":18},{"at":"2026-10-29T01:34:38.427Z","todayStars":13983,"totalStars":43411,"rank":18},{"at":"2026-10-29T03:45:18.966Z","todayStars":13983,"totalStars":43458,"rank":18},{"at":"2026-10-29T04:47:11.691Z","todayStars":13983,"totalStars":43478,"rank":18},{"at":"2026-10-29T06:23:52.583Z","todayStars":13983,"totalStars":43511,"rank":18},{"at":"2026-10-29T07:34:01.584Z","todayStars":13983,"totalStars":43543,"rank":18},{"at":"2026-10-29T09:24:54.231Z","todayStars":13983,"totalStars":43602,"rank":18},{"at":"2026-10-29T09:54:04.471Z","todayStars":13983,"totalStars":43612,"rank":18}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-29','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',41323,2143,10841,19,19,1,0,NULL,'2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z','[{"at":"2026-10-28T22:03:24.228Z","todayStars":9965,"totalStars":40597,"rank":19},{"at":"2026-10-29T01:34:38.427Z","todayStars":10841,"totalStars":40764,"rank":19},{"at":"2026-10-29T03:45:18.966Z","todayStars":10841,"totalStars":40898,"rank":19},{"at":"2026-10-29T04:47:11.691Z","todayStars":10841,"totalStars":40957,"rank":19},{"at":"2026-10-29T06:23:52.583Z","todayStars":10841,"totalStars":41037,"rank":19},{"at":"2026-10-29T07:34:01.584Z","todayStars":10841,"totalStars":41127,"rank":19},{"at":"2026-10-29T09:24:54.231Z","todayStars":10841,"totalStars":41281,"rank":19},{"at":"2026-10-29T09:54:04.471Z","todayStars":10841,"totalStars":41323,"rank":19}]','2026-10-28T22:03:24.228Z','2026-10-29T09:54:04.471Z'),
('2026-10-30','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',51160,6272,1930,1,1,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1930,"totalStars":50894,"rank":1},{"at":"2026-10-30T07:43:12.875Z","todayStars":1930,"totalStars":50894,"rank":1},{"at":"2026-10-30T07:43:20.440Z","todayStars":1930,"totalStars":50896,"rank":1},{"at":"2026-10-30T07:48:24.631Z","todayStars":1930,"totalStars":50908,"rank":1},{"at":"2026-10-30T08:50:44.668Z","todayStars":1930,"totalStars":51032,"rank":1},{"at":"2026-10-30T10:13:26.921Z","todayStars":1930,"totalStars":51160,"rank":1}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',309033,27482,1034,2,2,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1034,"totalStars":308889,"rank":2},{"at":"2026-10-30T07:43:12.875Z","todayStars":1034,"totalStars":308889,"rank":2},{"at":"2026-10-30T07:43:20.440Z","todayStars":1034,"totalStars":308891,"rank":2},{"at":"2026-10-30T07:48:24.631Z","todayStars":1034,"totalStars":308895,"rank":2},{"at":"2026-10-30T08:50:44.668Z","todayStars":1034,"totalStars":308964,"rank":2},{"at":"2026-10-30T10:13:26.921Z","todayStars":1034,"totalStars":309033,"rank":2}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96251,5660,2870,3,3,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":2870,"totalStars":95984,"rank":3},{"at":"2026-10-30T07:43:12.875Z","todayStars":2870,"totalStars":95984,"rank":3},{"at":"2026-10-30T07:43:20.440Z","todayStars":2870,"totalStars":95985,"rank":3},{"at":"2026-10-30T07:48:24.631Z","todayStars":2870,"totalStars":96001,"rank":3},{"at":"2026-10-30T08:50:44.668Z","todayStars":2870,"totalStars":96126,"rank":3},{"at":"2026-10-30T10:13:26.921Z","todayStars":2870,"totalStars":96251,"rank":3}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',6295,340,1117,4,4,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1117,"totalStars":6217,"rank":4},{"at":"2026-10-30T07:43:12.875Z","todayStars":1117,"totalStars":6217,"rank":4},{"at":"2026-10-30T07:43:20.440Z","todayStars":1117,"totalStars":6217,"rank":4},{"at":"2026-10-30T07:48:24.631Z","todayStars":1117,"totalStars":6220,"rank":4},{"at":"2026-10-30T08:50:44.668Z","todayStars":1117,"totalStars":6248,"rank":4},{"at":"2026-10-30T10:13:26.921Z","todayStars":1117,"totalStars":6295,"rank":4}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','milind-soni/openmausbot','milind-soni','OpenMausBot','milind-soni/OpenMausBot','https://github.com/milind-soni/OpenMausBot','Open-source Grok Bot alternative with a virtual machine that bots can use','TypeScript','#3178c6',7852,1143,1199,5,5,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1199,"totalStars":7736,"rank":5},{"at":"2026-10-30T07:43:12.875Z","todayStars":1199,"totalStars":7736,"rank":5},{"at":"2026-10-30T07:43:20.440Z","todayStars":1199,"totalStars":7736,"rank":5},{"at":"2026-10-30T07:48:24.631Z","todayStars":1199,"totalStars":7739,"rank":5},{"at":"2026-10-30T08:50:44.668Z","todayStars":1199,"totalStars":7799,"rank":5},{"at":"2026-10-30T10:13:26.921Z","todayStars":1199,"totalStars":7852,"rank":5}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','nightly-labs/openbot','nightly-labs','openbot','nightly-labs/openbot','https://github.com/nightly-labs/openbot','A local-first desktop workspace for persistent AI teammates. Run Codex, Claude, and Grok with dedicated workspaces, task queues, file sharing, browser control, and agent-to-agent collaboration.','TypeScript','#3178c6',4125,374,709,6,6,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":709,"totalStars":4053,"rank":6},{"at":"2026-10-30T07:43:12.875Z","todayStars":709,"totalStars":4053,"rank":6},{"at":"2026-10-30T07:43:20.440Z","todayStars":709,"totalStars":4053,"rank":6},{"at":"2026-10-30T07:48:24.631Z","todayStars":709,"totalStars":4056,"rank":6},{"at":"2026-10-30T08:50:44.668Z","todayStars":709,"totalStars":4089,"rank":6},{"at":"2026-10-30T10:13:26.921Z","todayStars":709,"totalStars":4125,"rank":6}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','elayadesign/ai-design-skills','elayadesign','ai-design-skills','elayadesign/ai-design-skills','https://github.com/elayadesign/ai-design-skills','','Unknown','#8b949e',12633,917,1187,7,7,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1187,"totalStars":12516,"rank":7},{"at":"2026-10-30T07:43:12.875Z","todayStars":1187,"totalStars":12516,"rank":7},{"at":"2026-10-30T07:43:20.440Z","todayStars":1187,"totalStars":12516,"rank":7},{"at":"2026-10-30T07:48:24.631Z","todayStars":1187,"totalStars":12523,"rank":7},{"at":"2026-10-30T08:50:44.668Z","todayStars":1187,"totalStars":12573,"rank":7},{"at":"2026-10-30T10:13:26.921Z","todayStars":1187,"totalStars":12633,"rank":7}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',105218,9269,336,8,8,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":336,"totalStars":105101,"rank":8},{"at":"2026-10-30T07:43:12.875Z","todayStars":336,"totalStars":105101,"rank":8},{"at":"2026-10-30T07:43:20.440Z","todayStars":336,"totalStars":105102,"rank":8},{"at":"2026-10-30T07:48:24.631Z","todayStars":336,"totalStars":105105,"rank":8},{"at":"2026-10-30T08:50:44.668Z","todayStars":336,"totalStars":105150,"rank":8},{"at":"2026-10-30T10:13:26.921Z","todayStars":336,"totalStars":105218,"rank":8}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','copilotkit/openbot','CopilotKit','OpenBot','CopilotKit/OpenBot','https://github.com/CopilotKit/OpenBot','Open-source AI coworkers that each get a computer of their own: a browser, files and tools, with every action decided before it happens and recorded after. Bring any AG-UI agent.','TypeScript','#3178c6',8413,1067,247,9,9,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":247,"totalStars":8351,"rank":9},{"at":"2026-10-30T07:43:12.875Z","todayStars":247,"totalStars":8351,"rank":9},{"at":"2026-10-30T07:43:20.440Z","todayStars":247,"totalStars":8351,"rank":9},{"at":"2026-10-30T07:48:24.631Z","todayStars":247,"totalStars":8354,"rank":9},{"at":"2026-10-30T08:50:44.668Z","todayStars":247,"totalStars":8383,"rank":9},{"at":"2026-10-30T10:13:26.921Z","todayStars":247,"totalStars":8413,"rank":9}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',9809,1378,1594,10,10,0,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":1594,"totalStars":9614,"rank":10},{"at":"2026-10-30T07:43:12.875Z","todayStars":1594,"totalStars":9614,"rank":10},{"at":"2026-10-30T07:43:20.440Z","todayStars":1594,"totalStars":9615,"rank":10},{"at":"2026-10-30T07:48:24.631Z","todayStars":1594,"totalStars":9619,"rank":10},{"at":"2026-10-30T08:50:44.668Z","todayStars":1594,"totalStars":9695,"rank":10},{"at":"2026-10-30T10:13:26.921Z","todayStars":1594,"totalStars":9809,"rank":10}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','daily','donchitos/claude-code-game-studios','Donchitos','Claude-Code-Game-Studios','Donchitos/Claude-Code-Game-Studios','https://github.com/Donchitos/Claude-Code-Game-Studios','Turn Claude Code into a full game dev studio — 49 AI agents, 72 workflow skills, and a complete coordination system mirroring real studio hierarchy.','Shell','#89e051',29856,4095,353,11,11,1,0,NULL,'2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z','[{"at":"2026-10-30T07:42:43.394Z","todayStars":353,"totalStars":29653,"rank":11},{"at":"2026-10-30T07:43:12.875Z","todayStars":353,"totalStars":29653,"rank":11},{"at":"2026-10-30T07:43:20.440Z","todayStars":353,"totalStars":29654,"rank":11},{"at":"2026-10-30T07:48:24.631Z","todayStars":353,"totalStars":29662,"rank":11},{"at":"2026-10-30T08:50:44.668Z","todayStars":353,"totalStars":29751,"rank":11},{"at":"2026-10-30T10:13:26.921Z","todayStars":353,"totalStars":29856,"rank":11}]','2026-10-30T07:42:43.394Z','2026-10-30T10:13:26.921Z'),
('2026-10-30','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',53304,3426,14320,1,1,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":14320,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:43:12.456Z","todayStars":14320,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:43:20.273Z","todayStars":14320,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:48:25.174Z","todayStars":14320,"totalStars":53183,"rank":1},{"at":"2026-10-30T08:50:44.831Z","todayStars":14320,"totalStars":53245,"rank":1},{"at":"2026-10-30T10:13:27.126Z","todayStars":14320,"totalStars":53304,"rank":1}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','php/php-src','php','php-src','php/php-src','https://github.com/php/php-src','The PHP Interpreter','C','#555555',41732,8496,960,2,2,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":960,"totalStars":41730,"rank":2},{"at":"2026-10-30T07:43:12.456Z","todayStars":960,"totalStars":41730,"rank":2},{"at":"2026-10-30T07:43:20.273Z","todayStars":960,"totalStars":41730,"rank":2},{"at":"2026-10-30T07:48:25.174Z","todayStars":960,"totalStars":41730,"rank":2},{"at":"2026-10-30T08:50:44.831Z","todayStars":960,"totalStars":41731,"rank":2},{"at":"2026-10-30T10:13:27.126Z","todayStars":960,"totalStars":41732,"rank":2}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',24199,3237,4110,3,3,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":4110,"totalStars":24146,"rank":3},{"at":"2026-10-30T07:43:12.456Z","todayStars":4110,"totalStars":24146,"rank":3},{"at":"2026-10-30T07:43:20.273Z","todayStars":4110,"totalStars":24146,"rank":3},{"at":"2026-10-30T07:48:25.174Z","todayStars":4110,"totalStars":24146,"rank":3},{"at":"2026-10-30T08:50:44.831Z","todayStars":4110,"totalStars":24171,"rank":3},{"at":"2026-10-30T10:13:27.126Z","todayStars":4110,"totalStars":24199,"rank":3}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96251,5660,9713,4,4,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":9713,"totalStars":95984,"rank":4},{"at":"2026-10-30T07:43:12.456Z","todayStars":9713,"totalStars":95984,"rank":4},{"at":"2026-10-30T07:43:20.273Z","todayStars":9713,"totalStars":95985,"rank":4},{"at":"2026-10-30T07:48:25.174Z","todayStars":9713,"totalStars":96001,"rank":4},{"at":"2026-10-30T08:50:44.831Z","todayStars":9713,"totalStars":96126,"rank":4},{"at":"2026-10-30T10:13:27.126Z","todayStars":9713,"totalStars":96251,"rank":4}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',226617,22630,4250,5,5,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":4250,"totalStars":226572,"rank":5},{"at":"2026-10-30T07:43:12.456Z","todayStars":4250,"totalStars":226572,"rank":5},{"at":"2026-10-30T07:43:20.273Z","todayStars":4250,"totalStars":226572,"rank":5},{"at":"2026-10-30T07:48:25.174Z","todayStars":4250,"totalStars":226572,"rank":5},{"at":"2026-10-30T08:50:44.831Z","todayStars":4250,"totalStars":226584,"rank":5},{"at":"2026-10-30T10:13:27.126Z","todayStars":4250,"totalStars":226617,"rank":5}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',118499,22661,5557,6,6,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":5557,"totalStars":118452,"rank":6},{"at":"2026-10-30T07:43:12.456Z","todayStars":5557,"totalStars":118452,"rank":6},{"at":"2026-10-30T07:43:20.273Z","todayStars":5557,"totalStars":118452,"rank":6},{"at":"2026-10-30T07:48:25.174Z","todayStars":5557,"totalStars":118454,"rank":6},{"at":"2026-10-30T08:50:44.831Z","todayStars":5557,"totalStars":118479,"rank":6},{"at":"2026-10-30T10:13:27.126Z","todayStars":5557,"totalStars":118499,"rank":6}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',309033,27482,4894,7,7,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":4894,"totalStars":308889,"rank":7},{"at":"2026-10-30T07:43:12.456Z","todayStars":4894,"totalStars":308889,"rank":7},{"at":"2026-10-30T07:43:20.273Z","todayStars":4894,"totalStars":308891,"rank":7},{"at":"2026-10-30T07:48:25.174Z","todayStars":4894,"totalStars":308895,"rank":7},{"at":"2026-10-30T08:50:44.831Z","todayStars":4894,"totalStars":308964,"rank":7},{"at":"2026-10-30T10:13:27.126Z","todayStars":4894,"totalStars":309033,"rank":7}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33928,3731,2504,8,8,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":2504,"totalStars":33907,"rank":8},{"at":"2026-10-30T07:43:12.456Z","todayStars":2504,"totalStars":33907,"rank":8},{"at":"2026-10-30T07:43:20.273Z","todayStars":2504,"totalStars":33908,"rank":8},{"at":"2026-10-30T07:48:25.174Z","todayStars":2504,"totalStars":33908,"rank":8},{"at":"2026-10-30T08:50:44.831Z","todayStars":2504,"totalStars":33915,"rank":8},{"at":"2026-10-30T10:13:27.126Z","todayStars":2504,"totalStars":33928,"rank":8}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',105890,7155,4359,9,9,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":4359,"totalStars":105798,"rank":9},{"at":"2026-10-30T07:43:12.456Z","todayStars":4359,"totalStars":105798,"rank":9},{"at":"2026-10-30T07:43:20.273Z","todayStars":4359,"totalStars":105798,"rank":9},{"at":"2026-10-30T07:48:25.174Z","todayStars":4359,"totalStars":105801,"rank":9},{"at":"2026-10-30T08:50:44.831Z","todayStars":4359,"totalStars":105842,"rank":9},{"at":"2026-10-30T10:13:27.126Z","todayStars":4359,"totalStars":105890,"rank":9}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',9266,350,980,10,10,0,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":980,"totalStars":9243,"rank":10},{"at":"2026-10-30T07:43:12.456Z","todayStars":980,"totalStars":9243,"rank":10},{"at":"2026-10-30T07:43:20.273Z","todayStars":980,"totalStars":9243,"rank":10},{"at":"2026-10-30T07:48:25.174Z","todayStars":980,"totalStars":9243,"rank":10},{"at":"2026-10-30T08:50:44.831Z","todayStars":980,"totalStars":9254,"rank":10},{"at":"2026-10-30T10:13:27.126Z","todayStars":980,"totalStars":9266,"rank":10}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','weekly','ruvnet/ruflo','ruvnet','ruflo','ruvnet/ruflo','https://github.com/ruvnet/ruflo','🌊 The original agent harness. Deploy intelligent multi-player swarms, coordinate autonomous workflows, and build conversational AI systems. Features adaptive memory, self-learning intelligence, federation, vector RAG integration, and native Claude Code / Codex / Hermes and many more Integrated','TypeScript','#3178c6',80216,9406,1854,11,11,1,0,NULL,'2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z','[{"at":"2026-10-30T07:42:44.774Z","todayStars":1854,"totalStars":80196,"rank":11},{"at":"2026-10-30T07:43:12.456Z","todayStars":1854,"totalStars":80196,"rank":11},{"at":"2026-10-30T07:43:20.273Z","todayStars":1854,"totalStars":80196,"rank":11},{"at":"2026-10-30T07:48:25.174Z","todayStars":1854,"totalStars":80196,"rank":11},{"at":"2026-10-30T08:50:44.831Z","todayStars":1854,"totalStars":80207,"rank":11},{"at":"2026-10-30T10:13:27.126Z","todayStars":1854,"totalStars":80216,"rank":11}]','2026-10-30T07:42:44.774Z','2026-10-30T10:13:27.126Z'),
('2026-10-30','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',53304,3426,29622,1,1,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":29622,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:43:12.729Z","todayStars":29622,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:43:20.132Z","todayStars":29622,"totalStars":53179,"rank":1},{"at":"2026-10-30T07:48:25.068Z","todayStars":29622,"totalStars":53183,"rank":1},{"at":"2026-10-30T08:50:45.083Z","todayStars":29622,"totalStars":53245,"rank":1},{"at":"2026-10-30T10:13:27.481Z","todayStars":29622,"totalStars":53304,"rank":1}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',75717,6897,21520,2,2,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":21520,"totalStars":75644,"rank":2},{"at":"2026-10-30T07:43:12.729Z","todayStars":21520,"totalStars":75644,"rank":2},{"at":"2026-10-30T07:43:20.132Z","todayStars":21520,"totalStars":75644,"rank":2},{"at":"2026-10-30T07:48:25.068Z","todayStars":21520,"totalStars":75647,"rank":2},{"at":"2026-10-30T08:50:45.083Z","todayStars":21520,"totalStars":75677,"rank":2},{"at":"2026-10-30T10:13:27.481Z","todayStars":21520,"totalStars":75717,"rank":2}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',33928,3731,8086,3,3,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":8086,"totalStars":33907,"rank":3},{"at":"2026-10-30T07:43:12.729Z","todayStars":8086,"totalStars":33907,"rank":3},{"at":"2026-10-30T07:43:20.132Z","todayStars":8086,"totalStars":33908,"rank":3},{"at":"2026-10-30T07:48:25.068Z","todayStars":8086,"totalStars":33908,"rank":3},{"at":"2026-10-30T08:50:45.083Z","todayStars":8086,"totalStars":33915,"rank":3},{"at":"2026-10-30T10:13:27.481Z","todayStars":8086,"totalStars":33928,"rank":3}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',24258,2327,7732,4,4,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":7732,"totalStars":24225,"rank":4},{"at":"2026-10-30T07:43:12.729Z","todayStars":7732,"totalStars":24225,"rank":4},{"at":"2026-10-30T07:43:20.132Z","todayStars":7732,"totalStars":24225,"rank":4},{"at":"2026-10-30T07:48:25.068Z","todayStars":7732,"totalStars":24227,"rank":4},{"at":"2026-10-30T08:50:45.083Z","todayStars":7732,"totalStars":24242,"rank":4},{"at":"2026-10-30T10:13:27.481Z","todayStars":7732,"totalStars":24258,"rank":4}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96251,5660,22473,5,5,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":22473,"totalStars":95984,"rank":5},{"at":"2026-10-30T07:43:12.729Z","todayStars":22473,"totalStars":95984,"rank":5},{"at":"2026-10-30T07:43:20.132Z","todayStars":22473,"totalStars":95985,"rank":5},{"at":"2026-10-30T07:48:25.068Z","todayStars":22473,"totalStars":96001,"rank":5},{"at":"2026-10-30T08:50:45.083Z","todayStars":22473,"totalStars":96126,"rank":5},{"at":"2026-10-30T10:13:27.481Z","todayStars":22473,"totalStars":96251,"rank":5}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',94876,10484,47778,6,6,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":47778,"totalStars":94714,"rank":6},{"at":"2026-10-30T07:43:12.729Z","todayStars":47778,"totalStars":94714,"rank":6},{"at":"2026-10-30T07:43:20.132Z","todayStars":47778,"totalStars":94715,"rank":6},{"at":"2026-10-30T07:48:25.068Z","todayStars":47778,"totalStars":94721,"rank":6},{"at":"2026-10-30T08:50:45.083Z","todayStars":47778,"totalStars":94792,"rank":6},{"at":"2026-10-30T10:13:27.481Z","todayStars":47778,"totalStars":94876,"rank":6}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45366,4728,8277,7,7,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":8277,"totalStars":45350,"rank":7},{"at":"2026-10-30T07:43:12.729Z","todayStars":8277,"totalStars":45350,"rank":7},{"at":"2026-10-30T07:43:20.132Z","todayStars":8277,"totalStars":45350,"rank":7},{"at":"2026-10-30T07:48:25.068Z","todayStars":8277,"totalStars":45351,"rank":7},{"at":"2026-10-30T08:50:45.083Z","todayStars":8277,"totalStars":45357,"rank":7},{"at":"2026-10-30T10:13:27.481Z","todayStars":8277,"totalStars":45366,"rank":7}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',32893,2273,8800,8,8,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":8800,"totalStars":32882,"rank":8},{"at":"2026-10-30T07:43:12.729Z","todayStars":8800,"totalStars":32882,"rank":8},{"at":"2026-10-30T07:43:20.132Z","todayStars":8800,"totalStars":32882,"rank":8},{"at":"2026-10-30T07:48:25.068Z","todayStars":8800,"totalStars":32883,"rank":8},{"at":"2026-10-30T08:50:45.083Z","todayStars":8800,"totalStars":32885,"rank":8},{"at":"2026-10-30T10:13:27.481Z","todayStars":8800,"totalStars":32893,"rank":8}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',14653,1509,5677,9,9,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":5677,"totalStars":14631,"rank":9},{"at":"2026-10-30T07:43:12.729Z","todayStars":5677,"totalStars":14631,"rank":9},{"at":"2026-10-30T07:43:20.132Z","todayStars":5677,"totalStars":14631,"rank":9},{"at":"2026-10-30T07:48:25.068Z","todayStars":5677,"totalStars":14632,"rank":9},{"at":"2026-10-30T08:50:45.083Z","todayStars":5677,"totalStars":14640,"rank":9},{"at":"2026-10-30T10:13:27.481Z","todayStars":5677,"totalStars":14653,"rank":9}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',105218,9269,9911,10,10,0,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":9911,"totalStars":105101,"rank":10},{"at":"2026-10-30T07:43:12.729Z","todayStars":9911,"totalStars":105101,"rank":10},{"at":"2026-10-30T07:43:20.132Z","todayStars":9911,"totalStars":105102,"rank":10},{"at":"2026-10-30T07:48:25.068Z","todayStars":9911,"totalStars":105105,"rank":10},{"at":"2026-10-30T08:50:45.083Z","todayStars":9911,"totalStars":105150,"rank":10},{"at":"2026-10-30T10:13:27.481Z","todayStars":9911,"totalStars":105218,"rank":10}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',42372,2192,12501,11,11,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":12501,"totalStars":42302,"rank":11},{"at":"2026-10-30T07:43:12.729Z","todayStars":12501,"totalStars":42302,"rank":11},{"at":"2026-10-30T07:43:20.132Z","todayStars":12501,"totalStars":42302,"rank":11},{"at":"2026-10-30T07:48:25.068Z","todayStars":12501,"totalStars":42302,"rank":11},{"at":"2026-10-30T08:50:45.083Z","todayStars":12501,"totalStars":42329,"rank":11},{"at":"2026-10-30T10:13:27.481Z","todayStars":12501,"totalStars":42372,"rank":11}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',96016,10823,16113,12,12,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":16113,"totalStars":95972,"rank":12},{"at":"2026-10-30T07:43:12.729Z","todayStars":16113,"totalStars":95972,"rank":12},{"at":"2026-10-30T07:43:20.132Z","todayStars":16113,"totalStars":95972,"rank":12},{"at":"2026-10-30T07:48:25.068Z","todayStars":16113,"totalStars":95973,"rank":12},{"at":"2026-10-30T08:50:45.083Z","todayStars":16113,"totalStars":95995,"rank":12},{"at":"2026-10-30T10:13:27.481Z","todayStars":16113,"totalStars":96016,"rank":12}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',32203,8547,7708,13,13,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":7708,"totalStars":32121,"rank":13},{"at":"2026-10-30T07:43:12.729Z","todayStars":7708,"totalStars":32121,"rank":13},{"at":"2026-10-30T07:43:20.132Z","todayStars":7708,"totalStars":32122,"rank":13},{"at":"2026-10-30T07:48:25.068Z","todayStars":7708,"totalStars":32124,"rank":13},{"at":"2026-10-30T08:50:45.083Z","todayStars":7708,"totalStars":32165,"rank":13},{"at":"2026-10-30T10:13:27.481Z","todayStars":7708,"totalStars":32203,"rank":13}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','flutter/flutter','flutter','flutter','flutter/flutter','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful apps for mobile and beyond','Dart','#00B4AB',180666,33377,1993,14,14,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":1993,"totalStars":180654,"rank":14},{"at":"2026-10-30T07:43:12.729Z","todayStars":1993,"totalStars":180654,"rank":14},{"at":"2026-10-30T07:43:20.132Z","todayStars":1993,"totalStars":180654,"rank":14},{"at":"2026-10-30T07:48:25.068Z","todayStars":1993,"totalStars":180654,"rank":14},{"at":"2026-10-30T08:50:45.083Z","todayStars":1993,"totalStars":180657,"rank":14},{"at":"2026-10-30T10:13:27.481Z","todayStars":1993,"totalStars":180666,"rank":14}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',292981,43347,24663,15,15,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":24663,"totalStars":292909,"rank":15},{"at":"2026-10-30T07:43:12.729Z","todayStars":24663,"totalStars":292909,"rank":15},{"at":"2026-10-30T07:43:20.132Z","todayStars":24663,"totalStars":292910,"rank":15},{"at":"2026-10-30T07:48:25.068Z","todayStars":24663,"totalStars":292913,"rank":15},{"at":"2026-10-30T08:50:45.083Z","todayStars":24663,"totalStars":292939,"rank":15},{"at":"2026-10-30T10:13:27.481Z","todayStars":24663,"totalStars":292981,"rank":15}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',105890,7155,14568,16,16,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":14568,"totalStars":105798,"rank":16},{"at":"2026-10-30T07:43:12.729Z","todayStars":14568,"totalStars":105798,"rank":16},{"at":"2026-10-30T07:43:20.132Z","todayStars":14568,"totalStars":105798,"rank":16},{"at":"2026-10-30T07:48:25.068Z","todayStars":14568,"totalStars":105801,"rank":16},{"at":"2026-10-30T08:50:45.083Z","todayStars":14568,"totalStars":105842,"rank":16},{"at":"2026-10-30T10:13:27.481Z","todayStars":14568,"totalStars":105890,"rank":16}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','panniantong/agent-reach','Panniantong','Agent-Reach','Panniantong/Agent-Reach','https://github.com/Panniantong/Agent-Reach','Give your AI agent eyes to see the entire internet. Read & search Twitter, Reddit, YouTube, GitHub, Bilibili, XiaoHongShu — one CLI, zero API fees.','Python','#3572A5',106547,9458,20593,17,17,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":20593,"totalStars":106473,"rank":17},{"at":"2026-10-30T07:43:12.729Z","todayStars":20593,"totalStars":106473,"rank":17},{"at":"2026-10-30T07:43:20.132Z","todayStars":20593,"totalStars":106473,"rank":17},{"at":"2026-10-30T07:48:25.068Z","todayStars":20593,"totalStars":106473,"rank":17},{"at":"2026-10-30T08:50:45.083Z","todayStars":20593,"totalStars":106515,"rank":17},{"at":"2026-10-30T10:13:27.481Z","todayStars":20593,"totalStars":106547,"rank":17}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','dietrichgebert/ponytail','DietrichGebert','ponytail','DietrichGebert/ponytail','https://github.com/DietrichGebert/ponytail','Makes your AI agent think like the laziest senior dev in the room. The best code is the code you never wrote.','JavaScript','#f1e05a',180561,9918,33063,18,18,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":33063,"totalStars":180437,"rank":18},{"at":"2026-10-30T07:43:12.729Z","todayStars":33063,"totalStars":180437,"rank":18},{"at":"2026-10-30T07:43:20.132Z","todayStars":33063,"totalStars":180437,"rank":18},{"at":"2026-10-30T07:48:25.068Z","todayStars":33063,"totalStars":180441,"rank":18},{"at":"2026-10-30T08:50:45.083Z","todayStars":33063,"totalStars":180495,"rank":18},{"at":"2026-10-30T10:13:27.481Z","todayStars":33063,"totalStars":180561,"rank":18}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-30','monthly','tashfeenahmed/freellmapi','tashfeenahmed','freellmapi','tashfeenahmed/freellmapi','https://github.com/tashfeenahmed/freellmapi','7.4 billion tokens per month. 34 free LLM providers. 635 free model endpoints. All behind one /v1 endpoint, plus any custom OpenAI-compatible endpoint. Smart routing, automatic failover, encrypted keys. Personal experimentation only.','TypeScript','#3178c6',44267,6011,14488,19,19,1,0,NULL,'2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z','[{"at":"2026-10-30T07:42:44.934Z","todayStars":14488,"totalStars":44193,"rank":19},{"at":"2026-10-30T07:43:12.729Z","todayStars":14488,"totalStars":44193,"rank":19},{"at":"2026-10-30T07:43:20.132Z","todayStars":14488,"totalStars":44193,"rank":19},{"at":"2026-10-30T07:48:25.068Z","todayStars":14488,"totalStars":44197,"rank":19},{"at":"2026-10-30T08:50:45.083Z","todayStars":14488,"totalStars":44232,"rank":19},{"at":"2026-10-30T10:13:27.481Z","todayStars":14488,"totalStars":44267,"rank":19}]','2026-10-30T07:42:44.934Z','2026-10-30T10:13:27.481Z'),
('2026-10-31','daily','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',106166,9349,1145,1,1,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":1145,"totalStars":106166,"rank":1}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z');
insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-10-31','daily','milind-soni/openmausbot','milind-soni','OpenMausBot','milind-soni/OpenMausBot','https://github.com/milind-soni/OpenMausBot','Open-source Grok Bot alternative with a virtual machine that bots can use','TypeScript','#3178c6',8576,1194,899,2,2,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":899,"totalStars":8576,"rank":2}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96989,5714,2299,3,3,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":2299,"totalStars":96989,"rank":3}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','copilotkit/openbot','CopilotKit','OpenBot','CopilotKit/OpenBot','https://github.com/CopilotKit/OpenBot','Open-source AI coworkers that each get a computer of their own: a browser, files and tools, with every action decided before it happens and recorded after. Bring any AG-UI agent.','TypeScript','#3178c6',8753,1106,707,4,4,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":707,"totalStars":8753,"rank":4}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','renhuai123/ziwei-doushu','Renhuai123','ziwei-doushu','Renhuai123/ziwei-doushu','https://github.com/Renhuai123/ziwei-doushu','紫微斗数开源排盘引擎 — 基于倪海厦《天纪》体系，含完整排盘算法、四化系统、格局知识库、古籍原文数据','TypeScript','#3178c6',11172,2231,1146,5,5,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":1146,"totalStars":11172,"rank":5}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','expo/skills','expo','skills','expo/skills','https://github.com/expo/skills','A collection of AI agent skills for working with Expo projects and Expo Application Services','Shell','#89e051',3876,247,108,6,6,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":108,"totalStars":3876,"rank":6}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','macro-inc/macro','macro-inc','macro','macro-inc/macro','https://github.com/macro-inc/macro','Macro is a unified workspace for teams: email, chat, docs, tasks, agents, calls, and CRM — @-linked together with shared AI memory.','Rust','#dea584',5850,537,117,7,7,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":117,"totalStars":5850,"rank":7}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','mattpocock/skills','mattpocock','skills','mattpocock/skills','https://github.com/mattpocock/skills','Skills for Real Engineers. Straight from my .agents directory.','Shell','#89e051',307439,25873,889,8,8,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":889,"totalStars":307439,"rank":8}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',32703,8651,920,9,9,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":920,"totalStars":32703,"rank":9}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',51730,6335,2282,10,10,0,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":2282,"totalStars":51730,"rank":10}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','anthropics/skills','anthropics','skills','anthropics/skills','https://github.com/anthropics/skills','Public repository for Agent Skills','Python','#3572A5',185273,21892,287,11,11,1,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":287,"totalStars":185273,"rank":11}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',6545,357,717,12,12,1,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":717,"totalStars":6545,"rank":12}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',10913,1585,2053,13,13,1,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":2053,"totalStars":10913,"rank":13}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',309399,27519,1255,14,14,1,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":1255,"totalStars":309399,"rank":14}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','daily','lightpanda-io/browser','lightpanda-io','browser','lightpanda-io/browser','https://github.com/lightpanda-io/browser','Lightpanda: the headless browser designed for AI and automation','Zig','#ec915c',38318,1868,652,15,15,1,0,NULL,'2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z','[{"at":"2026-10-30T23:17:27.302Z","todayStars":652,"totalStars":38318,"rank":15}]','2026-10-30T23:17:27.302Z','2026-10-30T23:17:27.302Z'),
('2026-10-31','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',54065,3493,14320,1,1,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":14320,"totalStars":54065,"rank":1}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',24490,3260,4110,2,2,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":4110,"totalStars":24490,"rank":2}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96989,5714,9713,3,3,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":9713,"totalStars":96989,"rank":3}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',309399,27519,4894,4,4,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":4894,"totalStars":309399,"rank":4}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',118694,22692,5557,5,5,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":5557,"totalStars":118694,"rank":5}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',226838,22648,4250,6,6,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":4250,"totalStars":226838,"rank":6}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',106303,7190,4359,7,7,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":4359,"totalStars":106303,"rank":7}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',9355,357,980,8,8,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":980,"totalStars":9355,"rank":8}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',32703,8651,2142,9,9,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":2142,"totalStars":32703,"rank":9}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',34029,3748,2504,10,10,0,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":2504,"totalStars":34029,"rank":10}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',293382,43415,6594,11,11,1,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":6594,"totalStars":293382,"rank":11}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','anthropics/skills','anthropics','skills','anthropics/skills','https://github.com/anthropics/skills','Public repository for Agent Skills','Python','#3572A5',185273,21892,1877,12,12,1,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":1877,"totalStars":185273,"rank":12}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','weekly','ruvnet/ruflo','ruvnet','ruflo','ruvnet/ruflo','https://github.com/ruvnet/ruflo','🌊 The original agent harness. Deploy intelligent multi-player swarms, coordinate autonomous workflows, and build conversational AI systems. Features adaptive memory, self-learning intelligence, federation, vector RAG integration, and native Claude Code / Codex / Hermes and many more Integrated','TypeScript','#3178c6',80293,9416,1854,13,13,1,0,NULL,'2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z','[{"at":"2026-10-30T23:17:28.748Z","todayStars":1854,"totalStars":80293,"rank":13}]','2026-10-30T23:17:28.748Z','2026-10-30T23:17:28.748Z'),
('2026-10-31','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',54065,3493,29622,1,1,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":29622,"totalStars":54065,"rank":1}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',76028,6929,21520,2,2,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":21520,"totalStars":76028,"rank":2}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',34029,3748,8086,3,3,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":8086,"totalStars":34029,"rank":3}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',96989,5714,22473,4,4,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":22473,"totalStars":96989,"rank":4}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',95689,10597,47778,5,5,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":47778,"totalStars":95689,"rank":5}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',24343,2336,7732,6,6,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":7732,"totalStars":24343,"rank":6}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',42942,2240,12501,7,7,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":12501,"totalStars":42942,"rank":7}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','mvschwarz/openrig','mvschwarz','openrig','mvschwarz/openrig','https://github.com/mvschwarz/openrig','Build your own network of agents from Claude Code, Codex and Pi: persistent teams with roles, shared context and owned work.','TypeScript','#3178c6',8369,692,5720,8,8,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":5720,"totalStars":8369,"rank":8}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45440,4737,8277,9,9,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":8277,"totalStars":45440,"rank":9}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',106166,9349,9911,10,10,0,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":9911,"totalStars":106166,"rank":10}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',32941,2278,8800,11,11,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":8800,"totalStars":32941,"rank":11}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',32703,8651,7708,12,12,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":7708,"totalStars":32703,"rank":12}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',14716,1515,5677,13,13,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":5677,"totalStars":14716,"rank":13}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',96187,10856,16113,14,14,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":16113,"totalStars":96187,"rank":14}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',106303,7190,14568,15,15,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":14568,"totalStars":106303,"rank":15}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','flutter/flutter','flutter','flutter','flutter/flutter','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful apps for mobile and beyond','Dart','#00B4AB',180735,33391,1993,16,16,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":1993,"totalStars":180735,"rank":16}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',293382,43415,24663,17,17,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":24663,"totalStars":293382,"rank":17}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',24490,3260,5997,18,18,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":5997,"totalStars":24490,"rank":18}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','android/skills','android','skills','android/skills','https://github.com/android/skills','','Kotlin','#A97BFF',10097,658,2460,19,19,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":2460,"totalStars":10097,"rank":19}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','panniantong/agent-reach','Panniantong','Agent-Reach','Panniantong/Agent-Reach','https://github.com/Panniantong/Agent-Reach','Give your AI agent eyes to see the entire internet. Read & search Twitter, Reddit, YouTube, GitHub, Bilibili, XiaoHongShu — one CLI, zero API fees.','Python','#3572A5',106794,9494,20593,20,20,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":20593,"totalStars":106794,"rank":20}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','vercel-labs/skills','vercel-labs','skills','vercel-labs/skills','https://github.com/vercel-labs/skills','The open agent skills tool - npx skills','TypeScript','#3178c6',37285,3219,4512,21,21,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":4512,"totalStars":37285,"rank":21}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-10-31','monthly','tashfeenahmed/freellmapi','tashfeenahmed','freellmapi','tashfeenahmed/freellmapi','https://github.com/tashfeenahmed/freellmapi','7.4 billion tokens per month. 34 free LLM providers. 635 free model endpoints. All behind one /v1 endpoint, plus any custom OpenAI-compatible endpoint. Smart routing, automatic failover, encrypted keys. Personal experimentation only.','TypeScript','#3178c6',44641,6069,14488,22,22,1,0,NULL,'2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z','[{"at":"2026-10-30T23:17:28.938Z","todayStars":14488,"totalStars":44641,"rank":22}]','2026-10-30T23:17:28.938Z','2026-10-30T23:17:28.938Z'),
('2026-11-01','daily','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',108378,9507,1723,1,1,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1723,"totalStars":108378,"rank":1}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z');
insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-11-01','daily','mattpocock/skills','mattpocock','skills','mattpocock/skills','https://github.com/mattpocock/skills','Skills for Real Engineers. Straight from my .agents directory.','Shell','#89e051',308803,25994,883,2,2,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":883,"totalStars":308803,"rank":2}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','donchitos/claude-code-game-studios','Donchitos','Claude-Code-Game-Studios','Donchitos/Claude-Code-Game-Studios','https://github.com/Donchitos/Claude-Code-Game-Studios','Turn Claude Code into a full game dev studio — 49 AI agents, 72 workflow skills, and a complete coordination system mirroring real studio hierarchy.','Shell','#89e051',31554,4314,742,3,3,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":742,"totalStars":31554,"rank":3}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',36367,8838,1148,4,4,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1148,"totalStars":36367,"rank":4}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','renhuai123/ziwei-doushu','Renhuai123','ziwei-doushu','Renhuai123/ziwei-doushu','https://github.com/Renhuai123/ziwei-doushu','紫微斗数开源排盘引擎 — 基于倪海厦《天纪》体系，含完整排盘算法、四化系统、格局知识库、古籍原文数据','TypeScript','#3178c6',12692,2488,1092,5,5,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1092,"totalStars":12692,"rank":5}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','milind-soni/openmausbot','milind-soni','OpenMausBot','milind-soni/OpenMausBot','https://github.com/milind-soni/OpenMausBot','Open-source Grok Bot alternative with a virtual machine that bots can use','TypeScript','#3178c6',10040,1389,1303,6,6,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1303,"totalStars":10040,"rank":6}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',98736,5823,1338,7,7,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1338,"totalStars":98736,"rank":7}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',310300,27612,665,8,8,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":665,"totalStars":310300,"rank":8}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','lightpanda-io/browser','lightpanda-io','browser','lightpanda-io/browser','https://github.com/lightpanda-io/browser','Lightpanda: the headless browser designed for AI and automation','Zig','#ec915c',39534,1931,929,9,9,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":929,"totalStars":39534,"rank":9}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','hkuds/deeptutor','HKUDS','DeepTutor','HKUDS/DeepTutor','https://github.com/HKUDS/DeepTutor','DeepTutor: Lifelong Personalized Tutoring. https://deeptutor.info/.','Python','#3572A5',53264,6510,1034,10,10,0,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1034,"totalStars":53264,"rank":10}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','orkas-ai/orkas','Orkas-AI','Orkas','Orkas-AI/Orkas','https://github.com/Orkas-AI/Orkas','Orkas is an open-source (MIT), local-first AI team for your desktop: a Commander turns your goal into to-dos and coordinates 16 built-in specialist agents plus Claude Code, Codex, OpenCode, OpenClaw and Hermes, with projects, scheduled automations and connectors. Free app for macOS & Windows; built-in models or your own keys.','JavaScript','#f1e05a',7046,452,1044,11,11,1,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":1044,"totalStars":7046,"rank":11}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','thu-maic/openmaic','THU-MAIC','OpenMAIC','THU-MAIC/OpenMAIC','https://github.com/THU-MAIC/OpenMAIC','Open Multi-Agent Interactive Classroom — Get an immersive, multi-agent learning experience in just one click','TypeScript','#3178c6',42339,6523,116,12,12,1,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":116,"totalStars":42339,"rank":12}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','bregman-arie/devops-exercises','bregman-arie','devops-exercises','bregman-arie/devops-exercises','https://github.com/bregman-arie/devops-exercises','Linux, Jenkins, AWS, SRE, Prometheus, Docker, Python, Ansible, Git, Kubernetes, Terraform, OpenStack, SQL, NoSQL, Azure, GCP, DNS, Elastic, Network, Virtualization. DevOps Interview Questions','Python','#3572A5',86231,20562,342,13,13,1,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":342,"totalStars":86231,"rank":13}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','daily','vorssaint/vorssaint-utils','vorssaint','vorssaint-utils','vorssaint/vorssaint-utils','https://github.com/vorssaint/vorssaint-utils','Free and open-source macOS menu bar toolkit.','Swift','#F05138',32157,1548,501,14,14,1,0,NULL,'2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z','[{"at":"2026-11-01T10:28:26.692Z","todayStars":501,"totalStars":32157,"rank":14}]','2026-11-01T10:28:26.692Z','2026-11-01T10:28:26.692Z'),
('2026-11-01','weekly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',44282,2339,12062,1,1,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":12062,"totalStars":44282,"rank":1}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',55767,3644,11908,2,2,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":11908,"totalStars":55767,"rank":2}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',25226,3334,4814,3,3,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":4814,"totalStars":25226,"rank":3}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',98736,5823,12031,4,4,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":12031,"totalStars":98736,"rank":4}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',310300,27612,5636,5,5,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":5636,"totalStars":310300,"rank":5}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',227701,22716,4277,6,6,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":4277,"totalStars":227701,"rank":6}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',119225,22812,5483,7,7,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":5483,"totalStars":119225,"rank":7}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',9736,375,1272,8,8,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":1272,"totalStars":9736,"rank":8}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',107348,7256,4975,9,9,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":4975,"totalStars":107348,"rank":9}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',36367,8838,3718,10,10,0,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":3718,"totalStars":36367,"rank":10}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',108378,9507,4575,11,11,1,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":4575,"totalStars":108378,"rank":11}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','anthropics/skills','anthropics','skills','anthropics/skills','https://github.com/anthropics/skills','Public repository for Agent Skills','Python','#3572A5',186068,21970,2389,12,12,1,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":2389,"totalStars":186068,"rank":12}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',294339,43581,6380,13,13,1,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":6380,"totalStars":294339,"rank":13}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','yujunzhixue/dsh-purge','YuJunZhiXue','dsh-purge','YuJunZhiXue/dsh-purge','https://github.com/YuJunZhiXue/dsh-purge','DeepSeek Harness 破甲：让所有模型都能破甲，不同模型可换不同提示词；默认提示词面向国模「小码酱」。Jailbreak for every model — swap prompts per model. 求 Star 收藏 ⭐ 如要二开，请查看署名要求部分','JavaScript','#f1e05a',14949,3452,6641,14,14,1,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":6641,"totalStars":14949,"rank":14}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','weekly','astrbotdevs/astrbot','AstrBotDevs','AstrBot','AstrBotDevs/AstrBot','https://github.com/AstrBotDevs/AstrBot','AI Agent Assistant & development framework that integrates lots of IM platforms, LLMs, plugins and AI feature, and can be your openclaw alternative. ✨','Python','#3572A5',45432,3329,2137,15,15,1,0,NULL,'2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z','[{"at":"2026-11-01T10:28:27.007Z","todayStars":2137,"totalStars":45432,"rank":15}]','2026-11-01T10:28:27.007Z','2026-11-01T10:28:27.007Z'),
('2026-11-01','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',55767,3644,31731,1,1,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":31731,"totalStars":55767,"rank":1}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',76761,7029,22303,2,2,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":22303,"totalStars":76761,"rank":2}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',44282,2339,14378,3,3,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":14378,"totalStars":44282,"rank":3}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',34275,3785,8375,4,4,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":8375,"totalStars":34275,"rank":4}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',97250,10789,47234,5,5,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":47234,"totalStars":97250,"rank":5}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',98736,5823,25479,6,6,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":25479,"totalStars":98736,"rank":6}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',24587,2355,8092,7,7,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":8092,"totalStars":24587,"rank":7}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',96604,10907,16685,8,8,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":16685,"totalStars":96604,"rank":8}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',36367,8838,9973,9,9,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":9973,"totalStars":36367,"rank":9}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',108378,9507,12705,10,10,0,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":12705,"totalStars":108378,"rank":10}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45627,4749,8525,11,11,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":8525,"totalStars":45627,"rank":11}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',33077,2281,8881,12,12,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":8881,"totalStars":33077,"rank":12}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','mvschwarz/openrig','mvschwarz','openrig','mvschwarz/openrig','https://github.com/mvschwarz/openrig','Build your own network of agents from Claude Code, Codex and Pi: persistent teams with roles, shared context and owned work.','TypeScript','#3178c6',8529,703,5747,13,13,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":5747,"totalStars":8529,"rank":13}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',14932,1539,5799,14,14,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":5799,"totalStars":14932,"rank":14}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',107348,7256,15847,15,15,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":15847,"totalStars":107348,"rank":15}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','flutter/flutter','flutter','flutter','flutter/flutter','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful apps for mobile and beyond','Dart','#00B4AB',180883,32836,2257,16,16,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":2257,"totalStars":180883,"rank":16}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','android/skills','android','skills','android/skills','https://github.com/android/skills','','Kotlin','#A97BFF',10191,665,2568,17,17,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":2568,"totalStars":10191,"rank":17}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',294339,43581,25494,18,18,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":25494,"totalStars":294339,"rank":18}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-01','monthly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',25226,3334,6891,19,19,1,0,NULL,'2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z','[{"at":"2026-11-01T10:28:26.903Z","todayStars":6891,"totalStars":25226,"rank":19}]','2026-11-01T10:28:26.903Z','2026-11-01T10:28:26.903Z'),
('2026-11-02','daily','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',109290,9565,1526,1,1,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":1526,"totalStars":109258,"rank":1},{"at":"2026-11-02T00:58:59.560Z","todayStars":1526,"totalStars":109290,"rank":1}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','lightpanda-io/browser','lightpanda-io','browser','lightpanda-io/browser','https://github.com/lightpanda-io/browser','Lightpanda: the headless browser designed for AI and automation','Zig','#ec915c',40130,1963,825,2,2,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":825,"totalStars":40112,"rank":2},{"at":"2026-11-02T00:58:59.560Z","todayStars":825,"totalStars":40130,"rank":2}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','shiyu-coder/kronos','shiyu-coder','Kronos','shiyu-coder/Kronos','https://github.com/shiyu-coder/Kronos','Kronos: A Foundation Model for the Language of Financial Markets','Python','#3572A5',45391,7502,630,3,3,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":630,"totalStars":45373,"rank":3},{"at":"2026-11-02T00:58:59.560Z","todayStars":630,"totalStars":45391,"rank":3}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z');
insert or replace into trending_repos (date, period, repo_key, owner, name, full_name, url, description, language, language_color, total_stars, forks, today_stars, rank, best_rank, bucket, dropped, dropped_at, first_seen_at, last_seen_at, snapshots, created_at, updated_at) values
('2026-11-02','daily','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',38011,8917,3094,4,4,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":3094,"totalStars":37978,"rank":4},{"at":"2026-11-02T00:58:59.560Z","todayStars":3094,"totalStars":38011,"rank":4}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','milind-soni/openmausbot','milind-soni','OpenMausBot','milind-soni/OpenMausBot','https://github.com/milind-soni/OpenMausBot','Open-source Grok Bot alternative with a virtual machine that bots can use','TypeScript','#3178c6',10532,1458,922,5,5,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":922,"totalStars":10515,"rank":5},{"at":"2026-11-02T00:58:59.560Z","todayStars":922,"totalStars":10532,"rank":5}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','public-apis/public-apis','public-apis','public-apis','public-apis/public-apis','https://github.com/public-apis/public-apis','A collective list of free APIs','Python','#3572A5',494612,55206,324,6,6,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":324,"totalStars":494595,"rank":6},{"at":"2026-11-02T00:58:59.560Z","todayStars":324,"totalStars":494612,"rank":6}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','cjpais/handy','cjpais','Handy','cjpais/Handy','https://github.com/cjpais/Handy','A free, open source, and extensible speech-to-text application that works completely offline.','Rust','#dea584',36555,3452,339,7,7,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":339,"totalStars":36539,"rank":7},{"at":"2026-11-02T00:58:59.560Z","todayStars":339,"totalStars":36555,"rank":7}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','donchitos/claude-code-game-studios','Donchitos','Claude-Code-Game-Studios','Donchitos/Claude-Code-Game-Studios','https://github.com/Donchitos/Claude-Code-Game-Studios','Turn Claude Code into a full game dev studio — 49 AI agents, 72 workflow skills, and a complete coordination system mirroring real studio hierarchy.','Shell','#89e051',32284,4399,967,8,8,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":967,"totalStars":32270,"rank":8},{"at":"2026-11-02T00:58:59.560Z","todayStars":967,"totalStars":32284,"rank":8}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','kornia/kornia','kornia','kornia','kornia/kornia','https://github.com/kornia/kornia','🐍 Geometric Computer Vision Library for Spatial AI','Python','#3572A5',11789,1466,101,9,9,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":101,"totalStars":11782,"rank":9},{"at":"2026-11-02T00:58:59.560Z","todayStars":101,"totalStars":11789,"rank":9}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','beenuar/aisoc','beenuar','AiSOC','beenuar/AiSOC','https://github.com/beenuar/AiSOC','Open-source AI Security Operations Center: alert fusion, LLM-agent triage, MITRE ATT&CK investigation, and a replayable decision ledger for every agent step. Self-hostable, runs with no API keys, MIT licensed. Ships an MCP server for Claude, Cursor and Continue.','Python','#3572A5',6222,643,446,10,10,0,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":446,"totalStars":6215,"rank":10},{"at":"2026-11-02T00:58:59.560Z","todayStars":446,"totalStars":6222,"rank":10}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','renhuai123/ziwei-doushu','Renhuai123','ziwei-doushu','Renhuai123/ziwei-doushu','https://github.com/Renhuai123/ziwei-doushu','紫微斗数开源排盘引擎 — 基于倪海厦《天纪》体系，含完整排盘算法、四化系统、格局知识库、古籍原文数据','TypeScript','#3178c6',13115,2559,941,11,11,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":941,"totalStars":13098,"rank":11},{"at":"2026-11-02T00:58:59.560Z","todayStars":941,"totalStars":13115,"rank":11}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','anomalyco/hex','anomalyco','hex','anomalyco/hex','https://github.com/anomalyco/hex','Local voice dictation for mac, windows and linux','Rust','#dea584',3274,189,1179,12,12,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":1179,"totalStars":3257,"rank":12},{"at":"2026-11-02T00:58:59.560Z","todayStars":1179,"totalStars":3274,"rank":12}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','copilotkit/openbot','CopilotKit','OpenBot','CopilotKit/OpenBot','https://github.com/CopilotKit/OpenBot','Open-source AI coworkers that each get a computer of their own: a browser, files and tools, with every action decided before it happens and recorded after. Bring any AG-UI agent.','TypeScript','#3178c6',9524,1189,175,13,13,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":175,"totalStars":9516,"rank":13},{"at":"2026-11-02T00:58:59.560Z","todayStars":175,"totalStars":9524,"rank":13}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','togg53192-cmd/jailbreaks','togg53192-cmd','jailbreaks','togg53192-cmd/jailbreaks','https://github.com/togg53192-cmd/jailbreaks','LIST OF ALL MY JAILBREAKS','Unknown','#8b949e',12959,1948,726,14,14,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":726,"totalStars":12952,"rank":14},{"at":"2026-11-02T00:58:59.560Z","todayStars":726,"totalStars":12959,"rank":14}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','patchy631/ai-engineering-hub','patchy631','ai-engineering-hub','patchy631/ai-engineering-hub','https://github.com/patchy631/ai-engineering-hub','In-depth tutorials on LLMs, RAGs and real-world AI agent applications.','Jupyter Notebook','#DA5B0B',40247,6483,1191,15,15,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":1191,"totalStars":40228,"rank":15},{"at":"2026-11-02T00:58:59.560Z","todayStars":1191,"totalStars":40247,"rank":15}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','flashml-org/freetoken','FlashML-org','FreeToken','FlashML-org/FreeToken','https://github.com/FlashML-org/FreeToken','FreeToken brings datacenter-scale model serving to your desktop. Run massive models locally, fast and efficiently.','Python','#3572A5',15406,1549,242,16,16,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":242,"totalStars":15400,"rank":16},{"at":"2026-11-02T00:58:59.560Z","todayStars":242,"totalStars":15406,"rank":16}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','daily','hyprwm/hyprland','hyprwm','Hyprland','hyprwm/Hyprland','https://github.com/hyprwm/Hyprland','Hyprland is an independent, highly customizable, dynamic tiling Wayland compositor that doesn''t sacrifice on its looks.','C++','#f34b7d',39372,2129,38,17,17,1,0,NULL,'2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z','[{"at":"2026-11-02T00:36:45.180Z","todayStars":38,"totalStars":39369,"rank":17},{"at":"2026-11-02T00:58:59.560Z","todayStars":38,"totalStars":39372,"rank":17}]','2026-11-02T00:36:45.180Z','2026-11-02T00:58:59.560Z'),
('2026-11-02','weekly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',44879,2384,11566,1,1,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":11566,"totalStars":44871,"rank":1},{"at":"2026-11-02T00:58:59.422Z","todayStars":11566,"totalStars":44879,"rank":1}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',99330,5875,12017,2,2,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":12017,"totalStars":99320,"rank":2},{"at":"2026-11-02T00:58:59.422Z","todayStars":12017,"totalStars":99330,"rank":2}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',25542,3357,5034,3,3,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5034,"totalStars":25537,"rank":3},{"at":"2026-11-02T00:58:59.422Z","todayStars":5034,"totalStars":25542,"rank":3}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',109290,9565,5852,4,4,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5852,"totalStars":109258,"rank":4},{"at":"2026-11-02T00:58:59.422Z","todayStars":5852,"totalStars":109290,"rank":4}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',56382,3675,10069,5,5,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":10069,"totalStars":56368,"rank":5},{"at":"2026-11-02T00:58:59.422Z","todayStars":10069,"totalStars":56382,"rank":5}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','obra/superpowers','obra','superpowers','obra/superpowers','https://github.com/obra/superpowers','An agentic skills framework & software development methodology that works.','Shell','#89e051',310637,27649,5896,6,6,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5896,"totalStars":310633,"rank":6},{"at":"2026-11-02T00:58:59.422Z","todayStars":5896,"totalStars":310637,"rank":6}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','jetbrains/thinkrail','JetBrains','thinkrail','JetBrains/thinkrail','https://github.com/JetBrains/thinkrail','Vibe code with pi in a lightweight, real IDE that customises itself around the way you work — The Vibe You Need','TypeScript','#3178c6',6971,391,5760,7,7,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5760,"totalStars":6968,"rank":7},{"at":"2026-11-02T00:58:59.422Z","todayStars":5760,"totalStars":6971,"rank":7}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',38011,8917,6926,8,8,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":6926,"totalStars":37978,"rank":8},{"at":"2026-11-02T00:58:59.422Z","todayStars":6926,"totalStars":38011,"rank":8}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','multica-ai/andrej-karpathy-skills','multica-ai','andrej-karpathy-skills','multica-ai/andrej-karpathy-skills','https://github.com/multica-ai/andrej-karpathy-skills','A single CLAUDE.md file to improve Claude Code behavior, derived from Andrej Karpathy''s observations on LLM coding pitfalls.','Unknown','#8b949e',227997,22742,4459,9,9,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":4459,"totalStars":227993,"rank":9},{"at":"2026-11-02T00:58:59.422Z","todayStars":4459,"totalStars":227997,"rank":9}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','jakubkrehel/skills','jakubkrehel','skills','jakubkrehel/skills','https://github.com/jakubkrehel/skills','A collection of agent skills that help you build great interfaces.','Markdown','#083fa1',10080,392,1607,10,10,0,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":1607,"totalStars":10077,"rank":10},{"at":"2026-11-02T00:58:59.422Z","todayStars":1607,"totalStars":10080,"rank":10}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','tauricresearch/tradingagents','TauricResearch','TradingAgents','TauricResearch/TradingAgents','https://github.com/TauricResearch/TradingAgents','TradingAgents: Multi-Agents LLM Financial Trading Framework','Python','#3572A5',119534,22868,5432,11,11,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5432,"totalStars":119529,"rank":11},{"at":"2026-11-02T00:58:59.422Z","todayStars":5432,"totalStars":119534,"rank":11}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',107789,7279,5336,12,12,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":5336,"totalStars":107780,"rank":12},{"at":"2026-11-02T00:58:59.422Z","todayStars":5336,"totalStars":107789,"rank":12}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','anthropics/skills','anthropics','skills','anthropics/skills','https://github.com/anthropics/skills','Public repository for Agent Skills','Python','#3572A5',186370,22021,2600,13,13,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":2600,"totalStars":186368,"rank":13},{"at":"2026-11-02T00:58:59.422Z","todayStars":2600,"totalStars":186370,"rank":13}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','affaan-m/ecc','affaan-m','ECC','affaan-m/ECC','https://github.com/affaan-m/ECC','The agent harness performance optimization system. Skills, instincts, memory, security, and research-first development for Claude Code, Codex, Opencode, Cursor and beyond.','JavaScript','#f1e05a',294808,43640,6299,14,14,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":6299,"totalStars":294803,"rank":14},{"at":"2026-11-02T00:58:59.422Z","todayStars":6299,"totalStars":294808,"rank":14}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','yujunzhixue/dsh-purge','YuJunZhiXue','dsh-purge','YuJunZhiXue/dsh-purge','https://github.com/YuJunZhiXue/dsh-purge','DeepSeek Harness 破甲：让所有模型都能破甲，不同模型可换不同提示词；默认提示词面向国模「小码酱」。Jailbreak for every model — swap prompts per model. 求 Star 收藏 ⭐ 如要二开，请查看署名要求部分','JavaScript','#f1e05a',15347,3530,6644,15,15,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":6644,"totalStars":15341,"rank":15},{"at":"2026-11-02T00:58:59.422Z","todayStars":6644,"totalStars":15347,"rank":15}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','weekly','ghostty-org/ghostty','ghostty-org','ghostty','ghostty-org/ghostty','https://github.com/ghostty-org/ghostty','👻 Ghostty is a fast, feature-rich, and cross-platform terminal emulator that uses platform-native UI and GPU acceleration.','Zig','#ec915c',63178,3817,589,16,16,1,0,NULL,'2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z','[{"at":"2026-11-02T00:36:45.398Z","todayStars":589,"totalStars":63177,"rank":16},{"at":"2026-11-02T00:58:59.422Z","todayStars":589,"totalStars":63178,"rank":16}]','2026-11-02T00:36:45.398Z','2026-11-02T00:58:59.422Z'),
('2026-11-02','monthly','cloudflare/security-audit-skill','cloudflare','security-audit-skill','cloudflare/security-audit-skill','https://github.com/cloudflare/security-audit-skill','A coding-agent skill for multi-phase security audits with independently verified, machine-readable findings','JavaScript','#f1e05a',56382,3675,32599,1,1,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":32599,"totalStars":56368,"rank":1},{"at":"2026-11-02T00:58:59.193Z","todayStars":32599,"totalStars":56382,"rank":1}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','heygen-com/hyperframes','heygen-com','hyperframes','heygen-com/hyperframes','https://github.com/heygen-com/hyperframes','Write HTML. Render video. Built for agents.','TypeScript','#3178c6',77116,7067,22225,2,2,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":22225,"totalStars":77112,"rank":2},{"at":"2026-11-02T00:58:59.193Z","todayStars":22225,"totalStars":77116,"rank":2}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','nutlope/hallmark','Nutlope','hallmark','Nutlope/hallmark','https://github.com/Nutlope/hallmark','Anti-AI-slop design skill for Claude Code, Cursor, and Codex.','CSS','#663399',44879,2384,15201,3,3,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":15201,"totalStars":44871,"rank":3},{"at":"2026-11-02T00:58:59.193Z","todayStars":15201,"totalStars":44879,"rank":3}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','debpalash/voicestudio','debpalash','VoiceStudio','debpalash/VoiceStudio','https://github.com/debpalash/VoiceStudio','VoiceStudio is the open-source, fully-local ElevenLabs alternative — voice cloning, voice design, video dubbing, dictation, transcription & audiobook creation in 646 languages.','Python','#3572A5',97920,10877,47055,4,4,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":47055,"totalStars":97907,"rank":4},{"at":"2026-11-02T00:58:59.193Z","todayStars":47055,"totalStars":97920,"rank":4}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','anthropics/knowledge-work-plugins','anthropics','knowledge-work-plugins','anthropics/knowledge-work-plugins','https://github.com/anthropics/knowledge-work-plugins','Open source repository of plugins primarily intended for knowledge workers to use in Claude Cowork','Python','#3572A5',34365,3799,8486,5,5,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":8486,"totalStars":34363,"rank":5},{"at":"2026-11-02T00:58:59.193Z","todayStars":8486,"totalStars":34365,"rank":5}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','pbakaus/impeccable','pbakaus','impeccable','pbakaus/impeccable','https://github.com/pbakaus/impeccable','The design vocabulary for your coding agent. Steer with polish and bolder, review with critique and audit, catch AI slop before it ships.','Rust','#dea584',99330,5875,26119,6,6,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":26119,"totalStars":99320,"rank":6},{"at":"2026-11-02T00:58:59.193Z","todayStars":26119,"totalStars":99330,"rank":6}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','earthtojake/text-to-cad','earthtojake','text-to-cad','earthtojake/text-to-cad','https://github.com/earthtojake/text-to-cad','Design physical products with AI','Python','#3572A5',24748,2363,8238,7,7,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":8238,"totalStars":24745,"rank":7},{"at":"2026-11-02T00:58:59.193Z","todayStars":8238,"totalStars":24748,"rank":7}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','thedotmack/claude-mem','thedotmack','claude-mem','thedotmack/claude-mem','https://github.com/thedotmack/claude-mem','Persistent Context Across Sessions for Every Agent – Captures everything your agent does during sessions, compresses it with AI, and injects relevant context back into future sessions. Works with Claude Code, OpenClaw, Codex, Gemini, Hermes, Copilot, OpenCode + More','TypeScript','#3178c6',109290,9565,14011,8,8,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":14011,"totalStars":109258,"rank":8},{"at":"2026-11-02T00:58:59.193Z","todayStars":14011,"totalStars":109290,"rank":8}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','nationalsecurityagency/ghidra','NationalSecurityAgency','ghidra','NationalSecurityAgency/ghidra','https://github.com/NationalSecurityAgency/ghidra','Ghidra is a software reverse engineering (SRE) framework','Java','#b07219',96776,10928,16858,9,9,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":16858,"totalStars":96774,"rank":9},{"at":"2026-11-02T00:58:59.193Z","todayStars":16858,"totalStars":96776,"rank":9}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','pingdotgg/t3code','pingdotgg','t3code','pingdotgg/t3code','https://github.com/pingdotgg/t3code','','TypeScript','#3178c6',38011,8917,12629,10,10,0,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":12629,"totalStars":37978,"rank":10},{"at":"2026-11-02T00:58:59.193Z","todayStars":12629,"totalStars":38011,"rank":10}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','anthropics/claude-plugins-official','anthropics','claude-plugins-official','anthropics/claude-plugins-official','https://github.com/anthropics/claude-plugins-official','Official, Anthropic-managed directory of high quality Claude Code Plugins.','Python','#3572A5',45722,4760,8625,11,11,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":8625,"totalStars":45719,"rank":11},{"at":"2026-11-02T00:58:59.193Z","todayStars":8625,"totalStars":45722,"rank":11}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','mksglu/context-mode','mksglu','context-mode','mksglu/context-mode','https://github.com/mksglu/context-mode','Context window optimization for AI coding agents. Sandboxes tool output (98% reduction), persists session memory, and enforces routing across 17 platforms via MCP + hooks.','TypeScript','#3178c6',33164,2285,8666,12,12,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":8666,"totalStars":33164,"rank":12},{"at":"2026-11-02T00:58:59.193Z","todayStars":8666,"totalStars":33164,"rank":12}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','leonxlnx/taste-skill','Leonxlnx','taste-skill','Leonxlnx/taste-skill','https://github.com/Leonxlnx/taste-skill','Agent skills that give coding agents taste: art direction, reference images and a browser check instead of generic AI pages','JavaScript','#f1e05a',107789,7279,16333,13,13,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":16333,"totalStars":107780,"rank":13},{"at":"2026-11-02T00:58:59.193Z","todayStars":16333,"totalStars":107789,"rank":13}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','flutter/flutter','flutter','flutter','flutter/flutter','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful apps for mobile and beyond','Dart','#00B4AB',180960,32860,2343,14,14,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":2343,"totalStars":180958,"rank":14},{"at":"2026-11-02T00:58:59.193Z","todayStars":2343,"totalStars":180960,"rank":14}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','cursor/plugins','cursor','plugins','cursor/plugins','https://github.com/cursor/plugins','Cursor plugin specification and official plugins','TypeScript','#3178c6',15017,1549,5809,15,15,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":5809,"totalStars":15016,"rank":15},{"at":"2026-11-02T00:58:59.193Z","todayStars":5809,"totalStars":15017,"rank":15}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','android/skills','android','skills','android/skills','https://github.com/android/skills','','Kotlin','#A97BFF',10228,666,2618,16,16,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":2618,"totalStars":10227,"rank":16},{"at":"2026-11-02T00:58:59.193Z","todayStars":2618,"totalStars":10228,"rank":16}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','agricidaniel/claude-seo','AgriciDaniel','claude-seo','AgriciDaniel/claude-seo','https://github.com/AgriciDaniel/claude-seo','Universal SEO skill for Claude Code. 26 sub-skills + 19 sub-agents covering technical SEO, E-E-A-T, schema, GEO/AEO, agent readiness (Lighthouse Agentic Browsing, WebMCP, llms.txt), backlinks, local SEO, e-commerce, international SEO, Google APIs, and PDF/Excel reporting. 9 optional extensions for live SEO data.','Python','#3572A5',25542,3357,7274,17,17,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":7274,"totalStars":25537,"rank":17},{"at":"2026-11-02T00:58:59.193Z","todayStars":7274,"totalStars":25542,"rank":17}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','vercel-labs/skills','vercel-labs','skills','vercel-labs/skills','https://github.com/vercel-labs/skills','The open agent skills tool - npx skills','TypeScript','#3178c6',37624,3250,4758,18,18,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":4758,"totalStars":37622,"rank":18},{"at":"2026-11-02T00:58:59.193Z","todayStars":4758,"totalStars":37624,"rank":18}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z'),
('2026-11-02','monthly','tashfeenahmed/freellmapi','tashfeenahmed','freellmapi','tashfeenahmed/freellmapi','https://github.com/tashfeenahmed/freellmapi','7.4 billion tokens per month. 34 free LLM providers. 635 free model endpoints. All behind one /v1 endpoint, plus any custom OpenAI-compatible endpoint. Smart routing, automatic failover, encrypted keys. Personal experimentation only.','TypeScript','#3178c6',45733,6245,15908,19,19,1,0,NULL,'2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z','[{"at":"2026-11-02T00:36:45.499Z","todayStars":15908,"totalStars":45723,"rank":19},{"at":"2026-11-02T00:58:59.193Z","todayStars":15908,"totalStars":45733,"rank":19}]','2026-11-02T00:36:45.499Z','2026-11-02T00:58:59.193Z');
insert or replace into crawl_runs (date, started_at, finished_at, duration_ms, source, fetched, upserted, modified, dropped, ok, error, triggered_by) values
('2026-10-28','2026-10-28T01:01:38.174Z','2026-10-28T01:01:40.894Z',2720,'github.com/trending?since=daily',0,0,0,0,0,'抓取 GitHub Trending 失败：pick is not defined','boot'),
('2026-10-28','2026-10-28T01:02:16.123Z','2026-10-28T01:02:19.721Z',3598,'github.com/trending?since=daily',11,11,0,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:02:21.340Z','2026-10-28T01:02:23.560Z',2220,'github.com/trending?since=daily',11,0,11,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T01:02:56.202Z','2026-10-28T01:02:58.949Z',2747,'github.com/trending?since=daily',11,0,12,1,1,NULL,'manual'),
('2026-10-28','2026-10-28T01:07:27.274Z','2026-10-28T01:07:30.400Z',3126,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:14:58.842Z','2026-10-28T01:15:02.295Z',3453,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:15:36.029Z','2026-10-28T01:15:37.571Z',1542,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:16:00.042Z','2026-10-28T01:16:01.490Z',1448,'github.com/trending?since=daily',11,0,11,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T01:16:02.103Z','2026-10-28T01:16:03.341Z',1238,'github.com/trending?since=daily',11,0,11,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T01:17:18.119Z','2026-10-28T01:17:20.842Z',2723,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:24:04.921Z','2026-10-28T01:24:07.790Z',2869,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:28:10.855Z','2026-10-28T01:28:14.143Z',3288,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:28:21.845Z','2026-10-28T01:28:23.328Z',1483,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:33:12.143Z','2026-10-28T01:33:14.760Z',2617,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:33:27.531Z','2026-10-28T01:33:28.962Z',1431,'github.com/trending?since=daily',11,0,11,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T01:35:33.443Z','2026-10-28T01:35:37.584Z',4141,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:40:42.325Z','2026-10-28T01:40:47.543Z',5218,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T01:55:57.732Z','2026-10-28T01:56:00.948Z',3216,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:01:45.291Z','2026-10-28T02:01:48.230Z',2939,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:12:17.815Z','2026-10-28T02:12:23.841Z',6026,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:25:49.713Z','2026-10-28T02:25:52.714Z',3001,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:31:58.535Z','2026-10-28T02:32:02.193Z',3658,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:39:42.409Z','2026-10-28T02:39:46.341Z',3932,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:46:33.329Z','2026-10-28T02:46:35.319Z',1990,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:52:05.068Z','2026-10-28T02:52:08.749Z',3681,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T02:59:38.771Z','2026-10-28T02:59:41.887Z',3116,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T03:05:29.573Z','2026-10-28T03:05:33.296Z',3723,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T03:16:07.095Z','2026-10-28T03:16:10.666Z',3571,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T03:26:55.242Z','2026-10-28T03:26:58.651Z',3409,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T03:43:46.145Z','2026-10-28T03:43:48.821Z',2676,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T04:00:31.423Z','2026-10-28T04:00:34.781Z',3358,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T04:50:47.004Z','2026-10-28T04:50:50.217Z',3213,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T04:56:49.992Z','2026-10-28T04:56:52.954Z',2962,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T05:00:23.716Z','2026-10-28T05:00:27.989Z',4273,'github.com/trending?since=daily',11,0,11,0,1,NULL,'schedule'),
('2026-10-28','2026-10-28T05:26:12.185Z','2026-10-28T05:26:14.150Z',1965,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T05:47:50.418Z','2026-10-28T05:47:53.132Z',2714,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T05:55:10.198Z','2026-10-28T05:55:13.295Z',3097,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T06:00:23.740Z','2026-10-28T06:00:25.822Z',2082,'github.com/trending?since=daily',11,0,11,0,1,NULL,'schedule'),
('2026-10-28','2026-10-28T06:36:13.832Z','2026-10-28T06:36:15.275Z',1443,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T06:52:59.336Z','2026-10-28T06:53:02.870Z',3534,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T07:00:23.729Z','2026-10-28T07:00:26.551Z',2822,'github.com/trending?since=daily',11,0,11,0,1,NULL,'schedule'),
('2026-10-28','2026-10-28T07:13:58.517Z','2026-10-28T07:14:01.902Z',3385,'github.com/trending?since=daily',11,0,11,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T07:18:04.995Z','2026-10-28T07:18:12.494Z',7499,'github.com/trending?since=daily|weekly|monthly',45,45,0,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T07:23:18.608Z','2026-10-28T07:23:27.092Z',8484,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T07:30:04.394Z','2026-10-28T07:30:13.012Z',8618,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T07:32:31.010Z','2026-10-28T07:32:38.942Z',7932,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T07:56:36.564Z','2026-10-28T07:56:44.958Z',8394,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T08:00:23.726Z','2026-10-28T08:00:26.530Z',2804,'github.com/trending?since=daily',11,0,40,32,1,NULL,'schedule'),
('2026-10-28','2026-10-28T08:15:24.765Z','2026-10-28T08:15:32.479Z',7714,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T08:43:39.761Z','2026-10-28T08:43:50.144Z',10383,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot');
insert or replace into crawl_runs (date, started_at, finished_at, duration_ms, source, fetched, upserted, modified, dropped, ok, error, triggered_by) values
('2026-10-28','2026-10-28T09:40:52.663Z','2026-10-28T09:41:02.226Z',9563,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T10:22:09.435Z','2026-10-28T10:22:17.202Z',7767,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'boot'),
('2026-10-28','2026-10-28T10:23:06.673Z','2026-10-28T10:23:14.873Z',8200,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'schedule'),
('2026-10-28','2026-10-28T10:30:19.084Z','2026-10-28T10:30:22.990Z',3906,'github.com/trending?since=daily|weekly|monthly',45,0,45,0,1,NULL,'manual'),
('2026-10-28','2026-10-28T11:54:09.387Z','2026-10-28T11:54:13.934Z',4547,'github.com/trending?since=daily|weekly|monthly',42,8,45,11,1,NULL,'schedule'),
('2026-10-29','2026-10-28T22:03:22.059Z','2026-10-28T22:03:25.097Z',3038,'github.com/trending?since=daily|weekly|monthly',44,44,0,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T01:34:36.448Z','2026-10-29T01:34:40.475Z',4027,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T03:45:17.044Z','2026-10-29T03:45:19.860Z',2816,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T04:47:09.380Z','2026-10-29T04:47:13.717Z',4337,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T06:23:50.665Z','2026-10-29T06:23:53.533Z',2868,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T07:33:59.512Z','2026-10-29T07:34:02.503Z',2991,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T09:24:51.963Z','2026-10-29T09:24:55.122Z',3159,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'schedule'),
('2026-10-29','2026-10-29T09:54:01.978Z','2026-10-29T09:54:06.554Z',4576,'github.com/trending?since=daily|weekly|monthly',44,0,44,0,1,NULL,'manual'),
('2026-10-30','2026-10-30T07:42:42.775Z','2026-10-30T07:42:45.838Z',3063,'github.com/trending?since=daily|weekly|monthly',41,41,0,0,1,NULL,'schedule'),
('2026-10-30','2026-10-30T07:43:11.927Z','2026-10-30T07:43:13.632Z',1705,'github.com/trending?since=daily|weekly|monthly',41,0,41,0,1,NULL,'manual'),
('2026-10-30','2026-10-30T07:43:19.721Z','2026-10-30T07:43:21.137Z',1416,'github.com/trending?since=daily|weekly|monthly',41,0,41,0,1,NULL,'manual'),
('2026-10-30','2026-10-30T07:48:22.921Z','2026-10-30T07:48:26.970Z',4049,'github.com/trending?since=daily|weekly|monthly',41,0,41,0,1,NULL,'manual'),
('2026-10-30','2026-10-30T08:50:43.012Z','2026-10-30T08:50:45.939Z',2927,'github.com/trending?since=daily|weekly|monthly',41,0,41,0,1,NULL,'schedule'),
('2026-10-30','2026-10-30T10:13:25.072Z','2026-10-30T10:13:28.394Z',3322,'github.com/trending?since=daily|weekly|monthly',41,0,41,0,1,NULL,'schedule'),
('2026-10-31','2026-10-30T23:17:26.805Z','2026-10-30T23:17:29.831Z',3026,'github.com/trending?since=daily|weekly|monthly',50,50,0,0,1,NULL,'schedule'),
('2026-11-01','2026-11-01T10:28:24.916Z','2026-11-01T10:28:27.811Z',2895,'github.com/trending?since=daily|weekly|monthly',48,48,0,0,1,NULL,'schedule'),
('2026-11-02','2026-11-02T00:36:43.168Z','2026-11-02T00:36:46.360Z',3192,'github.com/trending?since=daily|weekly|monthly',52,52,0,0,1,NULL,'schedule'),
('2026-11-02','2026-11-02T00:58:57.123Z','2026-11-02T00:59:00.333Z',3210,'github.com/trending?since=daily|weekly|monthly',52,0,52,0,1,NULL,'manual');
insert or replace into app_meta (key, value, updated_at) values ('app', '{}', '2026-11-02T01:50:51.472Z');
insert or replace into feed_snapshots (key, path, title, descr, category, render, ok, code, error, payload, raw_size, payload_bytes, fetched_at, upstream_updated_at, last_try_at) values
('weibo','/v2/weibo','微博热搜','实时热搜榜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"影视行业真的来春天了","desc":null,"value":"147.7万","link":"https://s.weibo.com/weibo?q=%E5%BD%B1%E8%A7%86%E8%A1%8C%E4%B8%9A%E7%9C%9F%E7%9A%84%E6%9D%A5%E6%98%A5%E5%A4%A9%E4%BA%86","cover":null,"badge":null},{"rank":2,"title":"微信转账加一个动作","desc":null,"value":"125.6万","link":"https://s.weibo.com/weibo?q=%E5%BE%AE%E4%BF%A1%E8%BD%AC%E8%B4%A6%E5%8A%A0%E4%B8%80%E4%B8%AA%E5%8A%A8%E4%BD%9C","cover":null,"badge":null},{"rank":3,"title":"今年乌镇峰会首次向社会开放预约","desc":null,"value":"113.7万","link":"https://s.weibo.com/weibo?q=%E4%BB%8A%E5%B9%B4%E4%B9%8C%E9%95%87%E5%B3%B0%E4%BC%9A%E9%A6%96%E6%AC%A1%E5%90%91%E7%A4%BE%E4%BC%9A%E5%BC%80%E6%94%BE%E9%A2%84%E7%BA%A6","cover":null,"badge":null},{"rank":4,"title":"电诈团伙已转移到非洲","desc":null,"value":"110.7万","link":"https://s.weibo.com/weibo?q=%E7%94%B5%E8%AF%88%E5%9B%A2%E4%BC%99%E5%B7%B2%E8%BD%AC%E7%A7%BB%E5%88%B0%E9%9D%9E%E6%B4%B2","cover":null,"badge":null},{"rank":5,"title":"金价大跌白银价格腰斩","desc":null,"value":"82.4万","link":"https://s.weibo.com/weibo?q=%E9%87%91%E4%BB%B7%E5%A4%A7%E8%B7%8C%E7%99%BD%E9%93%B6%E4%BB%B7%E6%A0%BC%E8%85%B0%E6%96%A9","cover":null,"badge":null},{"rank":6,"title":"美公务机坠毁致9死","desc":null,"value":"79.9万","link":"https://s.weibo.com/weibo?q=%E7%BE%8E%E5%85%AC%E5%8A%A1%E6%9C%BA%E5%9D%A0%E6%AF%81%E8%87%B49%E6%AD%BB","cover":null,"badge":null},{"rank":7,"title":"85花很刻意避免同台了","desc":null,"value":"78.2万","link":"https://s.weibo.com/weibo?q=85%E8%8A%B1%E5%BE%88%E5%88%BB%E6%84%8F%E9%81%BF%E5%85%8D%E5%90%8C%E5%8F%B0%E4%BA%86","cover":null,"badge":null},{"rank":8,"title":"罗技跟用户干上了","desc":null,"value":"58.9万","link":"https://s.weibo.com/weibo?q=%E7%BD%97%E6%8A%80%E8%B7%9F%E7%94%A8%E6%88%B7%E5%B9%B2%E4%B8%8A%E4%BA%86","cover":null,"badge":null},{"rank":9,"title":"台媒劝少看红果短剧反被喷","desc":null,"value":"56.6万","link":"https://s.weibo.com/weibo?q=%E5%8F%B0%E5%AA%92%E5%8A%9D%E5%B0%91%E7%9C%8B%E7%BA%A2%E6%9E%9C%E7%9F%AD%E5%89%A7%E5%8F%8D%E8%A2%AB%E5%96%B7","cover":null,"badge":null},{"rank":10,"title":"画地为牢","desc":null,"value":"29.6万","link":"https://s.weibo.com/weibo?q=%E7%94%BB%E5%9C%B0%E4%B8%BA%E7%89%A2","cover":null,"badge":null},{"rank":11,"title":"中国女生借卫生巾震撼外国网友","desc":null,"value":"29.5万","link":"https://s.weibo.com/weibo?q=%E4%B8%AD%E5%9B%BD%E5%A5%B3%E7%94%9F%E5%80%9F%E5%8D%AB%E7%94%9F%E5%B7%BE%E9%9C%87%E6%92%BC%E5%A4%96%E5%9B%BD%E7%BD%91%E5%8F%8B","cover":null,"badge":null},{"rank":12,"title":"吴磊婉拒蔡徐坤","desc":null,"value":"29.5万","link":"https://s.weibo.com/weibo?q=%E5%90%B4%E7%A3%8A%E5%A9%89%E6%8B%92%E8%94%A1%E5%BE%90%E5%9D%A4","cover":null,"badge":null},{"rank":13,"title":"迪丽热巴这套造型至今无人超越","desc":null,"value":"29.3万","link":"https://s.weibo.com/weibo?q=%E8%BF%AA%E4%B8%BD%E7%83%AD%E5%B7%B4%E8%BF%99%E5%A5%97%E9%80%A0%E5%9E%8B%E8%87%B3%E4%BB%8A%E6%97%A0%E4%BA%BA%E8%B6%85%E8%B6%8A","cover":null,"badge":null},{"rank":14,"title":"马天宇张萌 和好","desc":null,"value":"29.1万","link":"https://s.weibo.com/weibo?q=%E9%A9%AC%E5%A4%A9%E5%AE%87%E5%BC%A0%E8%90%8C%20%E5%92%8C%E5%A5%BD","cover":null,"badge":null},{"rank":15,"title":"孙颖莎夺冠后比1庆祝","desc":null,"value":"29万","link":"https://s.weibo.com/weibo?q=%E5%AD%99%E9%A2%96%E8%8E%8E%E5%A4%BA%E5%86%A0%E5%90%8E%E6%AF%941%E5%BA%86%E7%A5%9D","cover":null,"badge":null},{"rank":16,"title":"胡歌自曝身边好友陆续因心梗离世","desc":null,"value":"28.9万","link":"https://s.weibo.com/weibo?q=%E8%83%A1%E6%AD%8C%E8%87%AA%E6%9B%9D%E8%BA%AB%E8%BE%B9%E5%A5%BD%E5%8F%8B%E9%99%86%E7%BB%AD%E5%9B%A0%E5%BF%83%E6%A2%97%E7%A6%BB%E4%B8%96","cover":null,"badge":null},{"rank":17,"title":"孙颖莎退赛法兰克福站","desc":null,"value":"28.7万","link":"https://s.weibo.com/weibo?q=%E5%AD%99%E9%A2%96%E8%8E%8E%E9%80%80%E8%B5%9B%E6%B3%95%E5%85%B0%E5%85%8B%E7%A6%8F%E7%AB%99","cover":null,"badge":null},{"rank":18,"title":"林一看到穿婚纱的刘亦菲了","desc":null,"value":"28.5万","link":"https://s.weibo.com/weibo?q=%E6%9E%97%E4%B8%80%E7%9C%8B%E5%88%B0%E7%A9%BF%E5%A9%9A%E7%BA%B1%E7%9A%84%E5%88%98%E4%BA%A6%E8%8F%B2%E4%BA%86","cover":null,"badge":null},{"rank":19,"title":"原来冬天不是穿的越多越暖和","desc":null,"value":"28.5万","link":"https://s.weibo.com/weibo?q=%E5%8E%9F%E6%9D%A5%E5%86%AC%E5%A4%A9%E4%B8%8D%E6%98%AF%E7%A9%BF%E7%9A%84%E8%B6%8A%E5%A4%9A%E8%B6%8A%E6%9A%96%E5%92%8C","cover":null,"badge":null},{"rank":20,"title":"换不来收入的努力大多只是逃避","desc":null,"value":"28.4万","link":"https://s.weibo.com/weibo?q=%E6%8D%A2%E4%B8%8D%E6%9D%A5%E6%94%B6%E5%85%A5%E7%9A%84%E5%8A%AA%E5%8A%9B%E5%A4%A7%E5%A4%9A%E5%8F%AA%E6%98%AF%E9%80%83%E9%81%BF","cover":null,"badge":null},{"rank":21,"title":"孙颖莎采访时差点把自己绕进去","desc":null,"value":"28.1万","link":"https://s.weibo.com/weibo?q=%E5%AD%99%E9%A2%96%E8%8E%8E%E9%87%87%E8%AE%BF%E6%97%B6%E5%B7%AE%E7%82%B9%E6%8A%8A%E8%87%AA%E5%B7%B1%E7%BB%95%E8%BF%9B%E5%8E%BB","cover":null,"badge":null},{"rank":22,"title":"刘亦菲刘些宁撞婚纱造型","desc":null,"value":"27.9万","link":"https://s.weibo.com/weibo?q=%E5%88%98%E4%BA%A6%E8%8F%B2%E5%88%98%E4%BA%9B%E5%AE%81%E6%92%9E%E5%A9%9A%E7%BA%B1%E9%80%A0%E5%9E%8B","cover":null,"badge":null},{"rank":23,"title":"我画地为牢啊沈月","desc":null,"value":"27.7万","link":"https://s.weibo.com/weibo?q=%E6%88%91%E7%94%BB%E5%9C%B0%E4%B8%BA%E7%89%A2%E5%95%8A%E6%B2%88%E6%9C%88","cover":null,"badge":null},{"rank":24,"title":"迪丽热巴的造型没有瓶颈期吗","desc":null,"value":"27.5万","link":"https://s.weibo.com/weibo?q=%E8%BF%AA%E4%B8%BD%E7%83%AD%E5%B7%B4%E7%9A%84%E9%80%A0%E5%9E%8B%E6%B2%A1%E6%9C%89%E7%93%B6%E9%A2%88%E6%9C%9F%E5%90%97","cover":null,"badge":null},{"rank":25,"title":"喜欢吃烤红薯的人天塌了","desc":null,"value":"26.7万","link":"https://s.weibo.com/weibo?q=%E5%96%9C%E6%AC%A2%E5%90%83%E7%83%A4%E7%BA%A2%E8%96%AF%E7%9A%84%E4%BA%BA%E5%A4%A9%E5%A1%8C%E4%BA%86","cover":null,"badge":null},{"rank":26,"title":"蔡徐坤一把搂住吴磊","desc":null,"value":"26.1万","link":"https://s.weibo.com/weibo?q=%E8%94%A1%E5%BE%90%E5%9D%A4%E4%B8%80%E6%8A%8A%E6%90%82%E4%BD%8F%E5%90%B4%E7%A3%8A","cover":null,"badge":null},{"rank":27,"title":"孙颖莎张禹珍冠军合影","desc":null,"value":"20.8万","link":"https://s.weibo.com/weibo?q=%E5%AD%99%E9%A2%96%E8%8E%8E%E5%BC%A0%E7%A6%B9%E7%8F%8D%E5%86%A0%E5%86%9B%E5%90%88%E5%BD%B1","cover":null,"badge":null},{"rank":28,"title":"湖南台长派许飞劝厉娜","desc":null,"value":"20.7万","link":"https://s.weibo.com/weibo?q=%E6%B9%96%E5%8D%97%E5%8F%B0%E9%95%BF%E6%B4%BE%E8%AE%B8%E9%A3%9E%E5%8A%9D%E5%8E%89%E5%A8%9C","cover":null,"badge":null},{"rank":29,"title":"刘冲可以放心睡觉了","desc":null,"value":"20.7万","link":"https://s.weibo.com/weibo?q=%E5%88%98%E5%86%B2%E5%8F%AF%E4%BB%A5%E6%94%BE%E5%BF%83%E7%9D%A1%E8%A7%89%E4%BA%86","cover":null,"badge":null},{"rank":30,"title":"财务误发5000元工资给离职员工遭拒还","desc":null,"value":"20.7万","link":"https://s.weibo.com/weibo?q=%E8%B4%A2%E5%8A%A1%E8%AF%AF%E5%8F%915000%E5%85%83%E5%B7%A5%E8%B5%84%E7%BB%99%E7%A6%BB%E8%81%8C%E5%91%98%E5%B7%A5%E9%81%AD%E6%8B%92%E8%BF%98","cover":null,"badge":null},{"rank":31,"title":"想阴阳中国结果AI说是美国","desc":null,"value":"20.6万","link":"https://s.weibo.com/weibo?q=%E6%83%B3%E9%98%B4%E9%98%B3%E4%B8%AD%E5%9B%BD%E7%BB%93%E6%9E%9CAI%E8%AF%B4%E6%98%AF%E7%BE%8E%E5%9B%BD","cover":null,"badge":null},{"rank":32,"title":"苦难果然是文学的温床","desc":null,"value":"20.6万","link":"https://s.weibo.com/weibo?q=%E8%8B%A6%E9%9A%BE%E6%9E%9C%E7%84%B6%E6%98%AF%E6%96%87%E5%AD%A6%E7%9A%84%E6%B8%A9%E5%BA%8A","cover":null,"badge":null},{"rank":33,"title":"杨幂也在看后会友期","desc":null,"value":"20.4万","link":"https://s.weibo.com/weibo?q=%E6%9D%A8%E5%B9%82%E4%B9%9F%E5%9C%A8%E7%9C%8B%E5%90%8E%E4%BC%9A%E5%8F%8B%E6%9C%9F","cover":null,"badge":null},{"rank":34,"title":"你的手机可能在监听你","desc":null,"value":"19.7万","link":"https://s.weibo.com/weibo?q=%E4%BD%A0%E7%9A%84%E6%89%8B%E6%9C%BA%E5%8F%AF%E8%83%BD%E5%9C%A8%E7%9B%91%E5%90%AC%E4%BD%A0","cover":null,"badge":null},{"rank":35,"title":"侯卓成 杨汝晴","desc":null,"value":"19.5万","link":"https://s.weibo.com/weibo?q=%E4%BE%AF%E5%8D%93%E6%88%90%20%E6%9D%A8%E6%B1%9D%E6%99%B4","cover":null,"badge":null},{"rank":36,"title":"张真源这件衣服印花都被穿没了","desc":null,"value":"17.9万","link":"https://s.weibo.com/weibo?q=%E5%BC%A0%E7%9C%9F%E6%BA%90%E8%BF%99%E4%BB%B6%E8%A1%A3%E6%9C%8D%E5%8D%B0%E8%8A%B1%E9%83%BD%E8%A2%AB%E7%A9%BF%E6%B2%A1%E4%BA%86","cover":null,"badge":null},{"rank":37,"title":"后会友期最后一期","desc":null,"value":"17.6万","link":"https://s.weibo.com/weibo?q=%E5%90%8E%E4%BC%9A%E5%8F%8B%E6%9C%9F%E6%9C%80%E5%90%8E%E4%B8%80%E6%9C%9F","cover":null,"badge":null},{"rank":38,"title":"安东内利加冕F1世界冠军","desc":null,"value":"17.4万","link":"https://s.weibo.com/weibo?q=%E5%AE%89%E4%B8%9C%E5%86%85%E5%88%A9%E5%8A%A0%E5%86%95F1%E4%B8%96%E7%95%8C%E5%86%A0%E5%86%9B","cover":null,"badge":null},{"rank":39,"title":"晕碳两个字震惊日本人","desc":null,"value":"16万","link":"https://s.weibo.com/weibo?q=%E6%99%95%E7%A2%B3%E4%B8%A4%E4%B8%AA%E5%AD%97%E9%9C%87%E6%83%8A%E6%97%A5%E6%9C%AC%E4%BA%BA","cover":null,"badge":null},{"rank":40,"title":"A股将迎来3大中长期利好","desc":null,"value":"15.9万","link":"https://s.weibo.com/weibo?q=A%E8%82%A1%E5%B0%86%E8%BF%8E%E6%9D%A53%E5%A4%A7%E4%B8%AD%E9%95%BF%E6%9C%9F%E5%88%A9%E5%A5%BD","cover":null,"badge":null},{"rank":41,"title":"W盛典合影","desc":null,"value":"15.7万","link":"https://s.weibo.com/weibo?q=W%E7%9B%9B%E5%85%B8%E5%90%88%E5%BD%B1","cover":null,"badge":null},{"rank":42,"title":"嫁金钗25集只有46分钟","desc":null,"value":"15.1万","link":"https://s.weibo.com/weibo?q=%E5%AB%81%E9%87%91%E9%92%9725%E9%9B%86%E5%8F%AA%E6%9C%8946%E5%88%86%E9%92%9F","cover":null,"badge":null},{"rank":43,"title":"柬埔寨电诈团伙非洲重操旧业","desc":null,"value":"15万","link":"https://s.weibo.com/weibo?q=%E6%9F%AC%E5%9F%94%E5%AF%A8%E7%94%B5%E8%AF%88%E5%9B%A2%E4%BC%99%E9%9D%9E%E6%B4%B2%E9%87%8D%E6%93%8D%E6%97%A7%E4%B8%9A","cover":null,"badge":null},{"rank":44,"title":"张禹珍蒙彼利埃站冠军","desc":null,"value":"15万","link":"https://s.weibo.com/weibo?q=%E5%BC%A0%E7%A6%B9%E7%8F%8D%E8%92%99%E5%BD%BC%E5%88%A9%E5%9F%83%E7%AB%99%E5%86%A0%E5%86%9B","cover":null,"badge":null},{"rank":45,"title":"质疑假院士水货后对方找上门","desc":null,"value":"14万","link":"https://s.weibo.com/weibo?q=%E8%B4%A8%E7%96%91%E5%81%87%E9%99%A2%E5%A3%AB%E6%B0%B4%E8%B4%A7%E5%90%8E%E5%AF%B9%E6%96%B9%E6%89%BE%E4%B8%8A%E9%97%A8","cover":null,"badge":null},{"rank":46,"title":"中国女子因赖床错过西班牙事故高铁","desc":null,"value":"13.8万","link":"https://s.weibo.com/weibo?q=%E4%B8%AD%E5%9B%BD%E5%A5%B3%E5%AD%90%E5%9B%A0%E8%B5%96%E5%BA%8A%E9%94%99%E8%BF%87%E8%A5%BF%E7%8F%AD%E7%89%99%E4%BA%8B%E6%95%85%E9%AB%98%E9%93%81","cover":null,"badge":null},{"rank":47,"title":"飞雪","desc":null,"value":"13.5万","link":"https://s.weibo.com/weibo?q=%E9%A3%9E%E9%9B%AA","cover":null,"badge":null},{"rank":48,"title":"F1","desc":null,"value":"13万","link":"https://s.weibo.com/weibo?q=F1","cover":null,"badge":null},{"rank":49,"title":"孙颖沙再谈伤病状态","desc":null,"value":"12万","link":"https://s.weibo.com/weibo?q=%E5%AD%99%E9%A2%96%E6%B2%99%E5%86%8D%E8%B0%88%E4%BC%A4%E7%97%85%E7%8A%B6%E6%80%81","cover":null,"badge":null},{"rank":50,"title":"谭松韵感觉没有之前有活力了","desc":null,"value":"11.9万","link":"https://s.weibo.com/weibo?q=%E8%B0%AD%E6%9D%BE%E9%9F%B5%E6%84%9F%E8%A7%89%E6%B2%A1%E6%9C%89%E4%B9%8B%E5%89%8D%E6%9C%89%E6%B4%BB%E5%8A%9B%E4%BA%86","cover":null,"badge":null}],"total":50}',8704,8977,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('zhihu','/v2/zhihu','知乎热榜','全站热门问题','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"如何看待鸿蒙智行五界2026年10月销量合计33537辆？五界是否能生存下去？","desc":"[图片]","value":"459 万热度","link":"https://www.zhihu.com/question/2100246281591510431","cover":null,"badge":null},{"rank":2,"title":"《影之刃零》能复刻《黑神话：悟空》的千万级销量神话吗？","desc":"武侠题材比西游题材传播更大，而且出海的话老外可能看不懂武侠的人情世故和招式美学。","value":"216 万热度","link":"https://www.zhihu.com/question/2098861445219985178","cover":null,"badge":null},{"rank":3,"title":"江苏多地物业引入巡逻机器人「一台抵 5 个保安」，这会成为未来趋势吗？","desc":"据台州晚报消息，近日，江苏多地物业引进巡逻机器人保安。该机器人可 24 小时不间断执勤，工作量相当于 5 名真人保安，无需休息、不用发放工资、缴纳社保，每月仅耗…","value":"207 万热度","link":"https://www.zhihu.com/question/2099653516453328673","cover":null,"badge":null},{"rank":4,"title":"为何AI短剧好像放弃了清宫戏，而更倾向于唐/宋/架空朝代？跟观众偏好、技术、选题、价值观有啥关系吗？","desc":"最近看AI短剧，发现一个大问题，和演艺圈的价值观差异非常大 最明显的就是清宫戏，AI短剧似乎没有，没看到过。演艺圈，就有大量的清宫戏，可能是历史上一直这么拍下来…","value":"193 万热度","link":"https://www.zhihu.com/question/2100281204884731770","cover":null,"badge":null},{"rank":5,"title":"庆功宴上，领导表扬你一句后夹起一块鱼给你，说“鱼是好鱼，就是刺多”，你该如何高情商地回答？","desc":null,"value":"179 万热度","link":"https://www.zhihu.com/question/2099783520373756743","cover":null,"badge":null},{"rank":6,"title":"如何评价比亚迪 10 月新能源汽车销量 49.02 万辆，海外销量翻倍？横向对比这一销量属于什么水平？","desc":"比亚迪披露10月产销业绩，10月新能源汽车销量49.02万辆；前10个月累计销量362.17万辆，同比下降2.16%。其中，纯电动汽车10月销量30.57万辆，…","value":"158 万热度","link":"https://www.zhihu.com/question/2100317442232644379","cover":null,"badge":null},{"rank":7,"title":"巴菲特天天吃麦当劳还喝那么多可乐为何还那么长寿？","desc":"股神巴菲特的饮食和生活习惯真的如同媒体上所说的那样吗？还是媒体为了迎合读者和营销需求进行的宣传？","value":"137 万热度","link":"https://www.zhihu.com/question/279093295","cover":null,"badge":null},{"rank":8,"title":"鲁迅在《孔乙己》中写清末的普通打工人傍午就下班，下班后喝黄酒，吃盐煮笋、茴香豆是否符合历史？","desc":null,"value":"116 万热度","link":"https://www.zhihu.com/question/2100159022481532058","cover":null,"badge":null},{"rank":9,"title":"张雪提出飞行超 5 小时全员必须头等舱，说老板单独坐头等舱很 low，现实里其他公司能照搬吗？","desc":"11月1日，张雪机车创始人张雪带领一行9人团队从国内出发，前往意大利米兰参加即将开幕的第83届米兰国际两轮车展（EICMA）。 张雪在出发前介绍了公司的差旅原则…","value":"115 万热度","link":"https://www.zhihu.com/question/2100303604582191689","cover":null,"badge":null},{"rank":10,"title":"法定节假日增至 13 天并优化调休，将对公众生活与休假体验带来哪些改变？","desc":"根据修订后的《全国年节及纪念日放假办法》，从2025年1月1日起，全体公民放假的假日增加2天，其中春节、劳动节各增加1天。 也就是说，截至目前，法定放假总数已增…","value":"115 万热度","link":"https://www.zhihu.com/question/2099697728552952157","cover":null,"badge":null},{"rank":11,"title":"如何评价懂车帝MPV爬坡测试视频？","desc":"原新闻链接：https://m.163.com/dy/article/LAGKDGT70556NGFK.html 之前传闻因为懂车帝有问题所以被调查，删视频毁灭…","value":"114 万热度","link":"https://www.zhihu.com/question/2099981621046859004","cover":null,"badge":null},{"rank":12,"title":"如何评价山东东营80后男子用枯枝搭建巨型齐天大圣走红？为什么这件私人创作能引发这么大共鸣？","desc":"山东东营垦利区，淄博路与阜盛路交汇处附近，最近多了个显眼的大家伙。一尊用枯树枝搭成的巨型齐天大圣立在路边，眉眼低垂，披着蛛网状交织的枝桠，远远看去像是从荒野里长…","value":"114 万热度","link":"https://www.zhihu.com/question/2098799350503699522","cover":null,"badge":null},{"rank":13,"title":"孩子主动和我说，不想拿第一名，只想做中等舒服的人，我该怎么办？","desc":"孩子成绩稳定在班级中游，学习不算费力，也不摆烂。我和他聊未来目标，他很平静地告诉我，不想冲前面，不想承受考前紧张、被所有人盯着的压力，保持中间位置，有时间玩自己…","value":"111 万热度","link":"https://www.zhihu.com/question/2098060428395991630","cover":null,"badge":null},{"rank":14,"title":"几百年后的人看现在，会不会觉得内燃机是人类在汽车制造上的一条弯路?","desc":null,"value":"106 万热度","link":"https://www.zhihu.com/question/14858801086","cover":null,"badge":null},{"rank":15,"title":"芒果台今年已推出《我家那闺女》《后会友期》《中餐厅》《乘风》等大爆综艺，为啥芒果做综艺这么有「灵性」？","desc":"总觉得芒果台总能精准挖掘出一些十八线小明星，然后抓住最drama的点然后让他们快速翻红 还有网友还误以为《offer8》也是芒果台的，甚至《花少2》也是今年大规…","value":"100 万热度","link":"https://www.zhihu.com/question/2099892792797259253","cover":null,"badge":null},{"rank":16,"title":"懂球帝就姆巴佩一事再发补充声明，称在官方恢复皇马转播与报道前将不再主动推送相关内容，哪些信息值得关注？","desc":"近日，姆巴佩针对中国发表不当言论，懂球帝在发现相关情况后，第一时间针对其不当言论发布声明，提醒广大球迷遵守网络秩序，不要随意发表越界言论，并持续关注事件后续进展…","value":"99 万热度","link":"https://www.zhihu.com/question/2100245408010036134","cover":null,"badge":null},{"rank":17,"title":"热播剧《小城良方》中男主用甲硝唑磨粉吸进鼻子治鼻炎被质疑，甲硝唑粉真的能治鼻炎吗？可能会有哪些风险？","desc":"热播剧《小城良方》中，一处搞笑桥段令人印象深刻。刘铮亮（角色名）回到东北基层医院上班，撞见科室主任不走寻常路，照着会计给的偏方，把甲硝唑磨粉吸进鼻子治鼻炎，顿时…","value":"98 万热度","link":"https://www.zhihu.com/question/2099543121717454405","cover":null,"badge":null},{"rank":18,"title":"自媒体博主称苹果Duo中国版偷工减料，取消了卫星通信、UWB等组件，是真的吗？使用体验会受到影响吗？","desc":"[2 张图片]","value":"97 万热度","link":"https://www.zhihu.com/question/2100124169555764715","cover":null,"badge":null},{"rank":19,"title":"我国宣布派遣三名航天员登月，那么他们登上月球后应该说一句什么话才能在历史书上压倒阿姆斯特朗那句话呢？","desc":"如题，阿姆斯特朗说过“这是我个人的一小步，却是全人类的一大步”感觉这句话特别经典又特别震撼，中国航天员应该说什么能压倒这句话呢","value":"97 万热度","link":"https://www.zhihu.com/question/2100177964231149403","cover":null,"badge":null},{"rank":20,"title":"法国爆发第三轮抗议活动，抗议人数从55万降至32万，是意味着这轮社会抗议正在降温吗？抗议还会持续多久？","desc":"当地时间10月31日，法国爆发近三周以来第三轮全国性大规模抗议示威活动。据法国内政部统计，有数十万人参与了当天的抗议示威活动。法国内政部长努内兹表示，法国警方在…","value":"96 万热度","link":"https://www.zhihu.com/question/2100178342901019827","cover":null,"badge":null},{"rank":21,"title":"南京一男子在星巴克不消费占座，被店员提醒后反报警，经调解后离开门店，怎样看待这一行为？","desc":"星巴克全国门店推行「消费入座」规则后，近日有网友称，在江苏南京同曦万尚城的星巴克，看到一名男子不消费占座。男子被店员提醒点单时认为店员态度差，先当场投诉，投诉无…","value":"84 万热度","link":"https://www.zhihu.com/question/2099542758293877225","cover":null,"badge":null},{"rank":22,"title":"外媒称《影之刃零》后期难度太低甚至初见杀最终 Boss，如何评价该难度设计？","desc":"外媒FEXTRALIFE发布了《影之刃零》评测，评测者完成了游戏后表示，本作是他多年来见过最有野心的作品之一，地图巨大、Boss战众多、故事篇幅很长，但游戏在难…","value":"83 万热度","link":"https://www.zhihu.com/question/2098056295370711750","cover":null,"badge":null},{"rank":23,"title":"2627 赛季英超联赛英超第 9 轮利物浦 0:1 阿森纳，如何评价这场比赛？","desc":null,"value":"82 万热度","link":"https://www.zhihu.com/question/2100384760090645343","cover":null,"badge":null},{"rank":24,"title":"“冷门神作”真的存在吗？","desc":"最近看了一些被称为“冷门神作”的作品，评分普遍不高，而且根本不吸引人，难道不是“活该冷门”？","value":"81 万热度","link":"https://www.zhihu.com/question/473936711","cover":null,"badge":null},{"rank":25,"title":"如何看待钓友钓58斤青鱼被拖入3米水中，仍紧握鱼竿被连人带鱼救起？你钓鱼时印象最深刻的经历是怎样的？","desc":"近日，湖北襄阳，一名钓友在钓获约58斤大青鱼时，被大鱼发力拽入水深约3米的池塘。所幸该钓友会游泳，岸边其他钓友及时将其救起。钓友落水后仍紧紧握着鱼竿，众人配合约…","value":"81 万热度","link":"https://www.zhihu.com/question/2099138301290443082","cover":null,"badge":null},{"rank":26,"title":"怎么看 Anthropic IPO 前夕被黑石评为“垃圾级”？","desc":"投资级评级能让Anthropic以更低利率借钱，为这些项目融资。而很多保险公司、养老基金按规定只能投资级为主，或者限制持有垃圾级债务的规模。主体一旦掉到BB+及…","value":"79 万热度","link":"https://www.zhihu.com/question/2100203992827557509","cover":null,"badge":null},{"rank":27,"title":"三连冠选手 Gumayusi 生涯首次无缘 S 赛八强，如何评价他本届赛事的表现？","desc":"2026全球总决赛瑞士轮2-2组，HLE以0-2的比分不敌BLG，无缘八强。这也是Gumayusi职业生涯第一次无缘八强，其职业生涯六次世界赛成绩为：2021全…","value":"77 万热度","link":"https://www.zhihu.com/question/2100140951066894432","cover":null,"badge":null},{"rank":28,"title":"41 岁 C 罗距职业生涯千球仅差 15 球，这一纪录对世界足坛意味着什么？","desc":"沙特联第12轮，利雅得胜利主场5-3击败拉斯永恒，41岁的C罗下半场上演帽子戏法。沙特联官方社媒确认，他的职业生涯总进球数已达到985球，距离千球里程碑仅差15…","value":"76 万热度","link":"https://www.zhihu.com/question/2099769633012199862","cover":null,"badge":null},{"rank":29,"title":"怎么看百度搜索降价至千次4.9元，这是针对 DeepSeek 搜索的千次 5 元吗？","desc":"百度搜索AI API业务负责人张家铭介绍，新版本采用四层架构，覆盖内容、架构、引擎和应用层，提供检索、内容获取及面向Agent的相关能力。 现场公布的数据显示，…","value":"73 万热度","link":"https://www.zhihu.com/question/2099967799934313950","cover":null,"badge":null},{"rank":30,"title":"DeepSeek4.1Pro迟迟不发布的原因有哪些？","desc":null,"value":"72 万热度","link":"https://www.zhihu.com/question/2099909586245399443","cover":null,"badge":null}],"total":30}',16103,6200,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('douyin','/v2/douyin','抖音热搜','抖音热榜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"请大家选出最适合我的发型","desc":null,"value":"1211.7万","link":"https://www.douyin.com/search/%E8%AF%B7%E5%A4%A7%E5%AE%B6%E9%80%89%E5%87%BA%E6%9C%80%E9%80%82%E5%90%88%E6%88%91%E7%9A%84%E5%8F%91%E5%9E%8B","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-i-0813c001/oAmrSIgseEAasAAqA3AHIsEmfEADuCACjDi95F~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=IbpRSdIhJrWif%2FdTf08ztoZlMFQ%3D&from=3218412987","badge":null},{"rank":2,"title":"即梦首个剧本模型上线","desc":null,"value":"1211.4万","link":"https://www.douyin.com/search/%E5%8D%B3%E6%A2%A6%E9%A6%96%E4%B8%AA%E5%89%A7%E6%9C%AC%E6%A8%A1%E5%9E%8B%E4%B8%8A%E7%BA%BF","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015c000-ce/oc2dE8fDnEeu9IqAvIDAX5ChmBYAwEwrFBPaIw~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=2nk8v48TjsPLwS1xrQ4A5EvQBQc%3D&from=3218412987","badge":null},{"rank":3,"title":"广交会中国造智能搭子又上新","desc":null,"value":"1137万","link":"https://www.douyin.com/search/%E5%B9%BF%E4%BA%A4%E4%BC%9A%E4%B8%AD%E5%9B%BD%E9%80%A0%E6%99%BA%E8%83%BD%E6%90%AD%E5%AD%90%E5%8F%88%E4%B8%8A%E6%96%B0","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/oIedAYNE9NrfWt3q1gHu7QP5QAXq94DwZ99AFB~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=1srKnjZdrgOLPFA6SFKTPfGN6Vg%3D&from=3218412987","badge":null},{"rank":4,"title":"孙颖莎夺WTT蒙彼利埃站冠军","desc":null,"value":"1113.6万","link":"https://www.douyin.com/search/%E5%AD%99%E9%A2%96%E8%8E%8E%E5%A4%BAWTT%E8%92%99%E5%BD%BC%E5%88%A9%E5%9F%83%E7%AB%99%E5%86%A0%E5%86%9B","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/oMKq5IDCQABEfPiVfAAgQUvFX9n9wIwLwog9N0~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=nfq9aBcRNsIA5u%2B9eR6O1iCnTcc%3D&from=3218412987","badge":null},{"rank":5,"title":"阿森纳1:0利物浦","desc":null,"value":"1054.4万","link":"https://www.douyin.com/search/%E9%98%BF%E6%A3%AE%E7%BA%B31%3A0%E5%88%A9%E7%89%A9%E6%B5%A6","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/oYGBzrLzDQGEByCAdIOAepI4VnQZ7GfBEf65yC~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=d5HYwjAGcXvzz1dYt6sx11Vic1g%3D&from=3218412987","badge":null},{"rank":6,"title":"央行证监会将召开座谈会","desc":null,"value":"1052.5万","link":"https://www.douyin.com/search/%E5%A4%AE%E8%A1%8C%E8%AF%81%E7%9B%91%E4%BC%9A%E5%B0%86%E5%8F%AC%E5%BC%80%E5%BA%A7%E8%B0%88%E4%BC%9A","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/oIk2ymIOnbahfbIfDbn382AgGeARLCFNRETrfg~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=T7OSRjgwy7nYTOJMEnJk1nlAx7A%3D&from=3218412987","badge":null},{"rank":7,"title":"WTT法兰克福冠军赛抽签仪式","desc":null,"value":"941.4万","link":"https://www.douyin.com/search/WTT%E6%B3%95%E5%85%B0%E5%85%8B%E7%A6%8F%E5%86%A0%E5%86%9B%E8%B5%9B%E6%8A%BD%E7%AD%BE%E4%BB%AA%E5%BC%8F","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015c000-ce/ogBfPVtBeC4Wug7OaUAAfXQJjiMMBzZwd8RPQ8~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=J%2Fwy8t%2BmxpT0uCWy%2F9TlUe4ZYV0%3D&from=3218412987","badge":null},{"rank":8,"title":"歼20首次亮相十周年","desc":null,"value":"940.4万","link":"https://www.douyin.com/search/%E6%AD%BC20%E9%A6%96%E6%AC%A1%E4%BA%AE%E7%9B%B8%E5%8D%81%E5%91%A8%E5%B9%B4","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/oQwiQZHFqdAIuB1liCktsamRPQIInCPPGAaqo~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=nKLqIPzSjBjllpXWgBGcpnAFRTg%3D&from=3218412987","badge":null},{"rank":9,"title":"张禹珍逆转弗朗西斯卡夺冠","desc":null,"value":"936.1万","link":"https://www.douyin.com/search/%E5%BC%A0%E7%A6%B9%E7%8F%8D%E9%80%86%E8%BD%AC%E5%BC%97%E6%9C%97%E8%A5%BF%E6%96%AF%E5%8D%A1%E5%A4%BA%E5%86%A0","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/ogABAWIgCHAisifznCeJ1cvFpMBEABtI7GG1un~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=t8%2F1F5pPIIjQDQY3Qv4RpSgNTYA%3D&from=3218412987","badge":null},{"rank":10,"title":"将有2名中国人登陆月球","desc":null,"value":"933.5万","link":"https://www.douyin.com/search/%E5%B0%86%E6%9C%892%E5%90%8D%E4%B8%AD%E5%9B%BD%E4%BA%BA%E7%99%BB%E9%99%86%E6%9C%88%E7%90%83","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/okG92i8AiIbIgmcb4nf32QAAeZ0V1BCCAKr4BY~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=vcubiQqWurd%2BRgkDiW9rE61ALoU%3D&from=3218412987","badge":null},{"rank":11,"title":"杨瀚森工作室回应执行合同","desc":null,"value":"929.5万","link":"https://www.douyin.com/search/%E6%9D%A8%E7%80%9A%E6%A3%AE%E5%B7%A5%E4%BD%9C%E5%AE%A4%E5%9B%9E%E5%BA%94%E6%89%A7%E8%A1%8C%E5%90%88%E5%90%8C","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/osHYINiBv4fAl8hDRq0nAbrIk4iXk9A5JeB2kg~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=cT5jTLyr9IXS8oU%2F8w801%2BIoeUU%3D&from=3218412987","badge":null},{"rank":12,"title":"斯诺克国锦赛怀特2:6不敌塞尔比","desc":null,"value":"926.7万","link":"https://www.douyin.com/search/%E6%96%AF%E8%AF%BA%E5%85%8B%E5%9B%BD%E9%94%A6%E8%B5%9B%E6%80%80%E7%89%B92%3A6%E4%B8%8D%E6%95%8C%E5%A1%9E%E5%B0%94%E6%AF%94","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015c000-ce/oc0cBf4FAicoIi2H7B1wiBymEIe2AwyODE9qDW~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=PQnpk1p9DocJcZMIOuQ8mULV3xs%3D&from=3218412987","badge":null},{"rank":13,"title":"乌鲁木齐禁售马肉制品不实","desc":null,"value":"922.9万","link":"https://www.douyin.com/search/%E4%B9%8C%E9%B2%81%E6%9C%A8%E9%BD%90%E7%A6%81%E5%94%AE%E9%A9%AC%E8%82%89%E5%88%B6%E5%93%81%E4%B8%8D%E5%AE%9E","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015c000-ce/owkAAekhMC3BTfrgZXofDkQvlM2D8eAN2FFG84~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=jUr0HeOIVxw1ZrQ9gbF%2BLJagXMQ%3D&from=3218412987","badge":null},{"rank":14,"title":"云南玉昆队史首入足协杯决赛","desc":null,"value":"913.2万","link":"https://www.douyin.com/search/%E4%BA%91%E5%8D%97%E7%8E%89%E6%98%86%E9%98%9F%E5%8F%B2%E9%A6%96%E5%85%A5%E8%B6%B3%E5%8D%8F%E6%9D%AF%E5%86%B3%E8%B5%9B","cover":"https://p9-sign.douyinpic.com/tos-cn-p-0015/oUfTkB0GrESOyvTLIpVSxAEbDCfnenaAq2IUHf~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=%2FzKttNANJarhw%2FvNyiPlm3QdObA%3D&from=3218412987","badge":null},{"rank":15,"title":"看看互联网小姨们的生活","desc":null,"value":"913.1万","link":"https://www.douyin.com/search/%E7%9C%8B%E7%9C%8B%E4%BA%92%E8%81%94%E7%BD%91%E5%B0%8F%E5%A7%A8%E4%BB%AC%E7%9A%84%E7%94%9F%E6%B4%BB","cover":"https://p26-sign.douyinpic.com/tos-cn-i-0813/o4en9wwEqECAAAA6DC5F4D1EI0DAqXAk1gfnXx~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=vWAIHvl90mxqANWX2cHafrfMcfA%3D&from=3218412987","badge":null},{"rank":16,"title":"太多人的相逢不过是一场梦","desc":null,"value":"910.9万","link":"https://www.douyin.com/search/%E5%A4%AA%E5%A4%9A%E4%BA%BA%E7%9A%84%E7%9B%B8%E9%80%A2%E4%B8%8D%E8%BF%87%E6%98%AF%E4%B8%80%E5%9C%BA%E6%A2%A6","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015c000-ce/oUtAd4BrRFr5ACewUq4M9xwSJEIzfEeDIi0mLh~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=I9DkwibgNrG5SVs8WO9MICLZ8qQ%3D&from=3218412987","badge":null},{"rank":17,"title":"就这样变身大佬霸气出场","desc":null,"value":"893.5万","link":"https://www.douyin.com/search/%E5%B0%B1%E8%BF%99%E6%A0%B7%E5%8F%98%E8%BA%AB%E5%A4%A7%E4%BD%AC%E9%9C%B8%E6%B0%94%E5%87%BA%E5%9C%BA","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015c000-ce/ok8BiBrTKA9jJ7CkEAXNif3fno52qIAltE09wM~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=jYUxyEv3WDtwHQDVZE8j0YpZRcU%3D&from=3218412987","badge":null},{"rank":18,"title":"小城良方的大结局是人生","desc":null,"value":"889.6万","link":"https://www.douyin.com/search/%E5%B0%8F%E5%9F%8E%E8%89%AF%E6%96%B9%E7%9A%84%E5%A4%A7%E7%BB%93%E5%B1%80%E6%98%AF%E4%BA%BA%E7%94%9F","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/o8BPKZQAaHALwIa0fd7WYze9lXGIBCUQEKvVem~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=jAfOT%2BDkxCV3JxeInEH39cgBHm0%3D&from=3218412987","badge":null},{"rank":19,"title":"二十届五中全会决定全文发布","desc":null,"value":"889.4万","link":"https://www.douyin.com/search/%E4%BA%8C%E5%8D%81%E5%B1%8A%E4%BA%94%E4%B8%AD%E5%85%A8%E4%BC%9A%E5%86%B3%E5%AE%9A%E5%85%A8%E6%96%87%E5%8F%91%E5%B8%83","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/oM7cCIUIB3uZ3B7LgifKAxFiJiT6L1AAg8kejm~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=j8fMqt9txaOEeGbITFsk4slHkuU%3D&from=3218412987","badge":null},{"rank":20,"title":"徐明浩W盛典舞台","desc":null,"value":"881.9万","link":"https://www.douyin.com/search/%E5%BE%90%E6%98%8E%E6%B5%A9W%E7%9B%9B%E5%85%B8%E8%88%9E%E5%8F%B0","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015c000-ce/ocIONqEAvCvSiw9TukQAXFEE2fDaQ5C6ufg6be~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=fI5ayxddICJxV8xjkCcPP2bfUIg%3D&from=3218412987","badge":null},{"rank":21,"title":"退役特种兵姜世禄的自述","desc":null,"value":"864.7万","link":"https://www.douyin.com/search/%E9%80%80%E5%BD%B9%E7%89%B9%E7%A7%8D%E5%85%B5%E5%A7%9C%E4%B8%96%E7%A6%84%E7%9A%84%E8%87%AA%E8%BF%B0","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015c000-ce/oIEkeAGvwJOJcL73VYBrlI8BgI5fCCZQT0ekI5~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=Gz03%2Bl6aS7UuX2EwnWOSXhJyuwo%3D&from=3218412987","badge":null},{"rank":22,"title":"秋冬姐系高智感穿搭","desc":null,"value":"850.9万","link":"https://www.douyin.com/search/%E7%A7%8B%E5%86%AC%E5%A7%90%E7%B3%BB%E9%AB%98%E6%99%BA%E6%84%9F%E7%A9%BF%E6%90%AD","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-i-0813/oIaAALuDNZBEiHFEAMj85g5PPxTIAviI1g7cA~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=dupZKwad2kBRr4T87XdA6DmVqEE%3D&from=3218412987","badge":null},{"rank":23,"title":"赵铁春老师领头跳闪身步","desc":null,"value":"841.9万","link":"https://www.douyin.com/search/%E8%B5%B5%E9%93%81%E6%98%A5%E8%80%81%E5%B8%88%E9%A2%86%E5%A4%B4%E8%B7%B3%E9%97%AA%E8%BA%AB%E6%AD%A5","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/okKEdD9QE5FfBUnfBAtMOEVHAP7CyAekEQPCH0~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=h8U%2FNMjRZ2MzCeccgpSmADx%2Bp%2FQ%3D&from=3218412987","badge":null},{"rank":24,"title":"被玉簟秋大结局虐麻了","desc":null,"value":"824.6万","link":"https://www.douyin.com/search/%E8%A2%AB%E7%8E%89%E7%B0%9F%E7%A7%8B%E5%A4%A7%E7%BB%93%E5%B1%80%E8%99%90%E9%BA%BB%E4%BA%86","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/o4IBmqfAPBvWkg9t2TIALFEAa9D5x5BW9f8UwN~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=mwuR9hN4wFCOBkUWcZpLSMc4KuU%3D&from=3218412987","badge":null},{"rank":25,"title":"刘亦菲婚纱造型亮相W盛典","desc":null,"value":"824万","link":"https://www.douyin.com/search/%E5%88%98%E4%BA%A6%E8%8F%B2%E5%A9%9A%E7%BA%B1%E9%80%A0%E5%9E%8B%E4%BA%AE%E7%9B%B8W%E7%9B%9B%E5%85%B8","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015c000-ce/oIDp1EsB1IP5mF7A9nXfXQyZxHMYB9wfnqEzAE~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=hVdq%2F6oL7wveRnEkksZF2EyOVVk%3D&from=3218412987","badge":null},{"rank":26,"title":"我在现场见证石宇奇的幸福婚礼","desc":null,"value":"785.8万","link":"https://www.douyin.com/search/%E6%88%91%E5%9C%A8%E7%8E%B0%E5%9C%BA%E8%A7%81%E8%AF%81%E7%9F%B3%E5%AE%87%E5%A5%87%E7%9A%84%E5%B9%B8%E7%A6%8F%E5%A9%9A%E7%A4%BC","cover":"https://p26-sign.douyinpic.com/tos-cn-i-0813c001/o4tPCFDY9AAkiQApxNEI1nCAsAUgexAU5qfslH~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=tZItEs9A04VBbjiElyvguCN6xHI%3D&from=3218412987","badge":null},{"rank":27,"title":"胡歌自曝随身携带速效救心丸","desc":null,"value":"781.4万","link":"https://www.douyin.com/search/%E8%83%A1%E6%AD%8C%E8%87%AA%E6%9B%9D%E9%9A%8F%E8%BA%AB%E6%90%BA%E5%B8%A6%E9%80%9F%E6%95%88%E6%95%91%E5%BF%83%E4%B8%B8","cover":"https://p9-sign.douyinpic.com/tos-cn-p-0015/owzAIBBtiXnGc5mUze3FABrAH6AIINCfg13PRi~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=2HMHThEzx7Oe1uFxhvkAQbQaqyk%3D&from=3218412987","badge":null},{"rank":28,"title":"论我给朋友的出片速度","desc":null,"value":"780.2万","link":"https://www.douyin.com/search/%E8%AE%BA%E6%88%91%E7%BB%99%E6%9C%8B%E5%8F%8B%E7%9A%84%E5%87%BA%E7%89%87%E9%80%9F%E5%BA%A6","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015c000-ce/oIf0l64AECCiI7wIwnBhe1IEcEi2J3eTuirAPE~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=rP1HxIrKoNgsg%2BD37ji1tKG7k%2FI%3D&from=3218412987","badge":null},{"rank":29,"title":"薛之谦厦门站大屏互动神级现场","desc":null,"value":"775.3万","link":"https://www.douyin.com/search/%E8%96%9B%E4%B9%8B%E8%B0%A6%E5%8E%A6%E9%97%A8%E7%AB%99%E5%A4%A7%E5%B1%8F%E4%BA%92%E5%8A%A8%E7%A5%9E%E7%BA%A7%E7%8E%B0%E5%9C%BA","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015c000-ce/ooom9hajqEoCATE3GB5FrDtEIMDBfLAjEwfm7C~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=8pMx9jqSoel91eN1pk26E2QGlA8%3D&from=3218412987","badge":null},{"rank":30,"title":"旭旭宝宝CF狙王之夜开战","desc":null,"value":"774.5万","link":"https://www.douyin.com/search/%E6%97%AD%E6%97%AD%E5%AE%9D%E5%AE%9DCF%E7%8B%99%E7%8E%8B%E4%B9%8B%E5%A4%9C%E5%BC%80%E6%88%98","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/oAs37FMMrEffjJGXQQ7fYAgIDCLL8l3AE2gwf1~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=xb08isCELmqURz%2Fiqw7yUrez0Q8%3D&from=3218412987","badge":null},{"rank":31,"title":"虞昶轩叶平君战乱重逢","desc":null,"value":"774万","link":"https://www.douyin.com/search/%E8%99%9E%E6%98%B6%E8%BD%A9%E5%8F%B6%E5%B9%B3%E5%90%9B%E6%88%98%E4%B9%B1%E9%87%8D%E9%80%A2","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/ooFTa9fq5Ab7AsBCE75kv9iBCjMfQXbRAmggQD~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=AB24436KthPL6qziWKsJgQ5XMt4%3D&from=3218412987","badge":null},{"rank":32,"title":"武将杯总决赛最大意难平左左右","desc":null,"value":"773.8万","link":"https://www.douyin.com/search/%E6%AD%A6%E5%B0%86%E6%9D%AF%E6%80%BB%E5%86%B3%E8%B5%9B%E6%9C%80%E5%A4%A7%E6%84%8F%E9%9A%BE%E5%B9%B3%E5%B7%A6%E5%B7%A6%E5%8F%B3","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/o4nB78DXFatfzpmif7S4AC4BionQQaDfAVUxME~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=iD4fuhrk%2FzZLOkAPBKzOWs%2B8pL8%3D&from=3218412987","badge":null},{"rank":33,"title":"武将杯路西法复活归来夺冠","desc":null,"value":"772万","link":"https://www.douyin.com/search/%E6%AD%A6%E5%B0%86%E6%9D%AF%E8%B7%AF%E8%A5%BF%E6%B3%95%E5%A4%8D%E6%B4%BB%E5%BD%92%E6%9D%A5%E5%A4%BA%E5%86%A0","cover":"https://p3-sign.douyinpic.com/tos-cn-p-fd6e84/oYP5DfrtDAPqFO1oXMEcjjIy5BDQBatgiwlfjT~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=JYfNRFAHV6RhuImUJTCWA2Q00kY%3D&from=3218412987","badge":null},{"rank":34,"title":"陕西导演街头举牌自荐新片","desc":null,"value":"771.9万","link":"https://www.douyin.com/search/%E9%99%95%E8%A5%BF%E5%AF%BC%E6%BC%94%E8%A1%97%E5%A4%B4%E4%B8%BE%E7%89%8C%E8%87%AA%E8%8D%90%E6%96%B0%E7%89%87","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/oUBV0NqGJAThF7nwAILUybaGveFweYNIBBCfkQ~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=dRflB8bk9Ai2qHipDEO%2Bm7GIpNc%3D&from=3218412987","badge":null},{"rank":35,"title":"没有不爱坎肩皮草的义务","desc":null,"value":"771.7万","link":"https://www.douyin.com/search/%E6%B2%A1%E6%9C%89%E4%B8%8D%E7%88%B1%E5%9D%8E%E8%82%A9%E7%9A%AE%E8%8D%89%E7%9A%84%E4%B9%89%E5%8A%A1","cover":"https://p26-sign.douyinpic.com/tos-cn-i-0813c000-ce/o48AVJfENgwvV9eQzIFr7rAwAHE3FLBADrDe6h~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=tMG7uo5osrC1WUr17DWK3det7KU%3D&from=3218412987","badge":null},{"rank":36,"title":"在问卷里窥见爸爸的心愿","desc":null,"value":"770.7万","link":"https://www.douyin.com/search/%E5%9C%A8%E9%97%AE%E5%8D%B7%E9%87%8C%E7%AA%A5%E8%A7%81%E7%88%B8%E7%88%B8%E7%9A%84%E5%BF%83%E6%84%BF","cover":"https://p26-sign.douyinpic.com/tos-cn-i-0813/ooE9gFImgD8eAQDxCgfqFgADAzEUNAoaAq5qrA~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=rwk53Gnho%2BBBoHWVk6zl1XipotU%3D&from=3218412987","badge":null},{"rank":37,"title":"终于看清闺蜜谢帝这女装的全貌","desc":null,"value":"768.6万","link":"https://www.douyin.com/search/%E7%BB%88%E4%BA%8E%E7%9C%8B%E6%B8%85%E9%97%BA%E8%9C%9C%E8%B0%A2%E5%B8%9D%E8%BF%99%E5%A5%B3%E8%A3%85%E7%9A%84%E5%85%A8%E8%B2%8C","cover":"https://p11-sign.douyinpic.com/tos-cn-p-0015/oo3RjJp87VQXeGBeCTMaFTWXA0fzAAYBo76vAB~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=TzhI%2FivoICzdO%2BTsHkXXuz8wSmQ%3D&from=3218412987","badge":null},{"rank":38,"title":"Xun说要相信BLG","desc":null,"value":"768.4万","link":"https://www.douyin.com/search/Xun%E8%AF%B4%E8%A6%81%E7%9B%B8%E4%BF%A1BLG","cover":"https://p9-sign.douyinpic.com/tos-cn-p-0015/o8XcDf5rBA31i3kAzmir1JIYcBNI3Ydg5ke4aA~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=%2FLE7Hjf7zZHIz3dlzTciJsgjKDg%3D&from=3218412987","badge":null},{"rank":39,"title":"费兰托雷斯入驻抖音","desc":null,"value":"768.3万","link":"https://www.douyin.com/search/%E8%B4%B9%E5%85%B0%E6%89%98%E9%9B%B7%E6%96%AF%E5%85%A5%E9%A9%BB%E6%8A%96%E9%9F%B3","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015c000-ce/o0HGLDvfhBDFqfunICvdIeoNODzSVQARDJF7gq~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=QWnU9zmGZjQxvAH%2BF91OnUVfqXg%3D&from=3218412987","badge":null},{"rank":40,"title":"十月就到此为止吧","desc":null,"value":"768万","link":"https://www.douyin.com/search/%E5%8D%81%E6%9C%88%E5%B0%B1%E5%88%B0%E6%AD%A4%E4%B8%BA%E6%AD%A2%E5%90%A7","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015c000-ce/okCAF5Ef7FGYABnbMq3Z9kwC2EQXfETDQkLcoA~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=MxjpgyN%2Fq%2B%2BFECrdXHdB9FiVXYw%3D&from=3218412987","badge":null},{"rank":41,"title":"徐艺洋马代vlog看得人心暖暖","desc":null,"value":"767万","link":"https://www.douyin.com/search/%E5%BE%90%E8%89%BA%E6%B4%8B%E9%A9%AC%E4%BB%A3vlog%E7%9C%8B%E5%BE%97%E4%BA%BA%E5%BF%83%E6%9A%96%E6%9A%96","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/ooyDJ8fb4Au2MfBAPBnQAtEIeCmXBoY0r6QLHe~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=xUMC7Q3ESjfvIwRS58RljjTmkrI%3D&from=3218412987","badge":null},{"rank":42,"title":"老四泪洒武将杯总决赛直播间","desc":null,"value":"766.4万","link":"https://www.douyin.com/search/%E8%80%81%E5%9B%9B%E6%B3%AA%E6%B4%92%E6%AD%A6%E5%B0%86%E6%9D%AF%E6%80%BB%E5%86%B3%E8%B5%9B%E7%9B%B4%E6%92%AD%E9%97%B4","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/oIEmm1EAyBxSvge61mIADiiAYLB8McBlYflbFN~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=W1mO5SUJam56lYzwkl2zb%2FePuJ4%3D&from=3218412987","badge":null},{"rank":43,"title":"小城良方宫雪贾鑫在一起了","desc":null,"value":"765.9万","link":"https://www.douyin.com/search/%E5%B0%8F%E5%9F%8E%E8%89%AF%E6%96%B9%E5%AE%AB%E9%9B%AA%E8%B4%BE%E9%91%AB%E5%9C%A8%E4%B8%80%E8%B5%B7%E4%BA%86","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/osfWBv8MEgep79VB3rCIfyF6LCaAtQzWXQZZgA~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=DvMb7R3XmkQgO8aiChxutECmHWY%3D&from=3218412987","badge":null},{"rank":44,"title":"昊天武道会报名花样百出","desc":null,"value":"765.8万","link":"https://www.douyin.com/search/%E6%98%8A%E5%A4%A9%E6%AD%A6%E9%81%93%E4%BC%9A%E6%8A%A5%E5%90%8D%E8%8A%B1%E6%A0%B7%E7%99%BE%E5%87%BA","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/oUKnQ6F7oPNaU4BlADDAQy5h9Zqg3BfAtdE4fy~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=Y19dLnbm9b3SKlWusYbmO8wka0E%3D&from=3218412987","badge":null},{"rank":45,"title":"许飞发长文聊到底什么才是爱","desc":null,"value":"765.8万","link":"https://www.douyin.com/search/%E8%AE%B8%E9%A3%9E%E5%8F%91%E9%95%BF%E6%96%87%E8%81%8A%E5%88%B0%E5%BA%95%E4%BB%80%E4%B9%88%E6%89%8D%E6%98%AF%E7%88%B1","cover":"https://p26-sign.douyinpic.com/tos-cn-i-0813c000-ce/oIAEArrlM4qIfCmA4DDawEzSn5p9EaFwAGeA7K~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=44RsDtZAddZIGPWCtMt1Aje41Jw%3D&from=3218412987","badge":null},{"rank":46,"title":"谭松韵金色礼服路透好明媚","desc":null,"value":"765.7万","link":"https://www.douyin.com/search/%E8%B0%AD%E6%9D%BE%E9%9F%B5%E9%87%91%E8%89%B2%E7%A4%BC%E6%9C%8D%E8%B7%AF%E9%80%8F%E5%A5%BD%E6%98%8E%E5%AA%9A","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/o0D8m2f8CFgtqFpA7ceBAgDkE5IA3I4g9Qrzy9~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=%2BI8yEMxL5onFwDeifRDv4DzpI7k%3D&from=3218412987","badge":null},{"rank":47,"title":"现在就出发4复仇之战燃起来了","desc":null,"value":"765.6万","link":"https://www.douyin.com/search/%E7%8E%B0%E5%9C%A8%E5%B0%B1%E5%87%BA%E5%8F%914%E5%A4%8D%E4%BB%87%E4%B9%8B%E6%88%98%E7%87%83%E8%B5%B7%E6%9D%A5%E4%BA%86","cover":"https://p26-sign.douyinpic.com/tos-cn-p-0015/oEubfLRBIQzQAaz1XmeZMz1A7faQVGazBEp0C4~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=uhvJd98IqeHdSATckY%2FGkqz4%2FeY%3D&from=3218412987","badge":null},{"rank":48,"title":"再就业男团演唱会一年之约","desc":null,"value":"765.1万","link":"https://www.douyin.com/search/%E5%86%8D%E5%B0%B1%E4%B8%9A%E7%94%B7%E5%9B%A2%E6%BC%94%E5%94%B1%E4%BC%9A%E4%B8%80%E5%B9%B4%E4%B9%8B%E7%BA%A6","cover":"https://p5-ex-gddgtc-sign.douyinpic.com/tos-cn-p-0015/oQFlYedq5ArNAC2DElAh79GBNUmfQRSxAimgQD~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=nDwP121eL8hwjubOrJzirl6%2Bf3s%3D&from=3218412987","badge":null},{"rank":49,"title":"董思成：期待下一次见面","desc":null,"value":"765.1万","link":"https://www.douyin.com/search/%E8%91%A3%E6%80%9D%E6%88%90%EF%BC%9A%E6%9C%9F%E5%BE%85%E4%B8%8B%E4%B8%80%E6%AC%A1%E8%A7%81%E9%9D%A2","cover":"https://p3-sign.douyinpic.com/tos-cn-p-0015/oEcCmGtcq7AR0fdmB6FEgnDRA5A9q3HIIifiCg~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=eBQ2aJtnJxEYFQF6YFAUAf%2BjDaM%3D&from=3218412987","badge":null},{"rank":50,"title":"邓超和哈友团的舞台让人泪目了","desc":null,"value":"764.8万","link":"https://www.douyin.com/search/%E9%82%93%E8%B6%85%E5%92%8C%E5%93%88%E5%8F%8B%E5%9B%A2%E7%9A%84%E8%88%9E%E5%8F%B0%E8%AE%A9%E4%BA%BA%E6%B3%AA%E7%9B%AE%E4%BA%86","cover":"https://p11-sign.douyinpic.com/tos-cn-i-0813c000-ce/okAEAUAKsuqQfCZA4HDVmIlAo5p9EKFwAejAUG~noop.jpeg?lk3s=bfd515bb&x-expires=1793599200&x-signature=%2BRcFztjg9zrzja8%2FijaAFI31FBQ%3D&from=3218412987","badge":null}],"total":50}',26062,19887,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('bili','/v2/bili','B站热搜','哔哩哔哩热搜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"安东内利成F1史上最年轻世界冠军","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%AE%89%E4%B8%9C%E5%86%85%E5%88%A9%E6%88%90F1%E5%8F%B2%E4%B8%8A%E6%9C%80%E5%B9%B4%E8%BD%BB%E4%B8%96%E7%95%8C%E5%86%A0%E5%86%9B","cover":null,"badge":null},{"rank":2,"title":"阿森纳1-0利物浦","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%98%BF%E6%A3%AE%E7%BA%B31-0%E5%88%A9%E7%89%A9%E6%B5%A6","cover":null,"badge":null},{"rank":3,"title":"显卡大盘连续5天下跌","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E6%98%BE%E5%8D%A1%E5%A4%A7%E7%9B%98%E8%BF%9E%E7%BB%AD5%E5%A4%A9%E4%B8%8B%E8%B7%8C","cover":null,"badge":null},{"rank":4,"title":"首届CMG世界机器人登泰山大赛开赛","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%A6%96%E5%B1%8ACMG%E4%B8%96%E7%95%8C%E6%9C%BA%E5%99%A8%E4%BA%BA%E7%99%BB%E6%B3%B0%E5%B1%B1%E5%A4%A7%E8%B5%9B%E5%BC%80%E8%B5%9B","cover":null,"badge":null},{"rank":5,"title":"TES vs IG数据前瞻","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=TES%20vs%20IG%E6%95%B0%E6%8D%AE%E5%89%8D%E7%9E%BB","cover":null,"badge":null},{"rank":6,"title":"Bin说击败Zeus接替世一上","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=Bin%E8%AF%B4%E5%87%BB%E8%B4%A5Zeus%E6%8E%A5%E6%9B%BF%E4%B8%96%E4%B8%80%E4%B8%8A","cover":null,"badge":null},{"rank":7,"title":"张禹珍WTT蒙彼利埃站夺冠","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BC%A0%E7%A6%B9%E7%8F%8DWTT%E8%92%99%E5%BD%BC%E5%88%A9%E5%9F%83%E7%AB%99%E5%A4%BA%E5%86%A0","cover":null,"badge":null},{"rank":8,"title":"近期热梗大盘点","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E8%BF%91%E6%9C%9F%E7%83%AD%E6%A2%97%E5%A4%A7%E7%9B%98%E7%82%B9","cover":null,"badge":null},{"rank":9,"title":"黑人牙膏脸是什么梗","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%BB%91%E4%BA%BA%E7%89%99%E8%86%8F%E8%84%B8%E6%98%AF%E4%BB%80%E4%B9%88%E6%A2%97","cover":null,"badge":null},{"rank":10,"title":"美国中期选举为何变烧钱大战","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E7%BE%8E%E5%9B%BD%E4%B8%AD%E6%9C%9F%E9%80%89%E4%B8%BE%E4%B8%BA%E4%BD%95%E5%8F%98%E7%83%A7%E9%92%B1%E5%A4%A7%E6%88%98","cover":null,"badge":null},{"rank":11,"title":"徐静雨谈影之刃零战斗表现力","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BE%90%E9%9D%99%E9%9B%A8%E8%B0%88%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E6%88%98%E6%96%97%E8%A1%A8%E7%8E%B0%E5%8A%9B","cover":null,"badge":null},{"rank":12,"title":"UP主挑战搬空大润发","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=UP%E4%B8%BB%E6%8C%91%E6%88%98%E6%90%AC%E7%A9%BA%E5%A4%A7%E6%B6%A6%E5%8F%91","cover":null,"badge":null},{"rank":13,"title":"UP主手工复刻故宫同款蟠龙藻井","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=UP%E4%B8%BB%E6%89%8B%E5%B7%A5%E5%A4%8D%E5%88%BB%E6%95%85%E5%AE%AB%E5%90%8C%E6%AC%BE%E8%9F%A0%E9%BE%99%E8%97%BB%E4%BA%95","cover":null,"badge":null},{"rank":14,"title":"西班牙高铁相撞事故始末","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E8%A5%BF%E7%8F%AD%E7%89%99%E9%AB%98%E9%93%81%E7%9B%B8%E6%92%9E%E4%BA%8B%E6%95%85%E5%A7%8B%E6%9C%AB","cover":null,"badge":null},{"rank":15,"title":"韩立","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%9F%A9%E7%AB%8B","cover":null,"badge":null},{"rank":16,"title":"中期选举对特朗普有多重要","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E4%B8%AD%E6%9C%9F%E9%80%89%E4%B8%BE%E5%AF%B9%E7%89%B9%E6%9C%97%E6%99%AE%E6%9C%89%E5%A4%9A%E9%87%8D%E8%A6%81","cover":null,"badge":null},{"rank":17,"title":"UP主挑战和粉丝包下一座游艇","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=UP%E4%B8%BB%E6%8C%91%E6%88%98%E5%92%8C%E7%B2%89%E4%B8%9D%E5%8C%85%E4%B8%8B%E4%B8%80%E5%BA%A7%E6%B8%B8%E8%89%87","cover":null,"badge":null},{"rank":18,"title":"如果恐龙活着它的肉是什么味","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%A6%82%E6%9E%9C%E6%81%90%E9%BE%99%E6%B4%BB%E7%9D%80%E5%AE%83%E7%9A%84%E8%82%89%E6%98%AF%E4%BB%80%E4%B9%88%E5%91%B3","cover":null,"badge":null},{"rank":19,"title":"APEC领导人会议为何强调非正式","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=APEC%E9%A2%86%E5%AF%BC%E4%BA%BA%E4%BC%9A%E8%AE%AE%E4%B8%BA%E4%BD%95%E5%BC%BA%E8%B0%83%E9%9D%9E%E6%AD%A3%E5%BC%8F","cover":null,"badge":null},{"rank":20,"title":"牧神记","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E7%89%A7%E7%A5%9E%E8%AE%B0","cover":null,"badge":null},{"rank":21,"title":"供应链视角看苹果折叠屏问题在哪","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E4%BE%9B%E5%BA%94%E9%93%BE%E8%A7%86%E8%A7%92%E7%9C%8B%E8%8B%B9%E6%9E%9C%E6%8A%98%E5%8F%A0%E5%B1%8F%E9%97%AE%E9%A2%98%E5%9C%A8%E5%93%AA","cover":null,"badge":null},{"rank":22,"title":"当2077的CV来配音边缘行者2","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%932077%E7%9A%84CV%E6%9D%A5%E9%85%8D%E9%9F%B3%E8%BE%B9%E7%BC%98%E8%A1%8C%E8%80%852","cover":null,"badge":null},{"rank":23,"title":"AI短片克劳德的救赎","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=AI%E7%9F%AD%E7%89%87%E5%85%8B%E5%8A%B3%E5%BE%B7%E7%9A%84%E6%95%91%E8%B5%8E","cover":null,"badge":null},{"rank":24,"title":"影之刃零Steam在线人数破83万","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6Steam%E5%9C%A8%E7%BA%BF%E4%BA%BA%E6%95%B0%E7%A0%B483%E4%B8%87","cover":null,"badge":null},{"rank":25,"title":"央视频专访绝区零制作人","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%A4%AE%E8%A7%86%E9%A2%91%E4%B8%93%E8%AE%BF%E7%BB%9D%E5%8C%BA%E9%9B%B6%E5%88%B6%E4%BD%9C%E4%BA%BA","cover":null,"badge":null},{"rank":26,"title":"影之刃零格挡机制解析","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E6%A0%BC%E6%8C%A1%E6%9C%BA%E5%88%B6%E8%A7%A3%E6%9E%90","cover":null,"badge":null},{"rank":27,"title":"S16瑞士轮全位置前三数据","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=S16%E7%91%9E%E5%A3%AB%E8%BD%AE%E5%85%A8%E4%BD%8D%E7%BD%AE%E5%89%8D%E4%B8%89%E6%95%B0%E6%8D%AE","cover":null,"badge":null},{"rank":28,"title":"S16瑞士轮全位置数据图","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=S16%E7%91%9E%E5%A3%AB%E8%BD%AE%E5%85%A8%E4%BD%8D%E7%BD%AE%E6%95%B0%E6%8D%AE%E5%9B%BE","cover":null,"badge":null},{"rank":29,"title":"剖析人类提出过最难的数学题","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%89%96%E6%9E%90%E4%BA%BA%E7%B1%BB%E6%8F%90%E5%87%BA%E8%BF%87%E6%9C%80%E9%9A%BE%E7%9A%84%E6%95%B0%E5%AD%A6%E9%A2%98","cover":null,"badge":null},{"rank":30,"title":"12个AI预测BLG对阵HLE","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=12%E4%B8%AAAI%E9%A2%84%E6%B5%8BBLG%E5%AF%B9%E9%98%B5HLE","cover":null,"badge":null},{"rank":31,"title":"荣昌猪成高端生物医学材料","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E8%8D%A3%E6%98%8C%E7%8C%AA%E6%88%90%E9%AB%98%E7%AB%AF%E7%94%9F%E7%89%A9%E5%8C%BB%E5%AD%A6%E6%9D%90%E6%96%99","cover":null,"badge":null},{"rank":32,"title":"超级科学晚全程回顾","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E8%B6%85%E7%BA%A7%E7%A7%91%E5%AD%A6%E6%99%9A%E5%85%A8%E7%A8%8B%E5%9B%9E%E9%A1%BE","cover":null,"badge":null},{"rank":33,"title":"火兰朋克锐评LPL淘汰赛签运","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E7%81%AB%E5%85%B0%E6%9C%8B%E5%85%8B%E9%94%90%E8%AF%84LPL%E6%B7%98%E6%B1%B0%E8%B5%9B%E7%AD%BE%E8%BF%90","cover":null,"badge":null},{"rank":34,"title":"在影之刃零中拍超燃大片","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%9C%A8%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E4%B8%AD%E6%8B%8D%E8%B6%85%E7%87%83%E5%A4%A7%E7%89%87","cover":null,"badge":null},{"rank":35,"title":"BLG生死战Knight发挥有多好","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=BLG%E7%94%9F%E6%AD%BB%E6%88%98Knight%E5%8F%91%E6%8C%A5%E6%9C%89%E5%A4%9A%E5%A5%BD","cover":null,"badge":null},{"rank":36,"title":"影之刃零游戏评测","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E6%B8%B8%E6%88%8F%E8%AF%84%E6%B5%8B","cover":null,"badge":null},{"rank":37,"title":"影之刃BVB新娘阿花vs魔偶","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%B1%E4%B9%8B%E5%88%83BVB%E6%96%B0%E5%A8%98%E9%98%BF%E8%8A%B1vs%E9%AD%94%E5%81%B6","cover":null,"badge":null},{"rank":38,"title":"锐评HLE止步S16十六强","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%94%90%E8%AF%84HLE%E6%AD%A2%E6%AD%A5S16%E5%8D%81%E5%85%AD%E5%BC%BA","cover":null,"badge":null},{"rank":39,"title":"三角洲S12武器强度排行预估","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E4%B8%89%E8%A7%92%E6%B4%B2S12%E6%AD%A6%E5%99%A8%E5%BC%BA%E5%BA%A6%E6%8E%92%E8%A1%8C%E9%A2%84%E4%BC%B0","cover":null,"badge":null},{"rank":40,"title":"波兰疑似政变风波因何而起","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E6%B3%A2%E5%85%B0%E7%96%91%E4%BC%BC%E6%94%BF%E5%8F%98%E9%A3%8E%E6%B3%A2%E5%9B%A0%E4%BD%95%E8%80%8C%E8%B5%B7","cover":null,"badge":null},{"rank":41,"title":"华南什么时候能入秋","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%8D%8E%E5%8D%97%E4%BB%80%E4%B9%88%E6%97%B6%E5%80%99%E8%83%BD%E5%85%A5%E7%A7%8B","cover":null,"badge":null},{"rank":42,"title":"假如世界举办绷住大赛","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%81%87%E5%A6%82%E4%B8%96%E7%95%8C%E4%B8%BE%E5%8A%9E%E7%BB%B7%E4%BD%8F%E5%A4%A7%E8%B5%9B","cover":null,"badge":null},{"rank":43,"title":"影之刃零不小心就错过的彩蛋","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E4%B8%8D%E5%B0%8F%E5%BF%83%E5%B0%B1%E9%94%99%E8%BF%87%E7%9A%84%E5%BD%A9%E8%9B%8B","cover":null,"badge":null},{"rank":44,"title":"飞天汽车距离普通人还有多远","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E9%A3%9E%E5%A4%A9%E6%B1%BD%E8%BD%A6%E8%B7%9D%E7%A6%BB%E6%99%AE%E9%80%9A%E4%BA%BA%E8%BF%98%E6%9C%89%E5%A4%9A%E8%BF%9C","cover":null,"badge":null},{"rank":45,"title":"UP主用乐高拼漫威复仇者大厦","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=UP%E4%B8%BB%E7%94%A8%E4%B9%90%E9%AB%98%E6%8B%BC%E6%BC%AB%E5%A8%81%E5%A4%8D%E4%BB%87%E8%80%85%E5%A4%A7%E5%8E%A6","cover":null,"badge":null},{"rank":46,"title":"仁川兄弟晋级八强结算画面","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E4%BB%81%E5%B7%9D%E5%85%84%E5%BC%9F%E6%99%8B%E7%BA%A7%E5%85%AB%E5%BC%BA%E7%BB%93%E7%AE%97%E7%94%BB%E9%9D%A2","cover":null,"badge":null},{"rank":47,"title":"纯黑影之刃逆天者全程无伤解说","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E7%BA%AF%E9%BB%91%E5%BD%B1%E4%B9%8B%E5%88%83%E9%80%86%E5%A4%A9%E8%80%85%E5%85%A8%E7%A8%8B%E6%97%A0%E4%BC%A4%E8%A7%A3%E8%AF%B4","cover":null,"badge":null},{"rank":48,"title":"歌剧老师锐评韩娱","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E6%AD%8C%E5%89%A7%E8%80%81%E5%B8%88%E9%94%90%E8%AF%84%E9%9F%A9%E5%A8%B1","cover":null,"badge":null},{"rank":49,"title":"Bin赛后采访力挺Viper","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=Bin%E8%B5%9B%E5%90%8E%E9%87%87%E8%AE%BF%E5%8A%9B%E6%8C%BAViper","cover":null,"badge":null},{"rank":50,"title":"明日方舟塔露拉是个什么样的角色","desc":null,"value":null,"link":"https://search.bilibili.com/all?keyword=%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E5%A1%94%E9%9C%B2%E6%8B%89%E6%98%AF%E4%B8%AA%E4%BB%80%E4%B9%88%E6%A0%B7%E7%9A%84%E8%A7%92%E8%89%B2","cover":null,"badge":null}],"total":50}',8486,8923,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('toutiao','/v2/toutiao','头条热榜','今日头条','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"美国一公务机俯冲爆炸9人全遇难","desc":null,"value":"740.9万","link":"https://www.toutiao.com/trending/7703307437939622409","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/7ec1bea6ae82422f9f62e4d543f63dc4~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=ykrbt9mcxvc124%2BmZaAi6ok073A%3D","badge":null},{"rank":2,"title":"评论员：中国要在黄岩岛关门了","desc":null,"value":"670.4万","link":"https://www.toutiao.com/trending/7702475985760829503","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/02bd8062-e38d-4383-b132-91ff14315eee~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=W%2FtzN8s3BgJ3ENevY6D1Y0Q53KY%3D","badge":null},{"rank":3,"title":"永葆生机活力 走好新的赶考之路","desc":null,"value":"606.6万","link":"https://www.toutiao.com/article/7703050876532965922","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/2efbba80-10c0-4ebe-b286-f8fc365755ef~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=nyJtCYMJTAZ2ws5Ps7weXECwLJI%3D","badge":null},{"rank":4,"title":"孙颖莎夺WTT蒙彼利埃站冠军","desc":null,"value":"548.9万","link":"https://www.toutiao.com/trending/7703314602323378715","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/645b9e7656ae4c9980e93389fb99df7a~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=K0YzJYrduyPcJ2iyY7crvgku4%2BU%3D","badge":null},{"rank":5,"title":"DeepSeek亮出“超级智能体”架构","desc":null,"value":"496.6万","link":"https://www.toutiao.com/trending/7703258129567321638","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/c2ab49d1161d4a30abaf19217825d7a4~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=EIrQL1ZW6xDvs6WZeCTrXiUl39E%3D","badge":null},{"rank":6,"title":"一套房650万要缴450万的税","desc":null,"value":"449.4万","link":"https://www.toutiao.com/trending/7702438360152866866","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/50aef58f001c4c15a0498ff9ba912fc6~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=S%2F%2FYjn%2BffQD8UlYt6xqFnntXKhE%3D","badge":null},{"rank":7,"title":"伊朗已购买俄罗斯苏-35战斗机","desc":null,"value":"406.6万","link":"https://www.toutiao.com/trending/7703020620740723210","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/e862c9e0ba554d648390ba8960d44498~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=DXpGnBCGS9GnCMXlQ8l5EEWxzt4%3D","badge":null},{"rank":8,"title":"孙颖莎回应夺冠","desc":null,"value":"367.9万","link":"https://www.toutiao.com/trending/7702943994111688747","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/8851bd70bd9a4149bbafc4c9869771e9~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=4BmtG2mh5Aexm488eg%2BJIcPYbbM%3D","badge":null},{"rank":9,"title":"两家A股公司被证监会立案","desc":null,"value":"332.9万","link":"https://www.toutiao.com/trending/7703187065659260982","cover":"https://p3-sign.toutiaoimg.com/mosaic-legacy/2b29000036f8405561443~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=8KBgmXb74tIyC%2BVdtVE0xmebil4%3D","badge":null},{"rank":10,"title":"优质蛋白食物第一名出炉","desc":null,"value":"301.2万","link":"https://www.toutiao.com/trending/7703069646329069604","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/7dd238f8e8db48a3a1dc2ca44b2512cd~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=%2FZrDvym%2Ftv%2Bka%2FPRvn5BJJ5Tkz4%3D","badge":null},{"rank":11,"title":"新疆禾木野生猴群下山抢手机？假的","desc":null,"value":"272.6万","link":"https://www.toutiao.com/trending/7703350080081759795","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/b9bf2ce32ce649bf91f9acaca7e4fd49~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=6GolNIGh0OOAJbWnMwrSzwNxpMk%3D","badge":null},{"rank":12,"title":"W盛典名场面：刘亦菲穿婚纱压轴","desc":null,"value":"246.6万","link":"https://www.toutiao.com/trending/7702941090302689802","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/6bf6685a35f54b61bc473b5627f793f0~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=C%2FRzmUZfx7RcVZboAVPV%2B4znMo0%3D","badge":null},{"rank":13,"title":"刘建宏谈U17女足不敌巴西","desc":null,"value":"223.1万","link":"https://www.toutiao.com/trending/7703302308192453130","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/fc13bffa7b5f436482811b4817b9bd4f~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=J%2BUPL27gqqBpdj8BqSAjrP2UB1k%3D","badge":null},{"rank":14,"title":"伊朗披露斡旋进展抛出“两天计划”","desc":null,"value":"201.9万","link":"https://www.toutiao.com/trending/7703345543170231871","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/84b68892f6314aebacaba4f5d2af04c8~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=FeF8m%2FJ7N4hO518Itz9UUtTrgks%3D","badge":null},{"rank":15,"title":"周深刘亦菲同框热聊","desc":null,"value":"182.7万","link":"https://www.toutiao.com/trending/7702225221155029042","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/3b2ae7257ed647c6b73049ebc46e8b25~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=%2F1h%2BubS3CvFfJxTMJXk41wQdFHc%3D","badge":null},{"rank":16,"title":"中国队结束U17女足世界杯之旅","desc":null,"value":"165.3万","link":"https://www.toutiao.com/trending/7703304735142642214","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/c18732c7667645bd8b2904b380fe8fb8~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=pTCkadDcc6PO036F4PK594zjSW8%3D","badge":null},{"rank":17,"title":"中国载人登月路线图首次详解","desc":null,"value":"149.6万","link":"https://www.toutiao.com/trending/7703241183903878692","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/377dadaf65e348cb9da245fe46d5a5a8~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=NklDFipfyIEn9O0GSHAd2CwS6wE%3D","badge":null},{"rank":18,"title":"家长：接初中生放学就像特务接头","desc":null,"value":"135.3万","link":"https://www.toutiao.com/trending/7703157122619932708","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/1cfba889-83e6-48d1-9bdb-785e23ec5a06~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=OepPOOM7X3xxagJpUZw8Qvr0jrE%3D","badge":null},{"rank":19,"title":"市场下跌为何还要警惕后市踩踏风险","desc":null,"value":"122.5万","link":"https://www.toutiao.com/trending/7703350062348242495","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/6ef829b1124c4c59875566465db2123a~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=Gl8za5GAcC5e70mCkSjMGfQojVo%3D","badge":null},{"rank":20,"title":"全球资产遭遇洗盘","desc":null,"value":"110.8万","link":"https://www.toutiao.com/trending/7703198634543681050","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/59432a36-06fa-4cbf-bb3c-b6c7d0e1b0d2~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=GSdZ4ItUvoKu1uVorm1SaMZwwjY%3D","badge":null},{"rank":21,"title":"若AI破解世界难题 数学家还剩什么","desc":null,"value":"100.3万","link":"https://www.toutiao.com/trending/7703251675905003062","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/df98e49729ad4dfea003cdb7afc68de6~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=rJusFlW5A8B2QWcb3JoIkvPdpnA%3D","badge":null},{"rank":22,"title":"港媒：沈伯洋“洋流”或激出反作用力","desc":null,"value":"90.7万","link":"https://www.toutiao.com/trending/7703145462685089833","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/008f175adfc04e4e902af190120eee7e~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=yKl2dtNtDLFSzeJskPv%2BFaxYRS0%3D","badge":null},{"rank":23,"title":"女性在这两个年龄或会断崖式衰老","desc":null,"value":"82.1万","link":"https://www.toutiao.com/trending/7702772249719750698","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/14e7038a085544dca427b3de2b0fa278~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=GlUnuf1v2a77Cvn3BfNBeWs6AiE%3D","badge":null},{"rank":24,"title":"周华健演唱会唱《漂洋过海来看你》","desc":null,"value":"74.3万","link":"https://www.toutiao.com/trending/7703097577281208356","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/9a839de77612426891f152bdaf625979~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=7qpgSwTbaJx7fzBS2sDbcIOlYvo%3D","badge":null},{"rank":25,"title":"评论员：外部势力想在台海兴风作浪","desc":null,"value":"67.2万","link":"https://www.toutiao.com/trending/7703192430287536179","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/28a935fc81af43a286c1562541e68042~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=2bRG83NZc20%2F4QejhIfM3v8NHBg%3D","badge":null},{"rank":26,"title":"孙颖莎退赛法兰克福站","desc":null,"value":"60.8万","link":"https://www.toutiao.com/trending/7702723046238453802","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/42584b511a62477f97b9843e17298991~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=N96tNEerHri3lV5eUqL3yWy3idE%3D","badge":null},{"rank":27,"title":"光模块企业“易中天”谁先跌出机会","desc":null,"value":"55万","link":"https://www.toutiao.com/trending/7703257960679476772","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/65c8e017dc5543b39cf5bc5050afd7c3~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=EHfbMxFQxApcze5k1C7wbByt%2FTk%3D","badge":null},{"rank":28,"title":"基金经理：A股估值已被极度压缩","desc":null,"value":"49.8万","link":"https://www.toutiao.com/trending/7703198727875657769","cover":"https://p3-sign.toutiaoimg.com/mosaic-legacy/2b29000036f8405561443~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=8KBgmXb74tIyC%2BVdtVE0xmebil4%3D","badge":null},{"rank":29,"title":"中使馆：听蝲蝲蛄叫还不种庄稼了？","desc":null,"value":"45.1万","link":"https://www.toutiao.com/trending/7703086139686666283","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/f6796c21-6a2f-45da-86f5-7c54dc16fd05~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=rceJqNly1SoWAiE8D3uGOg4ntKs%3D","badge":null},{"rank":30,"title":"皇马3-0桑坦德竞技","desc":null,"value":"40.8万","link":"https://www.toutiao.com/trending/7703241248630538803","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/539c92a1-767b-47e1-993d-9158e981c5fa~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=O50MP1DmkavQjGB0P8gQEPBo%2FRQ%3D","badge":null},{"rank":31,"title":"媒体：U17国足世少赛出线难度不小","desc":null,"value":"36.9万","link":"https://www.toutiao.com/trending/7702767970489516068","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/6248d6765a1d43ad886ca5ac9240a6aa~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=iHa3j%2Bs4OSqOwFbSdQw4MLt1c3k%3D","badge":null},{"rank":32,"title":"陈赫演唱《南山南》惊艳全场","desc":null,"value":"33.4万","link":"https://www.toutiao.com/trending/7703048297120038963","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/4bf7383d06794434a40612bf751a1c97~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=kotcdxEOKEeYOQV2MMVy5eGae%2FI%3D","badge":null},{"rank":33,"title":"王曼昱林诗栋因伤退赛","desc":null,"value":"30.2万","link":"https://www.toutiao.com/trending/7703202746748404233","cover":"https://p3-sign.toutiaoimg.com/mosaic-legacy/2b29000036f8405561443~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=8KBgmXb74tIyC%2BVdtVE0xmebil4%3D","badge":null},{"rank":34,"title":"Kimi和妹妹抵达F1墨西哥正赛日围场","desc":null,"value":"27.3万","link":"https://www.toutiao.com/trending/7703243283148866086","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/0eadfc53f6034f48b4e04075ef30d161~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=A6A2UXBk3baUbPbL2PYQHPUTq9o%3D","badge":null},{"rank":35,"title":"蔚来创始人李斌亮相深圳","desc":null,"value":"24.7万","link":"https://www.toutiao.com/trending/7703119575231119401","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/cd99dfd9e69846ffb0048a6d2e897a8c~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=DCYNA3Czdzd4OUFrGEAZ0MTBgkE%3D","badge":null},{"rank":36,"title":"女子称翻出第三者物品才知被出轨","desc":null,"value":"22.4万","link":"https://www.toutiao.com/trending/7701986659813933110","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/1774026ef5b34e3aa094c4dd545caee4~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=ZE9qLEjV2rHc3zvDW0FA8PuoLwk%3D","badge":null},{"rank":37,"title":"刘建宏：足球场上情绪管理也是必修课","desc":null,"value":"20.2万","link":"https://www.toutiao.com/trending/7703261506208534079","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/e30a6d85066c4da89064b1daa96efadb~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=G1j74%2BBGb%2BNSi14yxl7wp08NRx8%3D","badge":null},{"rank":38,"title":"11岁女孩确诊甲状腺癌已肺转移","desc":null,"value":"18.3万","link":"https://www.toutiao.com/trending/7703155124209877035","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/37a36855-67f5-4fb2-8a45-bda6e6dd34b5~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=%2F%2FZb%2B6%2FWJWfz9l4bG2ow1DwmRRQ%3D","badge":null},{"rank":39,"title":"伊朗革命卫队逮捕一名间谍","desc":null,"value":"16.6万","link":"https://www.toutiao.com/trending/7703274963986186259","cover":"https://p3-sign.toutiaoimg.com/mosaic-legacy/2b29000036f8405561443~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=8KBgmXb74tIyC%2BVdtVE0xmebil4%3D","badge":null},{"rank":40,"title":"2027年春节有望连休9天","desc":null,"value":"15万","link":"https://www.toutiao.com/trending/7703001068950635046","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/8a2ce17b756e47fda62e24bdab47fd9b~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=RQXIu6Vcv9rbrvG4%2BUgu8xbgLY4%3D","badge":null},{"rank":41,"title":"绿军官方晒塔图姆32+4+7数据海报","desc":null,"value":"13.6万","link":"https://www.toutiao.com/trending/7703343259778712091","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/0f39fab732d04d79bf13cc93e63864bf~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=WqxvppwaXKUEpII4ivol4gNTMd0%3D","badge":null},{"rank":42,"title":"美国中期选举最后冲刺","desc":null,"value":"12.3万","link":"https://www.toutiao.com/trending/7703227127780347411","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/f680b04c826842e5b77a9bf718d04a97~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=3UwyJyDjt7UHuO2Z0ttuvfXx8Po%3D","badge":null},{"rank":43,"title":"基金经理：短期波动不改长期基本面","desc":null,"value":"11.1万","link":"https://www.toutiao.com/trending/7703094708356186162","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/cdce3714dc6a476cbfa271e9811cfab5~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=4F0ItJ%2F5khPI79h9UbKhR987aVY%3D","badge":null},{"rank":44,"title":"郑丽文出席活动力挺四县市长候选人","desc":null,"value":"10.1万","link":"https://www.toutiao.com/trending/7702765356338741798","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/e51bdf70dd6743dc8d8819da8d58e8a8~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=zvr3oMmOk0CMmy2JvQm1sKDVi9A%3D","badge":null},{"rank":45,"title":"压路机倒车碾压后车致1死 当地调查","desc":null,"value":"9.1万","link":"https://www.toutiao.com/trending/7703354065387785764","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/22d0a0acb72a4d64a7d81962ce782fb4~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=trQuvmhykTL8iknScHP7pRs%2F7O0%3D","badge":null},{"rank":46,"title":"保险公司追涨科技股换来3500亿浮亏","desc":null,"value":"8.2万","link":"https://www.toutiao.com/trending/7703214598127619647","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/b6e40c2c777d475796971614aceab614~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=ah425Vx5jxlPnvdRTi88lFRrnWM%3D","badge":null},{"rank":47,"title":"谢龙介竞选总部成立 蓝白大咖相挺","desc":null,"value":"7.4万","link":"https://www.toutiao.com/trending/7703171147618124298","cover":"https://p3-sign.toutiaoimg.com/mosaic-legacy/2b29000036f8405561443~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=8KBgmXb74tIyC%2BVdtVE0xmebil4%3D","badge":null},{"rank":48,"title":"一条红色预警 9名公职人员被查","desc":null,"value":"6.7万","link":"https://www.toutiao.com/trending/7703029264865772041","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/a50b0156-febd-4180-9010-fb66b91ccc6d~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=PCAyR4OyQgJXf6ryVb03jbf%2FzEM%3D","badge":null},{"rank":49,"title":"网红九哥余杰肝癌离世","desc":null,"value":"6.1万","link":"https://www.toutiao.com/trending/7702366255071772691","cover":"https://p3-sign.toutiaoimg.com/top-static-files-outer/breaknews/8b8902c0-9e69-425d-8d77-80dc652fbad9~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=gHnoY6QTPkIC1njN0K9XdVJAXaI%3D","badge":null},{"rank":50,"title":"曝Meta与中国机器人公司合作","desc":null,"value":"5.5万","link":"https://www.toutiao.com/trending/7703259358624222770","cover":"https://p3-sign.toutiaoimg.com/tos-cn-i-qvj2lq49k0/ce5ef8eb576a4b298f2910bfbe8ab97a~tplv-tt-shrink:960:540.jpeg?_iz=30575&from=sign_default&lk3s=8d617dac&x-expires=1796169600&x-signature=q1%2BVY%2FPOvzLiJDiML05%2F4tIriAo%3D","badge":null}],"total":50}',17068,17351,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('baidu-hot','/v2/baidu/hot','百度热搜','百度实时热搜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"美飞机坠毁9人遇难 地面被撞出大坑","desc":"当地时间1日，美国佛罗里达州棕榈滩县一处居民区发生坠机。一架载有9人的公务机从得克萨斯州起飞后，以超380km/h速度俯冲坠毁，机上9人全部遇难。美国联邦航空局…","value":"780.79w","link":"https://www.baidu.com/s?wd=%E7%BE%8E%E9%A3%9E%E6%9C%BA%E5%9D%A0%E6%AF%819%E4%BA%BA%E9%81%87%E9%9A%BE+%E5%9C%B0%E9%9D%A2%E8%A2%AB%E6%92%9E%E5%87%BA%E5%A4%A7%E5%9D%91&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/934204cccd971c229eb1c34dddee723f","badge":null},{"rank":2,"title":"全球资产遭遇洗盘","desc":"全球大类资产迎来一轮罕见的“流动性洗盘”。10月最后一个交易日，美股科技股恐慌大跌，机构补保证金抛售贵金属资产，叠加美联储加息预期升温，现货黄金失守3900美元…","value":"771.29w","link":"https://www.baidu.com/s?wd=%E5%85%A8%E7%90%83%E8%B5%84%E4%BA%A7%E9%81%AD%E9%81%87%E6%B4%97%E7%9B%98&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/76503173394c749845c88ed7746772c1","badge":null},{"rank":3,"title":"从“看热闹”到“看门道”","desc":"带着AI（人工智能）助手逛博物馆，遇到不懂的内容随时提问；提前数日预约专业讲解，为一场文博研学甘愿彻夜排队……当下，文博热潮正在悄然迭代：人们不再步履匆匆、“到…","value":"761.62w","link":"https://www.baidu.com/s?wd=%E4%BB%8E%E2%80%9C%E7%9C%8B%E7%83%AD%E9%97%B9%E2%80%9D%E5%88%B0%E2%80%9C%E7%9C%8B%E9%97%A8%E9%81%93%E2%80%9D&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/23498e790ec72673a3e3ee478372308e","badge":null},{"rank":4,"title":"电诈团伙已转移到非洲","desc":"近日，马达加斯加捣毁13个由中国公民营运的电诈园区，目前已有148名涉案中国公民被引渡回中国。此前，受东南亚执法行动影响，犯罪组织将业务从柬埔寨转移至当地。","value":"752.35w","link":"https://www.baidu.com/s?wd=%E7%94%B5%E8%AF%88%E5%9B%A2%E4%BC%99%E5%B7%B2%E8%BD%AC%E7%A7%BB%E5%88%B0%E9%9D%9E%E6%B4%B2&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/cfd8f4c0c2cac78d0745674fcfd0f36f","badge":null},{"rank":5,"title":"孙颖莎回应夺冠","desc":"在2026年WTT蒙彼利埃冠军赛女单决赛中，孙颖莎4-1战胜蒯曼夺得冠军。此前，她因伤病及身体原因近3个月状态起伏。孙颖莎赛后表示，此次在法国夺冠意义不同，不仅…","value":"742.84w","link":"https://www.baidu.com/s?wd=%E5%AD%99%E9%A2%96%E8%8E%8E%E5%9B%9E%E5%BA%94%E5%A4%BA%E5%86%A0&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/b8b56b55965721a3db3bb945347f6e31","badge":"新"},{"rank":6,"title":"“中国最冷小镇”降至-28℃","desc":"11月1日，受寒潮影响，有“中国最冷小镇”之称的大兴安岭呼中区最低气温降至-28℃。呼玛河两岸迎来唯美雾凇景观。","value":"733.09w","link":"https://www.baidu.com/s?wd=%E2%80%9C%E4%B8%AD%E5%9B%BD%E6%9C%80%E5%86%B7%E5%B0%8F%E9%95%87%E2%80%9D%E9%99%8D%E8%87%B3-28%E2%84%83&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/53c7a9a51308b1c8198733353bf6fb1e","badge":"新"},{"rank":7,"title":"A股迎利好！金融监管部门将开座谈会","desc":"11月2日上午9时左右，中国人民银行、中国证监会将召开会议，研究推动支持资本市场工具使用。在业内看来，近期A股市场持续下跌之下，上述会议的召开将给市场带来积极信…","value":"723.56w","link":"https://www.baidu.com/s?wd=A%E8%82%A1%E8%BF%8E%E5%88%A9%E5%A5%BD%EF%BC%81%E9%87%91%E8%9E%8D%E7%9B%91%E7%AE%A1%E9%83%A8%E9%97%A8%E5%B0%86%E5%BC%80%E5%BA%A7%E8%B0%88%E4%BC%9A&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/1cfb9900fb066dc44d7061f15c25cc14","badge":null},{"rank":8,"title":"女子买2套房打通后喜提环形跑道","desc":"日前，广东一女子买下同一楼层两套房子，打通之后才发现一个“缺点”：家里多出环形跑道，时不时和孩子在家上演百米追逐赛。","value":"713.64w","link":"https://www.baidu.com/s?wd=%E5%A5%B3%E5%AD%90%E4%B9%B02%E5%A5%97%E6%88%BF%E6%89%93%E9%80%9A%E5%90%8E%E5%96%9C%E6%8F%90%E7%8E%AF%E5%BD%A2%E8%B7%91%E9%81%93&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/4694d87b24f76acecfe844db3e0e8bca","badge":null},{"rank":9,"title":"张禹珍1-3落后翻盘拿下冠军赛首冠","desc":"11月2日凌晨，WTT蒙彼利埃冠军赛男单决赛，张禹珍1-3落后连扳三局，4-3逆转弗朗西斯卡夺冠，个人首获WTT冠军赛男单冠军，韩国选手首次登顶。","value":"704.24w","link":"https://www.baidu.com/s?wd=%E5%BC%A0%E7%A6%B9%E7%8F%8D1-3%E8%90%BD%E5%90%8E%E7%BF%BB%E7%9B%98%E6%8B%BF%E4%B8%8B%E5%86%A0%E5%86%9B%E8%B5%9B%E9%A6%96%E5%86%A0&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/5f018d5cc3285cb4bf82fb71bc758787","badge":null},{"rank":10,"title":"梁家辉获“世界杰出华人奖”","desc":"近日，梁家辉获“世界杰出华人奖”。他表示该奖是对自己的鼓励，受胡枫致辞中“永不言退”启发，他还宣布下一个目标是世界杰出华人终身成就奖，承诺一定会做到最好。","value":"695.28w","link":"https://www.baidu.com/s?wd=%E6%A2%81%E5%AE%B6%E8%BE%89%E8%8E%B7%E2%80%9C%E4%B8%96%E7%95%8C%E6%9D%B0%E5%87%BA%E5%8D%8E%E4%BA%BA%E5%A5%96%E2%80%9D&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/1d74b0233276dc547af784005197f98a","badge":null},{"rank":11,"title":"乌鲁木齐辟谣“禁售马肉马肠制品”","desc":"近日，针对网传“乌鲁木齐马肉马肠全面禁售”视频，乌鲁木齐市委网信办联合市食安办查证辟谣，确认该信息系谣言，提醒公众切勿信谣传谣。","value":"685.17w","link":"https://www.baidu.com/s?wd=%E4%B9%8C%E9%B2%81%E6%9C%A8%E9%BD%90%E8%BE%9F%E8%B0%A3%E2%80%9C%E7%A6%81%E5%94%AE%E9%A9%AC%E8%82%89%E9%A9%AC%E8%82%A0%E5%88%B6%E5%93%81%E2%80%9D&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/2df9a30677cb8441d8ad72404d1fc25d","badge":null},{"rank":12,"title":"自建房厨卫一体 看房人直呼难接受","desc":"11月1日，广东中山市民廖先生反映，有客户实地看房时发现，一套约20平方米的自建房格局特殊，厨房与卫生间连通在一起。该格局让看房人十分意外且难以接受。据悉该房源…","value":"676.14w","link":"https://www.baidu.com/s?wd=%E8%87%AA%E5%BB%BA%E6%88%BF%E5%8E%A8%E5%8D%AB%E4%B8%80%E4%BD%93+%E7%9C%8B%E6%88%BF%E4%BA%BA%E7%9B%B4%E5%91%BC%E9%9A%BE%E6%8E%A5%E5%8F%97&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/eefbc550081b41ba1df14a86b925474b","badge":"新"},{"rank":13,"title":"多个地方行业协会宣布自行解散","desc":"近日，民政部办公厅印发《社会组织注销指引》，规范社会组织注销程序。近期，因部分会员失联、达不到开会人数要求，安徽固镇县、浙江金华市等多地行业协会相继宣布自行解散…","value":"666.35w","link":"https://www.baidu.com/s?wd=%E5%A4%9A%E4%B8%AA%E5%9C%B0%E6%96%B9%E8%A1%8C%E4%B8%9A%E5%8D%8F%E4%BC%9A%E5%AE%A3%E5%B8%83%E8%87%AA%E8%A1%8C%E8%A7%A3%E6%95%A3&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/c84d20a1086c3d572a5e844fb102475e","badge":null},{"rank":14,"title":"老人被困电梯遭物业辱骂 随后猝死","desc":"2024年，六旬老人李某被困电梯约9分钟，脱困后与物业人员发生争吵，遭对方辱骂“老棺材早点死去”等。随后老人在棋牌室倒下，物业人员有急救证却未施救，老人经抢救无…","value":"657.08w","link":"https://www.baidu.com/s?wd=%E8%80%81%E4%BA%BA%E8%A2%AB%E5%9B%B0%E7%94%B5%E6%A2%AF%E9%81%AD%E7%89%A9%E4%B8%9A%E8%BE%B1%E9%AA%82+%E9%9A%8F%E5%90%8E%E7%8C%9D%E6%AD%BB&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/c84d20a1086c3d572a5e844fb102475e","badge":null},{"rank":15,"title":"246万买邮轮永居权2年后被要求离船","desc":"当地时间10月27日，身患癌症的美国男子兰迪及其妻子被限时7小时内离开停泊在柬埔寨西哈努克港的“奥德赛”号邮轮。此前，两人花约246万元买下该邮轮终身居住权并卖…","value":"646.28w","link":"https://www.baidu.com/s?wd=246%E4%B8%87%E4%B9%B0%E9%82%AE%E8%BD%AE%E6%B0%B8%E5%B1%85%E6%9D%832%E5%B9%B4%E5%90%8E%E8%A2%AB%E8%A6%81%E6%B1%82%E7%A6%BB%E8%88%B9&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/2cd314199a127a8fde3cdbc0c463a2f9","badge":null},{"rank":16,"title":"拐弯指路牌火了 网友建议全国推广","desc":"近日，南京地铁南京南站焕新的“拐弯”指路牌火了。不同于传统笔直的箭头，新版指示牌直接画出转向路径，旅客一眼就能看懂，前方需要转弯、下楼梯。有网友发帖热评：“箭头…","value":"637.64w","link":"https://www.baidu.com/s?wd=%E6%8B%90%E5%BC%AF%E6%8C%87%E8%B7%AF%E7%89%8C%E7%81%AB%E4%BA%86+%E7%BD%91%E5%8F%8B%E5%BB%BA%E8%AE%AE%E5%85%A8%E5%9B%BD%E6%8E%A8%E5%B9%BF&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/c966f59b785597af1fd5e3cb8d23d75d","badge":null},{"rank":17,"title":"中国“00后”球手爆冷淘汰特鲁姆普","desc":"2026世界斯诺克巡回赛国际锦标赛11月1日在江苏南京结束首轮较量，中国“00后”球手范争一爆冷以6∶5淘汰名将特鲁姆普，晋级32强。","value":"628.75w","link":"https://www.baidu.com/s?wd=%E4%B8%AD%E5%9B%BD%E2%80%9C00%E5%90%8E%E2%80%9D%E7%90%83%E6%89%8B%E7%88%86%E5%86%B7%E6%B7%98%E6%B1%B0%E7%89%B9%E9%B2%81%E5%A7%86%E6%99%AE&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/275038c35e5b9f594c7826399a1aa6e2","badge":"新"},{"rank":18,"title":"刘亦菲婚纱造型好像新娘子","desc":"11月1日晚，在W盛典红毯上，刘亦菲压轴亮相。她身穿白色定制礼服，佩戴白头纱与白手套，手拿百合捧花宛如新娘。","value":"618.4w","link":"https://www.baidu.com/s?wd=%E5%88%98%E4%BA%A6%E8%8F%B2%E5%A9%9A%E7%BA%B1%E9%80%A0%E5%9E%8B%E5%A5%BD%E5%83%8F%E6%96%B0%E5%A8%98%E5%AD%90&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/9a243ec7875043c3792bd84d1927ced0","badge":"热"},{"rank":19,"title":"第一场雪给大鹅都冻劈叉了","desc":"10月28日，黑龙江第一场雪给大鹅都冻劈叉了，一屁股坐下更是冻脚又冻腚，网友：给它进锅里热乎热乎。","value":"609.08w","link":"https://www.baidu.com/s?wd=%E7%AC%AC%E4%B8%80%E5%9C%BA%E9%9B%AA%E7%BB%99%E5%A4%A7%E9%B9%85%E9%83%BD%E5%86%BB%E5%8A%88%E5%8F%89%E4%BA%86&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/7ccbc68242ae25c6301125578442b2bb","badge":"新"},{"rank":20,"title":"评论员：中国要在黄岩岛关门了","desc":"近日，解放军南部战区与海警在黄岩岛展开战备警巡与执法巡查，作为对菲方挑衅的必要反制。刘和平解读称，中国要在黄岩岛关门了，从此以后对于菲律宾来说，黄岩岛将会是一个…","value":"600.23w","link":"https://www.baidu.com/s?wd=%E8%AF%84%E8%AE%BA%E5%91%98%EF%BC%9A%E4%B8%AD%E5%9B%BD%E8%A6%81%E5%9C%A8%E9%BB%84%E5%B2%A9%E5%B2%9B%E5%85%B3%E9%97%A8%E4%BA%86&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/f633a72cbc015ab4df0528878f646765","badge":null},{"rank":21,"title":"男子不雅视频被群发 不堪受辱割腕","desc":"辽宁葫芦岛一男子遭诱骗裸聊被勒索，拒绝再付12万元后，不雅视频被群发多个群组，不堪受辱割腕自杀，经抢救脱险；警方打掉该团伙，累计作案数十起，涉案近百万。","value":"590.42w","link":"https://www.baidu.com/s?wd=%E7%94%B7%E5%AD%90%E4%B8%8D%E9%9B%85%E8%A7%86%E9%A2%91%E8%A2%AB%E7%BE%A4%E5%8F%91+%E4%B8%8D%E5%A0%AA%E5%8F%97%E8%BE%B1%E5%89%B2%E8%85%95&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/225de128e1a9931612359f85b3b72b16","badge":"新"},{"rank":22,"title":"成人感染幽门螺杆菌很难自愈","desc":"针对“幽门螺杆菌感染能自愈”的说法，专家辟谣称该观点错误。专家指出，幽门螺杆菌生存力强，成人感染后自愈可能性极小，有症状或基础疾病者需积极查杀。","value":"580.61w","link":"https://www.baidu.com/s?wd=%E6%88%90%E4%BA%BA%E6%84%9F%E6%9F%93%E5%B9%BD%E9%97%A8%E8%9E%BA%E6%9D%86%E8%8F%8C%E5%BE%88%E9%9A%BE%E8%87%AA%E6%84%88&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/ad52f4bbda59948b78ec48cf472c3d9f","badge":null},{"rank":23,"title":"多名日本人聚会时使用纳粹标志","desc":"10月31日，多名日本人在聚会场所使用纳粹标志，遭到全球网友强烈批评。网友斥责他们无知，认为其对二战罪行缺乏悔意，这类行为绝不能容忍。","value":"571.22w","link":"https://www.baidu.com/s?wd=%E5%A4%9A%E5%90%8D%E6%97%A5%E6%9C%AC%E4%BA%BA%E8%81%9A%E4%BC%9A%E6%97%B6%E4%BD%BF%E7%94%A8%E7%BA%B3%E7%B2%B9%E6%A0%87%E5%BF%97&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/a2449fd1edd90a55145098f91a5bdf2a","badge":null},{"rank":24,"title":"伊朗抛出“两天计划”","desc":"当地时间11月1日，卡塔尔调解方连续第三天与伊朗谈判代表举行会谈，以期促成美伊达成协议。伊朗外长透露，伊朗已同意一项“两天计划”：第一天美国采取履约措施，第二天…","value":"560.53w","link":"https://www.baidu.com/s?wd=%E4%BC%8A%E6%9C%97%E6%8A%9B%E5%87%BA%E2%80%9C%E4%B8%A4%E5%A4%A9%E8%AE%A1%E5%88%92%E2%80%9D&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/a079582cb9b7dd48d4cb32b84a2f9589","badge":null},{"rank":25,"title":"沈阳保洁大叔和副市长同框看球","desc":"10月31日，沈阳保洁大叔陈景福与沈阳市副市长刘克斌同框为辽超沈阳主场助威。大叔因高颜值被夸为“保洁界的顶流”，现场人气爆棚引来众多球迷合影。","value":"550.57w","link":"https://www.baidu.com/s?wd=%E6%B2%88%E9%98%B3%E4%BF%9D%E6%B4%81%E5%A4%A7%E5%8F%94%E5%92%8C%E5%89%AF%E5%B8%82%E9%95%BF%E5%90%8C%E6%A1%86%E7%9C%8B%E7%90%83&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/bea64099601ffda25ea76b0061346ae6","badge":null},{"rank":26,"title":"休息日爬山5小时未回工作消息遭辞退","desc":"10月17日，南京一保研助教休息日爬山5小时未回工作消息被问责，公司还要求休息日每3小时看一次手机；10月25日其遭解除合同，现已申请劳动仲裁。","value":"542.7w","link":"https://www.baidu.com/s?wd=%E4%BC%91%E6%81%AF%E6%97%A5%E7%88%AC%E5%B1%B15%E5%B0%8F%E6%97%B6%E6%9C%AA%E5%9B%9E%E5%B7%A5%E4%BD%9C%E6%B6%88%E6%81%AF%E9%81%AD%E8%BE%9E%E9%80%80&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/751239e6eb06eb7279cc0340db8bc4ff","badge":"新"},{"rank":27,"title":"压路机倒车压到后方车辆致1人身亡","desc":"近日，西宁一段压路机倒车时压到后方车辆的视频引发关注。附近商户称事发10月28日，当时正在修路，被碾压车辆驾驶员已身亡。据悉，事故原因正在调查中。","value":"532.79w","link":"https://www.baidu.com/s?wd=%E5%8E%8B%E8%B7%AF%E6%9C%BA%E5%80%92%E8%BD%A6%E5%8E%8B%E5%88%B0%E5%90%8E%E6%96%B9%E8%BD%A6%E8%BE%86%E8%87%B41%E4%BA%BA%E8%BA%AB%E4%BA%A1&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/031eef7c213bcf3eabcea0326e4e63ae","badge":null},{"rank":28,"title":"大衣哥被举报风波后首场线下演出","desc":"11月1日，大衣哥朱之文现身北京金山岭参加公益演出。此前他遭遇网暴举报风波，此次系其11月首场演出。大衣哥透露目前精力全放在维权上，网暴问题警方已受理，后续二十…","value":"521.65w","link":"https://www.baidu.com/s?wd=%E5%A4%A7%E8%A1%A3%E5%93%A5%E8%A2%AB%E4%B8%BE%E6%8A%A5%E9%A3%8E%E6%B3%A2%E5%90%8E%E9%A6%96%E5%9C%BA%E7%BA%BF%E4%B8%8B%E6%BC%94%E5%87%BA&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/22f27174d650720aa167f100710118b9","badge":"热"},{"rank":29,"title":"默茨亚洲行碰了钉子 走得灰溜溜的","desc":"近日，德国总理默茨上任后的首次亚洲之行灰溜溜地结束了，其试图拉拢日韩打造所谓“志同道合国家全球自由贸易联盟”计划碰壁。且因日韩对欧盟拟议《工业加速器法案》政策表…","value":"512.43w","link":"https://www.baidu.com/s?wd=%E9%BB%98%E8%8C%A8%E4%BA%9A%E6%B4%B2%E8%A1%8C%E7%A2%B0%E4%BA%86%E9%92%89%E5%AD%90+%E8%B5%B0%E5%BE%97%E7%81%B0%E6%BA%9C%E6%BA%9C%E7%9A%84&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/e17666249ec5aeac870c5c52fa9a560b","badge":null},{"rank":30,"title":"33克金项链被老鼠偷走筑巢","desc":null,"value":"504.12w","link":"https://www.baidu.com/s?wd=33%E5%85%8B%E9%87%91%E9%A1%B9%E9%93%BE%E8%A2%AB%E8%80%81%E9%BC%A0%E5%81%B7%E8%B5%B0%E7%AD%91%E5%B7%A2&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-1.cdn.bcebos.com/fyb/de6163834f53ca92c1273fff98ac9078.jpeg","badge":null},{"rank":31,"title":"为什么烧得越厉害人越冷","desc":"发烧时体温升高却觉得冷，是因为大脑认为身体还不够热。病原体入侵时，免疫系统发出警报，让大脑将体温调节目标提高，以增强免疫细胞活性并抑制病原体繁殖。","value":"495.03w","link":"https://www.baidu.com/s?wd=%E4%B8%BA%E4%BB%80%E4%B9%88%E7%83%A7%E5%BE%97%E8%B6%8A%E5%8E%89%E5%AE%B3%E4%BA%BA%E8%B6%8A%E5%86%B7&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/cfe655a606dfdcdae34a00f219b951ee","badge":"新"},{"rank":32,"title":"武汉4名饭托诈骗团伙成员获刑","desc":null,"value":"485.47w","link":"https://www.baidu.com/s?wd=%E6%AD%A6%E6%B1%894%E5%90%8D%E9%A5%AD%E6%89%98%E8%AF%88%E9%AA%97%E5%9B%A2%E4%BC%99%E6%88%90%E5%91%98%E8%8E%B7%E5%88%91&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-1.cdn.bcebos.com/fyb/de6163834f53ca92c1273fff98ac9078.jpeg","badge":null},{"rank":33,"title":"被赞国泰民安脸 颁奖礼仪小姐回应","desc":"近日，在2026苏超决赛走红的颁奖礼仪小姐杨阳回应称，自己今年22岁刚大学毕业，曾因脸圆有容貌焦虑，网友鼓励缓解了她的焦虑。此前她在颁奖时因长相端庄大气被网友赞…","value":"475.24w","link":"https://www.baidu.com/s?wd=%E8%A2%AB%E8%B5%9E%E5%9B%BD%E6%B3%B0%E6%B0%91%E5%AE%89%E8%84%B8+%E9%A2%81%E5%A5%96%E7%A4%BC%E4%BB%AA%E5%B0%8F%E5%A7%90%E5%9B%9E%E5%BA%94&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/d81cb116e72c703e0d3ab9dff157ddd3","badge":"新"},{"rank":34,"title":"美民主党议员公开支持共和党候选人","desc":"据美国方面当地时间11月1日消息，美国密歇根州民主党联邦众议员海莉·史蒂文斯当天宣布，支持共和党联邦参议员候选人迈克·罗杰斯。","value":"466.74w","link":"https://www.baidu.com/s?wd=%E7%BE%8E%E6%B0%91%E4%B8%BB%E5%85%9A%E8%AE%AE%E5%91%98%E5%85%AC%E5%BC%80%E6%94%AF%E6%8C%81%E5%85%B1%E5%92%8C%E5%85%9A%E5%80%99%E9%80%89%E4%BA%BA&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/e8d2897dec90688f539200749559397d","badge":"新"},{"rank":35,"title":"男子留言交代家中财物后失联","desc":"11月1日，56岁男子陈华之子向媒体发来求助。10月24日清晨，陈华在微信留言交代家中财物后，未带手机独自前往化凤山。监控显示其穿西装提公文包进山后未现下山影像…","value":"457.15w","link":"https://www.baidu.com/s?wd=%E7%94%B7%E5%AD%90%E7%95%99%E8%A8%80%E4%BA%A4%E4%BB%A3%E5%AE%B6%E4%B8%AD%E8%B4%A2%E7%89%A9%E5%90%8E%E5%A4%B1%E8%81%94&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/012b9b5a8bdf3a426b307e6e60d16dca","badge":null},{"rank":36,"title":"U17女足世界杯中国队1比2不敌巴西","desc":"北京时间11月2日凌晨，U17女足世界杯1/4决赛，中国U17女足1比2不敌巴西U17女足，无缘四强。","value":"446.13w","link":"https://www.baidu.com/s?wd=U17%E5%A5%B3%E8%B6%B3%E4%B8%96%E7%95%8C%E6%9D%AF%E4%B8%AD%E5%9B%BD%E9%98%9F1%E6%AF%942%E4%B8%8D%E6%95%8C%E5%B7%B4%E8%A5%BF&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/554d7cad691c46a4872d93e4b29ab9ca","badge":null},{"rank":37,"title":"早期肾癌患者超半数是体检发现","desc":null,"value":"435.52w","link":"https://www.baidu.com/s?wd=%E6%97%A9%E6%9C%9F%E8%82%BE%E7%99%8C%E6%82%A3%E8%80%85%E8%B6%85%E5%8D%8A%E6%95%B0%E6%98%AF%E4%BD%93%E6%A3%80%E5%8F%91%E7%8E%B0&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-1.cdn.bcebos.com/fyb/de6163834f53ca92c1273fff98ac9078.jpeg","badge":null},{"rank":38,"title":"把地球冷冻一下 温室效应会缓解吗","desc":"冷冻地球能否缓解温室效应？答案是：不会。二氧化碳激增让地球的保温“棉衣”越来越厚，而气候变暖使海洋释放更多二氧化碳，正反馈持续加剧升温。","value":"425.48w","link":"https://www.baidu.com/s?wd=%E6%8A%8A%E5%9C%B0%E7%90%83%E5%86%B7%E5%86%BB%E4%B8%80%E4%B8%8B+%E6%B8%A9%E5%AE%A4%E6%95%88%E5%BA%94%E4%BC%9A%E7%BC%93%E8%A7%A3%E5%90%97&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/1e5d2337e28dd664031db6e8e6537ee4","badge":null},{"rank":39,"title":"爱喝茶的人赚了","desc":"2026年10月，《内科杂志》发表一项针对48万国人的研究证实，每周至少3天经常喝茶的人群，心血管疾病发病风险下降11%。","value":"417.77w","link":"https://www.baidu.com/s?wd=%E7%88%B1%E5%96%9D%E8%8C%B6%E7%9A%84%E4%BA%BA%E8%B5%9A%E4%BA%86&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/bbd046b19a8af491d0038ec5c1bfe55e","badge":null},{"rank":40,"title":"孙颖莎4比1蒯曼 获得女单冠军","desc":"北京时间11月2日凌晨，2026WTT蒙彼利埃冠军赛女单决赛，孙颖莎4比1战胜蒯曼，获得女单冠军，五局比分为8-11、11-7、11-3、11-9、11-6。","value":"409.06w","link":"https://www.baidu.com/s?wd=%E5%AD%99%E9%A2%96%E8%8E%8E4%E6%AF%941%E8%92%AF%E6%9B%BC+%E8%8E%B7%E5%BE%97%E5%A5%B3%E5%8D%95%E5%86%A0%E5%86%9B&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/2d99498ec68d53ccbbd9217a5bc05491","badge":null},{"rank":41,"title":"皇马客场3比0桑坦德竞技","desc":"北京时间11月1日，西甲第11轮皇家马德里客场3比0战胜桑坦德竞技。此前第10轮结束时，巴塞罗那领先皇马4到5分。此役过后，皇马积分追至仅差榜首巴萨3分，争冠悬…","value":"399.46w","link":"https://www.baidu.com/s?wd=%E7%9A%87%E9%A9%AC%E5%AE%A2%E5%9C%BA3%E6%AF%940%E6%A1%91%E5%9D%A6%E5%BE%B7%E7%AB%9E%E6%8A%80&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/d422ff8e5f7e56e88f0032d934cc0fae","badge":null},{"rank":42,"title":"方便面是痛风的“隐形杀手”吗","desc":null,"value":"387.9w","link":"https://www.baidu.com/s?wd=%E6%96%B9%E4%BE%BF%E9%9D%A2%E6%98%AF%E7%97%9B%E9%A3%8E%E7%9A%84%E2%80%9C%E9%9A%90%E5%BD%A2%E6%9D%80%E6%89%8B%E2%80%9D%E5%90%97&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-1.cdn.bcebos.com/fyb/de6163834f53ca92c1273fff98ac9078.jpeg","badge":null},{"rank":43,"title":"井迪在高铁上跟吵闹乘客“干架”","desc":"11月1日，歌手井迪在高铁上因邻座乘客持续大声打电话，先后两次请乘务员劝阻无效后，忍了一个多小时情绪崩溃，最终当面质问并在周围乘客声援下平息了这场闹剧。","value":"378.31w","link":"https://www.baidu.com/s?wd=%E4%BA%95%E8%BF%AA%E5%9C%A8%E9%AB%98%E9%93%81%E4%B8%8A%E8%B7%9F%E5%90%B5%E9%97%B9%E4%B9%98%E5%AE%A2%E2%80%9C%E5%B9%B2%E6%9E%B6%E2%80%9D&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/3c49e1027d8ffd8438b19574fc606481","badge":null},{"rank":44,"title":"8岁男孩走失画2火柴人找爸妈","desc":null,"value":"369.12w","link":"https://www.baidu.com/s?wd=8%E5%B2%81%E7%94%B7%E5%AD%A9%E8%B5%B0%E5%A4%B1%E7%94%BB2%E7%81%AB%E6%9F%B4%E4%BA%BA%E6%89%BE%E7%88%B8%E5%A6%88&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-1.cdn.bcebos.com/fyb/de6163834f53ca92c1273fff98ac9078.jpeg","badge":null},{"rank":45,"title":"青岛调查熏硫白芷相关问题","desc":"近日，总台《每周质量报告》曝光青岛抚顺路批发市场2家商家涉嫌销售熏硫白芷。11月1日，青岛市市场监管局通报，经查涉案2家商家承认曾销售熏硫白芷，执法人员已查封扣…","value":"362.25w","link":"https://www.baidu.com/s?wd=%E9%9D%92%E5%B2%9B%E8%B0%83%E6%9F%A5%E7%86%8F%E7%A1%AB%E7%99%BD%E8%8A%B7%E7%9B%B8%E5%85%B3%E9%97%AE%E9%A2%98&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/9387c3d626872ae9498b60f018fc9545","badge":null},{"rank":46,"title":"周华健要当爷爷了","desc":"近日，周华健在济南演唱会上官宣“我要当爷爷了”，并将歌曲《亲亲我的宝贝》改名为《亲亲我的孙儿宝贝》。","value":"352.51w","link":"https://www.baidu.com/s?wd=%E5%91%A8%E5%8D%8E%E5%81%A5%E8%A6%81%E5%BD%93%E7%88%B7%E7%88%B7%E4%BA%86&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/4f409d94f880d663f5adab9270b18907","badge":"热"},{"rank":47,"title":"中使馆：听蝲蝲蛄叫还不种庄稼了？","desc":"11月1日，针对美国驻巴拿马大使再次攻击中国、造谣抹黑中巴关系，中国驻巴拿马使馆发声明驳斥：美方言论是颠倒黑白的恶意抹黑，真正破坏地区秩序的是美国霸权行径。听蝲…","value":"338.98w","link":"https://www.baidu.com/s?wd=%E4%B8%AD%E4%BD%BF%E9%A6%86%EF%BC%9A%E5%90%AC%E8%9D%B2%E8%9D%B2%E8%9B%84%E5%8F%AB%E8%BF%98%E4%B8%8D%E7%A7%8D%E5%BA%84%E7%A8%BC%E4%BA%86%EF%BC%9F&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/23498e790ec72673a3e3ee478372308e","badge":null},{"rank":48,"title":"吃火锅未点鸭血锅底现鸭血残渣","desc":"10月31日‌，‌四川遂宁‌一顾客在‌火锅店‌就餐‌未点鸭血‌，却在锅底发现‌鸭血残渣‌。顾客‌未付款‌并‌报警‌，店家已‌道歉‌并‌配合调查‌。‌‌","value":"331.29w","link":"https://www.baidu.com/s?wd=%E5%90%83%E7%81%AB%E9%94%85%E6%9C%AA%E7%82%B9%E9%B8%AD%E8%A1%80%E9%94%85%E5%BA%95%E7%8E%B0%E9%B8%AD%E8%A1%80%E6%AE%8B%E6%B8%A3&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/114a9688862ad299349b0f27299328b4","badge":null},{"rank":49,"title":"阿森纳1-0客胜利物浦","desc":"北京时间11月2日凌晨0:30，英超第9轮利物浦在安菲尔德球场0:1不敌阿森纳。上半场赖斯助攻哈弗茨破门致胜，阿森纳凭此取得四连胜，以3分优势独自登顶榜首。","value":"324.09w","link":"https://www.baidu.com/s?wd=%E9%98%BF%E6%A3%AE%E7%BA%B31-0%E5%AE%A2%E8%83%9C%E5%88%A9%E7%89%A9%E6%B5%A6&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/2c407e85757da93e04e6b92040fb3246","badge":null},{"rank":50,"title":"菲律宾前总统杜特尔特放弃出庭","desc":"近日，菲律宾前总统杜特尔特向国际刑事法院提交弃权声明，放弃出席11月2日的第五次状况会议，授权律师代为处理。该案源于杜特尔特任内推行的禁毒战争，其被指控涉嫌反人…","value":"312.88w","link":"https://www.baidu.com/s?wd=%E8%8F%B2%E5%BE%8B%E5%AE%BE%E5%89%8D%E6%80%BB%E7%BB%9F%E6%9D%9C%E7%89%B9%E5%B0%94%E7%89%B9%E6%94%BE%E5%BC%83%E5%87%BA%E5%BA%AD&sa=fyb_news&rsv_dl=fyb_news","cover":"https://fyb-2.cdn.bcebos.com/hotboard_image/17d1d3b48bbfc22f398c64c37cbeb97a","badge":null}],"total":50}',24676,20157,'2026-11-02T00:59:07.464Z',NULL,'2026-11-02T00:59:07.464Z'),
('baidu-tieba','/v2/baidu/tieba','贴吧热议','贴吧热门话题','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"普通人不配?AI巨头嫌内存浪费","desc":"OpenAI CEO奥特曼发暴论：个人电脑内存平均使用率仅5%，属于资源浪费，应把内存集中部署在云端数据中心，提高整体利用率。","value":"239.93w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368792&amp;topic_name=%E6%99%AE%E9%80%9A%E4%BA%BA%E4%B8%8D%E9%85%8D%3FAI%E5%B7%A8%E5%A4%B4%E5%AB%8C%E5%86%85%E5%AD%98%E6%B5%AA%E8%B4%B9","cover":null,"badge":null},{"rank":2,"title":"赛博鱼塘!大肥鱼AI涌入鲸鱼吧","desc":"AI圈兴起养鱼潮，网友训练自家AI刷社区、聊QQ，一群大肥鱼带着对自我身份的好奇游到了鲸鱼吧、大肥鱼吧，吧友点评：好像看到了又一个抓虾吧。","value":"170.66w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368798&amp;topic_name=%E8%B5%9B%E5%8D%9A%E9%B1%BC%E5%A1%98%21%E5%A4%A7%E8%82%A5%E9%B1%BCAI%E6%B6%8C%E5%85%A5%E9%B2%B8%E9%B1%BC%E5%90%A7","cover":null,"badge":null},{"rank":3,"title":"岁月史书?大体老师事件被篡改","desc":"近期有自媒体将“大体老师骨骼写字”事件肇事者改换性别，以漫画、小说形式大肆传播，吧友怒批有心之人搞信息污染、植入性别偏见。","value":"155.69w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368804&amp;topic_name=%E5%B2%81%E6%9C%88%E5%8F%B2%E4%B9%A6%3F%E5%A4%A7%E4%BD%93%E8%80%81%E5%B8%88%E4%BA%8B%E4%BB%B6%E8%A2%AB%E7%AF%A1%E6%94%B9","cover":null,"badge":null},{"rank":4,"title":"网约车误入万圣节人流遭围攻","desc":"2026年武汉万圣节活动，一网约车按导航正常驶入机动车道，被万圣节人流堵住无法移动。期间遭人群扔垃圾、砸挡风玻璃等，司机情绪崩溃。","value":"122.67w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368816&amp;topic_name=%E7%BD%91%E7%BA%A6%E8%BD%A6%E8%AF%AF%E5%85%A5%E4%B8%87%E5%9C%A3%E8%8A%82%E4%BA%BA%E6%B5%81%E9%81%AD%E5%9B%B4%E6%94%BB","cover":null,"badge":null},{"rank":5,"title":"Bin放话取代Zeus做世一上","desc":"S16生死战BLG两局带走HLE，Bin对位赢下Zeus。面对韩媒的采访，Bin豪言已接替其“世一上”的位置，并承诺会拿到冠军。","value":"93.64w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368815&amp;topic_name=Bin%E6%94%BE%E8%AF%9D%E5%8F%96%E4%BB%A3Zeus%E5%81%9A%E4%B8%96%E4%B8%80%E4%B8%8A","cover":null,"badge":null},{"rank":6,"title":"攻防闪一体?影之刃被批轮椅","desc":"UP主仅靠三键连按就通关影之刃零高难度BOSS，按住防御不松手就可无脑通关，玩家争论不休，这战斗系统设计合理不？","value":"88.32w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368813&amp;topic_name=%E6%94%BB%E9%98%B2%E9%97%AA%E4%B8%80%E4%BD%93%3F%E5%BD%B1%E4%B9%8B%E5%88%83%E8%A2%AB%E6%89%B9%E8%BD%AE%E6%A4%85","cover":null,"badge":null},{"rank":7,"title":"Viper哽咽透露母亲患癌","desc":"BLG横扫HLE晋级八强后，Viper赛后采访哽咽透露，母亲正与癌症斗争，希望她看到我比赛的样子后能早日恢复健康。","value":"66.58w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368714&amp;topic_name=Viper%E5%93%BD%E5%92%BD%E9%80%8F%E9%9C%B2%E6%AF%8D%E4%BA%B2%E6%82%A3%E7%99%8C","cover":null,"badge":null},{"rank":8,"title":"BLG首场直面DK,TES八强战IG","desc":"S16八强抽签出炉：BLG首场直面DK，TES与IG上演LPL内战。GEN抽到LYON，T1对阵KC。吧友们如何评价这次抽签？","value":"60.85w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368659&amp;topic_name=BLG%E9%A6%96%E5%9C%BA%E7%9B%B4%E9%9D%A2DK%2CTES%E5%85%AB%E5%BC%BA%E6%88%98IG","cover":null,"badge":null},{"rank":9,"title":"战胜心魔!BLG横扫HLE晋级八强","desc":"BLG在S16瑞士轮生死战以2-0横扫HLE，拿到最后一张八强门票。BLG继MSI之后时隔112天完成复仇，战胜了自己的心魔！","value":"47.92w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368656&amp;topic_name=%E6%88%98%E8%83%9C%E5%BF%83%E9%AD%94%21BLG%E6%A8%AA%E6%89%ABHLE%E6%99%8B%E7%BA%A7%E5%85%AB%E5%BC%BA","cover":null,"badge":null},{"rank":10,"title":"吧友甩Steam数据,影之刃零进前六","desc":"吧友甩出Steam单机游戏在线峰值TOP10：黑神话241万第一，影之刃零77.5万第六，力压丝之歌58.7万和杀戮尖塔2的57.4万。","value":"34.58w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368733&amp;topic_name=%E5%90%A7%E5%8F%8B%E7%94%A9Steam%E6%95%B0%E6%8D%AE%2C%E5%BD%B1%E4%B9%8B%E5%88%83%E9%9B%B6%E8%BF%9B%E5%89%8D%E5%85%AD","cover":null,"badge":null},{"rank":11,"title":"吧友拿十六进制撩AI,回复亮了","desc":"吧友把“我爱你”编成十六进制扔给AI解码，不同的AI给出的回复也大不相同。有直接破译的，有傲娇不回答的，除了豆姐，都是亮点。","value":"27.01w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368713&amp;topic_name=%E5%90%A7%E5%8F%8B%E6%8B%BF%E5%8D%81%E5%85%AD%E8%BF%9B%E5%88%B6%E6%92%A9AI%2C%E5%9B%9E%E5%A4%8D%E4%BA%AE%E4%BA%86","cover":null,"badge":null},{"rank":12,"title":"HLE爆冷不敌BLG,全员遭清算","desc":"S16瑞士轮生死战，BLG两局带走HLE，MSI冠军止步16强，HLE全员拉胯。明星选手离谱操作不断，赛后全员被清算。","value":"26.37w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368690&amp;topic_name=HLE%E7%88%86%E5%86%B7%E4%B8%8D%E6%95%8CBLG%2C%E5%85%A8%E5%91%98%E9%81%AD%E6%B8%85%E7%AE%97","cover":null,"badge":null},{"rank":13,"title":"抗吧好活!S16爆改七龙珠","desc":"吧友脑洞大开，S16世界赛爆改龙珠世界观。BLG首当其冲火拼HLE特战队，魔王飞鲁、孙悟shy堂堂登场！","value":"22.31w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368646&amp;topic_name=%E6%8A%97%E5%90%A7%E5%A5%BD%E6%B4%BB%21S16%E7%88%86%E6%94%B9%E4%B8%83%E9%BE%99%E7%8F%A0","cover":null,"badge":null},{"rank":14,"title":"表情包大赛,16进8生死局","desc":"贴吧第一届表情包大赛16强比赛开始啦，16强1v1开战，你的本命表情包能走多远，就差你一票！","value":"21.26w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368643&amp;topic_name=%E8%A1%A8%E6%83%85%E5%8C%85%E5%A4%A7%E8%B5%9B%2C16%E8%BF%9B8%E7%94%9F%E6%AD%BB%E5%B1%80","cover":null,"badge":null},{"rank":15,"title":"活招牌!炒股平台拿久留美打广告","desc":"久留美的投资女王形象深入人心，被股票交易平台同花顺拿来做宣传广告，吧友刷到直呼地狱。","value":"16.62w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368649&amp;topic_name=%E6%B4%BB%E6%8B%9B%E7%89%8C%21%E7%82%92%E8%82%A1%E5%B9%B3%E5%8F%B0%E6%8B%BF%E4%B9%85%E7%95%99%E7%BE%8E%E6%89%93%E5%B9%BF%E5%91%8A","cover":null,"badge":null},{"rank":16,"title":"爆了!KC与MKOI老板推特对线","desc":"KC与MKOI明日即将上演生死对局，没想到两队老板先在推特上吵起来了。起因是两队约训练赛，结果双方忘考虑时差，都认为是对方爽约。","value":"15.71w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368653&amp;topic_name=%E7%88%86%E4%BA%86%21KC%E4%B8%8EMKOI%E8%80%81%E6%9D%BF%E6%8E%A8%E7%89%B9%E5%AF%B9%E7%BA%BF","cover":null,"badge":null},{"rank":17,"title":"美股AI暴跌,万亿市值蒸发","desc":"美国股市的AI股遭血洗，纳斯达克100单日市值蒸发超1万亿美元。谷歌暴跌12%创上市最大跌幅，英特尔盘后一度跌超20%。","value":"14.75w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368651&amp;topic_name=%E7%BE%8E%E8%82%A1AI%E6%9A%B4%E8%B7%8C%2C%E4%B8%87%E4%BA%BF%E5%B8%82%E5%80%BC%E8%92%B8%E5%8F%91","cover":null,"badge":null},{"rank":18,"title":"六姐妹齐嫁权贵,女频权谋太儿戏","desc":"女频权谋文开局就让人眼前一黑，六姐妹被赐婚，新郎阵容堪称豪华：有皇子、将军、状元、世子，真不怕她们家族势力壮大？","value":"11.84w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368640&amp;topic_name=%E5%85%AD%E5%A7%90%E5%A6%B9%E9%BD%90%E5%AB%81%E6%9D%83%E8%B4%B5%2C%E5%A5%B3%E9%A2%91%E6%9D%83%E8%B0%8B%E5%A4%AA%E5%84%BF%E6%88%8F","cover":null,"badge":null},{"rank":19,"title":"宿命对决!BLG生死局撞上HLE","desc":"瑞士轮最后一轮抽签结果出炉，BLG与HLE在2-2组正面相遇，这场BO3生死战的胜者将会晋级八强，败者则直接淘汰。","value":"10.27w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368618&amp;topic_name=%E5%AE%BF%E5%91%BD%E5%AF%B9%E5%86%B3%21BLG%E7%94%9F%E6%AD%BB%E5%B1%80%E6%92%9E%E4%B8%8AHLE","cover":null,"badge":null},{"rank":20,"title":"医学生辱大体老师仅被处分","desc":"医学生在大体老师骨骼上写字，摆拍取乐，仅被校级处分取消评优，吧友质疑处罚是否太轻。","value":"8.83w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368628&amp;topic_name=%E5%8C%BB%E5%AD%A6%E7%94%9F%E8%BE%B1%E5%A4%A7%E4%BD%93%E8%80%81%E5%B8%88%E4%BB%85%E8%A2%AB%E5%A4%84%E5%88%86","cover":null,"badge":null},{"rank":21,"title":"从A到Z,摇滚吧专辑斗蛐蛐","desc":"摇滚吧专辑一对一大PK！不只有从A到Z首字母比拼，还有红蓝大战，黑白斗法...论战被吧友玩出花。","value":"8.11w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368644&amp;topic_name=%E4%BB%8EA%E5%88%B0Z%2C%E6%91%87%E6%BB%9A%E5%90%A7%E4%B8%93%E8%BE%91%E6%96%97%E8%9B%90%E8%9B%90","cover":null,"badge":null},{"rank":22,"title":"亲妈蹭流量,张雪翻脸拉黑","desc":"张雪机车创始人称已将母亲拉黑，曾要求母亲不接受采访，但她还继续，他表示“鄙视想以我妈为流量入口的机构或人，消耗我的人或事会毫不犹豫砍掉。”","value":"7.23w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368627&amp;topic_name=%E4%BA%B2%E5%A6%88%E8%B9%AD%E6%B5%81%E9%87%8F%2C%E5%BC%A0%E9%9B%AA%E7%BF%BB%E8%84%B8%E6%8B%89%E9%BB%91","cover":null,"badge":null},{"rank":23,"title":"反诈斗士惨死,凶手死缓惹议","desc":"反诈博主“徽剑”遭电诈头目买凶杀害，主犯获死缓。大量网友认为量刑过轻，在法院官号留言为死者抗诉。","value":"7.15w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368631&amp;topic_name=%E5%8F%8D%E8%AF%88%E6%96%97%E5%A3%AB%E6%83%A8%E6%AD%BB%2C%E5%87%B6%E6%89%8B%E6%AD%BB%E7%BC%93%E6%83%B9%E8%AE%AE","cover":null,"badge":null},{"rank":24,"title":"抗吧批瑞士轮赛制:抽签游戏","desc":"抗吧怒喷瑞士轮赛制垃圾：中韩二号种子争破头，欧美队却能保送2个八强，T1也是一路无压力晋级，抽签的影响还是太大了。","value":"6.89w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368632&amp;topic_name=%E6%8A%97%E5%90%A7%E6%89%B9%E7%91%9E%E5%A3%AB%E8%BD%AE%E8%B5%9B%E5%88%B6%3A%E6%8A%BD%E7%AD%BE%E6%B8%B8%E6%88%8F","cover":null,"badge":null},{"rank":25,"title":"卖电脑遇豆包人,吧友笑疯","desc":"吧友海鲜市场卖闲置电脑，买家砍价AI味十足，这是豆包本包？","value":"5.7w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368622&amp;topic_name=%E5%8D%96%E7%94%B5%E8%84%91%E9%81%87%E8%B1%86%E5%8C%85%E4%BA%BA%2C%E5%90%A7%E5%8F%8B%E7%AC%91%E7%96%AF","cover":null,"badge":null},{"rank":26,"title":"国产剧抄韩国文物?小韩倒反天罡","desc":"韩网民指责中国古装剧《嫁金钗》中的香炉抄袭韩国文物“百济香炉”，吧友点评：又来爷爷像孙子那一套。","value":"4.54w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368624&amp;topic_name=%E5%9B%BD%E4%BA%A7%E5%89%A7%E6%8A%84%E9%9F%A9%E5%9B%BD%E6%96%87%E7%89%A9%3F%E5%B0%8F%E9%9F%A9%E5%80%92%E5%8F%8D%E5%A4%A9%E7%BD%A1","cover":null,"badge":null},{"rank":27,"title":"369打瓦悟道,抗吧怒赞Bin严父","desc":"369休赛期苦练无畏契约，半年没打LOL却带队暴打BLG，挺进S16八强。抗吧怒赞369已成为Bin哥最严厉的父亲。","value":"4.32w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368623&amp;topic_name=369%E6%89%93%E7%93%A6%E6%82%9F%E9%81%93%2C%E6%8A%97%E5%90%A7%E6%80%92%E8%B5%9EBin%E4%B8%A5%E7%88%B6","cover":null,"badge":null},{"rank":28,"title":"完美小编被曝夹带私货嘲载物","desc":"完美官方编辑被曝公号私用，在官方APP上给选手ZywOo（载物）设置的预测满分人数是485，狙击手榜排名48。一次是巧合，两次三次呢？","value":"3.72w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368621&amp;topic_name=%E5%AE%8C%E7%BE%8E%E5%B0%8F%E7%BC%96%E8%A2%AB%E6%9B%9D%E5%A4%B9%E5%B8%A6%E7%A7%81%E8%B4%A7%E5%98%B2%E8%BD%BD%E7%89%A9","cover":null,"badge":null},{"rank":29,"title":"16强开打,谁是最靓表情包","desc":"贴吧第一届表情包大赛16强比赛开始啦，16强1v1开战，你的本命表情包能走多远，就差你一票！","value":"2.78w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368582&amp;topic_name=16%E5%BC%BA%E5%BC%80%E6%89%93%2C%E8%B0%81%E6%98%AF%E6%9C%80%E9%9D%93%E8%A1%A8%E6%83%85%E5%8C%85","cover":null,"badge":null},{"rank":30,"title":"吧友炼声线做单曲,带飞嘉然二创","desc":"吧友用IndexTTS 2.0炼出嘉然声线，称“离一户一然更近了”。同日另一批吧友发布嘉然同人单曲，质量夯爆。嘉然二创越来越卷了。","value":"2.41w","link":"https://tieba.baidu.com/hottopic/browse/hottopic?topic_id=28368615&amp;topic_name=%E5%90%A7%E5%8F%8B%E7%82%BC%E5%A3%B0%E7%BA%BF%E5%81%9A%E5%8D%95%E6%9B%B2%2C%E5%B8%A6%E9%A3%9E%E5%98%89%E7%84%B6%E4%BA%8C%E5%88%9B","cover":null,"badge":null}],"total":30}',18642,9542,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('rednote','/v2/rednote','小红书热榜','小红书热搜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"用万能旅行拍照姿势美美出片","desc":null,"value":"947.5w","link":"https://www.xiaohongshu.com/search_result?keyword=%E7%94%A8%E4%B8%87%E8%83%BD%E6%97%85%E8%A1%8C%E6%8B%8D%E7%85%A7%E5%A7%BF%E5%8A%BF%E7%BE%8E%E7%BE%8E%E5%87%BA%E7%89%87&type=51","cover":null,"badge":"热"},{"rank":2,"title":"耗时三年拍下古诗词里的中国","desc":null,"value":"934.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E8%80%97%E6%97%B6%E4%B8%89%E5%B9%B4%E6%8B%8D%E4%B8%8B%E5%8F%A4%E8%AF%97%E8%AF%8D%E9%87%8C%E7%9A%84%E4%B8%AD%E5%9B%BD&type=51","cover":null,"badge":"热"},{"rank":3,"title":"我拍到了海鸥雨","desc":null,"value":"903.2w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%88%91%E6%8B%8D%E5%88%B0%E4%BA%86%E6%B5%B7%E9%B8%A5%E9%9B%A8&type=51","cover":null,"badge":"无"},{"rank":4,"title":"超日常美食教程速来get","desc":null,"value":"886w","link":"https://www.xiaohongshu.com/search_result?keyword=%E8%B6%85%E6%97%A5%E5%B8%B8%E7%BE%8E%E9%A3%9F%E6%95%99%E7%A8%8B%E9%80%9F%E6%9D%A5get&type=51","cover":null,"badge":"无"},{"rank":5,"title":"定格这一刻的日照金山","desc":null,"value":"871.1w","link":"https://www.xiaohongshu.com/search_result?keyword=%E5%AE%9A%E6%A0%BC%E8%BF%99%E4%B8%80%E5%88%BB%E7%9A%84%E6%97%A5%E7%85%A7%E9%87%91%E5%B1%B1&type=51","cover":null,"badge":"无"},{"rank":6,"title":"你可以永远相信赛里木湖的美景","desc":null,"value":"783.1w","link":"https://www.xiaohongshu.com/search_result?keyword=%E4%BD%A0%E5%8F%AF%E4%BB%A5%E6%B0%B8%E8%BF%9C%E7%9B%B8%E4%BF%A1%E8%B5%9B%E9%87%8C%E6%9C%A8%E6%B9%96%E7%9A%84%E7%BE%8E%E6%99%AF&type=51","cover":null,"badge":"热"},{"rank":7,"title":"拼豆上也可以作画了","desc":null,"value":"749.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%8B%BC%E8%B1%86%E4%B8%8A%E4%B9%9F%E5%8F%AF%E4%BB%A5%E4%BD%9C%E7%94%BB%E4%BA%86&type=51","cover":null,"badge":"热"},{"rank":8,"title":"我的家庭旅行更像是打副本","desc":null,"value":"737.1w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%88%91%E7%9A%84%E5%AE%B6%E5%BA%AD%E6%97%85%E8%A1%8C%E6%9B%B4%E5%83%8F%E6%98%AF%E6%89%93%E5%89%AF%E6%9C%AC&type=51","cover":null,"badge":"无"},{"rank":9,"title":"原来古诗词里的河南真的存在","desc":null,"value":"727.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E5%8E%9F%E6%9D%A5%E5%8F%A4%E8%AF%97%E8%AF%8D%E9%87%8C%E7%9A%84%E6%B2%B3%E5%8D%97%E7%9C%9F%E7%9A%84%E5%AD%98%E5%9C%A8&type=51","cover":null,"badge":"热"},{"rank":10,"title":"蒸出了奶香爆米花馒头","desc":null,"value":"716.2w","link":"https://www.xiaohongshu.com/search_result?keyword=%E8%92%B8%E5%87%BA%E4%BA%86%E5%A5%B6%E9%A6%99%E7%88%86%E7%B1%B3%E8%8A%B1%E9%A6%92%E5%A4%B4&type=51","cover":null,"badge":"热"},{"rank":11,"title":"这可能是江西最被低估的一座山","desc":null,"value":"703w","link":"https://www.xiaohongshu.com/search_result?keyword=%E8%BF%99%E5%8F%AF%E8%83%BD%E6%98%AF%E6%B1%9F%E8%A5%BF%E6%9C%80%E8%A2%AB%E4%BD%8E%E4%BC%B0%E7%9A%84%E4%B8%80%E5%BA%A7%E5%B1%B1&type=51","cover":null,"badge":"无"},{"rank":12,"title":"海边日落赴一场温柔约会","desc":null,"value":"689.4w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%B5%B7%E8%BE%B9%E6%97%A5%E8%90%BD%E8%B5%B4%E4%B8%80%E5%9C%BA%E6%B8%A9%E6%9F%94%E7%BA%A6%E4%BC%9A&type=51","cover":null,"badge":"热"},{"rank":13,"title":"拼豆也能当火漆印章玩","desc":null,"value":"241.7w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%8B%BC%E8%B1%86%E4%B9%9F%E8%83%BD%E5%BD%93%E7%81%AB%E6%BC%86%E5%8D%B0%E7%AB%A0%E7%8E%A9&type=51","cover":null,"badge":"无"},{"rank":14,"title":"我创造了新型遛狗法","desc":null,"value":"231.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%88%91%E5%88%9B%E9%80%A0%E4%BA%86%E6%96%B0%E5%9E%8B%E9%81%9B%E7%8B%97%E6%B3%95&type=51","cover":null,"badge":"热"},{"rank":15,"title":"用镜头捕捉四季如画","desc":null,"value":"222.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E7%94%A8%E9%95%9C%E5%A4%B4%E6%8D%95%E6%8D%89%E5%9B%9B%E5%AD%A3%E5%A6%82%E7%94%BB&type=51","cover":null,"badge":"热"},{"rank":16,"title":"笔墨重现课本诗意","desc":null,"value":"213.5w","link":"https://www.xiaohongshu.com/search_result?keyword=%E7%AC%94%E5%A2%A8%E9%87%8D%E7%8E%B0%E8%AF%BE%E6%9C%AC%E8%AF%97%E6%84%8F&type=51","cover":null,"badge":"无"},{"rank":17,"title":"拍到了洱海的丁达尔效应","desc":null,"value":"203.3w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%8B%8D%E5%88%B0%E4%BA%86%E6%B4%B1%E6%B5%B7%E7%9A%84%E4%B8%81%E8%BE%BE%E5%B0%94%E6%95%88%E5%BA%94&type=51","cover":null,"badge":"热"},{"rank":18,"title":"珠圆玉润妆完全是淡颜天菜","desc":null,"value":"193.8w","link":"https://www.xiaohongshu.com/search_result?keyword=%E7%8F%A0%E5%9C%86%E7%8E%89%E6%B6%A6%E5%A6%86%E5%AE%8C%E5%85%A8%E6%98%AF%E6%B7%A1%E9%A2%9C%E5%A4%A9%E8%8F%9C&type=51","cover":null,"badge":"热"},{"rank":19,"title":"碎钻美甲指尖藏着细碎星光","desc":null,"value":"184.5w","link":"https://www.xiaohongshu.com/search_result?keyword=%E7%A2%8E%E9%92%BB%E7%BE%8E%E7%94%B2%E6%8C%87%E5%B0%96%E8%97%8F%E7%9D%80%E7%BB%86%E7%A2%8E%E6%98%9F%E5%85%89&type=51","cover":null,"badge":"无"},{"rank":20,"title":"我来当旅行中的颜色猎手","desc":null,"value":"175.7w","link":"https://www.xiaohongshu.com/search_result?keyword=%E6%88%91%E6%9D%A5%E5%BD%93%E6%97%85%E8%A1%8C%E4%B8%AD%E7%9A%84%E9%A2%9C%E8%89%B2%E7%8C%8E%E6%89%8B&type=51","cover":null,"badge":"热"}],"total":20}',6273,4599,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('quark','/v2/quark','夸克热点','夸克热搜榜','hot','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"林涛当选厦门市委书记","desc":"中共厦门市第十四届委员会第一次全体会议11月1日选举林涛为市委书记。","value":null,"link":"https://123.quark.cn/detail?item_id=12049764225383254827","cover":null,"badge":"国内 · 地方时政"},{"rank":2,"title":"夫妻倾家荡产花246万买邮轮“永居权”，两年后被要求7小时内在柬埔寨下船","desc":"夫妻倾家荡产花246万买邮轮“永居权”，两年后被要求7小时内在柬埔寨下船。","value":null,"link":"https://123.quark.cn/detail?item_id=9635505370698634002","cover":null,"badge":"社会 · 法制社会"},{"rank":3,"title":"央视曝光后 青岛立案调查","desc":"涉案商家承认曾经销售熏硫白芷，执法人员对涉案货物予以查封扣押，立案调查。","value":null,"link":"https://123.quark.cn/detail?item_id=16563324359168654759","cover":null,"badge":"社会 · 法制社会"},{"rank":4,"title":"学长把学妹照片挂色情网站后道歉","desc":"多名女生照片被挂上色情网站，受害者起初不相信是学长所为；男子因涉嫌传播淫秽物品罪被刑事立案。案件。","value":null,"link":"https://123.quark.cn/detail?item_id=5525381465054599391","cover":null,"badge":"娱乐 · 八卦"},{"rank":5,"title":"特朗普称不希望以总理干扰美伊谈判","desc":"消息人士透露，特朗普与内塔尼亚胡进行了“直接而尖锐”的通话，特朗普希望“让谈判充分展开”，不希望以干扰谈判进程。","value":null,"link":"https://123.quark.cn/detail?item_id=4827328893430004238","cover":null,"badge":"国际 · 国际时政"},{"rank":6,"title":"环球时报：默茨亚洲行碰了钉子，走得灰溜溜的","desc":"环球时报：默茨亚洲行碰了钉子，走得灰溜溜的。","value":null,"link":"https://123.quark.cn/detail?item_id=9938879148946896015","cover":null,"badge":"国际"},{"rank":7,"title":"总统和总理公然对立 波兰政局往何处走","desc":"波兰司法争端发酵，总统纳夫罗茨基中断出访回国，与总理图斯克公开对立，双方互相指责，该国宪政危机持续升级。","value":null,"link":"https://123.quark.cn/detail?item_id=2887714434068323773","cover":null,"badge":"国际 · 国际时政"},{"rank":8,"title":"石油\"虎\"退休11年被查 曾因事故受处分","desc":"傅成玉被查，其深耕能源领域数十年，曾因输油管道爆炸事故受处分；他退休后频繁参加各种活动，一个月前曾现身企业家年会。","value":null,"link":"https://123.quark.cn/detail?item_id=2045527904989017006","cover":null,"badge":"default"},{"rank":9,"title":"面包店下单吃到要等1年 店主回应","desc":"杭州一面包店下单吃到要等1年，店主回应“饥饿营销”质疑：产能确实有限，不是自家面包有多好吃，而是赶上互联网热潮。","value":null,"link":"https://123.quark.cn/detail?item_id=6090297672027245095","cover":null,"badge":"美食 · 菜谱"},{"rank":10,"title":"央行将召开股票回购增持再贷款座谈会","desc":"业内猜测，此次会议大概率是金融管理部门为进一步稳定市场做准备。","value":null,"link":"https://123.quark.cn/detail?item_id=1949939324921434631","cover":null,"badge":"财经 · 宏观经济"},{"rank":11,"title":"留学生回国行为诡异 全家靠写纸条交流","desc":"男孩留学回国后变得行为诡异，不敢说话，不敢带手机，全家靠写小纸条交流，父母千方百计将其带到派出所，真相大白。","value":null,"link":"https://123.quark.cn/detail?item_id=3526246697832266757","cover":null,"badge":"社会 · 法制社会"},{"rank":12,"title":"特朗普：支持马斯克执掌CNN","desc":"特朗普发声：支持马斯克执掌CNN，这比现在的情况更让我喜欢，他是个好人，工作干得不错。","value":null,"link":"https://123.quark.cn/detail?item_id=12218984062289471803","cover":null,"badge":"国际 · 国际时政"},{"rank":13,"title":"苏超礼仪小姐走红 网友：国泰民安脸","desc":"2026年“苏超”决赛落下帷幕，颁奖台上的一位礼仪小姐意外走红，网友：一眼看到这张国泰民安的脸；图。","value":null,"link":"https://123.quark.cn/detail?item_id=12948007884939808504","cover":null,"badge":"社会 · 奇闻"},{"rank":14,"title":"一条红色预警引注意 9名公职人员被查","desc":"大数据模型发出红色预警，武汉市纪委监委顺藤摸瓜，一个月内9名公职人员被查。","value":null,"link":"https://123.quark.cn/detail?item_id=8335745157003392052","cover":null,"badge":"国内 · 地方时政"},{"rank":15,"title":"上海男子花90万元充美容美发卡，已消费的30多万里竟有“弹力烫发”，当事人：我是光头，这不扯吗；多方回应","desc":"上海男子花90万元充美容美发卡，已消费的30多万里竟有“弹力烫发”，当事人：我是光头，这不扯吗；多方回应。","value":null,"link":"https://123.quark.cn/detail?item_id=3456923346409274606","cover":null,"badge":"社会 · 奇闻"},{"rank":16,"title":"柬埔寨电诈园区转移至非洲重操旧业","desc":"柬埔寨电诈园区转移至非洲重操旧业，主要从事网恋、加密货币及虚假投资诈骗，目前已有148名涉案人员被引渡回中国。","value":null,"link":"https://123.quark.cn/detail?item_id=10811544122004138098","cover":null,"badge":"国际"},{"rank":17,"title":"Token，在多个电商平台上架","desc":"Token，在多个电商平台上架。","value":null,"link":"https://123.quark.cn/detail?item_id=504744597998429351","cover":null,"badge":"科技"},{"rank":18,"title":"沪深上市公司净利润超5万亿 创4年新高","desc":"今年前三季度，沪深两市上市公司实现净利润5.1万亿元，创2022年以来新高；科创板上市公司净利润增长474.6％。分析。","value":null,"link":"https://123.quark.cn/detail?item_id=8012286025572371630","cover":null,"badge":"财经 · 股票"},{"rank":19,"title":"谢霆锋演唱会上被扔荧光棒 警方通报","desc":"谢霆锋演唱会现场，一男子向台上投掷荧光棒，并称自己是发自内心喜欢歌手才扔的；警方通报。","value":null,"link":"https://123.quark.cn/detail?item_id=17262568945996072319","cover":null,"badge":"娱乐 · 明星"},{"rank":20,"title":"演员吕齐去世 曾出演《编辑部的故事》","desc":"著名表演艺术家吕齐去世，享年101岁，曾出演《编辑部的故事》中的“陈主编”，还曾出演《霸王别姬》《雷雨》《李白》等。","value":null,"link":"https://123.quark.cn/detail?item_id=6573643079891360217","cover":null,"badge":"娱乐 · 明星"},{"rank":21,"title":"邓紫棋官宣第二部科幻小说《自由的你》，曾入围银河奖","desc":"邓紫棋官宣第二部科幻小说《自由的你》，曾入围银河奖。","value":null,"link":"https://123.quark.cn/detail?item_id=17941070702473225771","cover":null,"badge":"娱乐 · 明星"},{"rank":22,"title":"中共中央关于持之以恒推进全面从严治党若干重大问题的决定","desc":"中共中央关于持之以恒推进全面从严治党若干重大问题的决定","value":null,"link":"https://123.quark.cn/detail?item_id=11893734454339456202","cover":null,"badge":"国内"},{"rank":23,"title":"央行、证监会将于明天召开座谈会","desc":"一些证券公司和基金公司接到通知，明天上午央行、证监会召开会议，研究推动支持资本市场工具使用。","value":null,"link":"https://123.quark.cn/detail?item_id=15861066331213763216","cover":null,"badge":"财经 · 银行"},{"rank":24,"title":"伊朗外交部将英国海空军列为\"恐怖组织\"","desc":"伊朗外交部11月1日发表声明说，根据伊朗法律将英国海军和空军列为“恐怖组织”。","value":null,"link":"https://123.quark.cn/detail?item_id=13216963391400875155","cover":null,"badge":"国际 · 国际时政"},{"rank":25,"title":"中国路桥严正声明","desc":"柬埔寨项目招工先交钱？中国路桥声明：这是假的，已有人被骗。","value":null,"link":"https://123.quark.cn/detail?item_id=14554216597124861839","cover":null,"badge":"社会"},{"rank":26,"title":"张雪：老板独自坐头等舱的做法很low","desc":"张雪公布差旅原则：飞行时间超过5小时必须乘坐头等舱；老板独自坐头等舱，让同事坐经济舱的做法“很low”。","value":null,"link":"https://123.quark.cn/detail?item_id=13998130705532737420","cover":null,"badge":"default"},{"rank":27,"title":"无尽深渊！触不到底的曼联，何谈反弹？","desc":"无尽深渊！触不到底的曼联，何谈反弹？","value":null,"link":"https://123.quark.cn/detail?item_id=9507108743659042679","cover":null,"badge":"体育 · 国际足球"},{"rank":28,"title":"“国羽一哥”石宇奇低调举行婚礼, 新娘是电竞主播","desc":"新娘是电竞女主播“姜蛋蛋”。","value":null,"link":"https://123.quark.cn/detail?item_id=4297236493893146109","cover":null,"badge":"体育 · 羽毛球"},{"rank":29,"title":"“男子因幻听行凶致2死1伤”案进展","desc":"被告被判死刑后提起上诉，称案件系在精神疾病影响下发生。","value":null,"link":"https://123.quark.cn/detail?item_id=9379883693663428786","cover":null,"badge":"社会 · 法制社会"},{"rank":30,"title":"中期选举前夕MAGA选民为何纷纷倒戈? 昔日铁杆揭露原因","desc":"特朗普昔日铁杆支持者揭露原因。","value":null,"link":"https://123.quark.cn/detail?item_id=7227809049404811878","cover":null,"badge":"国际 · 国际时政"},{"rank":31,"title":"沈伯洋在台北市长选举首场辩论中完败？媒体人：他事前太臭屁了，结果“大洋流”变大洋相","desc":"沈伯洋在台北市长选举首场辩论中完败？媒体人：他事前太臭屁了，结果“大洋流”变大洋相。","value":null,"link":"https://123.quark.cn/detail?item_id=11398868428969136690","cover":null,"badge":"国内"},{"rank":32,"title":"肯尼亚18层坍塌大楼由中国承建？","desc":"媒体：消息不实，实际是中企参与了救援。","value":null,"link":"https://123.quark.cn/detail?item_id=13306948759984864017","cover":null,"badge":"国际"},{"rank":33,"title":"公司误将5000元工资发给已离职员工","desc":"对方不肯退还，经法院调解双方商定：每月还800元，直至全部款项返还完毕。","value":null,"link":"https://123.quark.cn/detail?item_id=1497125054818951029","cover":null,"badge":"社会 · 民生"},{"rank":34,"title":"法国再次爆发大规模示威, 约32万人参加511人被捕","desc":null,"value":null,"link":"https://123.quark.cn/detail?item_id=341236846638136618","cover":null,"badge":"国际 · 国际社会"},{"rank":35,"title":"派出所副所长电梯里捡到5万元现金","desc":"随即送到附近派出所，笑称：“有时候，我也挺想报警的”。","value":null,"link":"https://123.quark.cn/detail?item_id=13717420157770023731","cover":null,"badge":"社会 · 地方新闻"},{"rank":36,"title":"谢霆锋演唱会上被扔荧光棒","desc":"歌迷上前质问，涉事男子称是发自内心喜欢才扔。","value":null,"link":"https://123.quark.cn/detail?item_id=11512553086988891610","cover":null,"badge":"娱乐 · 明星"},{"rank":37,"title":"环保博主遭村支书死亡威胁 媒体发声","desc":"涉事村支书被免，媒体：官方通报里有三个问题没有公开说明，让人感到疑惑。","value":null,"link":"https://123.quark.cn/detail?item_id=1763151398654068817","cover":null,"badge":"社会 · 奇闻"},{"rank":38,"title":"博索纳罗败选后逃往美国 特朗普表态","desc":"特朗普：不打算与小博索纳罗举行会面，不过他可以“想在美国待多久就待多久”。","value":null,"link":"https://123.quark.cn/detail?item_id=9881720760605732881","cover":null,"badge":"国际 · 国际时政"},{"rank":39,"title":"币安：已补回90%被盗资产","desc":"币安：已补回90%被盗资产，计划周日恢复提现。","value":null,"link":"https://123.quark.cn/detail?item_id=15604736469029285237","cover":null,"badge":"社会 · 民生"},{"rank":40,"title":"男子在星巴克不消费占座被劝离后报警","desc":"知情人：他连续多天占座不消费；涉事门店回应。","value":null,"link":"https://123.quark.cn/detail?item_id=7083701896662801196","cover":null,"badge":"社会 · 法制社会"},{"rank":41,"title":"“速成车”，被喊停","desc":"不少新车上博人眼球的“酷炫”功能，在部分使用场景即将迎来明确限制。","value":null,"link":"https://123.quark.cn/detail?item_id=1191949978019515710","cover":null,"badge":"汽车 · 车圈资讯"},{"rank":42,"title":"英国首相: 考虑道歉 但拒绝赔偿","desc":"英国首相表示，愿考虑代表英国政府就该国历史上参与奴隶贸易正式道歉，但拒绝向奴隶贸易受害者后裔支付经济赔偿。","value":null,"link":"https://123.quark.cn/detail?item_id=9466542808099307852","cover":null,"badge":"国际 · 国际时政"},{"rank":43,"title":"29岁男子陪女友去医院，在女友劝说下顺带做检查，B超结果一出当场蒙了","desc":"29岁男子陪女友去医院，在女友劝说下顺带做检查，B超结果一出当场蒙了","value":null,"link":"https://123.quark.cn/detail?item_id=18396867715560862380","cover":null,"badge":"健康 · 健康养生"},{"rank":44,"title":"俄称从美方获悉莫斯科可能发生恐袭","desc":"据俄罗斯方面消息，俄罗斯联邦安全局通过美国方面获得有关莫斯科可能发生恐怖袭击的情报，俄方已采取应对举措。","value":null,"link":"https://123.quark.cn/detail?item_id=9063477037215443737","cover":null,"badge":"国际"},{"rank":45,"title":"央视曝光2388元止痛蜜丸成本仅40元","desc":"加盟商实名举报含违禁物。","value":null,"link":"https://123.quark.cn/detail?item_id=3936060290307984236","cover":null,"badge":"社会 · 法制社会"},{"rank":46,"title":"少女遭5人团伙胁迫卖淫 主犯是闺蜜","desc":"10名嫖客也被追究刑事责任，构成强奸罪，刑期2年至5年不等。","value":null,"link":"https://123.quark.cn/detail?item_id=13650881585816594666","cover":null,"badge":"社会 · 法制社会"},{"rank":47,"title":"鲁比奥嘴上说“不反华”，却又暗指中国","desc":"鲁比奥嘴上说“不反华”，却又暗指中国。","value":null,"link":"https://123.quark.cn/detail?item_id=4843367872700051696","cover":null,"badge":"国际 · 国际时政"},{"rank":48,"title":"连续2个周末，三亚市委书记、市长等带头上街大扫除","desc":"连续2个周末，三亚市委书记、市长等带头上街大扫除。","value":null,"link":"https://123.quark.cn/detail?item_id=15339898804125151572","cover":null,"badge":"国内 · 地方时政"},{"rank":49,"title":"康定勒多曼因峰4人滑坠2人遇难 细节披露","desc":"两遇难者遗体已被转运下山，1幸存者在配合调查，4人未经审批，系违规登山。","value":null,"link":"https://123.quark.cn/detail?item_id=1761113783969820024","cover":null,"badge":"社会 · 法制社会"},{"rank":50,"title":"日本发生6.1级地震","desc":"当地时间1日7时15分左右，日本三重县东南海域发生6.1级地震，最大震感为震度3，震源深度350千米。","value":null,"link":"https://123.quark.cn/detail?item_id=701868694722691021","cover":null,"badge":"国际 · 国际社会"}],"total":50}',99393,8611,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('ai-news','/v2/ai-news','AI 每日资讯','AI 行业动态','info','list',1,200,NULL,'{"kind":"list","items":[],"total":0}',120,36,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('it-news','/v2/it-news','IT 资讯','科技新闻流','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"现代汽车集团投资约 9 万亿韩元打造 AI 谷进展：计划成立两家新公司，分别负责 AI 基础设施建设与 GPU 算力服务运营","desc":"IT之家 11 月 2 日消息，当地时间 10 月 30 日，现代汽车集团宣布正式启用新办事处，此举是推进新万金（Saemangeum）人工智能数据中心建设的重…","value":null,"link":"https://www.ithome.com/1/020/864.htm","cover":null,"badge":null},{"rank":2,"title":"石油巨头沙特阿美收购该国人工智能企业 HUMAIN 49% 股份","desc":"IT之家 11 月 2 日消息，此前由沙特阿拉伯主权财富基金 PIF 完全控股的人工智能初创企业 HUMAIN 当地时间本月 1 日宣布，全球最大石化企业沙特阿…","value":null,"link":"https://www.ithome.com/1/020/863.htm","cover":null,"badge":null},{"rank":3,"title":"《辐射 76》游戏累计玩家突破 2500 万，B 社确认持续更新内容","desc":"IT之家 11 月 2 日消息，Bethesda（贝塞斯达）近日确认，《辐射 76》游戏累计玩家数已突破 2500 万。作为参考，本作最初发售于 2018 年 …","value":null,"link":"https://www.ithome.com/1/020/861.htm","cover":null,"badge":null},{"rank":4,"title":"福特汽车目标到 2032 年销量增长约 20%，实现年销 500 万辆","desc":"IT之家 11 月 2 日消息，据华尔街日报消息，知情人士透露，福特汽车首席执行官吉姆 · 法利（Jim Farley）在上周四举行的全员大会上宣布了新目标，福…","value":null,"link":"https://www.ithome.com/1/020/860.htm","cover":null,"badge":null},{"rank":5,"title":"荣耀 Magic9 Pro Max 手机摄像头右上角开孔揭秘，细缝暗藏行业首发的自研枪麦系统","desc":"IT之家 11 月 2 日消息，荣耀研发工程师 @荣耀曹工 昨晚发布视频，揭秘了 Magic9 Pro Max 手机摄像头右上角开孔的作用。据介绍，这条细细的开…","value":null,"link":"https://www.ithome.com/1/020/859.htm","cover":null,"badge":null},{"rank":6,"title":"美国特拉华州拟允许 AI 智能体创办、运营企业","desc":"IT之家 11 月 2 日消息，据科技媒体 TechRadar 今天报道，美国特拉华州计划放宽商业监管规定，允许 AI 智能体运营的企业注册成立。国会议员对此并…","value":null,"link":"https://www.ithome.com/1/020/858.htm","cover":null,"badge":null},{"rank":7,"title":"思科给 1 位年轻工程师无上限 Token 预算，最终目标 2 年内利用 AI 重写 98% 的遗留代码","desc":"IT之家 11 月 2 日消息，据《财富》报道，思科（Cisco）总裁兼首席产品官吉图 · 帕特尔（Jeetu Patel）透露，他指派了一位 27 岁的年轻工…","value":null,"link":"https://www.ithome.com/1/020/857.htm","cover":null,"badge":null},{"rank":8,"title":"美国佛罗里达州发生飞机坠毁事故：不到 1 分钟急坠近万米，机上人员全部遇难","desc":"IT之家 11 月 2 日消息，综合央视新闻、CCTV 国际时讯今日报道，当地时间 11 月 1 日，一架飞机在美国佛罗里达州棕榈滩附近坠毁，机上载有 9 人。…","value":null,"link":"https://www.ithome.com/1/020/856.htm","cover":null,"badge":null},{"rank":9,"title":"今日结束：B站 x 京东 PLUS 联名年卡 148 元、大会员 97 元、超级大会员 151 元大促","desc":"B站大会员年卡 + 京东 PLUS 年卡日常售价 258 元，现 11.11 大促价为 148 元，到手双会员各一年：京东哔哩哔哩大会员 12 个月年卡 + 京…","value":null,"link":"https://www.ithome.com/1/017/751.htm","cover":null,"badge":null},{"rank":10,"title":"王腾回应为何今日宜休首款设备做智能戒指，称睡眠不是靠一款产品就能解决所有问题","desc":"IT之家 11 月 2 日消息，今日宜休科技公司创始人王腾昨晚发文，解释了为什么今日宜休第一款设备做智能戒指这一问题。王腾表示，睡眠不是靠一款设备就能解决所有问…","value":null,"link":"https://www.ithome.com/1/020/855.htm","cover":null,"badge":null},{"rank":11,"title":"古尔曼：苹果计划明年淘汰非触屏版 MacBook Pro，仅保留 14 英寸基础款机型","desc":"IT之家 11 月 2 日消息，苹果上周推出首款触屏 MacBook Pro，采用 M5 Pro/M5 Max 芯片。不过如今，苹果仍在销售今年 3 月推出的 …","value":null,"link":"https://www.ithome.com/1/020/853.htm","cover":null,"badge":null},{"rank":12,"title":"猛玛推出探境 3 直播相机：1/1.3 英寸传感器，3199 元","desc":"IT之家 11 月 2 日消息，猛玛推出了探境 3 直播相机，这款新品现已开售，售价 3199 元。这款直播相机搭载 1/1.3 英寸传感器，5000 万有效像…","value":null,"link":"https://www.ithome.com/1/020/852.htm","cover":null,"badge":null},{"rank":13,"title":"受益人口近 1.18 亿：南水北调中线工程圆满完成 2025-2026 年度供水任务，累计向受水区供水 72.64 亿立方米","desc":"IT之家 11 月 2 日消息，据中国南水北调集团分享，截至 10 月 31 日，南水北调中线工程圆满完成 2025-2026 年度供水任务，年度累计向受水区河…","value":null,"link":"https://www.ithome.com/1/020/851.htm","cover":null,"badge":null},{"rank":14,"title":"IT早报 1102：2026 年 10 月汽车销量榜出炉；问界将全面进入欧洲市场；首付 7.99 万元起小米推限时 0 息购车权益；2027 年度春节假期可连休…","desc":"“IT早报”时间，大家好，现在是 2026 年 11 月 2 日星期一，今天的重要科技资讯有：1. 2026 年 10 月汽车销量 / 交付榜出炉：比亚迪超 4…","value":null,"link":"https://www.ithome.com/1/020/850.htm","cover":null,"badge":null},{"rank":15,"title":"铠侠：2027 年芯片产能已售罄，2028 年配额锁定超 50%","desc":"IT之家 11 月 2 日消息，据日媒 ITmedia 报道，在铠侠控股 2027 财年第二财季（2026 年 7 月～2026 年 9 月）财报电话会议上，铠…","value":null,"link":"https://www.ithome.com/1/020/849.htm","cover":null,"badge":null},{"rank":16,"title":"微软 AI 负责人苏莱曼：AI 模型没有意识，我们应确保它永远如此","desc":"IT之家 11 月 2 日消息，微软 AI 负责人（Mustafa Suleyman）昨天在 X 平台发布长文，称目前的 AI 模型并不具备意识，人们应该让这种…","value":null,"link":"https://www.ithome.com/1/020/848.htm","cover":null,"badge":null},{"rank":17,"title":"补齐湖南境内“最后一块拼图”，全长约 2803 公里的呼北高速实现全线贯通","desc":"IT之家 11 月 2 日消息，据新华网报道，呼和浩特至北海高速公路张家界至高坪段 11 月 1 日通车试运营。补齐湖南境内“最后一块拼图”后，全长约 2803…","value":null,"link":"https://www.ithome.com/1/020/847.htm","cover":null,"badge":null},{"rank":18,"title":"微软确认：受支持的 Win10 设备现可直接升级至 Win11 26H2","desc":"IT之家 11 月 2 日消息，据科技媒体 neowin 昨天报道，微软于今年 9 月底推送 Win11 26H2。此次更新采取分阶段推送形式，逐步推送至符合条…","value":null,"link":"https://www.ithome.com/1/020/846.htm","cover":null,"badge":null},{"rank":19,"title":"比亚迪前三季度研发比净利润高 140 亿元：何志奇称不是不会算账，是在算一本更长的账","desc":"IT之家 11 月 2 日消息，比亚迪股份有限公司执行副总裁何志奇昨晚发文表示，比亚迪（今年）前三季度研发费用 363 亿元，归母净利润 223 亿元 —— 研…","value":null,"link":"https://www.ithome.com/1/020/845.htm","cover":null,"badge":null},{"rank":20,"title":"OpenAI 即将启动大规模公关宣传，考虑将数据中心重新包装为“AI 算力园区”","desc":"IT之家 11 月 2 日消息，据外媒 Axios 昨天报道，OpenAI 正准备在周二美国中期选举结束后，发起大规模公关宣传活动。OpenAI 首席全球事务官…","value":null,"link":"https://www.ithome.com/1/020/844.htm","cover":null,"badge":null}],"total":20}',10826,4075,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('it-news-rank','/v2/it-news/rank','IT 资讯榜','热度排行','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"2026 年 10 月汽车销量 / 交付汇总（持续更新）：奇瑞汽车 28.25 万辆，同比增长 7.2%","desc":null,"value":null,"link":"https://www.ithome.com/1/020/661.htm","cover":null,"badge":null},{"rank":2,"title":"2027 年度春节放假安排公布：除夕恰逢周五可与周末顺连，实现 9 天假期","desc":null,"value":null,"link":"https://www.ithome.com/1/020/779.htm","cover":null,"badge":null},{"rank":3,"title":"小米汽车 2026 年 10 月交付量超过 50,000 台","desc":null,"value":null,"link":"https://www.ithome.com/1/020/656.htm","cover":null,"badge":null},{"rank":4,"title":"鸿蒙智行官宣 10 月交付 33537 台、均价超 40 万元，累计销量 160 万台刷新中国新势力纪录","desc":null,"value":null,"link":"https://www.ithome.com/1/020/701.htm","cover":null,"badge":null},{"rank":5,"title":"华为鸿蒙 HarmonyOS 7 系统“星闪耳返”功能上线，手机自带音乐 App + 播控中心可体验","desc":null,"value":null,"link":"https://www.ithome.com/1/020/811.htm","cover":null,"badge":null},{"rank":6,"title":"消息称苹果 iPhone 18 Pro 系列销量突破 600 万台","desc":null,"value":null,"link":"https://www.ithome.com/1/020/730.htm","cover":null,"badge":null},{"rank":7,"title":"华为新机影像超前瞻：200Mp 1/1.3\" 超大底主摄 + 200Mp 1/1.4\" 大底潜望长焦，预计明年落地","desc":null,"value":null,"link":"https://www.ithome.com/1/020/765.htm","cover":null,"badge":null},{"rank":8,"title":"赛力斯：问界将全面进入欧洲市场，公司不参与价格战和规模内卷","desc":null,"value":null,"link":"https://www.ithome.com/1/020/839.htm","cover":null,"badge":null},{"rank":9,"title":"一地叫停网约车“只送货不载人”，回应称并非一刀切禁止“四轮小件”货运","desc":null,"value":null,"link":"https://www.ithome.com/1/020/702.htm","cover":null,"badge":null},{"rank":10,"title":"上市价 4399 → 2893 元：vivo X300 手机 12GB+256GB 国补直降","desc":null,"value":null,"link":"https://www.ithome.com/1/020/831.htm","cover":null,"badge":null},{"rank":11,"title":"2026 年 10 月汽车销量 / 交付榜出炉：比亚迪超 49 万辆稳居榜首，小米月销重回 5 万辆","desc":null,"value":null,"link":"https://www.ithome.com/1/020/835.htm","cover":null,"badge":null},{"rank":12,"title":"小米推出限时“0 息”购车权益，SU7 / YU7 现车可享“3 年 0 息”或“5 年分期 3 年 0 息”","desc":null,"value":null,"link":"https://www.ithome.com/1/020/679.htm","cover":null,"badge":null}],"total":12}',1325,1382,'2026-11-02T00:59:14.609Z',NULL,'2026-11-02T00:59:14.609Z'),
('hn-top','/v2/hacker-news/top','Hacker News 热门','HN Top','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"Show HN: HackerBooks – HackerTube, but for books mentioned on HN","desc":null,"value":"858","link":"https://hackerbooks.org","cover":null,"badge":"roansh"},{"rank":2,"title":"HackerTube: YouTube built from videos recommended by HN","desc":null,"value":"2,242","link":"https://karpathy.bearblog.dev/hacker-tube/","cover":null,"badge":"karpathy"},{"rank":3,"title":"Nibnib: Image compression with extreme decompression speed","desc":null,"value":"85","link":"https://github.com/raphlinus/nibnib","cover":null,"badge":"raphlinus"},{"rank":4,"title":"Ask HN: Which TV do you recommend for privacy?","desc":null,"value":"105","link":null,"cover":null,"badge":"LecroJS"},{"rank":5,"title":"Tips for more effective fuzz testing with AFL++","desc":null,"value":"67","link":"https://nullprogram.com/blog/2025/02/05/","cover":null,"badge":"luu"},{"rank":6,"title":"Keeping Up Appearances – The women taking over the funeral industry","desc":null,"value":"13","link":"https://lareviewofbooks.org/article/death-industry-mortuary-programs-women-andie-eisen-quarterly/","cover":null,"badge":"TMWNN"},{"rank":7,"title":"New 3D thermal invisibility cloak makes objects disappear from infrared cameras","desc":null,"value":"35","link":"https://www.sciencedaily.com/releases/2026/10/261025073051.htm","cover":null,"badge":"stevenalowe"},{"rank":8,"title":"Show HN: OmniDiff – Opensource, super fast, content aware Git difftool, in Rust","desc":null,"value":"144","link":"https://github.com/ivankovic/omnidiff","cover":null,"badge":"FabCH"},{"rank":9,"title":"Mathematics has changed. Let''s act like it","desc":null,"value":"209","link":"https://terrytao.wordpress.com/2026/11/01/mathematics-has-changed-lets-act-like-it/","cover":null,"badge":"smilelamp"},{"rank":10,"title":"AI delivers ''zero financial payoff'' to most companies, Apollo economist says","desc":null,"value":"113","link":"https://techcrunch.com/2026/10/25/ai-delivers-zero-financial-payoff-to-most-companies-according-to-apollo-economist/","cover":null,"badge":"throwoutway"}],"total":10}',2509,1817,'2026-11-02T00:37:04.840Z',NULL,'2026-11-02T00:37:04.840Z'),
('hn-new','/v2/hacker-news/new','Hacker News 最新','HN New','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"Show HN: HackerBooks – HackerTube, but for books mentioned on HN","desc":null,"value":"858","link":"https://hackerbooks.org","cover":null,"badge":"roansh"},{"rank":2,"title":"HackerTube: YouTube built from videos recommended by HN","desc":null,"value":"2,242","link":"https://karpathy.bearblog.dev/hacker-tube/","cover":null,"badge":"karpathy"},{"rank":3,"title":"Nibnib: Image compression with extreme decompression speed","desc":null,"value":"85","link":"https://github.com/raphlinus/nibnib","cover":null,"badge":"raphlinus"},{"rank":4,"title":"Ask HN: Which TV do you recommend for privacy?","desc":null,"value":"105","link":null,"cover":null,"badge":"LecroJS"},{"rank":5,"title":"Tips for more effective fuzz testing with AFL++","desc":null,"value":"67","link":"https://nullprogram.com/blog/2025/02/05/","cover":null,"badge":"luu"},{"rank":6,"title":"Keeping Up Appearances – The women taking over the funeral industry","desc":null,"value":"13","link":"https://lareviewofbooks.org/article/death-industry-mortuary-programs-women-andie-eisen-quarterly/","cover":null,"badge":"TMWNN"},{"rank":7,"title":"New 3D thermal invisibility cloak makes objects disappear from infrared cameras","desc":null,"value":"35","link":"https://www.sciencedaily.com/releases/2026/10/261025073051.htm","cover":null,"badge":"stevenalowe"},{"rank":8,"title":"Show HN: OmniDiff – Opensource, super fast, content aware Git difftool, in Rust","desc":null,"value":"144","link":"https://github.com/ivankovic/omnidiff","cover":null,"badge":"FabCH"},{"rank":9,"title":"Mathematics has changed. Let''s act like it","desc":null,"value":"209","link":"https://terrytao.wordpress.com/2026/11/01/mathematics-has-changed-lets-act-like-it/","cover":null,"badge":"smilelamp"},{"rank":10,"title":"AI delivers ''zero financial payoff'' to most companies, Apollo economist says","desc":null,"value":"113","link":"https://techcrunch.com/2026/10/25/ai-delivers-zero-financial-payoff-to-most-companies-according-to-apollo-economist/","cover":null,"badge":"throwoutway"}],"total":10}',2509,1817,'2026-11-02T00:37:04.840Z',NULL,'2026-11-02T00:37:04.840Z'),
('hn-best','/v2/hacker-news/best','Hacker News 最佳','HN Best','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"HackerTube: YouTube built from videos recommended by HN","desc":null,"value":"2,242","link":"https://karpathy.bearblog.dev/hacker-tube/","cover":null,"badge":"karpathy"},{"rank":2,"title":"Serbia just elected the world''s brainiest parliament","desc":null,"value":"898","link":"https://www.science.org/content/article/serbia-just-elected-world-s-brainiest-parliament","cover":null,"badge":"input_sh"},{"rank":3,"title":"Show HN: HackerBooks – HackerTube, but for books mentioned on HN","desc":null,"value":"858","link":"https://hackerbooks.org","cover":null,"badge":"roansh"},{"rank":4,"title":"An Italian farmer found some unknown seeds in his attic and planted them","desc":null,"value":"767","link":"https://www.smithsonianmag.com/science-nature/italian-farmer-found-unknown-seeds-attic-with-nothing-lose-planted-them-result-biblical-180989644/","cover":null,"badge":"ecares"},{"rank":5,"title":"TCP Use-After-Free: CVE-2026-98432 / CVSS 9.8","desc":null,"value":"699","link":"https://atlasum.net/blog/cve-2026-98432-linux-ipv4-tcp-uaf","cover":null,"badge":"oger"},{"rank":6,"title":"Restrooms along the Norwegian Scenic Routes","desc":null,"value":"672","link":"https://www.visitnorway.com/plan-your-trip/travel-tips-a-z/norwegian-scenic-routes/worlds-best-toilets/","cover":null,"badge":"giuliomagnifico"},{"rank":7,"title":"Anthropic blocks users for anything touching training larger models","desc":null,"value":"454","link":"https://twitter.com/jiahaoshao1/status/2116475922190922088","cover":null,"badge":"pretext"},{"rank":8,"title":"Memdoor: A team of 5 Qwen3.8-27B models beats Fable 5 on LiveCodeBench Hard","desc":null,"value":"420","link":"https://github.com/guregodevo/memdoor/tree/main/examples/workflows/team-solve","cover":null,"badge":"guregodevo"},{"rank":9,"title":"Police chief unplugs cameras after Flock ignores contract cancellation","desc":null,"value":"411","link":"https://www.thedrive.com/news/my-city-canceled-flocks-contract-flock-ignored-it-so-the-police-chief-unplugged-the-cameras","cover":null,"badge":"entryleveljobsc"},{"rank":10,"title":"Lenovo''s ''encrypted'' fingerprint USB is just an unencrypted SD card in a case","desc":null,"value":"383","link":"https://www.reddit.com/r/technology/comments/1xl2pr3/lenovos_encrypted_fingerprint_usb_drive_is_just/","cover":null,"badge":"entryleveljobsc"}],"total":10}',2820,2138,'2026-11-02T00:37:04.840Z',NULL,'2026-11-02T00:37:04.840Z'),
('history-today','/v2/today-in-history','历史上的今天','当天历史事件','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"北宋皇帝、书画家宋徽宗赵佶出生","desc":"赵佶是宋朝第8位皇帝。他穷奢极侈，曾大肆搜刮江南“花石纲”运至汴京修筑园林。后金兵入侵，他和儿子赵恒被虏，北宋灭亡，史称“靖康之变”。但他的书法极好，被称为“瘦…","value":"1082","link":"https://baike.baidu.com/item/%E8%B5%B5%E4%BD%B6","cover":null,"badge":null},{"rank":2,"title":"日本战国武将立花道雪逝世","desc":"立花道雪（1513年4月22日－1585年11月2日），日本战国时代武将，大友氏家臣，与高桥绍运并称「大友双璧」。","value":"1585","link":"https://baike.baidu.com/item/%E7%AB%8B%E8%8A%B1%E9%81%93%E9%9B%AA","cover":null,"badge":null},{"rank":3,"title":"法国和那瓦尔皇后玛丽·安托瓦内特出生","desc":"玛丽·安托瓦内特（Marie Antoinette 1755年11月2日~1793年10月16日），法国国王路易十六的妻子，原奥地利帝国公主，生于维也纳，是神圣…","value":"1755","link":"https://baike.baidu.com/item/%E7%8E%9B%E4%B8%BD%C2%B7%E5%AE%89%E6%89%98%E7%93%A6%E5%86%85%E7%89%B9","cover":null,"badge":null},{"rank":4,"title":"英国数学家乔治·布尔出生","desc":"乔治·布尔（George Boole，1815.11.2～1864），1815年11月2日生于英格兰的林肯。19世纪最重要的数学家之一，出版了《逻辑的数学分析》…","value":"1815","link":"https://baike.baidu.com/item/%E4%B9%94%E6%B2%BB%C2%B7%E5%B8%83%E5%B0%94","cover":null,"badge":null},{"rank":5,"title":"著名社会学家、人类学家、民族学家费孝通出生","desc":"费孝通，汉族，江苏吴江（今苏州市吴江区）人。著名社会学家、人类学家、民族学家、社会活动家，中国社会学和人类学的奠基人之一，第七、八届全国人民代表大会常务委员会副…","value":"1910","link":"https://baike.baidu.com/item/%E8%B4%B9%E5%AD%9D%E9%80%9A","cover":null,"badge":null},{"rank":6,"title":"俄国正式对土耳其宣战","desc":"土耳其共和国，简称土耳其，是一个横跨亚欧大陆两洲的国家，北临黑海，南临地中海，东南与叙利亚、伊拉克接壤，西临爱琴海，与希腊以及保加利亚接壤，东部与格鲁吉亚、亚美…","value":"1914","link":"https://baike.baidu.com/item/%E5%9C%9F%E8%80%B3%E5%85%B6","cover":null,"badge":null},{"rank":7,"title":"中华民国北洋政府总理段祺瑞逝世","desc":"段祺瑞（1865—1936），曾用名启瑞，字芝泉，晚年号称“正道老人”，安徽六安县（今属六安市）人。","value":"1936","link":"https://baike.baidu.com/item/%E6%AE%B5%E7%A5%BA%E7%91%9E","cover":null,"badge":null},{"rank":8,"title":"中华民国国民革命军将领丘之纪逝世","desc":"丘之纪（1902-1937），广东揭阳人，黄埔陆军军官学校三期学生。","value":"1937","link":"https://baike.baidu.com/item/%E4%B8%98%E4%B9%8B%E7%BA%AA","cover":null,"badge":null},{"rank":9,"title":"辽沈战役辽沈战役结束，东北全境“获得解放”","desc":"辽沈战役是中国近代史中第二次国共内战的“三大战役”之一，1948年9月12日开始，同年11月2日结束，共历时52天。","value":"1948","link":"https://baike.baidu.com/item/%E8%BE%BD%E6%B2%88%E6%88%98%E5%BD%B9/1295","cover":null,"badge":null},{"rank":10,"title":"杜鲁门成功连任美国总统","desc":"哈里·S·杜鲁门（Harry S. Truman，1884年5月8日－1972年12月26日），其姓氏早年在中国被译作“褚盟” ，生于美国密苏里州，美国民主党政…","value":"1948","link":"https://baike.baidu.com/item/%E5%93%88%E9%87%8C%C2%B7S%C2%B7%E6%9D%9C%E9%B2%81%E9%97%A8/81150","cover":null,"badge":null},{"rank":11,"title":"英国现实主义戏剧家萧伯纳逝世","desc":"萧伯纳，全名乔治·伯纳德·萧（George Bernard Shaw，1856年7月26日—1950年11月2日），爱尔兰剧作家。","value":"1950","link":"https://baike.baidu.com/item/%E8%90%A7%E4%BC%AF%E7%BA%B3","cover":null,"badge":null},{"rank":12,"title":"苏联出兵匈牙利镇压匈牙利十月事件","desc":"匈牙利十月事件（英文：Hungarian Event，Hungarian Revolution of 1956；又译匈牙利事件或1956年匈牙利革命）是1956…","value":"1956","link":"https://baike.baidu.com/item/%E5%8C%88%E7%89%99%E5%88%A9%E5%8D%81%E6%9C%88%E4%BA%8B%E4%BB%B6","cover":null,"badge":null},{"rank":13,"title":"韩国女演员金素妍出生","desc":"金素妍（韩文：김소연），韩国女演员，1980年11月2日出生于韩国首尔，2006年毕业于东国大学。","value":"1980","link":"https://baike.baidu.com/item/%E9%87%91%E7%B4%A0%E5%A6%8D/75474","cover":null,"badge":null},{"rank":14,"title":"中国物理学家\n严济慈逝世","desc":"严济慈（1901.1.23—1996.11.2），谱名泽荣，学名寓慈、济慈，字华庭、慕光，号子祥、厂佛、岸佛。","value":"1996","link":"https://baike.baidu.com/item/%E4%B8%A5%E6%B5%8E%E6%85%88","cover":null,"badge":null}],"total":14}',3455,2912,'2026-11-02T00:37:04.840Z',NULL,'2026-11-02T00:37:04.840Z'),
('ncm-rank','/v2/ncm-rank','网易云音乐榜','官方榜单索引','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"飙升榜","desc":"云音乐中每天热度上升最快的100首单曲，每日更新。","value":"更新90首","link":null,"cover":"https://p1.music.126.net/rIi7Qzy2i2Y_1QD7cd0MYA==/109951170048506929.jpg","badge":null},{"rank":2,"title":"新歌榜","desc":"云音乐新歌榜：云音乐用户一周内收听所有新歌（一月内最新发行） 官方TOP排行榜，每天更新。","value":"刚刚更新","link":null,"cover":"https://p1.music.126.net/5guhqPBTcIrrhLBotgaT6w==/109951170048511751.jpg","badge":null},{"rank":3,"title":"原创榜","desc":"云音乐独立原创音乐人作品官方榜单，以推荐优秀原创作品为目的。每周四网易云音乐首发。申请网易音乐人：http://music.163.com/nmusician/","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/BaP9nrocNTL3gGThysv4eQ==/109951170091896587.jpg","badge":null},{"rank":4,"title":"热歌榜","desc":"云音乐热歌榜：云音乐用户一周内收听所有线上歌曲官方TOP排行榜，每日更新。","value":"更新13首","link":null,"cover":"https://p1.music.126.net/0SUEG8yDACfx0Bw2MYFv4Q==/109951170048519512.jpg","badge":null},{"rank":5,"title":"网易云古典榜","desc":"网易云用户一周内收听所有古典音乐官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/urByD_AmfBDBrs7fA9-O8A==/109951167976973225.jpg","badge":null},{"rank":6,"title":"网易云电音榜","desc":"网易云用户一周内收听电子音乐官方TOP排行榜，每周五更新，用先锋电音带你解锁全新维度和体验！","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/hXGObvXfsGtFjFvRhOYAkA==/109951170091888741.jpg","badge":null},{"rank":7,"title":"网易云中文说唱榜","desc":"网易云原创说唱音乐人作品官方榜单，每周五更新。以网易云用户一周播放热度为主，收录2个月内发行的原创说唱作品，按照综合数据排名取前50名。申请网易音乐人：http…","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/GgHbgDfGXHpE2YTchU7IvA==/109951171510498108.jpg","badge":null},{"rank":8,"title":"荣耀音乐热歌榜","desc":"荣耀音乐用户收听线上歌曲的官方TOP排行榜，每日更新。","value":"每天更新","link":null,"cover":"https://p1.music.126.net/KrEjItbh8PkIlaRMKP5lAw==/109951174149506005.jpg","badge":null},{"rank":9,"title":"小天才热歌榜","desc":null,"value":"每天更新","link":null,"cover":"https://p1.music.126.net/GmmRZwOmh-DFwtF3TVJJrw==/109951174096842449.jpg","badge":null},{"rank":10,"title":"实时分享榜","desc":"以网易云音乐站内最近一小时的歌曲分享人数真实数据为唯一依据，每小时更新，实时反映当下最具传播力的100首歌曲。","value":"更新24首","link":null,"cover":"https://p1.music.126.net/b2-_Xw-6DwDXWIn7RNuCYQ==/109951173652479140.jpg","badge":null},{"rank":11,"title":"网易云全球说唱榜","desc":"想聆听世界的说唱节奏？全球说唱榜每周五更新，聚焦华语地区以外的优秀说唱作品。根据云音乐用户每周播放热度数据，按照综合数据排名取前 50 名。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/0hhFjP6WyIjHYDXKW5E7BA==/109951171535150782.jpg","badge":null},{"rank":12,"title":"潮流风向榜","desc":"精心挑选云音乐极具声量的音乐作品，呈现歌曲真实热度趋势，榜单每日更新。","value":"每天更新","link":null,"cover":"https://p1.music.126.net/dIKA5e7jCncz2Br1Toxgaw==/109951170621574552.jpg","badge":null},{"rank":13,"title":"音乐合伙人推荐榜","desc":"音乐合伙人近一个月内推荐过的歌曲官方TOP排行榜，每周一更新。 跟随音乐合伙人的步伐，一起发现那些隐藏的音乐瑰宝。","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/s6ITpmGjKbyDpi7DPkqd2w==/109951170187827373.jpg","badge":null},{"rank":14,"title":"音乐合伙人热歌榜","desc":"音乐合伙人近一周评定过的高分热歌官方TOP排行榜，每周一更新。 跟随音乐合伙人的步伐，一起发现那些隐藏的音乐瑰宝。","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/RgYxQmB-ZUjkMRo2N1jWnQ==/109951170187823494.jpg","badge":null},{"rank":15,"title":"音乐合伙人留名榜","desc":"音乐合伙人近一个月内留名过的所有歌曲官方TOP排行榜，每周一更新。 跟随音乐合伙人的步伐，一起发现那些隐藏的音乐瑰宝。","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/aJJzGIxhkVaD7dX0XBNUnw==/109951170187831145.jpg","badge":null},{"rank":16,"title":"音乐合伙人高分新歌榜","desc":"音乐合伙人近期评定过的所有新歌（一个月内最新发行）官方TOP排行榜，每周一更新。 跟随音乐合伙人的步伐，一起发现那些隐藏的音乐瑰宝。","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/bfk15bvanhdPFU7yjPFgWA==/109951170187832038.jpg","badge":null},{"rank":17,"title":"音乐合伙人高分榜","desc":"音乐合伙人的高分歌曲官方榜单，收录近半年来获得音乐合伙人高分推荐的TOP100首歌曲，每日更新。跟随音乐合伙人的步伐，一起发现那些隐藏的音乐瑰宝。","value":"每天更新","link":null,"cover":"https://p1.music.126.net/fPP5T0Z8Ac15qNvRTcHa6g==/109951170074028970.jpg","badge":null},{"rank":18,"title":"黑胶VIP爱听榜","desc":"云音乐站内会员播放热度TOP100的歌曲，每周四更新。\n黑胶们都爱听什么歌曲？\n热门好歌一站式收听，让你念念不忘~\n做尊贵黑胶，畅听品味好歌~","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/qo6-o9n5AhMjNyejev38-A==/109951169743111905.jpg","badge":null},{"rank":19,"title":"网易云ACG榜","desc":"网易云用户一周内收听所有ACG音乐官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/na1kEeCS1iZEkzOrs9r_9g==/109951167976973667.jpg","badge":null},{"rank":20,"title":"网易云韩语榜","desc":"网易云用户一周内收听所有韩语歌曲官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/5oN9YaFznwNGXkmi8i2Ytw==/109951167430864741.jpg","badge":null},{"rank":21,"title":"UK排行榜周榜","desc":"UK排行榜","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/fhAqiflLy3eU-ldmBQByrg==/109951165613082765.jpg","badge":null},{"rank":22,"title":"美国Billboard榜","desc":"美国Billboard排行榜","value":"每周三更新","link":null,"cover":"https://p1.music.126.net/rwRsVIJHQ68gglhA6TNEYA==/109951165611413732.jpg","badge":null},{"rank":23,"title":"Beatport全球电子舞曲榜","desc":"Beatport全球电子舞曲排行榜TOP100（本榜每周三更新）","value":"每周三更新","link":null,"cover":"https://p1.music.126.net/oT-RHuPBJiD7WMoU7WG5Rw==/109951166093489621.jpg","badge":null},{"rank":24,"title":"KTV唛榜","desc":"KTV唛榜是目前国内首个以全国超过200家KTV点歌平台真实数据的当红歌曲榜单。所涉及的KTV店铺覆盖全国近100多个城市，囊括一、二、三线各级城市及地区。在综…","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/5wDP78s43ydVTKt62C8OjQ==/109951165613100063.jpg","badge":null},{"rank":25,"title":"日本Oricon榜","desc":"日本Oricon数字单曲周榜，每周三更新，欢迎关注。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/aXUPgImt8hhf4cMUZEjP4g==/109951165611417794.jpg","badge":null},{"rank":26,"title":"网易云欧美热歌榜","desc":"网易云用户一周内收听所有欧美歌曲官方TOP排行榜，每周四更新。\nWestern Hit Chart (updated every Thursday)","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/70_EO_Dc7NT_hhfvsapzcQ==/109951167430862162.jpg","badge":null},{"rank":27,"title":"网易云欧美新歌榜","desc":"网易云用户一周内收听所有欧美新歌（一月内最新发行）官方TOP排行榜，每天更新。\nWestern New Release Chart (new songs rel…","value":"每天更新","link":null,"cover":"https://p1.music.126.net/0lPWpI9Ejn1OiW2LSbg-qw==/109951167430863224.jpg","badge":null},{"rank":28,"title":"法国 NRJ Vos Hits 周榜","desc":"法国NRJ电台（national Radio de Jeunes）成立于1981年，总部位于法国巴黎。是法国最受欢迎的音乐电台和听众最多的广播电台之一。NRJ音…","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/-fyzrPWd06FfWl_0JDAxMQ==/109951165613108584.jpg","badge":null},{"rank":29,"title":"网易云ACG动画榜","desc":"网易云中每天热度上升最快的100首ACG动画单曲，每日更新。","value":"每天更新","link":null,"cover":"https://p1.music.126.net/SkGlKQ6acixthb77VlD9eQ==/109951164432300406.jpg","badge":null},{"rank":30,"title":"网易云ACG游戏榜","desc":"网易云中每天热度上升最快的100首ACG游戏单曲，每日更新。","value":"每天更新","link":null,"cover":"https://p1.music.126.net/hivOOHMwEmnn9s_6rgZwEQ==/109951164432303700.jpg","badge":null},{"rank":31,"title":"网易云ACG VOCALOID榜","desc":null,"value":"每天更新","link":null,"cover":"https://p1.music.126.net/Ag7RyRCYiINcd9EtRXf6xA==/109951164432303690.jpg","badge":null},{"rank":32,"title":"网易云日语榜","desc":"网易云用户一周内收听所有日语歌曲官方TOP排行榜，每周二更新。","value":"每周二更新","link":null,"cover":"https://p1.music.126.net/YFBFNI2F-4BveUpv6FKFuw==/109951167430864069.jpg","badge":null},{"rank":33,"title":"网易云摇滚榜","desc":"网易云用户一周内收听所有摇滚歌曲官方TOP排行榜，每周五更新。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/LjkX2hktgFD1NXc3W6w0sA==/109951170048522513.jpg","badge":null},{"rank":34,"title":"网易云国风榜","desc":"网易云用户一周内收听所有国风歌曲官方TOP排行榜，每周五更新。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/kTJC5OBhg8I477X_ZmXyDQ==/109951168539740982.jpg","badge":null},{"rank":35,"title":"潜力爆款榜","desc":"全民一起PICK潜力好歌，每周二更新","value":"每周二更新","link":null,"cover":"https://p1.music.126.net/Mi4QPklg1mtbWAfq74tEqQ==/109951165498334721.jpg","badge":null},{"rank":36,"title":"网易云民谣榜","desc":"网易云用户一周内收听所有民谣歌曲官方TOP排行榜，每周五更新。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/Xe9qLTAqtBAWX_hPgFHMyw==/109951170048510929.jpg","badge":null},{"rank":37,"title":"听歌识曲榜","desc":"网易云音乐站内歌曲按用户“听歌识曲”次数排列，每周四更新","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/wJVUAiUuykKk7yGbQxDBug==/109951167430857712.jpg","badge":null},{"rank":38,"title":"网络热歌榜","desc":"网罗一周热门网络歌曲，反映云音乐用户近一周网络热歌收听趋势。每周五更新。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/_kSxOPqQ5J5etC5DKTFwNA==/109951170048519530.jpg","badge":null},{"rank":39,"title":"俄语榜","desc":"网易云音乐用户一周内收听所有俄罗斯语歌曲官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/HbJ0BK5doY4I4pEMY6-FQw==/109951167430852698.jpg","badge":null},{"rank":40,"title":"越南语榜","desc":"网易云音乐用户一周内收听所有越南语歌曲官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/N-Y5maLGWgrowt3TE6RtSg==/109951167430857045.jpg","badge":null},{"rank":41,"title":"中文慢摇DJ榜","desc":"搜索“DJ”，进入慢摇DJ专区，探索更多网络热歌！","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/w_01BfDU012ojxnzLO6tYw==/109951167977358686.jpg","badge":null},{"rank":42,"title":"俄罗斯top hit流行音乐榜","desc":"top hit榜根据俄罗斯及全球400多个无线广播的音乐播放量和YouTube播放量计算得来，每周一更新。","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/KLVO8PxVZzOoLdWQQNyprA==/109951166327316568.jpg","badge":null},{"rank":43,"title":"泰语榜","desc":"网易云音乐用户一周内收听所有泰语歌曲官方TOP排行榜，每周四更新。","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/4W0WBHBgwYlYfRniuyL47A==/109951167430843284.jpg","badge":null},{"rank":44,"title":"BEAT排行榜","desc":"嘿~朋友，欢迎来到本周的Beat排行榜\n我们挑选了近一周内热门的Beat作品，一起来感受下大家近期的“口味”吧！\n每周都会更新哦，记得按下收藏，我每天都会在这里…","value":"每周四更新","link":null,"cover":"https://p1.music.126.net/yhzlQJCJ9NcT4MvJBG_HgQ==/109951167977014958.jpg","badge":null},{"rank":45,"title":"星云榜VOL.31 翁杰新专来袭，愿我们拥有广阔的天地！","desc":"精心评审，专业推荐，为你呈现宝藏新歌。\n1.《城乡》 翁杰Winjay\n2.《Next 2 U》 OHYUL of LNGSHOT,LOUIS of LNGSH…","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/m9HWYdcz9xH-7SSito3-3A==/109951172864859483.jpg","badge":null},{"rank":46,"title":"LOOK直播歌曲榜","desc":"LOOK直播好歌共赏，专属你的声音聊愈场。榜单选取符合条件且近7日热度最高的前50首歌曲，每周二更新。","value":"每周二更新","link":null,"cover":"https://p1.music.126.net/u-RQC-LyY0aoeseRumJ14A==/109951167977730469.jpg","badge":null},{"rank":47,"title":"赏音榜","desc":"云音乐歌曲赏音榜，以让用户鉴赏到更多潜力好歌为目的，以用户对歌曲互动热度为核心，按照综合数据排名取前100名，每日更新","value":"每天更新","link":null,"cover":"https://p1.music.126.net/m9hQzC-d5wefBipedNPaHg==/109951168178601971.jpg","badge":null},{"rank":48,"title":"黑胶VIP新歌榜","desc":"云音乐站内播放热度TOP50的7日内新晋会员歌曲，每日更新。\n更适合黑胶体质的新歌榜单来啦！\n耳机分你一只，新曲一起来听~\n成为尊贵黑胶，不错过每一首VIP新歌…","value":"每天更新","link":null,"cover":"https://p1.music.126.net/vjitpkT9nXBCth6tvdDMWg==/109951169743115266.jpg","badge":null},{"rank":49,"title":"黑胶VIP热歌榜","desc":"云音乐站内播放和付费热度TOP50的会员歌曲，每日更新。\n更适合黑胶体质的热歌榜单来啦！\n哪首是你的单曲循环？\n成为尊贵黑胶，随心畅听热门好歌！","value":"每天更新","link":null,"cover":"https://p1.music.126.net/Ay3mLgQ9weG_c8JjYrD-Bw==/109951169743106495.jpg","badge":null},{"rank":50,"title":"黑胶VIP爱搜榜","desc":"云音乐站内会员搜索播放热度TOP50的歌曲，每日更新。\n更适合黑胶体质的搜歌榜单来啦！\n热搜好歌一网打尽，只为有品位的你~\n成为尊贵黑胶，你搜我听畅听不停！","value":"每天更新","link":null,"cover":"https://p1.music.126.net/R7DtZqNraesnsiaIKvzTHA==/109951169743112799.jpg","badge":null},{"rank":51,"title":"实时热度榜","desc":"云音乐中实时热度上升最快的100首单曲，每小时更新。","value":"更新48首","link":null,"cover":"https://p1.music.126.net/pvB8xRE2LMNxa-15ro69tw==/109951173645098023.jpg","badge":null},{"rank":52,"title":"喜力®星电音派对潮音榜","desc":"乐无界，越未来！《星电音联盟》歌曲官方榜单，每周一更新，让云村村民们随时随地躁起高燃派对氛围！喜力®星电音构建狂欢永不停歇的新奇电音宇宙，激活潮流基因，释放先锋…","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/HVu2hGYvzN5XBuvFc_4Bgg==/109951168730309120.jpg","badge":null},{"rank":53,"title":"乐夏榜","desc":"听乐夏，上网易云，一头扎进爱音乐的人群！ 综艺《乐队的夏天3》官方榜单，每周一更新。和三星折叠屏手机一起畅听《乐队的夏天3》官方榜单，折叠看三星，五代更来劲。","value":"每周一更新","link":null,"cover":"https://p1.music.126.net/RlStCmE97y0xYFk7rS3Zww==/109951168864907822.jpg","badge":null},{"rank":54,"title":"特斯拉车友爱听榜","desc":null,"value":"每周一更新","link":null,"cover":"https://p1.music.126.net/UL8dhobSa3TR6Wd1JmWe_g==/109951168924385363.jpg","badge":null},{"rank":55,"title":"理想车友爱听榜","desc":null,"value":"每周一更新","link":null,"cover":"https://p1.music.126.net/U--PWdWupY1ER5cVSjr1jQ==/109951168928365496.jpg","badge":null},{"rank":56,"title":"比亚迪车友爱听榜","desc":null,"value":"每周一更新","link":null,"cover":"https://p1.music.126.net/S1OG-OLTaofa3HfrHW48kA==/109951168924393585.jpg","badge":null},{"rank":57,"title":"蔚来车友爱听榜","desc":null,"value":"每周一更新","link":null,"cover":"https://p1.music.126.net/r9kBQNsOro1EAB82Ol51WQ==/109951168924380971.jpg","badge":null},{"rank":58,"title":"极氪车友爱听榜","desc":null,"value":"每周一更新","link":null,"cover":"https://p1.music.126.net/Cu0RXoKewSPM9Gyc7Cp8jw==/109951168924391596.jpg","badge":null},{"rank":59,"title":"蛋仔派对听歌榜","desc":"来自蛋仔岛的热播歌曲速递，网易《蛋仔派对》官方榜单，每周五更新。云村村民们，和蛋仔们一起随歌摇摆吧！","value":"每周五更新","link":null,"cover":"https://p1.music.126.net/TMb0be5QLMZKOFeuOKT4tg==/109951168717283910.jpg","badge":null},{"rank":60,"title":"AI歌曲榜","desc":"精心挑选每日最新最热AI生成歌曲，榜单每日更新，一起感受AI的独特魅力吧！","value":"每天更新","link":null,"cover":"https://p1.music.126.net/M0m6GeZ1Y8Osz9jqxaW8Wg==/109951169462048035.jpg","badge":null}],"total":65}',25809,10927,'2026-11-02T00:37:04.840Z',NULL,'2026-11-02T00:37:04.840Z'),
('daily-60s','/v2/60s','每天 60 秒读懂世界','今日新闻速览','info','list',1,200,NULL,'{"kind":"list","items":[{"rank":1,"title":"2027 年春节有望连休 9 天：除夕 2 月 5 日恰逢周五，顺连周末可实现从除夕至正月初八连休"},{"rank":2,"title":"前 10 个月百强房企销售总额超 2.5 万亿元，65 家房企单月销售额环比增长"},{"rank":3,"title":"上海 10 月二手住房成交量 2.23 万套，同比增加 34%，创近 6 年同期新高"},{"rank":4,"title":"前三季度沪深两市上市公司净利润 5.1 万亿元、同比增 8.5%，创 2022 年以来新高，73% 公司盈利"},{"rank":5,"title":"国有某大行计划向中国国新和中国诚通各新增千亿级股票回购增持专项贷款额度"},{"rank":6,"title":"铁路部门启动 “双 11” 高峰期快件运输服务，每日安排高铁载客动车组列车约 1900 列"},{"rank":7,"title":"Token 首次摆上 “双 11” 货架，算力服务变成明码标价、可下单的商品"},{"rank":8,"title":"报告预计，2026 年中国大宗商品价格指数均值为 132.1 点，较上年上涨 17.6%"},{"rank":9,"title":"多所高校明确 “严禁全程依赖 PPT”，央媒：课堂主角永远是人"},{"rank":10,"title":"多个地方行业协会宣布自行解散：因部分会员失联、达不到开会人数要求"},{"rank":11,"title":"调查显示日本 11 月将有近 1500 种食品涨价，全年涨价的食品预计将超过 2 万种"},{"rank":12,"title":"加拿大与欧盟启动构建 “未来联盟” ，以实现共同繁荣；特朗普曾称此举 “可笑”"},{"rank":13,"title":"二十国集团外长会未就地缘和经济安全问题达成共识，美方临时取消外长 “全家福” 合影"},{"rank":14,"title":"印度爆发大规模集会，指控莫迪修订选民名册，选择性剔除超过 1.3 亿选民"},{"rank":15,"title":"法国、德国、意大利、葡萄牙、西班牙、荷兰六国同一天出现大规模集会，数百人被捕"}],"total":15}',1343,979,'2026-11-02T00:37:04.840Z','2026-11-01T21:32:56.692Z','2026-11-02T00:37:04.840Z'),
('bing-wallpaper','/v2/bing','必应每日壁纸','今日 Bing 壁纸','info','image',1,200,NULL,'{"kind":"image","image":"https://bing.com/th?id=OHR.HudsonBear_ZH-CN6630706907_1920x1080.jpg","title":"写在冰上的未来","desc":"写在冰上的未来"}',464,129,'2026-11-02T00:37:06.119Z',NULL,'2026-11-02T00:37:06.119Z');
insert or replace into nav_categories (key, name, grp, icon, sort, status, created_at, updated_at) values
('AI聊天对话','AI聊天对话','AI 工具','',45,'active','2026-11-02T01:50:53.518Z',NULL),
('AI代码编程','AI代码编程','AI 工具','',46,'active','2026-11-02T01:50:53.518Z',NULL),
('AI图像绘画','AI图像绘画','AI 工具','',47,'active','2026-11-02T01:50:53.518Z',NULL),
('AI文档办公','AI文档办公','AI 工具','',48,'active','2026-11-02T01:50:53.518Z',NULL),
('国内防护','国内防护','代理防护','',41,'active','2026-11-02T01:50:53.518Z',NULL),
('国际防护','国际防护','代理防护','',42,'active','2026-11-02T01:50:53.518Z',NULL),
('国内代理','国内代理','代理防护','',43,'active','2026-11-02T01:50:53.518Z',NULL),
('国际代理','国际代理','代理防护','',50,'active','2026-11-02T01:50:53.518Z',NULL),
('APP其他','APP其他','其他','',36,'active','2026-11-02T01:50:53.518Z',NULL),
('AFF','AFF','商业推广','',0,'active','2026-11-02T01:50:53.518Z',NULL),
('教程','教程','学习提升','',7,'active','2026-11-02T01:50:53.518Z',NULL),
('比赛','比赛','学习提升','',12,'active','2026-11-02T01:50:53.518Z',NULL),
('刷题','刷题','学习提升','',13,'active','2026-11-02T01:50:53.518Z',NULL),
('学习文档','学习文档','学习提升','',17,'active','2026-11-02T01:50:53.518Z',NULL),
('文档资料','文档资料','学习提升','',20,'active','2026-11-02T01:50:53.518Z',NULL),
('练习平台','练习平台','学习提升','',53,'active','2026-11-02T01:50:53.518Z',NULL),
('工具','工具','开发工具','',3,'active','2026-11-02T01:50:53.518Z',NULL),
('设计','设计','开发工具','',6,'active','2026-11-02T01:50:53.518Z',NULL),
('前端','前端','开发工具','',8,'active','2026-11-02T01:50:53.518Z',NULL),
('编程','编程','开发工具','',11,'active','2026-11-02T01:50:53.518Z',NULL),
('Github项目','Github项目','开发工具','',14,'active','2026-11-02T01:50:53.518Z',NULL),
('Python库','Python库','开发工具','',15,'active','2026-11-02T01:50:53.518Z',NULL),
('后端','后端','开发工具','',16,'active','2026-11-02T01:50:53.518Z',NULL),
('Python三方库','Python三方库','开发工具','',18,'active','2026-11-02T01:50:53.518Z',NULL),
('在线工具','在线工具','开发工具','',22,'active','2026-11-02T01:50:53.518Z',NULL),
('接口调试','接口调试','开发工具','',24,'active','2026-11-02T01:50:53.518Z',NULL),
('监控管理','监控管理','开发工具','',25,'active','2026-11-02T01:50:53.518Z',NULL),
('其他工具','其他工具','开发工具','',26,'active','2026-11-02T01:50:53.518Z',NULL),
('效率工具','效率工具','开发工具','',27,'active','2026-11-02T01:50:53.518Z',NULL),
('环境框架','环境框架','开发工具','',31,'active','2026-11-02T01:50:53.518Z',NULL),
('优质项目','优质项目','开发工具','',51,'active','2026-11-02T01:50:53.518Z',NULL),
('网盘分享','网盘分享','资源社区','',1,'active','2026-11-02T01:50:53.518Z',NULL),
('影视','影视','资源社区','',2,'active','2026-11-02T01:50:53.518Z',NULL),
('个人站','个人站','资源社区','',4,'active','2026-11-02T01:50:53.518Z',NULL),
('网站导航','网站导航','资源社区','',10,'active','2026-11-02T01:50:53.518Z',NULL),
('资源','资源','资源社区','',19,'active','2026-11-02T01:50:53.518Z',NULL),
('娱乐影音','娱乐影音','资源社区','',21,'active','2026-11-02T01:50:53.518Z',NULL),
('交流论坛','交流论坛','资源社区','',44,'active','2026-11-02T01:50:53.518Z',NULL),
('推广','推广','资源社区','',49,'active','2026-11-02T01:50:53.518Z',NULL),
('国外论坛','国外论坛','资源社区','',52,'active','2026-11-02T01:50:53.518Z',NULL),
('逆向相关','逆向相关','逆向安全','',9,'active','2026-11-02T01:50:53.518Z',NULL),
('调试运行','调试运行','逆向安全','',28,'active','2026-11-02T01:50:53.518Z',NULL),
('代码混淆','代码混淆','逆向安全','',29,'active','2026-11-02T01:50:53.518Z',NULL),
('脱壳工具','脱壳工具','逆向安全','',33,'active','2026-11-02T01:50:53.518Z',NULL),
('APP反编译','APP反编译','逆向安全','',35,'active','2026-11-02T01:50:53.518Z',NULL),
('小程序反编译','小程序反编译','逆向安全','',37,'active','2026-11-02T01:50:53.518Z',NULL),
('网络安全','网络安全','逆向安全','',54,'active','2026-11-02T01:50:53.518Z',NULL),
('爬虫','爬虫','采集自动化','',5,'active','2026-11-02T01:50:53.518Z',NULL),
('抓包工具','抓包工具','采集自动化','',23,'active','2026-11-02T01:50:53.518Z',NULL),
('指纹相关','指纹相关','采集自动化','',30,'active','2026-11-02T01:50:53.518Z',NULL);
insert or replace into nav_categories (key, name, grp, icon, sort, status, created_at, updated_at) values
('自动化RPC','自动化RPC','采集自动化','',32,'active','2026-11-02T01:50:53.518Z',NULL),
('Hook工具','Hook工具','采集自动化','',34,'active','2026-11-02T01:50:53.518Z',NULL),
('打码平台','打码平台','采集自动化','',38,'active','2026-11-02T01:50:53.518Z',NULL),
('开源识别','开源识别','采集自动化','',39,'active','2026-11-02T01:50:53.518Z',NULL),
('轨迹相关','轨迹相关','采集自动化','',40,'active','2026-11-02T01:50:53.518Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('11刀一年2g的vps','https://cloud.colocrossing.com/aff.php?aff=1191&pid=95','AFF','商业推广','11刀一年的机器','',0,'active','2026-11-02T01:50:54.886Z',NULL),
('2Captcha','https://2captcha.com/?from=17553728','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、Geetest、FunCaptcha、Cloudflare、AWS WAF、Audio 等识别，支持直接返回 token 解决方案。','',10,'active','2026-11-02T01:50:54.886Z',NULL),
('360 智脑','https://chat.360.cn/','AI聊天对话','AI 工具','360 智脑为 360 自研千亿参数大语言模型，已具备生成与创作、多轮对话、代码能力、文本分类、文本改写、阅读理解、逻辑与推理、知识问答、多模态、翻译等十大核心能力，维度涵盖数百项细分功能，可覆盖大模型全部应用场景。','',20,'active','2026-11-02T01:50:54.886Z',NULL),
('52破解','https://www.52pojie.cn/','逆向相关','逆向安全','教程','',30,'active','2026-11-02T01:50:54.886Z',NULL),
('A Primer on Bézier Curves','https://pomax.github.io/bezierinfo/','轨迹相关','采集自动化','贝塞尔曲线的详细介绍。','',40,'active','2026-11-02T01:50:54.886Z',NULL),
('ADB Shell','https://adbshell.com/','文档资料','学习提升','Android ADB 命令手册。','',50,'active','2026-11-02T01:50:54.886Z',NULL),
('ADBGUI','https://github.com/bigsinger/adbgui','APP其他','其他','使用 C# 编写的界面版 adb 操作工具，方便高效。','',60,'active','2026-11-02T01:50:54.886Z',NULL),
('AI 艺术二维码','https://qr.mewx.art/?invite_code=RVP98wzb','AI图像绘画','AI 工具','使用 MewXAI星月熊 在几秒内创建令人惊叹的下一代艺术二维码和艺术字。 从此告别单调的黑白二维码和文字，留下令人深刻的印象！','',70,'active','2026-11-02T01:50:54.886Z',NULL),
('AISecurius','https://www.aisecurius.com/','国内防护','代理防护','顶象国际版，国际版验证码 atbCAPTCHA。','',80,'active','2026-11-02T01:50:54.886Z',NULL),
('AST Explorer','https://astexplorer.net/','在线工具','开发工具','一个使用各种解析器生成代码的 AST 的 Web 工具。','',90,'active','2026-11-02T01:50:54.886Z',NULL),
('AST工具','https://astexplorer.net/','工具','开发工具','js_to_ast','',100,'active','2026-11-02T01:50:54.886Z',NULL),
('AWS Captcha','https://docs.aws.amazon.com/waf/latest/developerguide/waf-captcha-puzzle.html','国际防护','代理防护','AWS WAF provides standard CAPTCHA functionality that challenges users to confirm that they are human beings. CAPTCHA stands for Completely Automated Public Turing test to tell Computers and Humans Apart. CAPTCHA puzzles are designed to verify that a human is sending requests and to prevent activity like web scraping, credential stuffing, and spam.','',110,'active','2026-11-02T01:50:54.886Z',NULL),
('AcWing','https://www.acwing.com/','刷题','学习提升','专属于程序员的平台,漫漫的刷题之旅中,提供最优质的解答.','',120,'active','2026-11-02T01:50:54.886Z',NULL),
('Adobe Firefly','https://firefly.adobe.com/','AI图像绘画','AI 工具','Firefly 是 Adobe 推出的创意生成式 AI，允许内容创作者使用自己的文字来生成图像、音频、插图、视频和3D图像。','',130,'active','2026-11-02T01:50:54.886Z',NULL),
('Airtest','https://airtest.netease.com/','自动化RPC','采集自动化','Airtest是一个跨平台的UI自动化测试框架，适用于游戏和App。目前支持Windows和Android平台，iOS支持正在开发中。','',140,'active','2026-11-02T01:50:54.886Z',NULL),
('Akamai','https://www.akamai.com/','国际防护','代理防护','Akamai Connected Cloud is a massively distributed edge and cloud platform that keeps experiences closer to users — and threats farther away.','',150,'active','2026-11-02T01:50:54.886Z',NULL),
('Ake','https://ake.net/','国际代理','代理防护','The largest database of mobile, residential and server proxies in one place.','',160,'active','2026-11-02T01:50:54.886Z',NULL),
('Alnitak','https://alnitak.interastral-peace.com/','Github项目','开发工具','前后端分离 完全开源 部署简单。Alnitak是一个基于nuxt和gin开发的前后端分离的弹幕视频网站。 项目实现了视频、专栏、弹幕、评论、点赞、收藏等功能。','',170,'active','2026-11-02T01:50:54.886Z',NULL),
('Android API','https://developer.android.com/reference','文档资料','学习提升','Android API 参考。','',180,'active','2026-11-02T01:50:54.886Z',NULL),
('Android Crack Tool','https://github.com/Jermic/Android-Crack-Tool','APP反编译','逆向安全','mac 下 Android 逆向神器，实用工具集，集成了Android开发中常见的一些编译/反编译工具，方便用户对 Apk 进行逆向分析，提供 Apk 信息查看功能。','',190,'active','2026-11-02T01:50:54.886Z',NULL),
('AndroidKiller','https://github.com/liaojack8/AndroidKiller','APP反编译','逆向安全','Android 应用程序逆向工具(apk反编译工具)。','',200,'active','2026-11-02T01:50:54.886Z',NULL),
('Ant','https://ant.design/index-cn','前端','开发工具','基于 Ant Design 设计体系的 React UI 组件库，主要用于研发企业级中后台产品。','',210,'active','2026-11-02T01:50:54.886Z',NULL),
('Anti Captcha','https://anti-captcha.com/','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、FunCaptcha、Cloudflare 等平台，直接返回 token 解决方案。','',220,'active','2026-11-02T01:50:54.886Z',NULL),
('AntiBot','https://bot.sannysoft.com/','指纹相关','采集自动化','无头浏览器检测','',230,'active','2026-11-02T01:50:54.886Z',NULL),
('Apifox','https://apifox.com/','接口调试','开发工具','Apifox - API 文档、调试、Mock、测试一体化协作平台。拥有接口文档管理、接口调试、Mock、自动化测试等功能，接口开发、测试、联调效率，提升 10 倍。最好用的接口文档管理工具，接口自动化测试工具。','',240,'active','2026-11-02T01:50:54.886Z',NULL),
('Apipost','https://www.apipost.cn/','接口调试','开发工具','Apipost 是集 API 设计、API 调试、API 文档、自动化测试为一体的 API 研发协同平台,支持 grpc、http、websocket、socketio、socketjs 类型接口调试,支持私有化部署。','',250,'active','2026-11-02T01:50:54.886Z',NULL),
('Apktool','https://apktool.org/','APP反编译','逆向安全','功能强大且操作简单的 apk 反编译工具。','',260,'active','2026-11-02T01:50:54.886Z',NULL),
('Appium','https://appium.io/','自动化RPC','采集自动化','开源的移动端自动化测试框架。','',270,'active','2026-11-02T01:50:54.886Z',NULL),
('Arkose Labs','https://www.arkoselabs.com/','国际防护','代理防护','Banish malicious bots and stop SMS toll fraud (IRSF), account takeovers, credential stuffing, and new account fraud – with protection that rolls out in hours.','',280,'active','2026-11-02T01:50:54.886Z',NULL),
('Asocks','https://asocks.com/','国际代理','代理防护','The Most Stable Residential Proxy Network.','',290,'active','2026-11-02T01:50:54.886Z',NULL),
('AutoJS6','https://github.com/SuperMonster003/AutoJs6','自动化RPC','采集自动化','Auto.js 是一款 Android 平台支持无障碍服务的 JavaScript 自动化工具软件，现已停止维护，AutoJS6 在 Auto.js 最终项目的基础上进行二次开发。','',300,'active','2026-11-02T01:50:54.886Z',NULL),
('Awesome Captcha','https://github.com/ZYSzys/awesome-captcha','开源识别','采集自动化','精选的验证码库和破解工具的精选列表。','',310,'active','2026-11-02T01:50:54.886Z',NULL),
('Babel 官方文档','https://babel.dev/docs/','文档资料','学习提升','Babel 官方文档。','',320,'active','2026-11-02T01:50:54.886Z',NULL),
('BlackDex','https://github.com/CodingGay/BlackDex','脱壳工具','逆向安全','BlackDex 是一个运行在Android手机上的脱壳工具，支持5.0～12，无需依赖任何环境任何手机都可以使用，包括模拟器。只需几秒，即可对已安装包括未安装的APK进行脱壳。','',330,'active','2026-11-02T01:50:54.886Z',NULL),
('Bot/Headless Chrome Detection','https://bot.incolumitas.com/','指纹相关','采集自动化','机器人/无头浏览器检测','',340,'active','2026-11-02T01:50:54.886Z',NULL),
('Browse AI','https://www.browse.ai/','AI代码编程','AI 工具','Browse AI 是一个网页数据抓取和监控爬虫工具，可以让你在几分钟内训练一个机器人，从任何网站提取你需要的数据，并且无需编写任何代码。你可以将抓取到的数据保存为电子表格，或者通过 API，Google Sheets，Zapier 等方式与其他应用程序集成。','',350,'active','2026-11-02T01:50:54.886Z',NULL),
('Browser Leaks','https://browserleaks.com/','指纹相关','采集自动化','提供一系列测试来评估网络浏览器的安全性和隐私性','',360,'active','2026-11-02T01:50:54.886Z',NULL),
('Bun','https://bun.sh/','前端','开发工具','一个一体化的JavaScript运行时和工具包，专为提高速度而设计，包括编译器、测试运行器和与Node.js兼容的包管理器。使用Bun开发、测试、运行和捆绑JavaScript和TypeScript项目。Develop, test, run, and bundle JavaScript & TypeScript projects—all with Bun. Bun is an all-in-one JavaScript runtime & toolkit designed for speed, complete with a bundler, test runner, and Node.js-compatible package manager.','',370,'active','2026-11-02T01:50:54.886Z',NULL),
('Bytecode Viewer','https://github.com/Konloch/bytecode-viewer','APP反编译','逆向安全','支持 apk、dex 等多种文件格式的反编译。','',380,'active','2026-11-02T01:50:54.886Z',NULL),
('CODELF','https://unbug.github.io/codelf/','工具','开发工具','变量命名神器.','',390,'active','2026-11-02T01:50:54.886Z',NULL),
('CSDN','https://www.csdn.net/','教程','学习提升','教程','',400,'active','2026-11-02T01:50:54.886Z',NULL),
('CSDN 爬虫逆向社区','https://bbs.csdn.net/forums/lx','交流论坛','资源社区','CSDN 李玺爬虫逆向技术交流社区。','',410,'active','2026-11-02T01:50:54.886Z',NULL),
('CSDN 逆向安全社区','https://bbs.csdn.net/forums/ReverseSecurity','交流论坛','资源社区','CSDN 逆向安全社区。','',420,'active','2026-11-02T01:50:54.886Z',NULL),
('CTF工具','https://ctf.020417.xyz/','个人站','资源社区','tools','',430,'active','2026-11-02T01:50:54.886Z',NULL),
('CapSolver','https://www.capsolver.com/','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、Geetest、FunCaptcha、Cloudflare、MTCaptcha、AWS WAF、DataDome、Cybersiara captcha 等识别，支持直接返回 token 解决方案。','',440,'active','2026-11-02T01:50:54.886Z',NULL),
('CaptchaAI','https://captchaai.com/','打码平台','采集自动化','号称第一的 reCAPTCHA、hCaptcha 识别方案解决平台。','',450,'active','2026-11-02T01:50:54.886Z',NULL),
('Carbon','https://carbon.now.sh/','在线工具','开发工具','将代码转为精美的图片。','',460,'active','2026-11-02T01:50:54.886Z',NULL),
('Charles','https://www.charlesproxy.com/','抓包工具','采集自动化','Charles 抓包工具，又被戏称为尿壶、夜壶。','',470,'active','2026-11-02T01:50:54.886Z',NULL),
('Charlesproxy抓包工具','https://www.charlesproxy.com/','爬虫','采集自动化','爬虫工具箱','',480,'active','2026-11-02T01:50:54.886Z',NULL),
('Chart.js','https://www.chartjs.org/','前端','开发工具','Simple yet flexible JavaScript charting library for the modern web','',490,'active','2026-11-02T01:50:54.886Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('Chrome for Testing availability','https://googlechromelabs.github.io/chrome-for-testing/','自动化RPC','采集自动化','获取 Stable 版、Beta 版、Dev 版、Canary 版 chromedriver。','',500,'active','2026-11-02T01:50:54.886Z',NULL),
('ChromeDriver','https://chromedriver.storage.googleapis.com/index.html','自动化RPC','采集自动化','所有版本的 chromedriver 下载页面。','',510,'active','2026-11-02T01:50:54.886Z',NULL),
('Cloudflare','https://www.cloudflare.com/','国际防护','代理防护','Here at Cloudflare, we make the Internet work the way it should. Offering CDN, DNS, DDoS protection and security, find out how we can help your site.','',520,'active','2026-11-02T01:50:54.886Z',NULL),
('CodeGeeX','https://codegeex.cn/','AI代码编程','AI 工具','CodeGeeX 是清华和智谱 AI 联合打造的多语言代码生成模型。','',530,'active','2026-11-02T01:50:54.886Z',NULL),
('CodeWhisperer','https://aws.amazon.com/cn/codewhisperer/','AI代码编程','AI 工具','CodeWhisperer，亚马逊推出的实时AI编程助手，是一项基于机器学习的服务，它可以分析开发者在集成开发环境（IDE）中的注释和代码，并根据其内容生成多种代码建议。','',540,'active','2026-11-02T01:50:54.886Z',NULL),
('Copilot','https://copilot.github.com/','AI代码编程','AI 工具','GitHub Copilot 是 GitHub 与 OpenAI 共同推出的一款 AI 编程工具，它基于 GitHub 及其他网站的源代码，可根据上文提示为程序员自动编写下文代码。','',550,'active','2026-11-02T01:50:54.886Z',NULL),
('Crack-JS-Spider','https://github.com/LoseNine/Crack-JS-Spider','优质项目','开发工具','JS 破解逆向，破解 JS 反爬虫加密参数。','',560,'active','2026-11-02T01:50:54.886Z',NULL),
('CrackMinApp','https://github.com/Cherrison/CrackMinApp','小程序反编译','逆向安全','(反编译微信小程序)一键获取微信小程序源码(傻瓜式操作), 使用了 C# 加 nodejs 制作。','',570,'active','2026-11-02T01:50:54.886Z',NULL),
('Crawlab','https://www.crawlab.cn/','监控管理','开发工具','分布式爬虫管理平台，支持任何语言和框架。','',580,'active','2026-11-02T01:50:54.886Z',NULL),
('CreepJS','https://abrahamjuliot.github.io/creepjs/','指纹相关','采集自动化','浏览器指纹检测','',590,'active','2026-11-02T01:50:54.886Z',NULL),
('Curl Converter','https://curlconverter.com/','在线工具','开发工具','将 curl 命令转换为 Python、JavaScript、Go 等任何语言。','',600,'active','2026-11-02T01:50:54.886Z',NULL),
('Curl转换','https://curlconverter.com/','爬虫','采集自动化','爬虫工具箱','',610,'active','2026-11-02T01:50:54.886Z',NULL),
('CyberSiara','https://www.cybersiara.com/','国际防护','代理防护','The most advanced human verification tool for website security against bots, spam, credit card fraud, and other cybercrime. An effective alternative to reCaptcha, hCaptcha, and honeypots.','',620,'active','2026-11-02T01:50:54.886Z',NULL),
('CycleTLS','https://github.com/Danny-Dasilva/CycleTLS','指纹相关','采集自动化','在 GO 和 Javascript 中模拟 TLS/JA3 指纹。','',630,'active','2026-11-02T01:50:54.886Z',NULL),
('Deobfuscate','https://deobfuscate.io/','代码混淆','逆向安全','一个简单但功能强大的反混淆器，支持 OB 反混淆。','',640,'active','2026-11-02T01:50:54.886Z',NULL),
('Detect Headless','https://infosimples.github.io/detect-headless/','指纹相关','采集自动化','无头浏览器检测','',650,'active','2026-11-02T01:50:54.886Z',NULL),
('DeveloperHelper','https://github.com/WrBug/DeveloperHelper','脱壳工具','逆向安全','易开发是一款帮助开发人员快速开发的工具，功能包括界面分析，页面信息，加固脱壳，支持Android9.0。','',660,'active','2026-11-02T01:50:54.886Z',NULL),
('Django','https://www.djangoproject.com/','Python三方库','开发工具','Django让构建更好的Web应用程序变得更容易，更快，更少的代码。','',670,'active','2026-11-02T01:50:54.886Z',NULL),
('Docker 官方文档','https://docs.docker.com/','文档资料','学习提升','Docker 官方文档。','',680,'active','2026-11-02T01:50:54.886Z',NULL),
('DrissionPage','https://github.com/g1879/DrissionPage','自动化RPC','采集自动化','基于python的网页自动化工具。既能控制浏览器，也能收发数据包。可兼顾浏览器自动化的便利性和requests的高效率。功能强大，内置无数人性化设计和便捷功能。语法简洁而优雅，代码量少。','',690,'active','2026-11-02T01:50:54.886Z',NULL),
('ECharts','https://echarts.apache.org/zh/index.html','前端','开发工具','一个基于 JavaScript 的开源可视化图表库','',700,'active','2026-11-02T01:50:54.886Z',NULL),
('Easing functions','https://easings.net/','文档资料','学习提升','缓动函数表，可基于此类函数生成滑动轨迹。','',710,'active','2026-11-02T01:50:54.886Z',NULL),
('Electron','https://www.electronjs.org/zh/','前端','开发工具','使用 JavaScript、HTML 和 CSS 构建桌面应用程序的框架。','',720,'active','2026-11-02T01:50:54.886Z',NULL),
('Element Plus','https://element-plus.org/zh-CN/','前端','开发工具','基于 Vue 3，面向设计师和开发者的组件库','',730,'active','2026-11-02T01:50:54.886Z',NULL),
('Eolink','https://www.eolink.com/','接口调试','开发工具','Eolink 致力于打造一站式、智能化的 API 全生命周期解决方案，为企业用户提供完善的 API 接口管理、API 规范化治理、API 研发流程优化、API 性能和安全保障、API 数据服务开放及交易等创新服务。','',740,'active','2026-11-02T01:50:54.886Z',NULL),
('ExplainPaper','https://www.explainpaper.com/','AI文档办公','AI 工具','explainpaper，ai学术论文，文献阅读助手。','',750,'active','2026-11-02T01:50:54.886Z',NULL),
('F5 & Shape Security','https://www.f5.com/','国际防护','代理防护','F5 application services ensure that applications are always secure and perform the way they should—in any environment and on any device.','',760,'active','2026-11-02T01:50:54.886Z',NULL),
('FART','https://github.com/hanbinglengyue/FART','脱壳工具','逆向安全','ART 环境下自动化脱壳方案。','',770,'active','2026-11-02T01:50:54.886Z',NULL),
('FRIDA-DEXDump','https://github.com/hluwa/frida-dexdump','脱壳工具','逆向安全','号称“葫芦娃”，Frida集成工具，实现一键脱壳。','',780,'active','2026-11-02T01:50:54.886Z',NULL),
('Faceswap','https://faceswap.dev/','AI图像绘画','AI 工具','FaceSwap 是一个利用深度学习来识别图片和视频中的人脸，并进行变换人脸的工具。','',790,'active','2026-11-02T01:50:54.886Z',NULL),
('FastAPI','https://fastapi.tiangolo.com/','Python三方库','开发工具','FastAPI 框架，高性能，易于学习，高效编码，生产可用','',800,'active','2026-11-02T01:50:54.886Z',NULL),
('FastApi 官方文档','https://fastapi.tiangolo.com/','文档资料','学习提升','FastApi 官方文档。','',810,'active','2026-11-02T01:50:54.886Z',NULL),
('FeHelper','https://www.baidufe.com/fehelper/','效率工具','开发工具','Web开发者助手，包括JSON自动/手动格式化、JSON内容比对、代码美化与压缩、信息编解码转换、二维码生成与解码、图片Base64编解码转换、Markdown、 网页油猴、网页取色器、脑图(Xmind)等贴心工具。','',820,'active','2026-11-02T01:50:54.886Z',NULL),
('Feapder','https://feapder.com/','监控管理','开发工具','秉承着开发快速、抓取快速、简单、轻量且功能强大的原则，倾心打造，支持轻量级爬虫、分布式爬虫、批次爬虫、爬虫集成，以及完善的报警等。','',830,'active','2026-11-02T01:50:54.886Z',NULL),
('Fiddler','https://www.telerik.com/fiddler','抓包工具','采集自动化','Fiddler Classic 免费抓包工具，仅支持 Windows，Fiddler Everywhere 收费抓包工具，支持 MacOS, Windows 和 Linux。','',840,'active','2026-11-02T01:50:54.886Z',NULL),
('Fiddler 编程猫插件','https://pan.baidu.com/s/1GFJhq-AqFxty4DOrkjSuLA?pwd=sbox','效率工具','开发工具','Fiddler 编程猫专用插件 V1.0.8。','',850,'active','2026-11-02T01:50:54.886Z',NULL),
('Fingerprint','https://fingerprint.com/','国际防护','代理防护','The Fingerprint device intelligence platform works across web and mobile applications to identify all visitors with 99.5% accuracy — even if they’re anonymous.','',860,'active','2026-11-02T01:50:54.886Z',NULL),
('Flask','https://flask.palletsprojects.com/en/3.0.x/','Python三方库','开发工具','Flask是一个使用 Python 编写的轻量级 Web 应用框架。其 WSGI 工具箱采用 Werkzeug ，模板引擎则使用 Jinja2 。Flask使用 BSD 授权。','',870,'active','2026-11-02T01:50:54.886Z',NULL),
('FontCreator','https://www.high-logic.com/font-editor/fontcreator','其他工具','开发工具','FontCreator 是一个强大的字体编辑软件，逆向中常用作字体加密的分析。','',880,'active','2026-11-02T01:50:54.886Z',NULL),
('Free ChatGPT Site List','https://d0424.ai55.cc/','AI聊天对话','AI 工具','Free ChatGPT Site List，众多免费好用的 ChatGPT 国内镜像站点。','',890,'active','2026-11-02T01:50:54.886Z',NULL),
('Frida','https://github.com/frida/frida','Hook工具','采集自动化','Frida 是一种动态插桩工具，可以插入一些代码到原生app的内存空间去，动态地监视和修改其行为，可对内存空间里的对象方法实现监视、修改甚至替换。','',900,'active','2026-11-02T01:50:54.886Z',NULL),
('Frida 官方文档','https://frida.re/docs/','文档资料','学习提升','Frida 官方文档。','',910,'active','2026-11-02T01:50:54.886Z',NULL),
('GDA','https://github.com/charles2gan/GDA-android-reversing-Tool','APP反编译','逆向安全','GDA，一款用C++实现的强大的Dalvik字节码反编译器，具有分析速度快、内存磁盘消耗低等优点，对apk、dex、odex、oat、jar、class、aar文件的反编译能力更强。','',920,'active','2026-11-02T01:50:54.886Z',NULL),
('GMail','https://mail.qq.com/cgi-bin/frame_html?sid=up6KZlz3BGBz40wu&r=ebc72a3dc579725eb92a51a5a7d86b2f','工具','开发工具','一款直观、高效、实用的电子邮件应用。免费提供15GB存储空间,垃圾邮件更少,而且支持移动访问。 一个帐户,畅享 Google所有服务!','',930,'active','2026-11-02T01:50:54.886Z',NULL),
('GeckoDriver','https://github.com/mozilla/geckodriver','自动化RPC','采集自动化','火狐浏览器的 webdriver。','',940,'active','2026-11-02T01:50:54.886Z',NULL),
('GeneralNewsExtractor','https://github.com/GeneralNewsExtractor/GeneralNewsExtractor','效率工具','开发工具','新闻网页正文通用抽取器 Beta 版。','',950,'active','2026-11-02T01:50:54.886Z',NULL),
('Gerapy','https://github.com/Gerapy/Gerapy','监控管理','开发工具','基于 Scrapy、Scrapyd、Django 和 Vue.js 的分布式爬虫管理框架。','',960,'active','2026-11-02T01:50:54.886Z',NULL),
('Ghidra','https://github.com/NationalSecurityAgency/ghidra','APP反编译','逆向安全','Ghidra 是一个由美国国家安全局研究局创建和维护的、开源的软件逆向工程 (SRE) 框架 。该框架包括一套功能齐全的高端软件分析工具，使用户能够在包括 Windows、macOS 和 Linux 在内的各种平台上分析编译的代码。功能包括反汇编、汇编、反编译、绘图和脚本编写，以及数百种其他功能。','',970,'active','2026-11-02T01:50:54.886Z',NULL),
('Ghost Cursor','https://github.com/Xetera/ghost-cursor','轨迹相关','采集自动化','在 puppeteer 或者任何 2D 平面上生成类似人类的鼠标运动。','',980,'active','2026-11-02T01:50:54.886Z',NULL),
('Gitee','https://gitee.com/','编程','开发工具','基于Git的代码托管平台,提供免费的私有仓库托管.','',990,'active','2026-11-02T01:50:54.886Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('Github','https://github.com/','编程','开发工具','一个面向开源及私有软件项目的托管平台.','',1000,'active','2026-11-02T01:50:54.886Z',NULL),
('Golang 官方文档','https://go.dev/doc/','文档资料','学习提升','Golang 官方文档。','',1010,'active','2026-11-02T01:50:54.886Z',NULL),
('Grafana','https://grafana.com/','监控管理','开发工具','Grafana 是一款开源的数据可视化工具，使用 Grafana 可以非常轻松的将数据转成图表的展现形式来做到数据监控以及数据统计。','',1020,'active','2026-11-02T01:50:54.886Z',NULL),
('HELLOGITHUB','https://hellogithub.com/','Github项目','开发工具','让对开源项目感兴趣的人不再畏惧、让开源项目的发起者不再孤单.','',1030,'active','2026-11-02T01:50:54.886Z',NULL),
('Header 自定义工具','https://chrome.google.com/webstore/detail/header%E8%87%AA%E5%AE%9A%E4%B9%89%E5%B7%A5%E5%85%B7/maaccnhcoaehdeehahenkmchinbdjjmi','效率工具','开发工具','一个可以自定义HTTP Header信息的Chrome插件，包括Referer访问来源、随机UA信息、随机IP地址。','',1040,'active','2026-11-02T01:50:54.886Z',NULL),
('HiPPTer','http://www.hippter.com/','网站导航','资源社区','PPT设计相关网站,提供创意灵感等.','',1050,'active','2026-11-02T01:50:54.886Z',NULL),
('Hoppscotch','https://hoppscotch.io/','接口调试','开发工具','Hoppscotch 的前身是 Postwoman，是一个开源的轻量级、基于 Web 的 API 管理工具。','',1060,'active','2026-11-02T01:50:54.886Z',NULL),
('Http Debugger','https://www.httpdebugger.com/','抓包工具','采集自动化','Http Debugger 抓包工具，易于使用、简洁的用户界面和较短的启动时间。','',1070,'active','2026-11-02T01:50:54.886Z',NULL),
('Hydra','https://github.com/HelloGitHub-Team/Hydra','优质项目','开发工具','简单但绝不简陋的 Python3 爬虫项目，从本项目中你可以看到：熟悉的 Python 基础语法、如何编写爬虫、操作数据库、常用第三库、分析网页、解析接口、编写单元测试、mock 请求、异常监控和管理、保证代码质量的自动化、GitHub Action 等实战应用。','',1080,'active','2026-11-02T01:50:54.886Z',NULL),
('IPRoyal','https://iproyal.com/','国际代理','代理防护','IPRoyal is one of the best and cheapest proxy service providers with 2M+ residential proxies and many other proxy types☑️! Start using it NOW!','',1090,'active','2026-11-02T01:50:54.886Z',NULL),
('Imperva','https://www.imperva.com/','国际防护','代理防护','Imperva provides complete cyber security by protecting what really matters most—your data and applications—whether on-premises or in the cloud.','',1100,'active','2026-11-02T01:50:54.886Z',NULL),
('InfoSpider','https://github.com/kangvcar/InfoSpider','优质项目','开发工具','INFO-SPIDER 是一个集众多数据源于一身的爬虫工具箱🧰，旨在安全快捷的帮助用户拿回自己的数据，工具代码开源，流程透明。','',1110,'active','2026-11-02T01:50:54.886Z',NULL),
('Inspeckage','https://github.com/ac-pm/Inspeckage','Hook工具','采集自动化','基于 Xposed 写的动态分析工具，Hook了大量逆向时常见的方法，如Crypto、Hash。','',1120,'active','2026-11-02T01:50:54.886Z',NULL),
('JADX','https://github.com/skylot/jadx','APP反编译','逆向安全','JADX 是一个 Dex 到 Java 的反编译器，用于从 Android Dex 和 Apk 文件生成 Java 源代码，有命令行和 GUI 两个版本。','',1130,'active','2026-11-02T01:50:54.886Z',NULL),
('JD-GUI','https://github.com/java-decompiler/jd-gui','APP反编译','逆向安全','可将安卓可执行文件 dex 转为 jar 包，并提供可视化代码阅读能力。','',1140,'active','2026-11-02T01:50:54.886Z',NULL),
('JEB','https://www.pnfsoftware.com/','APP反编译','逆向安全','JEB 是 PNF Software的逆向工程平台，可以手动或作为分析管道的一部分执行代码和文档文件的反汇编、反编译、调试和分析。','',1150,'active','2026-11-02T01:50:54.886Z',NULL),
('JS 盾','https://jsvmp.net/','代码混淆','逆向安全','JS 盾制霸 JS 代码加固领域，能有效保护JS代码不被反混淆，JS 盾诞生于我们的 WEB 安全研究，他是市场上唯一的 JS 动态混淆加壳器，在发布之前，经过长达一年的测试，迭代 10 个版本，经历了 10 余位在 JS 逆向技术前 10% 的逆向考验，有的甚至连入口都找不到。','',1160,'active','2026-11-02T01:50:54.886Z',NULL),
('JSDebugger','https://pan.baidu.com/s/1dDgCV61DTyFKvO01qvtgqA?pwd=sbox','调试运行','逆向安全','JSDebugger','',1170,'active','2026-11-02T01:50:54.886Z',NULL),
('JSREI','https://github.com/JSREI','效率工具','开发工具','JavaScript Reverse Engineering Infrastructure，提供更多更好的JS逆向工具，让JS逆向变得简单。','',1180,'active','2026-11-02T01:50:54.886Z',NULL),
('JSVMP 在线混淆','https://jsvmp.com/','代码混淆','逆向安全','OB 在线混淆。','',1190,'active','2026-11-02T01:50:54.886Z',NULL),
('JSpider','https://github.com/bytebuff/JSpider','优质项目','开发工具','JSpider 会每周更新至少一个网站的JS解密方式。','',1200,'active','2026-11-02T01:50:54.886Z',NULL),
('Java 官方文档','https://docs.oracle.com/en/java/','文档资料','学习提升','Java 官方文档。','',1210,'active','2026-11-02T01:50:54.886Z',NULL),
('Js2Py','https://github.com/PiotrDabkowski/Js2Py','调试运行','逆向安全','js2py 是一个专门为 Python 设计的库，允许在 Python 中执行 JavaScript 代码，并且提供了较完整的 JavaScript 解释器。它支持更复杂的 JavaScript 特性，如闭包和异常处理。','',1220,'active','2026-11-02T01:50:54.886Z',NULL),
('JsRpc','https://github.com/jxhczhl/JsRpc','自动化RPC','采集自动化','js 逆向之远程调用 (rpc) 免去抠代码补环境。','',1230,'active','2026-11-02T01:50:54.886Z',NULL),
('Jsjiemi','https://github.com/NXY666/Jsjiemi','代码混淆','逆向安全','基于正则匹配的 JavaScript 解密工具。','',1240,'active','2026-11-02T01:50:54.886Z',NULL),
('JustTrustMe','https://github.com/Fuzion24/JustTrustMe','Hook工具','采集自动化','基于Xposed写的可以绕过SSL Pinning检测的工具。','',1250,'active','2026-11-02T01:50:54.886Z',NULL),
('Kasada','https://www.kasada.io/','国际防护','代理防护','Kasada transcends bot management with a radical approach to defeat automated threats and online fraud. Web and API protection that lasts.','',1260,'active','2026-11-02T01:50:54.886Z',NULL),
('KuangStudy','https://www.kuangstudy.com/','编程','开发工具','优质体系课程、文章博客、专栏书写、技术论坛、资源下载.','',1270,'active','2026-11-02T01:50:54.886Z',NULL),
('Kubernetes','https://kubernetes.io/','监控管理','开发工具','Kubernetes，也称为 K8s，是一个用于自动化部署、扩展和管理容器化应用程序的开源系统。','',1280,'active','2026-11-02T01:50:54.886Z',NULL),
('K哥爬虫','https://www.kgtools.cn/','爬虫','采集自动化','爬虫工具箱','',1290,'active','2026-11-02T01:50:54.887Z',NULL),
('LeetCode','https://leetcode-cn.com/','刷题','学习提升','海量技术面试资源,高效提升编程技能.','',1300,'active','2026-11-02T01:50:54.887Z',NULL),
('Luosimao','https://luosimao.com/service/captcha','国内防护','代理防护','Luosimao 创新开发的人机验证，免去了复杂的输入过程，具有更加优秀的操作体验，更加美观的设计，可更好地融入到您的网站中。','',1310,'active','2026-11-02T01:50:54.887Z',NULL),
('MDN','https://developer.mozilla.org/zh-CN/docs/Learn/HTML','学习文档','学习提升','指导零基础Web开发初学者,提供他们开始编写网站代码所需的所有内容.','',1320,'active','2026-11-02T01:50:54.887Z',NULL),
('MDN','https://developer.mozilla.org/zh-CN/docs/Learn','前端','开发工具','教程','',1330,'active','2026-11-02T01:50:54.887Z',NULL),
('MDN Web API','https://developer.mozilla.org/docs/Web/API','文档资料','学习提升','Web API 接口参考。','',1340,'active','2026-11-02T01:50:54.887Z',NULL),
('MT 管理器','https://mt2.cn/','APP其他','其他','Android 平台文件管理 & 逆向修改神器。','',1350,'active','2026-11-02T01:50:54.887Z',NULL),
('Magisk','https://github.com/topjohnwu/Magisk','APP其他','其他','Magisk是一套用于定制 Android的开源工具,支持高于 Android4.2的设备。涵盖了 Android定制的基本部分:root、引导脚本、 SELInux修补、移除AVB2.0/dm- verity/强制加密等。','',1360,'active','2026-11-02T01:50:54.887Z',NULL),
('Matplotlib','https://matplotlib.org/stable/tutorials/index.html','Python库','开发工具','绘图库,轻松地将数据图形化,提供多样化输出格式.','',1370,'active','2026-11-02T01:50:54.887Z',NULL),
('Matplotlib 官方文档','https://matplotlib.org/','文档资料','学习提升','Matplotlib 官方文档。','',1380,'active','2026-11-02T01:50:54.887Z',NULL),
('Matplotlib(C)','https://www.matplotlib.org.cn/tutorials/','Python库','开发工具','Matplotlib的中文版本.','',1390,'active','2026-11-02T01:50:54.887Z',NULL),
('MediaCMS','https://mediacms.io/','Github项目','开发工具','MediaCMS 是一个现代的、功能齐全的开源视频和媒体 CMS，用 Python/Django 和 React 编写，具有 REST API。现代、功能齐全的开源视频和媒体 CMS。为满足现代网络平台查看和共享媒体的需求而开发的内容管理系统。非常适合那些想要围绕媒体文件共享建立在线社区以用于信息、教育或娱乐目的的人。','',1400,'active','2026-11-02T01:50:54.887Z',NULL),
('ModHeader','https://modheader.com/','效率工具','开发工具','修改 HTTP 请求标头、响应标头和重定向 URL。','',1410,'active','2026-11-02T01:50:54.887Z',NULL),
('NP 管理器','https://github.com/githubXiaowangzi/NP-Manager','APP其他','其他','另一款 Android 平台文件管理 & 逆向修改神器。','',1420,'active','2026-11-02T01:50:54.887Z',NULL),
('Netlify','https://www.netlify.com/','前端','开发工具','连接一切，建造任何东西。Netlify是提供卓越和动态Web体验的重要平台，没有限制。','',1430,'active','2026-11-02T01:50:54.887Z',NULL),
('NewBing','https://www.bing.com/new','AI聊天对话','AI 工具','Bing 必应推出的 AI 聊天搜索，可以通过聊天方式创作所需图像，一站式提供搜索、聊天和创作等功能。','',1440,'active','2026-11-02T01:50:54.887Z',NULL),
('NewsCrawl','https://github.com/casual-silva/NewsCrawl','优质项目','开发工具','开源企业级舆情新闻爬虫项目：支持任意数量爬虫一键运行、爬虫定时任务、爬虫批量删除；爬虫一键部署；爬虫监控可视化; 集群爬虫分配策略。','',1450,'active','2026-11-02T01:50:54.887Z',NULL),
('NodeJS','https://nodejs.cn/','前端','开发工具','Node.js 是一个开源的、跨平台的 JavaScript 运行时环境。','',1460,'active','2026-11-02T01:50:54.887Z',NULL),
('NodeJS 官方文档','https://nodejs.org/api/','文档资料','学习提升','NodeJS 官方文档。','',1470,'active','2026-11-02T01:50:54.887Z',NULL),
('NopeCHA','https://nopecha.com/','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、FunCaptcha、AWS WAF 等平台，直接返回 token 解决方案，价格稍便宜。','',1480,'active','2026-11-02T01:50:54.887Z',NULL),
('Notion AI','https://www.notion.so/product/ai','AI文档办公','AI 工具','Notion AI 写作神器，可以根据输入的关键词智能推荐相关的文章素材，提高文章的质量和准确度。','',1490,'active','2026-11-02T01:50:54.887Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('NumPy 官方文档','https://numpy.org/','文档资料','学习提升','NumPy 官方文档。','',1500,'active','2026-11-02T01:50:54.887Z',NULL),
('Nuxt','https://nuxt.com/','前端','开发工具','Nuxt是一个开源框架，使Web开发直观而强大。充满信心地创建高性能和生产级的全栈Web应用程序和网站。The Intuitive Vue Framework','',1510,'active','2026-11-02T01:50:54.887Z',NULL),
('OB 在线混淆','https://www.obfuscator.io/','代码混淆','逆向安全','OB 在线混淆。','',1520,'active','2026-11-02T01:50:54.887Z',NULL),
('Oxylabs','https://oxylabs.io/','国际代理','代理防护','The best proxy service platform with 100M+ Residential and 2M Datacenter IP proxies. Extract public data from any website with ease!','',1530,'active','2026-11-02T01:50:54.887Z',NULL),
('PKiD','https://pan.baidu.com/s/1Ho0gVCH_sS-75nhO2TcXXw?pwd=sbox','APP反编译','逆向安全','目前仅支持的加固厂商：娜迦、梆梆、爱加密、通付盾、360加固、百度加固、阿里加固、腾讯加固、盛大加固、瑞星加固、网秦加固、国信灵通加固、apkprotect 加固。','',1540,'active','2026-11-02T01:50:54.887Z',NULL),
('PKiD Java 跨平台版','https://bbs.kanxue.com/thread-225120.htm','APP反编译','逆向安全','目前仅支持加固厂商：娜迦、梆梆、爱加密、通付盾、360加固、百度加固、阿里、腾讯、盛大、瑞星加、网秦、国信灵通、apkprotect、几维安全、顶像科技、网易易盾等常规厂商。功能比win版PKID更强大，特征更多！','',1550,'active','2026-11-02T01:50:54.887Z',NULL),
('PM2 官方文档','https://pm2.keymetrics.io/docs/usage/quick-start/','文档资料','学习提升','PM2 守护进程管理器官方文档。','',1560,'active','2026-11-02T01:50:54.887Z',NULL),
('PTA','https://pintia.cn/home','刷题','学习提升','程序设计类实验辅助教学平台.','',1570,'active','2026-11-02T01:50:54.887Z',NULL),
('PandaGPT','https://www.pandagpt.io/','AI文档办公','AI 工具','AI 阅读文档，生成知识图谱，回答问题。','',1580,'active','2026-11-02T01:50:54.887Z',NULL),
('Pandas 官方文档','https://pandas.pydata.org/docs/','文档资料','学习提升','Pandas 官方文档。','',1590,'active','2026-11-02T01:50:54.887Z',NULL),
('PearOCR','https://pearocr.com/#/','工具','开发工具','免费简单,图片文字识别,自动校对错误等功能,支持下载到本地!','',1600,'active','2026-11-02T01:50:54.887Z',NULL),
('PerimeterX','https://www.perimeterx.com/','国际防护','代理防护','HUMAN Security is a cybersecurity company that safeguards enterprises and internet platforms from sophisticated bot attacks, fraud, and account abuse.','',1610,'active','2026-11-02T01:50:54.887Z',NULL),
('PhantomJS','https://phantomjs.org/','自动化RPC','采集自动化','PhantomJS 是一款可使用 JavaScript 编写脚本的无头 Web 浏览器，18 年已停止维护。','',1620,'active','2026-11-02T01:50:54.887Z',NULL),
('Pinia','https://pinia.vuejs.org/zh/','前端','开发工具','符合直觉的Vue.js状态管理库。类型安全、可扩展性以及模块化设计。甚至让你忘记正在使用的是一个状态库。','',1630,'active','2026-11-02T01:50:54.887Z',NULL),
('Pixelscan','https://pixelscan.net/','指纹相关','采集自动化','一种用于检测互联网机器人的一次性解决方案','',1640,'active','2026-11-02T01:50:54.887Z',NULL),
('Playwright','https://playwright.dev/','自动化RPC','采集自动化','Playwright 是微软在 2020 年初开源的新一代自动化测试工具，对市面上的主流浏览器都提供了支持，API 功能简洁又强大。','',1650,'active','2026-11-02T01:50:54.887Z',NULL),
('Postman','https://www.postman.com/','接口调试','开发工具','Postman 是一个用于构建和使用 API 的 API 平台。Postman 简化了 API 生命周期的每个步骤并简化了协作，以便您可以更快地创建更好的 API。','',1660,'active','2026-11-02T01:50:54.887Z',NULL),
('ProcessOn','https://www.processon.com/diagrams','工具','开发工具','在线流程图,迅捷画图,基于云计算,人实时协作编辑同一个思维导图.','',1670,'active','2026-11-02T01:50:54.887Z',NULL),
('Prometheus','https://prometheus.io/','监控管理','开发工具','Prometheus 开源监控系统。','',1680,'active','2026-11-02T01:50:54.887Z',NULL),
('Prometheus 官方文档','https://prometheus.io/docs/','文档资料','学习提升','Prometheus 开源监控系统官方文档。','',1690,'active','2026-11-02T01:50:54.887Z',NULL),
('Proxy SwitchyOmega','https://github.com/FelisCatus/SwitchyOmega','效率工具','开发工具','轻松快捷地管理和切换多个代理设置。','',1700,'active','2026-11-02T01:50:54.887Z',NULL),
('Proxy/VPN Detection','https://bot.incolumitas.com/proxy_detect.html','指纹相关','采集自动化','实时代理和 VPN 检测','',1710,'active','2026-11-02T01:50:54.887Z',NULL),
('Proxyman','https://proxyman.io/','抓包工具','采集自动化','MacOS 系统下一款非常优秀的抓包软件，免费使用，而且界面非常好看，现也支持 Windows。','',1720,'active','2026-11-02T01:50:54.887Z',NULL),
('Puppeteer','https://github.com/puppeteer/puppeteer','自动化RPC','采集自动化','Puppeteer 是一个 Node.js 库，它提供了一个高级 API 来通过 DevTools Protocol控制 Chrome/Chromium。','',1730,'active','2026-11-02T01:50:54.887Z',NULL),
('PyCharm 中文指南','https://pycharm.iswbm.com/','文档资料','学习提升','PyCharm 中文指南。','',1740,'active','2026-11-02T01:50:54.887Z',NULL),
('PyExecJS','https://github.com/doloopwhile/PyExecJS','调试运行','逆向安全','在 Python 中运行 JavaScript 代码，现已停止维护。','',1750,'active','2026-11-02T01:50:54.887Z',NULL),
('PyMiniRacer','https://github.com/sqreen/PyMiniRacer','调试运行','逆向安全','PyMiniRacer 是 Python 中的 V8 桥接器。','',1760,'active','2026-11-02T01:50:54.887Z',NULL),
('PySimpleGUI','https://github.com/PySimpleGUI/PySimpleGUI','Python库','开发工具','一个非常简单好用的Python图形界面库.','',1770,'active','2026-11-02T01:50:54.887Z',NULL),
('Pyppeteer','https://github.com/pyppeteer/pyppeteer','自动化RPC','采集自动化','Pyppeteer 是一款非常高效的 web 自动化测试工具，是 Puppeteer 的 Python 版本。','',1780,'active','2026-11-02T01:50:54.887Z',NULL),
('Python Ghost Cursor','https://github.com/mcolella14/python_ghost_cursor','轨迹相关','采集自动化','生成逼真的、类似人类的鼠标移动数据。','',1790,'active','2026-11-02T01:50:54.887Z',NULL),
('Python 官方文档','https://docs.python.org/','文档资料','学习提升','Python 官方文档','',1800,'active','2026-11-02T01:50:54.887Z',NULL),
('Python 黑魔法手册','https://magic.iswbm.com/','文档资料','学习提升','Python 黑魔法手册。','',1810,'active','2026-11-02T01:50:54.887Z',NULL),
('PythonMonkey','https://github.com/Distributive-Network/PythonMonkey','调试运行','逆向安全','嵌入到 Python VM 中的 Mozilla SpiderMonkey JavaScript 引擎，使用 Python 引擎提供 JS 宿主环境。','',1820,'active','2026-11-02T01:50:54.887Z',NULL),
('PythonSpider','https://github.com/DingZaiHub/PythonSpider','优质项目','开发工具','JS 逆向系列教程，模拟登录，AES、RSA、DES加密等。','',1830,'active','2026-11-02T01:50:54.887Z',NULL),
('QQ邮箱','https://mail.qq.com/cgi-bin/frame_html?sid=up6KZlz3BGBz40wu&r=ebc72a3dc579725eb92a51a5a7d86b2f','工具','开发工具','为亿万用户提供高效稳定便捷的电子邮件服务.','',1840,'active','2026-11-02T01:50:54.887Z',NULL),
('QQ音乐','https://y.qq.com/','娱乐影音','资源社区','腾讯公司推出的一款网络音乐服务产品.','',1850,'active','2026-11-02T01:50:54.887Z',NULL),
('QRBTF','https://qrbtf.com/','工具','开发工具','参数化二维码生成器.','',1860,'active','2026-11-02T01:50:54.887Z',NULL),
('QuickRef','https://quickref.me/','文档资料','学习提升','QuickRef，快速查阅各种编程语言、工具、数据库、键盘快捷键等基础用法。','',1870,'active','2026-11-02T01:50:54.887Z',NULL),
('Rayobyte','https://rayobyte.com/','国际代理','代理防护','We Are Rayobyte, The company that can take your business into the future no matter how much data you might need.','',1880,'active','2026-11-02T01:50:54.887Z',NULL),
('ReRes','https://github.com/annnhan/ReRes','效率工具','开发工具','把远程 css 文件或者 js 映射到本地的文件上，通过修改本地文件进行调试和开发。','',1890,'active','2026-11-02T01:50:54.887Z',NULL),
('React','https://react.dev/','前端','开发工具','教程','',1900,'active','2026-11-02T01:50:54.887Z',NULL),
('Reqable','https://reqable.com/','抓包工具','采集自动化','小黄鸟作者另一力作，新一代API调试 + API测试一站化国产解决方案，全平台支持HTTP1、HTTP2和HTTP3(QUIC)，先进技术赋能API生产。','',1910,'active','2026-11-02T01:50:54.887Z',NULL),
('RotNet','https://github.com/d4nst/RotNet','开源识别','采集自动化','预测图像的旋转角度以纠正其方向。','',1920,'active','2026-11-02T01:50:54.887Z',NULL),
('RotateCaptchaBreak','https://github.com/chencchen/RotateCaptchaBreak','开源识别','采集自动化','旋转验证码识别。','',1930,'active','2026-11-02T01:50:54.887Z',NULL),
('SQLPub','https://www.sqlpub.com/','后端','开发工具','提供最新版本、甚至是开发者版本的 MySQL 服务器测试服务。您将获得最大36000次/小时的请求、同时30个连接和500M存储空间；','',1940,'active','2026-11-02T01:50:54.887Z',NULL),
('Save as PDF','https://pdfcrowd.com/save-as-pdf-addon/','其他工具','开发工具','网页转 PDF，把你喜欢的博主的文章保存一份吧。','',1950,'active','2026-11-02T01:50:54.887Z',NULL),
('Scrape Center','https://scrape.center/','练习平台','学习提升','崔庆才《Python3网络爬虫开发实战（第二版）》配套案例练习平台。','',1960,'active','2026-11-02T01:50:54.887Z',NULL),
('ScraperAPI','https://www.scraperapi.com/','国际代理','代理防护','ScraperAPI handles proxy rotation, browsers, and CAPTCHAs so developers can scrape any page with a single API call. Web scraping with 5,000 free API calls!','',1970,'active','2026-11-02T01:50:54.887Z',NULL),
('Scraping Helper','https://github.com/huangwc94/scraping-helper-chrome-extension','效率工具','开发工具','自动生成最简 HTML 选择命令，用于爬虫网页内容分析。','',1980,'active','2026-11-02T01:50:54.887Z',NULL),
('Scrapyd','https://github.com/scrapy/scrapyd','监控管理','开发工具','Scrapyd 是一个用于运行 Scrapy 爬虫的服务，它允许部署 Scrapy 项目并使用 HTTP JSON API 控制爬虫脚本。','',1990,'active','2026-11-02T01:50:54.887Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('ScrapydWeb','https://github.com/my8100/scrapydweb','监控管理','开发工具','用于 Scrapyd 集群管理、Scrapy 日志分析和可视化、自动打包、计时器任务、监控和警报以及移动 UI 的 Web 应用程序。','',2000,'active','2026-11-02T01:50:54.887Z',NULL),
('Sekiro','https://github.com/yint-tech/sekiro-open','自动化RPC','采集自动化','RPC 框架。','',2010,'active','2026-11-02T01:50:54.887Z',NULL),
('SelectorGadget','https://selectorgadget.com/','效率工具','开发工具','简单、强大的 CSS 选择器生成。','',2020,'active','2026-11-02T01:50:54.887Z',NULL),
('Selenium','https://www.selenium.dev/','自动化RPC','采集自动化','最流行的自动化测试框架，支持的浏览器包括IE（7, 8, 9, 10, 11），Mozilla Firefox，Safari，Google Chrome，Opera，Edge等。','',2030,'active','2026-11-02T01:50:54.887Z',NULL),
('Shifter','https://shifter.io/','国际代理','代理防护','Shifter is the ultimate data toolkit for data collection providing access to residential proxy networks and data scraping APIs.','',2040,'active','2026-11-02T01:50:54.887Z',NULL),
('SlideCrack','https://github.com/crazyxw/SlideCrack','开源识别','采集自动化','滑块缺口位置识别，支持网易、极验。','',2050,'active','2026-11-02T01:50:54.887Z',NULL),
('SmsForwarder','https://github.com/pppscn/SmsForwarder','其他工具','开发工具','短信转发器——监控 Android 手机短信、来电、APP 通知，并根据指定规则转发到其他手机：钉钉群自定义机器人、钉钉企业内机器人、企业微信群机器人、飞书机器人、企业微信应用消息、邮箱、bark、webhook、Telegram机器人、Server酱、PushPlus、手机短信等。包括主动控制服务端与客户端，让你轻松远程发短信、查短信、查通话、查话簿、查电量等。','',2060,'active','2026-11-02T01:50:54.887Z',NULL),
('Snipaste','https://www.snipaste.com/','其他工具','开发工具','Snipaste 是一个简单但强大的截图工具，可以将截图贴回到屏幕上、可以给截图添加文字、箭头、马赛克等。','',2070,'active','2026-11-02T01:50:54.887Z',NULL),
('Solve Captcha','https://solvecaptcha.net/','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、FunCaptcha、Cloudflare、Geetest 等平台，直接返回 token 解决方案。','',2080,'active','2026-11-02T01:50:54.887Z',NULL),
('Splash','https://github.com/scrapinghub/splash','自动化RPC','采集自动化','Splash 是一个带有 HTTP API 的 JavaScript 渲染服务。它是一个带有 HTTP API 的轻量级浏览器，使用 Twisted 和 QT5 在 Python 3 中实现。它快速、轻量级且无状态，因此易于分发。','',2090,'active','2026-11-02T01:50:54.887Z',NULL),
('Stream','https://apps.apple.com/cn/app/stream/id1312141691','抓包工具','采集自动化','Stream 是一款在 iOS 端的网络抓包工具，该工具可以直接独立运行在 iOS 设备，无需依赖 PC 环境。','',2100,'active','2026-11-02T01:50:54.887Z',NULL),
('TCP/IP Fingerprint API','https://tcpip.incolumitas.com/classify?detail=1','指纹相关','采集自动化','TCP/IP 指纹 API','',2110,'active','2026-11-02T01:50:54.887Z',NULL),
('Tampermonkey','https://www.tampermonkey.net/','效率工具','开发工具','Tampermonkey，又称作油猴，篡改猴，允许用户自定义并增强网页的功能。','',2120,'active','2026-11-02T01:50:54.887Z',NULL),
('Tcpdump','https://www.tcpdump.org/','抓包工具','采集自动化','适用于会话层抓包，在使用没有无线网卡的电脑或无法开热点的情况下可以直接在手机上运行Tcpdump然后导出文件在电脑端WireShark中打开，与直接使用WireShark抓包效果相同。','',2130,'active','2026-11-02T01:50:54.887Z',NULL),
('TensorFlow','https://tensorflow.google.cn/tutorials/images/cnn?hl=zh_cn','Python库','开发工具','一个端到端开源机器学习平台,拥有一个全面而灵活的生态系统.','',2140,'active','2026-11-02T01:50:54.887Z',NULL),
('Text Select Captcha','https://github.com/MgArcher/Text_select_captcha','开源识别','采集自动化','实现文字点选、选字、选择、点触验证码识别，基于pytorch训练。','',2150,'active','2026-11-02T01:50:54.887Z',NULL),
('The Web Scraping Club','https://substack.thewebscraping.club/','国外论坛','资源社区','国外的一个爬虫俱乐部。','',2160,'active','2026-11-02T01:50:54.887Z',NULL),
('Trace','https://github.com/L018/Trace','效率工具','开发工具','Trace 是一个用于网站分析的 Chrome 扩展, 包括追踪Cookie、追踪事件、追踪对象、脚本注入、阻止请求、变量追踪、JS反混淆、响应流转等功能。','',2170,'active','2026-11-02T01:50:54.887Z',NULL),
('Track Point Gen','https://github.com/2833844911/Track_point_gen','轨迹相关','采集自动化','AI 模拟人手轨迹。','',2180,'active','2026-11-02T01:50:54.887Z',NULL),
('TrackMe - fp API','https://tls.peet.ws/','指纹相关','采集自动化','TLS 指纹 API','',2190,'active','2026-11-02T01:50:54.887Z',NULL),
('UI Automator 2','https://github.com/openatx/uiautomator2','自动化RPC','采集自动化','Python 版本的 UI Automator，是一种 Android 自动化测试框架，提供了点击、长按、输入文本、滑动、拖拽、截屏等方法，能够模拟用户的各种动作。用户可以通过控件的 id 或 text 等属性，定位到控件，从而对控件实施上述操作。','',2200,'active','2026-11-02T01:50:54.887Z',NULL),
('Undetected Chromedriver','https://github.com/ultrafunkamsterdam/undetected-chromedriver','自动化RPC','采集自动化','优化的 Selenium Chromedriver 补丁，不会触发 Distill Network / Imperva / DataDome / Botprotect.io 等反机器人服务，自动下载驱动程序二进制文件并对其进行修补。','',2210,'active','2026-11-02T01:50:54.887Z',NULL),
('UnpackMiniApp','https://pan.baidu.com/s/19mKFLGqUAve-FG4Fp6J76g?pwd=sbox','小程序反编译','逆向安全','微信小程序解密工具。','',2220,'active','2026-11-02T01:50:54.887Z',NULL),
('Vercel','https://vercel.com/','前端','开发工具','构建和部署最好的Web体验。','',2230,'active','2026-11-02T01:50:54.887Z',NULL),
('Vue','https://cn.vuejs.org/','前端','开发工具','教程','',2240,'active','2026-11-02T01:50:54.887Z',NULL),
('Vue Router','https://router.vuejs.org/zh/','前端','开发工具','Vue.js 的官方路由。为 Vue.js 提供富有表现力、可配置的、方便的路由','',2250,'active','2026-11-02T01:50:54.887Z',NULL),
('W3school','https://www.w3school.com.cn/','学习文档','学习提升','全球最大的中文 Web 技术教程.','',2260,'active','2026-11-02T01:50:54.887Z',NULL),
('WPS AI','https://ai.wps.cn/','AI文档办公','AI 工具','WPS 缩写、扩写、续写、风格转变，一键生成完整 PPT，无论是论文、合同，或简历等长文 PDF 文档，都能交给 WPS AI 梳理。发起询问，总结数据，快速概括。','',2270,'active','2026-11-02T01:50:54.887Z',NULL),
('WT-JS','https://bbs.125.la/thread-14734668-1-1.html','调试运行','逆向安全','WT-JS','',2280,'active','2026-11-02T01:50:54.887Z',NULL),
('Web安全学习笔记','https://github.com/LyleMi/Learn-Web-Hacking','网络安全','逆向安全','','',2290,'active','2026-11-02T01:50:54.887Z',NULL),
('Wireshark','https://www.wireshark.org/','抓包工具','采集自动化','Wireshark 抓包工具使用 WinPCAP 作为接口，直接与网卡进行数据报文交换。','',2300,'active','2026-11-02T01:50:54.887Z',NULL),
('XAPKDetector','https://github.com/horsicq/XAPKDetector','APP反编译','逆向安全','XAPKDetector 显示有关构建工具，库和APK / DEX文件保护的信息。','',2310,'active','2026-11-02T01:50:54.887Z',NULL),
('XPath Helper','https://chrome.google.com/webstore/detail/xpath-helper/hgimnogjllphhhkhlmebbmlgjoejdpjl','效率工具','开发工具','轻松提取、编辑和评估 XPath 查询。','',2320,'active','2026-11-02T01:50:54.887Z',NULL),
('XPath Helper Plus','https://github.com/mic1on/xpath-helper-plus','效率工具','开发工具','xpath开发者的工具，可以帮助开发者快速的定位元素。','',2330,'active','2026-11-02T01:50:54.887Z',NULL),
('XPath Helper Wizard','https://chrome.google.com/webstore/detail/xpath-helper-wizard/jadhpggafkbmpdpmpgigopmodldgfcki','效率工具','开发工具','创建 XPath 查询选择相似元素并可视化结果，XPath Helper Wizard 创建的 xpath 很短，并且在网站更改时不太可能中断。','',2340,'active','2026-11-02T01:50:54.887Z',NULL),
('Xposed','https://github.com/rovo89/Xposed','Hook工具','采集自动化','Xposed 框架是一款可以在不修改 APK 的情况下影响程序运行（修改系统）的框架服务，基于它可以制作出许多功能强大的模块，且在功能不冲突的情况下同时运作。','',2350,'active','2026-11-02T01:50:54.887Z',NULL),
('YesCaptcha','https://yescaptcha.com/i/oPZU3g','打码平台','采集自动化','支持 ImageToText、hCaptcha、reCAPTCHA、FunCaptcha、Cloudflare 等识别，支持直接返回 token 解决方案。','',2360,'active','2026-11-02T01:50:54.887Z',NULL),
('Zyte','https://www.zyte.com/','国际代理','代理防护','Access clean, valuable data with web scraping services that drive your business forward. 14 day free trial available.','',2370,'active','2026-11-02T01:50:54.887Z',NULL),
('animejs','https://github.com/juliangarnier/anime/','前端','开发工具','一个轻量级的 JavaScript 动画库，具有简单而强大的 API。它适用于 CSS 属性、SVG、DOM 属性和 JavaScript 对象。','',2380,'active','2026-11-02T01:50:54.887Z',NULL),
('animxyz','https://github.com/ingram-projects/animxyz','前端','开发工具','第一个可组合项CSS动画工具包。The first composable CSS animation toolkit.','',2390,'active','2026-11-02T01:50:54.887Z',NULL),
('ast_tools','https://github.com/sml2h3/ast_tools','代码混淆','逆向安全','ast 基础框架 - 基于 babel，置了一些常见的混淆还原策略。','',2400,'active','2026-11-02T01:50:54.887Z',NULL),
('awesome-reverse','https://github.com/AlienwareHe/awesome-reverse','优质项目','开发工具','awesome-逆向基础入门，包括 JS、安卓 APP/Native。','',2410,'active','2026-11-02T01:50:54.887Z',NULL),
('bestV8','https://github.com/BestToYou/bestV8_release','调试运行','逆向安全','一个可以跑 js 的逆向工具。','',2420,'active','2026-11-02T01:50:54.887Z',NULL),
('bigme','https://1s.bigmeok.me/user#/register?code=ZTrIUOBr','AFF','商业推广','一个节点','',2430,'active','2026-11-02T01:50:54.887Z',NULL),
('blog','https://lideshan.cn','个人站','资源社区','blog','',2440,'active','2026-11-02T01:50:54.887Z',NULL),
('boda_jsEnv','https://github.com/xuxiaobo-bobo/boda_jsEnv','环境框架','开发工具','js补环境框架。','',2450,'active','2026-11-02T01:50:54.887Z',NULL),
('boxy-svg','https://boxy-svg.com','前端','开发工具','svg在线编辑器','',2460,'active','2026-11-02T01:50:54.887Z',NULL),
('bt影视','https://www.bttwo.me','影视','资源社区','影视网站','',2470,'active','2026-11-02T01:50:54.887Z',NULL),
('captcha_crack','https://github.com/cos120/captcha_crack','开源识别','采集自动化','选字验证码破解，试验过网易和极验，破解率99。','',2480,'active','2026-11-02T01:50:54.887Z',NULL),
('catvm','https://github.com/fanchangrui/catvm','环境框架','开发工具','基于志远的思路实现实现的 js 逆向环境框架。','',2490,'active','2026-11-02T01:50:54.887Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('catvm','https://github.com/Big1moster/catvm','环境框架','开发工具','catvm 另一个版本，志远补环境框架视频配套完结版。','',2500,'active','2026-11-02T01:50:54.887Z',NULL),
('chrome-wasm-debugger','https://github.com/itszn/chrome-wasm-debugger','效率工具','开发工具','一个 chrome 扩展，为 WASM 模块提供稍微更简单的调试 UI。','',2510,'active','2026-11-02T01:50:54.887Z',NULL),
('cip.cc','https://www.cip.cc/','在线工具','开发工具','查IP(cip)网站, 提供免费的IP查询服务,命令行查询IP, 并且支持PC网站, 手机网站, 命令行(Windows/UNIX/Linux)三大平台, 是个多平台的IP查询网站。','',2520,'active','2026-11-02T01:50:54.887Z',NULL),
('cliproxy','https://share.cliproxy.com/share/3sp2dre4g','AFF','商业推广','海外代理ip','',2530,'active','2026-11-02T01:50:54.887Z',NULL),
('cmsZy5影视','https://360zy5.com','影视','资源社区','影视网站','',2540,'active','2026-11-02T01:50:54.887Z',NULL),
('cms牛牛影视','https://niuniuzy.cc','影视','资源社区','影视网站','',2550,'active','2026-11-02T01:50:54.887Z',NULL),
('cms量子影视','http://lzizy.net','影视','资源社区','影视网站','',2560,'active','2026-11-02T01:50:54.887Z',NULL),
('cms非凡影视','http://ffzy5.tv/','影视','资源社区','影视网站','',2570,'active','2026-11-02T01:50:54.887Z',NULL),
('common-regex','https://github.com/cdoco/common-regex','文档资料','学习提升','常用正则表达式。','',2580,'active','2026-11-02T01:50:54.887Z',NULL),
('curl_cffi','https://github.com/yifeikong/curl_cffi','指纹相关','采集自动化','curl-impersonate 的 Python 绑定，基于 cffi，支持 JA3/TLS 和 http2 指纹模拟。','',2590,'active','2026-11-02T01:50:54.887Z',NULL),
('cy_jsvmp','https://github.com/2833844911/cy_jsvmp','代码混淆','逆向安全','JSVMP 的实现。','',2600,'active','2026-11-02T01:50:54.887Z',NULL),
('ddddocr','https://github.com/sml2h3/ddddocr','开源识别','采集自动化','带带弟弟OCR通用验证码识别，提供了相关训练工具，支持自定义训练模型。','',2610,'active','2026-11-02T01:50:54.887Z',NULL),
('de4js','https://lelinhtinh.github.io/de4js/','代码混淆','逆向安全','JS 在线解混淆，支持 Eval、OB、JSFuck、JJencode、AAencode 等。','',2620,'active','2026-11-02T01:50:54.887Z',NULL),
('decode-js','https://github.com/echo094/decode-js','代码混淆','逆向安全','使用AST方式（依赖Babel插件）实现的JS代码净化工具。','',2630,'active','2026-11-02T01:50:54.887Z',NULL),
('dex2jar','https://github.com/pxb1988/dex2jar','APP反编译','逆向安全','将安卓可执行文件 dex 转为 jar 包。','',2640,'active','2026-11-02T01:50:54.887Z',NULL),
('dianxuan','https://github.com/wlkjyh/dianxuan','开源识别','采集自动化','基于孪生神经网络实现的点选识别。','',2650,'active','2026-11-02T01:50:54.887Z',NULL),
('diffbot','https://www.diffbot.com/','效率工具','开发工具','智能解析算法应用，通过人工智能技术，让“机器”识别网页内容，抓取关键内容，并输出软件可以直接识别的结构化数据。','',2660,'active','2026-11-02T01:50:54.887Z',NULL),
('docker加速','https://github.com/dongyubin/DockerHub','工具','开发工具','tools','',2670,'active','2026-11-02T01:50:54.887Z',NULL),
('dumpDex','https://github.com/WrBug/dumpDex','脱壳工具','逆向安全','一款 Android 脱壳工具，需要 xposed 支持。','',2680,'active','2026-11-02T01:50:54.887Z',NULL),
('eCapture','https://ecapture.cc/','抓包工具','采集自动化','eCapture(旁观者)，基于 eBPF 技术实现TLS加密的明文捕获，无需CA证书。','',2690,'active','2026-11-02T01:50:54.887Z',NULL),
('facelessJsvmp','https://github.com/Alanhays/facelessJsvmp','代码混淆','逆向安全','单栈实现的 js 代码虚拟化保护程序，加固代码支持在浏览器和 nodejs 中运行。','',2700,'active','2026-11-02T01:50:54.887Z',NULL),
('fake-useragent','https://github.com/fake-useragent/fake-useragent','效率工具','开发工具','随机 UA。','',2710,'active','2026-11-02T01:50:54.887Z',NULL),
('fridaUiTools','https://github.com/dqzg12300/fridaUiTools','Hook工具','采集自动化','fridaUiTools 是一个界面化整理脚本的工具。','',2720,'active','2026-11-02T01:50:54.887Z',NULL),
('gurs','https://github.com/2833844911/gurs','轨迹相关','采集自动化','基于贝塞尔曲线生成滑动轨迹。','',2730,'active','2026-11-02T01:50:54.887Z',NULL),
('hCaptcha','https://www.hcaptcha.com/','国际防护','代理防护','hCaptcha is an anti-bot solution that protects user privacy and rewards websites. It is the most popular reCAPTCHA alternative. Help build a better web.','',2740,'active','2026-11-02T01:50:54.887Z',NULL),
('hCaptcha Challenger','https://github.com/QIN2DIM/hcaptcha-challenger','开源识别','采集自动化','使用 MoE(ONNX) 嵌入式解决方案轻松应对 hCaptcha 挑战。','',2750,'active','2026-11-02T01:50:54.887Z',NULL),
('httpbin','https://www.httpbin.org/','在线工具','开发工具','一个简单的 HTTP 请求和响应测试服务。','',2760,'active','2026-11-02T01:50:54.887Z',NULL),
('iLovePDF','https://www.ilovepdf.com/zh-cn/word_to_pdf','工具','开发工具','丰富的PDF合并、拆分、压缩、转换、旋转和解锁，添加水印等.','',2770,'active','2026-11-02T01:50:54.887Z',NULL),
('iTab','https://www.itab.link/','网站导航','资源社区','个性化卡片式起始页插件.','',2780,'active','2026-11-02T01:50:54.887Z',NULL),
('icanhazip','https://icanhazip.com/','在线工具','开发工具','快速返回当前 IP。','',2790,'active','2026-11-02T01:50:54.887Z',NULL),
('jeb全家桶全平台','https://pan.quark.cn/s/d6dce606270d','网盘分享','资源社区','jeb全家桶激活工具,使用到2099年','',2800,'active','2026-11-02T01:50:54.887Z',NULL),
('jpgHD','https://jpghd.com/','AI图像绘画','AI 工具','人工智能老照片无损修复，利用2023年最先进人工智能 AI 将老照片无损高清修复（支持老照片修复、老照片上色和魔法动态照片）','',2810,'active','2026-11-02T01:50:54.887Z',NULL),
('js-hook-framework','https://github.com/JSREI/crawler-js-hook-framework-public','效率工具','开发工具','JS 逆向 Hook 工具集。将JS逆向时用到的一些工具封装为油猴脚本，降低逆向成本。','',2820,'active','2026-11-02T01:50:54.887Z',NULL),
('js_reverse','https://github.com/luzhisheng/js_reverse','优质项目','开发工具','各种 JS 逆向案例。','',2830,'active','2026-11-02T01:50:54.887Z',NULL),
('json解析','https://www.json.cn/','工具','开发工具','轻量级的数据交换格式,提供相关的Json解析,验证,格式化,压缩,编辑器等服务.','',2840,'active','2026-11-02T01:50:54.887Z',NULL),
('jsvmp-repository','https://github.com/xiaoweigege/jsvmp-repository','优质项目','开发工具','国内部分网站的 jsvmp 算法。','',2850,'active','2026-11-02T01:50:54.887Z',NULL),
('lamda','https://github.com/rev1si0n/lamda','Hook工具','采集自动化','史上最强安卓抓包/逆向/HOOK & 云手机/远程桌面/自动化辅助框架，你的工作从未如此简单快捷。','',2860,'active','2026-11-02T01:50:54.887Z',NULL),
('learn_python3_spider','https://github.com/wistbean/learn_python3_spider','优质项目','开发工具','python爬虫教程系列、从0到1学习python爬虫，包括浏览器抓包，手机APP抓包，如 fiddler、mitmproxy，各种爬虫涉及的模块的使用，如：requests、beautifulSoup、selenium、appium、scrapy等，以及IP代理，验证码识别，Mysql，MongoDB数据库的python使用，多线程多进程爬虫的使用，css 爬虫加密逆向破解，JS爬虫逆向，分布式爬虫，爬虫项目实战实例等。','',2870,'active','2026-11-02T01:50:54.887Z',NULL),
('mac iso','https://github.com/Pyenb/macOS-ISOs','资源','资源社区','mac 系统镜像','',2880,'active','2026-11-02T01:50:54.887Z',NULL),
('magical_spider','https://github.com/lixi5338619/magical_spider','自动化RPC','采集自动化','神奇的蜘蛛🕷，一个几乎适用于所有web端站点的采集方案。','',2890,'active','2026-11-02T01:50:54.887Z',NULL),
('mitmproxy','https://mitmproxy.org/','抓包工具','采集自动化','是一个交互式、支持 SSL/TLS 的拦截代理，具有 HTTP/1、HTTP/2 和 WebSocket 的控制台界面。','',2900,'active','2026-11-02T01:50:54.887Z',NULL),
('newspaper','https://github.com/codelucas/newspaper','效率工具','开发工具','Python3 中的新闻、全文和文章元数据提取。','',2910,'active','2026-11-02T01:50:54.887Z',NULL),
('noCaptcha','https://www.nocaptcha.io/','打码平台','采集自动化','支持 hCaptcha、reCAPTCHA、Incapsula、Akamai、Cloudflare 等平台，直接返回 token 解决方案。','',2920,'active','2026-11-02T01:50:54.887Z',NULL),
('node-sandbox','https://github.com/bnmgh1/node-sandbox','环境框架','开发工具','魔改 Node Js 补环境框架。','',2930,'active','2026-11-02T01:50:54.887Z',NULL),
('notepad--','https://github.com/cxasm/notepad--','其他工具','开发工具','一个支持 windows/linux/mac 的文本编辑器，目标是做中国人自己的编辑器，来自中国。干翻 notepad++。','',2940,'active','2026-11-02T01:50:54.887Z',NULL),
('ob-decrypt','https://github.com/DingZaiHub/ob-decrypt','代码混淆','逆向安全','ob 混淆还原工具。','',2950,'active','2026-11-02T01:50:54.887Z',NULL),
('pdai','https://pdai.tech/','学习文档','学习提升','Java全栈知识体系.','',2960,'active','2026-11-02T01:50:54.887Z',NULL),
('ppt设计','https://www.hippter.com/','设计','开发工具','设计师','',2970,'active','2026-11-02T01:50:54.887Z',NULL),
('prophet','https://github.com/456vv/prophet','效率工具','开发工具','JAVASCRIPT AST HOOK JS逆向快速定位。','',2980,'active','2026-11-02T01:50:54.887Z',NULL),
('pybestV8','https://github.com/wangluozhe/pybestV8','调试运行','逆向安全','bestV8 Python 版本。','',2990,'active','2026-11-02T01:50:54.887Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('qxVm','https://github.com/ylw00/qxVm','环境框架','开发工具','qxVm 补环境框架 (纯 js 实现)。','',3000,'active','2026-11-02T01:50:54.887Z',NULL),
('r0capture','https://github.com/r0ysue/r0capture','抓包工具','采集自动化','安卓应用层抓包通杀脚本。','',3010,'active','2026-11-02T01:50:54.887Z',NULL),
('r0chrome','https://github.com/daisixuan/r0chrome','指纹相关','采集自动化','r0chrome 是一款对 chromium 源码进行定制的浏览器，支持浏览器随机指纹，支持爬虫/JS逆向工程师进行辅助分析网页。','',3020,'active','2026-11-02T01:50:54.887Z',NULL),
('reCAPTCHA','https://www.google.com/recaptcha/','国际防护','代理防护','reCAPTCHA uses an advanced risk analysis engine and adaptive challenges to keep malicious software from engaging in abusive activities on your website. Meanwhile, legitimate users will be able to login, make purchases, view pages, or create accounts and fake users will be blocked.','',3030,'active','2026-11-02T01:50:54.887Z',NULL),
('removebg','https://www.remove.bg/zh/upload','工具','开发工具','智能的AI5秒钟内100%自动去除背景,简单实用的一键智能抠图工具.','',3040,'active','2026-11-02T01:50:54.887Z',NULL),
('requests-go','https://github.com/wangluozhe/requests-go','指纹相关','采集自动化','requests-go 是一个支持 tls 指纹修改（如ja3）和 http2 的 http 请求库。','',3050,'active','2026-11-02T01:50:54.887Z',NULL),
('rotate-captcha-crack','https://github.com/Starry-OvO/rotate-captcha-crack','开源识别','采集自动化','CNN预测图片旋转角度✨可用于破解图像旋转验证码。','',3060,'active','2026-11-02T01:50:54.887Z',NULL),
('rotate_captcha','https://github.com/ycq0125/rotate_captcha','开源识别','采集自动化','双旋转验证码解决方案。','',3070,'active','2026-11-02T01:50:54.887Z',NULL),
('sperm','https://github.com/darbra/sperm','优质项目','开发工具','精彩逆向文章汇总，值得一看。','',3080,'active','2026-11-02T01:50:54.887Z',NULL),
('stealth.min.js','https://github.com/berstend/puppeteer-extra/tree/master/packages/extract-stealth-evasions','自动化RPC','采集自动化','stealth.min.js 通过注入 JS 来隐藏自动化框架的特征。','',3090,'active','2026-11-02T01:50:54.887Z',NULL),
('supabase','https://supabase.com/','前端','开发工具','在一个周末内建造，在一个周末内建造。Supplement是一个开源的Firebase替代品。Supplement是一个开源的Firebase替代品。','',3100,'active','2026-11-02T01:50:54.887Z',NULL),
('tls-client','https://github.com/FlorianREGAZ/Python-Tls-Client','指纹相关','采集自动化','Python-Tls-Client 是一个基于 requests 和 tls-client 的高级 HTTP 库。','',3110,'active','2026-11-02T01:50:54.887Z',NULL),
('v_jstools','https://github.com/cilame/v_jstools','效率工具','开发工具','v 神出品的用于快速调试 JS 代码的插件，内置 dom 对象 hook、pac 代理、AST 解混淆、代码模板等强大功能。','',3120,'active','2026-11-02T01:50:54.887Z',NULL),
('vaptcha','https://www.vaptcha.com/','国内防护','代理防护','手势验证码VAPTCHA是基于人工智能和大数据的次世代人机验证解决方案。独有的验证策略及风控模型组合可彻底杜绝刷票、灌水、撞库等恶意攻击行为。','',3130,'active','2026-11-02T01:50:54.887Z',NULL),
('vm2','https://github.com/patriksimek/vm2','调试运行','逆向安全','Node.js 的高级虚拟机/沙箱，因为包含严重的安全问题，现已停止维护。','',3140,'active','2026-11-02T01:50:54.887Z',NULL),
('vthread','https://github.com/cilame/vthread','调试运行','逆向安全','python 更加方便的多线程库，以最小的代码侵入，做到最高效的多线程、线程池 coding 效率。在不改变源代码的情况下，一行代码即可实现线程池操作。','',3150,'active','2026-11-02T01:50:54.887Z',NULL),
('webcrawler','https://github.com/chencchen/webcrawler','优质项目','开发工具','硬核 JS 逆向内容。','',3160,'active','2026-11-02T01:50:54.887Z',NULL),
('webhook','https://github.com/valuespider/webHookTools','效率工具','开发工具','阿布的 js 反调试工具。','',3170,'active','2026-11-02T01:50:54.887Z',NULL),
('webpack','https://www.webpackjs.com/','前端','开发工具','一个用于现代 JavaScript 应用程序的 静态模块打包工具','',3180,'active','2026-11-02T01:50:54.887Z',NULL),
('wxapkg-unpacker','https://github.com/zgqwork/wxapkg-unpacker','小程序反编译','逆向安全','自动化反编译微信小程序/小游戏，基于 wxappUnpacker 二次开发。','',3190,'active','2026-11-02T01:50:54.887Z',NULL),
('wxappUnpacker','https://github.com/geilige/wxappUnpacker','小程序反编译','逆向安全','Wechat App(微信小程序, .wxapkg)解包及相关文件(.wxss, .json, .wxs, .wxml)还原工具。','',3200,'active','2026-11-02T01:50:54.887Z',NULL),
('七味道影视','https://www.qwavi.com/','影视','资源社区','影视网站','',3210,'active','2026-11-02T01:50:54.887Z',NULL),
('丹里科技','https://www.zjdanli.com/','打码平台','采集自动化','丹里科技专注解决反人类验证码，支持 Akamai、Incapsula、hCaptcha、PerimeterX 等。','',3220,'active','2026-11-02T01:50:54.887Z',NULL),
('主页','https://020417.xyz/','个人站','资源社区','个人主页','',3230,'active','2026-11-02T01:50:54.887Z',NULL),
('乐易编程助手','https://www.leybc.com/thread-7123-1-1.html','调试运行','逆向安全','乐易编程助手','',3240,'active','2026-11-02T01:50:54.887Z',NULL),
('乐易论坛','https://www.leybc.com/','交流论坛','资源社区','乐易论坛，易语言火山 PC 视窗中文编程交流论坛，APP逆向，APK动态分析。','',3250,'active','2026-11-02T01:50:54.887Z',NULL),
('乱码在线恢复','http://www.mytju.com/classcode/tools/messyCodeRecover.asp','在线工具','开发工具','乱码在线恢复。','',3260,'active','2026-11-02T01:50:54.887Z',NULL),
('云片','https://www.yunpian.com/product/captcha','国内防护','代理防护','云片行为验证，帮助网站智能区分人机，防止恶意攻击。全程AES+RSA算法加密传输，保障用户数据安全；秒级用户验证体验，验证结果毫秒级判断。','',3270,'active','2026-11-02T01:50:54.887Z',NULL),
('云码','https://console.jfbym.com/register/TG17764','打码平台','采集自动化','最推荐的打码平台，云码提供：在线普通图片、滑动、点选、谷歌、Hcaptcha、数字计算题等验证码识别及验证码识别API接口服务。','',3280,'active','2026-11-02T01:50:54.887Z',NULL),
('云立方','https://www.yunlifang.cn/','国内代理','代理防护','云立方是动态vps,拔号vps,adsl拔号服务器,代理ip,动态ip,天翼云,阿里云,腾讯云,华为云, 高防服务器提供商,高性价比vps服务器,静态云,云,vps,vps就找云立方!','',3290,'active','2026-11-02T01:50:54.887Z',NULL),
('互联网+','https://cy.ncss.cn/','比赛','学习提升','推动互联网发展新业态、催生的经济社会发展新形态.','',3300,'active','2026-11-02T01:50:54.887Z',NULL),
('代码转图片','https://carbon.now.sh/','爬虫','采集自动化','爬虫工具箱','',3310,'active','2026-11-02T01:50:54.887Z',NULL),
('仿B站项目','https://github.com/xunlu129/teriteri-client','Github项目','开发工具','一个用Springboot + Vue开发的仿B站项目。一个基于 vue3 搭建的视频网站平台客户端。','',3320,'active','2026-11-02T01:50:54.887Z',NULL),
('优设导航','https://hao.uisdc.com/','网站导航','资源社区','为设计师精选国内外优质网站.','',3330,'active','2026-11-02T01:50:54.887Z',NULL),
('优设设计','https://hao.uisdc.com/','设计','开发工具','设计师','',3340,'active','2026-11-02T01:50:54.887Z',NULL),
('先知社区','https://xz.aliyun.com/','交流论坛','资源社区','阿里云先知社区，先知安全技术社区。','',3350,'active','2026-11-02T01:50:54.887Z',NULL),
('公众号','https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token=2025719581','编程','开发工具','一种主流的线上线下微信互动营销方式.','',3360,'active','2026-11-02T01:50:54.887Z',NULL),
('刷题平台','https://match.yuanrenxue.cn/','爬虫','采集自动化','猿人学练习平台','',3370,'active','2026-11-02T01:50:54.887Z',NULL),
('加解密','http://tool.chacuo.net/cryptdes','爬虫','采集自动化','爬虫工具箱','',3380,'active','2026-11-02T01:50:54.887Z',NULL),
('协采云','http://clue.xiecaiyun.com/reg/?channel=Y-wt-bob','国内代理','代理防护','协采云九年深耕，百万级代理节点，自由调度！资源分池，客户间物理隔离，互不干扰！深度定制，代理池私有化部署，安全灵活！','',3390,'active','2026-11-02T01:50:54.887Z',NULL),
('博客园','https://www.cnblogs.com/','教程','学习提升','教程','',3400,'active','2026-11-02T01:50:54.887Z',NULL),
('发条 JS 调试工具','https://pan.baidu.com/s/1RSGT3lneb_pmFhvyuofT2w?pwd=sbox','调试运行','逆向安全','发条 JS 调试工具','',3410,'active','2026-11-02T01:50:54.887Z',NULL),
('吾爱汇编','https://www.52hb.com/','交流论坛','资源社区','吾爱汇编专注于软件安全领域。学习软件逆向分析技术，使软件开发者能够更好的弥补软件缺陷，修复软件漏洞，提升软件安全，将损失降为最低。大量的软件加密解密教程，使软件开发者与代码逆向分析爱好者受益颇多。保护开发者的利益与版权是我们持之以恒的动力！吾爱汇编论坛将竭尽全力为软件安全领域献出微薄之力！','',3420,'active','2026-11-02T01:50:54.887Z',NULL),
('吾爱破解','https://www.52pojie.cn/','资源','资源社区','PC软件安全领域、移动安全领域技术交流的社区.','',3430,'active','2026-11-02T01:50:54.887Z',NULL),
('品赞 HTTP','https://www.ipzan.com/','国内代理','代理防护','品赞代理ip软件是国内专业的ip代理服务器提供商，提供http代理，API接口和自动换IP代理软件，千万高匿名ip覆盖全国随意切换，支持PC、iOS、安卓，高效稳定免费试用，国内ip代理软件、http代理选择品赞代理。','',3440,'active','2026-11-02T01:50:54.887Z',NULL),
('哔哩哔哩','https://www.bilibili.com/','娱乐影音','资源社区','中国年轻世代高度聚集的文化社区和视频平台.','',3450,'active','2026-11-02T01:50:54.887Z',NULL),
('因体技术','https://iinti.cn/','国内代理','代理防护','马莲妮亚（Malenia）代理IP资源中台系统，配合 MITM 中间人攻击脚本无视加密进行数据采集，梅祖拉（majora）代理IP建设系统，更适合爬虫工程师的解决方案。','',3460,'active','2026-11-02T01:50:54.887Z',NULL),
('图鉴','http://www.ttshitu.com/','打码平台','采集自动化','图鉴网络科技有限公司是一家专注于图像识别的技术企业，我们通过深度学习的人工智能分析来解决终端图像识别问题，24小时不间断全天候的为大家服务。','',3470,'active','2026-11-02T01:50:54.887Z',NULL),
('在线加解密','http://tool.chacuo.net/cryptdes','在线工具','开发工具','在线 DES、3DES、AES、RC2、RC4、RC5、RC6、RSA 等加解密。','',3480,'active','2026-11-02T01:50:54.887Z',NULL),
('在线图片坐标拾取','https://uutool.cn/img-coord/','在线工具','开发工具','在线图片坐标拾取工具，可以快速拾取图片中指定点的坐标，在验证码逆向中比较有用。','',3490,'active','2026-11-02T01:50:54.887Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('域名探测','https://web.020417.xyz/','个人站','资源社区','域名探测','',3500,'active','2026-11-02T01:50:54.887Z',NULL),
('大眼仔旭','https://www.dayanzai.me/','工具','开发工具','教程','',3510,'active','2026-11-02T01:50:54.887Z',NULL),
('奇安信攻防社区','https://forum.butian.net/','交流论坛','资源社区','奇安信攻防社区。','',3520,'active','2026-11-02T01:50:54.887Z',NULL),
('奇迹秀','https://www.qijishow.com/','设计','开发工具','设计师','',3530,'active','2026-11-02T01:50:54.887Z',NULL),
('奇迹秀','http://www.qijishow.com/','网站导航','资源社区','为设计师提供设计干货及资源,绿色且免费.','',3540,'active','2026-11-02T01:50:54.887Z',NULL),
('实时新闻','https://new.020417.xyz/','个人站','资源社区','实时新闻','',3550,'active','2026-11-02T01:50:54.887Z',NULL),
('小七编程助手','https://pan.baidu.com/s/1S_u2Jr5eMGoW88sCR5coUw?pwd=sbox','调试运行','逆向安全','小七编程助手','',3560,'active','2026-11-02T01:50:54.887Z',NULL),
('小盾安全','https://sec.xiaodun.com/','国内防护','代理防护','小盾安全是同盾科技旗下全新业务安全独立品牌，是国内领先的全栈式业务安全解决方案专家，以“维护数字社会的安全与清朗”为使命，以业务攻击情报为驱动，以业务数据资产为原料，以网络安全技术为基础，以人工智能算法为核心，护航客户业务高速增长。','',3570,'active','2026-11-02T01:50:54.887Z',NULL),
('小象代理','https://www.xiaoxiangdaili.com/','国内代理','代理防护','小象代理是一家专业的优质HTTP动态IP服务提供商，产品低延迟高可用，稳定可靠，全国自建机房海量IP，企业级用户首选方案！','',3580,'active','2026-11-02T01:50:54.887Z',NULL),
('开发者所需软件合集','https://pan.baidu.com/s/1uoJqW12v-o3JfdQdqOP1Mw?pwd=r2ue','网盘分享','资源社区','开发者需要的常用软件','',3590,'active','2026-11-02T01:50:54.887Z',NULL),
('微信公众号文章排版','https://md.020417.xyz/','个人站','资源社区','微信公众号文章排版','',3600,'active','2026-11-02T01:50:54.887Z',NULL),
('快代理','https://www.kuaidaili.com/','国内代理','代理防护','快代理创立于2013年,专注为企业和开发者提供高品质的HTTP代理IP云服务,每日去重代理IP超40万个,提供使用IP代理服务完备的API接口和SDK,赋能于需要大量使用IP代理来实现大规模公共数据采集的场景,企业IP代理服务认准快代理。','',3610,'active','2026-11-02T01:50:54.887Z',NULL),
('掘金','https://juejin.cn/','教程','学习提升','教程','',3620,'active','2026-11-02T01:50:54.887Z',NULL),
('搜片','https://soupian.one/','影视','资源社区','搜片','',3630,'active','2026-11-02T01:50:54.887Z',NULL),
('数美科技','https://www.ishumei.com/','国内防护','代理防护','数美科技，基于先进的人工智能技术构建了全场景全流程全维度业务风控产品矩阵与秒级迭代全球SaaS AI风控服务网络，数美科技致力于为全球企业提供专业的在线业务风控服务，为在线业务增长保驾护航。','',3640,'active','2026-11-02T01:50:54.887Z',NULL),
('李玺 JS 在线解混淆','http://www.cnlans.com:8887/','代码混淆','逆向安全','李玺 JS 在线解混淆。','',3650,'active','2026-11-02T01:50:54.887Z',NULL),
('极验 GEETEST','https://www.geetest.com/','国内防护','代理防护','极验 GEETEST，互联网交互安全创领者，利用先进AI技术，通过行为验证，身份验证，设备验证等多维验证方式，智能识别人机，帮助企业鉴别异常流量，保障企业的业务安全，移动安全和流量安全。','',3660,'active','2026-11-02T01:50:54.887Z',NULL),
('欧易','https://oyicn.link/ul/YbU25D?channelId=52391770','AFF','商业推广','btc','',3670,'active','2026-11-02T01:50:54.887Z',NULL),
('注册sms','https://hero-sms.com/?ref-380169','AFF','商业推广','sms','',3680,'active','2026-11-02T01:50:54.887Z',NULL),
('泰迪杯','https://www.tipdm.org/','比赛','学习提升','群众性科技活动。以赛促学，以赛促教，以赛促研.','',3690,'active','2026-11-02T01:50:54.887Z',NULL),
('流量卡','https://www.hemorn.cn/index?k=bzBzYWFuSDkvYXM9','AFF','商业推广','流量卡很多','',3700,'active','2026-11-02T01:50:54.887Z',NULL),
('渐变色','https://uigradients.com/#BackToEarth','工具','开发工具','精美渐变色彩，可以直接下载.','',3710,'active','2026-11-02T01:50:54.887Z',NULL),
('爬虫工具库','https://spidertools.cn/','在线工具','开发工具','feapder 作者出品的爬虫工具库。','',3720,'active','2026-11-02T01:50:54.887Z',NULL),
('爬虫工具库','https://www.kgtools.cn/','在线工具','开发工具','K 哥爬虫工具库。','',3730,'active','2026-11-02T01:50:54.887Z',NULL),
('爬虫工具箱','https://spidertools.cn/#/','爬虫','采集自动化','爬虫工具箱','',3740,'active','2026-11-02T01:50:54.887Z',NULL),
('爬虫题库','https://tiku.020417.xyz','个人站','资源社区','爬虫题库','',3750,'active','2026-11-02T01:50:54.887Z',NULL),
('爱壹帆','https://www.iyf.lv','影视','资源社区','影视网站','',3760,'active','2026-11-02T01:50:54.887Z',NULL),
('爱奇艺','https://www.iqiyi.com/','娱乐影音','资源社区','拥有海量、优质视频的网站.','',3770,'active','2026-11-02T01:50:54.887Z',NULL),
('爱改写','https://www.aigaixie.com/','AI文档办公','AI 工具','基于 NLP 自然语言技术支持为您提供中英文查词解释、释义改写、同义词识别、文本纠错、内容原创度查询一站式服务。','',3780,'active','2026-11-02T01:50:54.887Z',NULL),
('爱锭网','https://www.python-spider.com/challenge/','爬虫','采集自动化','猿人学练习平台','',3790,'active','2026-11-02T01:50:54.887Z',NULL),
('片库网','https://www.zzldxny.com/','影视','资源社区','片库网','',3800,'active','2026-11-02T01:50:54.887Z',NULL),
('牛客网','https://www.nowcoder.com/','刷题','学习提升','集笔面试系统、题库、课程教育、社群交流、招聘内推于一体的招聘类网站.','',3810,'active','2026-11-02T01:50:54.887Z',NULL),
('狸猫盘搜','https://www.alipansou.com/','资源','资源社区','狸猫盘搜','',3820,'active','2026-11-02T01:50:54.887Z',NULL),
('猿人学练习平台','https://www.python-spider.com/challenge/','练习平台','学习提升','猿人学练习平台','',3830,'active','2026-11-02T01:50:54.887Z',NULL),
('百度翻译','https://fanyi.baidu.com/','工具','开发工具','多语种即时在线翻译.','',3840,'active','2026-11-02T01:50:54.887Z',NULL),
('看雪安全社区','https://bbs.kanxue.com/','交流论坛','资源社区','看雪安全，专注于PC、移动、智能设备安全研究及逆向工程的开发者社区。','',3850,'active','2026-11-02T01:50:54.887Z',NULL),
('知数云','https://data.zhishuyun.com/','打码平台','采集自动化','用一个个标准化服务，助力你工作与生活的方方面面。支持 reCaptcha、hCaptcha 等识别，还支持 AI 图像接口等。','',3860,'active','2026-11-02T01:50:54.887Z',NULL),
('短链接生成','https://l.020417.xyz/','个人站','资源社区','短链接生成','',3870,'active','2026-11-02T01:50:54.887Z',NULL),
('程序员盒子','https://www.coderutil.com/','工具','开发工具','很多东西','',3880,'active','2026-11-02T01:50:54.887Z',NULL),
('简悦 - SimpRead','https://simpread.pro/','其他工具','开发工具','让你瞬间进入沉浸式阅读的 Chrome 扩展，类似 Safari 的阅读模式。','',3890,'active','2026-11-02T01:50:54.887Z',NULL),
('精易编程助手','http://soft.125.la/plugin.php?id=jingyi_soft:soft&cid=3','调试运行','逆向安全','精易编程助手','',3900,'active','2026-11-02T01:50:54.887Z',NULL),
('精易论坛','https://bbs.125.la/','交流论坛','资源社区','富有学习气氛的编程技术论坛。易语言答疑互助模式，让新手的疑问得到解决，让高手接到软件定制业务。','',3910,'active','2026-11-02T01:50:54.887Z',NULL),
('维格表','https://spcqwserdvymm.com.vika.cn/share/shryNwH3HRgvzMTaZVAGx/fodkuzz5eaw0w','网站导航','资源社区','团队数据协作与项目管理神器。无需下载，在线使用.','',3920,'active','2026-11-02T01:50:54.888Z',NULL),
('编程导航','https://www.code-nav.cn/','网站导航','资源社区','一站式编程资源搜索,定制你的程序员必备主页,提高编程学习效率.','',3930,'active','2026-11-02T01:50:54.888Z',NULL),
('网易云','https://music.163.com/','娱乐影音','资源社区','一款专注于发现与分享的音乐产品.','',3940,'active','2026-11-02T01:50:54.888Z',NULL),
('网易易盾','https://dun.163.com/','国内防护','代理防护','网易易盾是网易旗下一站式数字内容风控品牌，依托网易20余年的技术沉淀和实践经验，提供专业的内容安全、业务安全、移动安全等服务，全方位保障客户业务合规、稳健和安全运营。','',3950,'active','2026-11-02T01:50:54.888Z',NULL),
('网易邮箱','https://mail.qq.com/cgi-bin/frame_html?sid=up6KZlz3BGBz40wu&r=ebc72a3dc579725eb92a51a5a7d86b2f','工具','开发工具','网易163免费邮箱--中文邮箱第一品牌,支持各种客户端软件收发.','',3960,'active','2026-11-02T01:50:54.888Z',NULL),
('耐看点播','https://www.nkvod.com/','影视','资源社区','耐看点播','',3970,'active','2026-11-02T01:50:54.888Z',NULL),
('胖虎影视','https://panghuys.com/','影视','资源社区','影视网站','',3980,'active','2026-11-02T01:50:54.888Z',NULL),
('腾讯云','https://cloud.tencent.com/','编程','开发工具','腾讯的云计算品牌，以卓越科技能力助力各行业数字化转型.','',3990,'active','2026-11-02T01:50:54.888Z',NULL);
insert or replace into nav_links (name, url, catelog, grp, descr, icon, sort, status, created_at, updated_at) values
('腾讯云7.5折扣入口','https://curl.qcloud.com/JgTpb4jm','推广','资源社区','腾讯云大使','',4000,'active','2026-11-02T01:50:54.888Z',NULL),
('腾讯视频','https://v.qq.com/','娱乐影音','资源社区','致力于打造中国领先的在线视频媒体平台.','',4010,'active','2026-11-02T01:50:54.888Z',NULL),
('良许教程','https://www.lxlinux.net/','学习文档','学习提升','Linux系统常用命令教学,shell脚本入门学习.','',4020,'active','2026-11-02T01:50:54.888Z',NULL),
('节点','https://1s.bigmeok.me/user#/register?code=ZTrIUOBr','推广','资源社区','节点','',4030,'active','2026-11-02T01:50:54.888Z',NULL),
('菜鸟教程','https://www.runoob.com/','教程','学习提升','菜鸟教程','',4040,'active','2026-11-02T01:50:54.888Z',NULL),
('超大流量卡','https://www.hemorn.cn/index?k=bzBzYWFuSDkvYXM9','推广','资源社区','超大流量卡，可打电话，可注册','',4050,'active','2026-11-02T01:50:54.888Z',NULL),
('超级鹰','http://www.chaojiying.com/','打码平台','采集自动化','超级鹰是比较老牌的打码平台，提供专业的验证码云端识别服务，让验证码识别更快速、更准确、更强大。可为所有软件提供验证码识别自动化解决方案，帮助客户进行验证码识别、远程答题、人工打码,为用户实现价值。','',4060,'active','2026-11-02T01:50:54.888Z',NULL),
('通义万相','https://wanxiang.aliyun.com/','AI图像绘画','AI 工具','通义万相，是阿里云通义系列 AI 绘画创作大模型，该模型可辅助人类进行图片创作，于2023年7月7日正式上线。','',4070,'active','2026-11-02T01:50:54.888Z',NULL),
('通义千问','https://qianwen.aliyun.com/','AI聊天对话','AI 工具','通义千问，是阿里云推出的一个超大规模的语言模型，功能包括多轮对话、文案创作、逻辑推理、多模态理解、多语言支持。能够跟人类进行多轮的交互，也融入了多模态的知识理解，且有文案创作能力，能够续写小说，编写邮件等。','',4080,'active','2026-11-02T01:50:54.888Z',NULL),
('镀金的天空 GlidedSky','http://www.glidedsky.com/','练习平台','学习提升','镀金的天空 GlidedSky，爬虫在线闯关练习平台。','',4090,'active','2026-11-02T01:50:54.888Z',NULL),
('阿布云','https://www.abuyun.com/','国内代理','代理防护','阿布云 —— 最专业的大数据服务商','',4100,'active','2026-11-02T01:50:54.888Z',NULL),
('阿里云','https://www.aliyun.com/','编程','开发工具','面向全球用户,提供多种高性能的云产品.','',4110,'active','2026-11-02T01:50:54.888Z',NULL),
('阿里云云盾','https://www.aliyun.com/product/afs','国内防护','代理防护','阿里云验证码产品，使用业界先进的风控引擎结合“规则+AI”模型，有效区分真实用户和机器自动化脚本攻击，避免机器请求造成业务损失。','',4120,'active','2026-11-02T01:50:54.888Z',NULL),
('阿里云折扣入口','https://www.aliyun.com/minisite/goods?userCode=qn2j4wxt','推广','资源社区','腾讯云大使','',4130,'active','2026-11-02T01:50:54.888Z',NULL),
('阿里云盘','https://www.aliyundrive.com/drive/','编程','开发工具','一款速度快、不打扰、够安全、易于分享的网盘.','',4140,'active','2026-11-02T01:50:54.888Z',NULL),
('阿里矢量图','https://www.iconfont.cn/','资源','资源社区','功能强大,图标内容丰富,支持矢量图标下载、在线存储、格式转换.','',4150,'active','2026-11-02T01:50:54.888Z',NULL),
('随缘 JS 调试工具','https://pan.baidu.com/s/18XmJwP2MZI9jZibS8tqw-Q?pwd=sbox','调试运行','逆向安全','随缘 JS 调试工具','',4160,'active','2026-11-02T01:50:54.888Z',NULL),
('青果代理ip','https://www.qg.net/kxjlbwwq','AFF','商业推广','国内外代理ip','',4170,'active','2026-11-02T01:50:54.888Z',NULL),
('青果网络','https://www.qg.net/kxjlbwwq','国内代理','代理防护','青果网络提供香港、美国、韩国云主机，同时携手腾讯云、天翼云助力企业上云；云电脑、拨号VPS和动态代理IP为大数据赋能；高防服务器租用与托管为企业安全保驾护航；大带宽与机柜业务加速网络访问。','',4180,'active','2026-11-02T01:50:54.888Z',NULL),
('音范丝','https://www.yinfans.me/','影视','资源社区','音范丝','',4190,'active','2026-11-02T01:50:54.888Z',NULL),
('顶象','https://www.dingxiang-inc.com/','国内防护','代理防护','顶象防御云，致力于帮助企业构建自主可控的业务安全体系，通过智能无感验证码、端加固、设备指纹、实时决策、安全感知防御平台等产品解决业务欺诈威胁，防范化解各类网络黑灰产风险，让业务更加健康稳定,助力企业创新与增长。','',4200,'active','2026-11-02T01:50:54.888Z',NULL),
('飘云阁','https://www.chinapyg.com/','交流论坛','资源社区','飘云阁致力于软件安全、游戏外挂及病毒分析的前沿，丰富的学习教程免费向广大用户提供，由国内外安全界知名人士共同维护。','',4210,'active','2026-11-02T01:50:54.888Z',NULL),
('鬼鬼 JS 调试工具','https://pan.baidu.com/s/1i5O-RrsHCgBmQCSXplR5sg?pwd=sbox','调试运行','逆向安全','鬼鬼 JS 调试工具','',4220,'active','2026-11-02T01:50:54.888Z',NULL),
('黑马程序员','https://www.runoob.com/','编程','开发工具','传智教育旗下高端IT教育品牌，高品质教研.','',4230,'active','2026-11-02T01:50:54.888Z',NULL);
insert or replace into ai_boards (key, name, icon, sort, status, created_at, updated_at) values
('stations','中转站','cloud',0,'active','2026-11-02T01:50:55.123Z',NULL),
('tools','工具','code',1,'active','2026-11-02T01:50:55.123Z',NULL),
('skills','Skills','apps',2,'active','2026-11-02T01:50:55.123Z',NULL),
('vpns','VPN','safe',3,'active','2026-11-02T01:50:55.123Z',NULL),
('servers','AI 直连平台','thunderbolt',4,'active','2026-11-02T01:50:55.123Z',NULL),
('tutorials','教程','file',5,'active','2026-11-02T01:50:55.123Z',NULL);
insert or replace into ai_items (board, name, url, descr, models, ratio, tags, content, sort, status, created_at, updated_at) values
('stations','快跑','https://kuaipao.ai/register?aff=4u8Y','有0.08x','codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.5-openai-compact / gpt-5.6-luna-openai-compact / gpt-5.6-sol / gpt-5.6-sol-openai-compact / gpt-5.6-terra / gpt-5.6-terra-openai-compact','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','aixoras','https://aixoras.com/register?aff=CHpR','0.15x','codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','wawazz','https://wawazz.xyz/register?aff=4QEFE4FD4U5R','','codex-auto-review / gpt-4o-audio-preview / gpt-4o-realtime-preview / gpt-5.2 / gpt-5.2-2025-12-11 / gpt-5.2-chat-latest / gpt-5.2-pro / gpt-5.2-pro-2025-12-11 / gpt-5.3-codex-spark / gpt-5.4 / gpt-5.4-2026-03-05 / gpt-5.4-mini / gpt-5.5 / gpt-5.6 / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra / gpt-image-1 / gpt-image-1.5 / gpt-image-2','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','codex666ai','https://codex666ai.com/register?aff=U4K568W2QUAD','有0.08x','codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.6 / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra / gpt-image-2','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','gateai','https://gateai.cc/register?aff=XW2XK5NKBK46','20260810有0.08x','gpt-5.4 / gpt-5.3-codex / gpt-5.6-terra / gpt-5.6-luna / gpt-5.3-codex-spark / gpt-5.4-mini / gpt-5.2 / gpt-5.5 / gpt-5.6-sol','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','吉吉中转站','https://www.jiji.cc/register?aff=XHGGLDGH3295','有0.08x','codex-auto-review / gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','ooioo','https://ooioo.work/sign-up?aff=FUte','有0.08x','gpt-5.3-codex-spark / gpt-5.4-mini / gpt-5.4 / gpt-5.6 / gpt-5.6-terra / gpt-5.6-luna / codex-auto-review / gpt-5.5 / gpt-5.6-sol','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','悠米','https://www.umapis.com/sign-up?aff=0Zee','有0.01x','gpt-5.4 / gpt-5.5 / gpt-5.6-sol / gpt-5.6-terra','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','小肩膀','https://www.fastaitoken.com/register?aff=WE5KN7HXYFA5','有0.06','gpt-3.5-turbo / gpt-4','','[]','',0,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','xfastapi','https://xfastapi.ai/register?aff=C95CW43PDZLC','0.2x','gpt-5.3-codex-spark / gpt-5.4 / gpt-5.4-2026-03-05 / gpt-5.4-mini / gpt-5.5 / gpt-5.6 / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra / gpt-image-1 / gpt-image-1.5 / gpt-image-2','','[]','',1,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','agentrouter','https://agentrouter.org/register?aff=IF4f','需要🪜注册送175应该是','gpt-3.5-turbo / gpt-4','','[]','',2,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','rapidapi','https://rapidapi.cc/register?aff=WVXPCAMFAMQ7','','gpt-3.5-turbo / gpt-4','','[]','',2,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','一坨屎','https://yituoshiai.com/sign-up?aff=qKbX','1x','gpt-5.4 / gpt-5.4-mini / gpt-5.5 / gpt-5.5-openai-compact / gpt-5.6-luna / gpt-5.6-sol / gpt-5.6-terra','','[]','',2,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','aispeedapi','https://aispeedapi.com/register?aff=2JCDBDNXN2XR','','','','[]','',3,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','自用','https://cc.hlds.fun/v1','','all / ch / kr/claude-opus-5 / kr/claude-opus-5-thinking / kr/claude-opus-5-agentic / kr/claude-opus-5-thinking-agentic / kr/claude-opus-4.8 / kr/claude-opus-4.8-thinking / kr/claude-opus-4.8-agentic / kr/claude-opus-4.8-thinking-agentic / kr/claude-opus-4.7 / kr/claude-opus-4.7-thinking / kr/claude-opus-4.7-agentic / kr/claude-opus-4.7-thinking-agentic / kr/claude-opus-4.5 / kr/claude-opus-4.5-thinking / kr/claude-opus-4.5-agentic / kr/claude-opus-4.5-thinking-agentic / kr/claude-sonnet-5 / kr/claude-sonnet-4.5 / kr/claude-haiku-4.5 / kr/deepseek-3.2 / kr/qwen3-coder-next / kr/glm-5 / kr/MiniMax-M2.5 / kr/gpt-5.6-sol / kr/gpt-5.6-terra / kr/gpt-5.6-luna / kr/claude-sonnet-5-thinking / kr/claude-sonnet-4.5-thinking / kr/claude-haiku-4.5-thinking / kr/gpt-5.6-sol-thinking / kr/gpt-5.6-terra-thinking / kr/gpt-5.6-luna-thinking / kr/claude-sonnet-5-agentic / kr/claude-sonnet-4.5-agentic / kr/claude-haiku-4.5-agentic / kr/gpt-5.6-sol-agentic / kr/gpt-5.6-terra-agentic / kr/gpt-5.6-luna-agentic / kr/claude-sonnet-5-thinking-agentic / kr/claude-sonnet-4.5-thinking-agentic / kr/claude-haiku-4.5-thinking-agentic / kr/gpt-5.6-sol-thinking-agentic / kr/gpt-5.6-terra-thinking-agentic / kr/gpt-5.6-luna-thinking-agentic / nvidia/deepseek-ai/deepseek-v4-flash / nvidia/nemotron-3-ultra-550b-a55b / nvidia/parakeet-ctc-1.1b-asr / ollama/minimax-m3 / gemini/gemini-3.6-flash / gemini/gemini-3.5-flash-lite / gemini/gemini-3.1-flash-lite-preview / gemini/gemini-3-flash-preview / gemini/gemma-4-31b-it / ps/laguna-s-2.1 / ps/laguna-xs-2.1 / kimchi/kimi-k2.7 / kimchi/minimax-m3 / kimchi/nemotron-3-ultra-fp4 / kimchi/deepseek-v4-flash / kgw/kilo-auto/free / kgw/nvidia/nemotron-3-super-120b-a12b:free / kgw/nvidia/nemotron-3-ultra-550b-a55b:free / bzl/auto:free / openrouter/nvidia/nemotron-3-ultra-550b-a55b:free / openrouter/poolside/laguna-s-2.1:free / openrouter/poolside/laguna-xs-2.1:free / openrouter/google/gemma-4-26b-a4b-it:free / openrouter/nvidia/nemotron-3-nano-30b-a3b:free / openrouter/nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free / openrouter/nvidia/nemotron-3-super-120b-a12b:free / openrouter/cohere/north-mini-code:free / openrouter/inclusionai/ling-3.0-flash:free / af/anthropic/claude-3.7-sonnet / af/moonshot/kimi-k2.6 / af/google/gemini-2.5-flash / cbcn/glm-5.2 / cbcn/glm-5.1 / cbcn/glm-5.0 / cbcn/glm-5.0-turbo / cbcn/glm-5v-turbo / cbcn/glm-4.7 / cbcn/minimax-m3 / cbcn/minimax-m2.7 / cbcn/kimi-k2.7 / cbcn/kimi-k2.6 / cbcn/kimi-k2.5 / cbcn/hy3-preview / cbcn/deepseek-v4-pro / cbcn/deepseek-v4-flash / cbcn/deepseek-v3-2-volc / cbcn/hy3 / qd/qmodel_38max','','[]','',9,'active','2026-11-02T01:50:56.940Z',NULL),
('stations','硅基流动','https://cloud.siliconflow.cn/i/YPTRToh2','','meituan-longcat/LongCat-2.0 / zai-org/GLM-5.2 / moonshotai/Kimi-K2.7-Code / deepseek-ai/DeepSeek-V4-Pro / deepseek-ai/DeepSeek-V4-Flash / Pro/moonshotai/Kimi-K2.6 / Pro/zai-org/GLM-5.1 / nex-agi/Nex-N2-Pro / MiniMaxAI/MiniMax-M2.5 / Pro/MiniMaxAI/MiniMax-M2.5 / Tongyi-MAI/Z-Image-Turbo / Tongyi-MAI/Z-Image / baidu/ERNIE-Image-Turbo / deepseek-ai/DeepSeek-V3.2 / Pro/deepseek-ai/DeepSeek-V3.2 / deepseek-ai/DeepSeek-V3.1-Terminus / Pro/deepseek-ai/DeepSeek-V3.1-Terminus / Qwen/Qwen3.6-35B-A3B / Qwen/Qwen3.6-27B / Qwen/Qwen3.5-397B-A17B / Qwen/Qwen3.5-122B-A10B / Qwen/Qwen3.5-35B-A3B / Qwen/Qwen3.5-27B / Qwen/Qwen3.5-9B / Qwen/Qwen3.5-4B / Qwen/Qwen3-VL-Embedding-8B / Qwen/Qwen3-VL-Reranker-8B / PaddlePaddle/PaddleOCR-VL-1.5 / deepseek-ai/DeepSeek-R1 / Pro/deepseek-ai/DeepSeek-R1 / deepseek-ai/DeepSeek-V3 / Pro/deepseek-ai/DeepSeek-V3 / stepfun-ai/Step-3.5-Flash / Qwen/Qwen3-VL-32B-Instruct / Qwen/Qwen3-VL-32B-Thinking / Qwen/Qwen3-VL-8B-Instruct / Qwen/Qwen3-VL-8B-Thinking / Qwen/Qwen3-VL-30B-A3B-Instruct / Qwen/Qwen3-VL-30B-A3B-Thinking / Qwen/Qwen3-Omni-30B-A3B-Instruct / Qwen/Qwen3-Omni-30B-A3B-Thinking / Qwen/Qwen3-Omni-30B-A3B-Captioner / deepseek-ai/DeepSeek-OCR / inclusionAI/Ling-flash-2.0 / inclusionAI/Ling-mini-2.0 / Qwen/Qwen-Image-Edit-2509 / Qwen/Qwen-Image-Edit / Qwen/Qwen-Image / tencent/Hunyuan-MT-7B / ByteDance-Seed/Seed-OSS-36B-Instruct / Wan-AI/Wan2.2-I2V-A14B / Wan-AI/Wan2.2-T2V-A14B / zai-org/GLM-4.5V / zai-org/GLM-4.5-Air / TeleAI/TeleSpeechASR / Qwen/Qwen3-Coder-30B-A3B-Instruct / Qwen/Qwen3-30B-A3B-Instruct-2507 / tencent/Hunyuan-A13B-Instruct / deepseek-ai/DeepSeek-R1-0528-Qwen3-8B / Qwen/Qwen3-32B / Qwen/Qwen3-14B / Qwen/Qwen3-8B / Qwen/Qwen3-Reranker-8B / Qwen/Qwen3-Embedding-8B / Qwen/Qwen3-Reranker-4B / Qwen/Qwen3-Embedding-4B / Qwen/Qwen3-Reranker-0.6B / Qwen/Qwen3-Embedding-0.6B / THUDM/GLM-4-32B-0414 / THUDM/GLM-Z1-9B-0414 / THUDM/GLM-4-9B-0414 / fnlp/MOSS-TTSD-v0.5 / FunAudioLLM/CosyVoice2-0.5B / FunAudioLLM/SenseVoiceSmall / BAAI/bge-m3 / BAAI/bge-reranker-v2-m3 / Kwai-Kolors/Kolors / Qwen/Qwen2.5-72B-Instruct-128K / Qwen/Qwen2.5-72B-Instruct / Qwen/Qwen2.5-32B-Instruct / Qwen/Qwen2.5-14B-Instruct / Qwen/Qwen2.5-7B-Instruct / BAAI/bge-large-en-v1.5 / BAAI/bge-large-zh-v1.5 / Pro/BAAI/bge-m3 / Pro/Qwen/Qwen2.5-7B-Instruct / Pro/BAAI/bge-reranker-v2-m3 / LoRA/Qwen/Qwen2.5-32B-Instruct / LoRA/Qwen/Qwen2.5-14B-Instruct / LoRA/Qwen/Qwen2.5-72B-Instruct / LoRA/Qwen/Qwen2.5-7B-Instruct','','[]','',10,'active','2026-11-02T01:50:56.940Z',NULL),
('tools','codex','https://chatgpt.com','OpenAI Codex CLI 是一款基于终端的 AI 编程助手，用于在命令行中快速生成、修改和解释代码。','','','["AI编程","命令行工具","代码生成","OpenAI","开发辅助"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','opencode','npm i -g opencode-ai@latest','','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','Termius','https://github.com/ArcSurge/Termius-Pro-zh_CN','Termius是一款跨平台的SSH客户端工具，用于远程服务器管理与终端连接。','','','["SSH客户端","远程连接","终端工具","跨平台","服务器管理"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','小说生成https://github.com/godothub/konado','https://github.com/godothub/konado','基于大语言模型的自动化小说生成工具，适用于快速创作长篇虚构故事场景。','','','["小说生成","AI写作","自动化创作","LLM应用","Python"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','小说生成https://github.com/MRXOAD/xuanji-write','https://github.com/MRXOAD/xuanji-write','基于大语言模型的开源小说生成工具，适用于自动化创作与长文本写作场景。','','','["小说生成","AI写作","自动化工具","开源项目"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','zvec向量轻量数据库','','阿里巴巴开源的高性能向量化处理库，适用于高并发数据计算与处理场景。','','','["向量化","高性能","C++库","数据处理"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','临时邮箱cloudflare_temp_email','https://github.com/ice-a/cloudflare_temp_email','基于 Cloudflare Workers 构建的临时邮箱服务，用于快速搭建个人专属的临时收发信平台。','','','["Cloudflare","临时邮箱","Workers","D1数据库","自建服务"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','claude code','npm i -g @anthropic-ai/claude-code@latest','Anthropic推出的命令行AI编程助手，用于在终端中直接进行代码编写、调试与仓库管理。','','','["命令行工具","AI编程","代码生成","Anthropic","开发效率"]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('tools','gemini','npm i -g @google/gemini-cli@latest','Google Gemini AI大模型，适用于自然语言处理、代码生成与多模态理解场景。','','','["大模型","人工智能","Google","API","多模态"]','',2,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','reverse-skill','https://github.com/zhaoxuya520/reverse-skill.git','一个专注于逆向工程技能与知识分享的开源项目。','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','爬虫王','https://github.com/aoyunyang/spider-king-skill','一款专注于网络数据抓取与自动化采集的开源爬虫工具或技能包。','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','objection','https://github.com/sensepost/objection','基于Frida的运行时移动设备探索工具包，支持免Root测试。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','JsRpc','https://github.com/jxhczhl/JsRpc','基于WebSocket的JavaScript远程调用工具，常用于爬虫逆向与自动化。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','iv8','https://github.com/HanZzzzz000/iv8','一个托管在 GitHub 上的开源项目，提供相关技术工具或代码库。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','binwalk','https://github.com/ReFirmLabs/binwalk','Binwalk是一款强大的固件分析工具，用于扫描和提取嵌入式固件中的文件系统及代码。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','GhidraMCP','https://github.com/LaurieWired/GhidraMCP','Ghidra的MCP服务器实现，支持AI模型自动化执行逆向工程与代码分析任务。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','js-reverse-automation--skill','https://github.com/Fausto-404/js-reverse-automation--skill','用于自动化 JavaScript 逆向工程的技能工具，辅助代码解密与逻辑分析。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','jshook-skill','https://github.com/wuji66dde/jshook-skill','一个专注于 JavaScript Hook 技术的工具库，提供灵活的函数拦截与修改能力。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','mitmproxy','https://github.com/mitmproxy/mitmproxy','一款开源的交互式 HTTPS 代理工具，支持抓包与流量篡改。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','IDA-Skill','https://github.com/miunasu/IDA-Skill','让 AI Agent 像安全分析师一样分析恶意样本','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','Reverse Engineering Skill','https://github.com/vgrichina/re-skill','逆向工程技能库，提供二进制分析与软件逆向的学习资源和工具集。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','reverse-skill','https://github.com/715494637/reverse-skill','一个聚焦于逆向工程技能与相关知识的开源资源项目。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','Reverse Engineering Skills','https://github.com/P4nda0s/reverse-skills','专注于逆向工程技术的开源知识库与学习资源合集。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','rizin','https://github.com/rizinorg/rizin','一款开源的逆向工程框架与命令行工具集，源自radare2的分支。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','agent-skills','https://github.com/betab0t/skills','为AI智能体提供可复用工具与技能的开源代码库。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','angr','https://github.com/angr/angr','一个强大的Python二进制分析框架，支持符号执行与逆向工程。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','android-reverse-engineering-skill','https://github.com/SimoneAvogadro/android-reverse-engineering-skill','专注于 Android 逆向工程的学习指南与技能资源库，助力安全研究与应用分析。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','ai-reverse-toolkit','https://github.com/zhizhuodemao/ai-reverse-toolkit','专注于人工智能模型逆向分析与安全测试的开源工具集。','','','[]','',1,'active','2026-11-02T01:50:56.941Z',NULL),
('skills','js-deobfuscator','https://github.com/0x1Avram/js-deobfuscator','用于还原混淆 JavaScript 代码的开源工具，提升代码可读性。','','','[]','',3,'active','2026-11-02T01:50:56.941Z',NULL),
('vpns','Bigme','https://1s.bigmeok.me/user#/register?code=ZTrIUOBr','用的还行，很多人用','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('vpns','赔钱机场','https://pqjc.site/register?code=s24MpjNA&cover=sfw','价格还行','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('vpns','宝可梦','https://love2.p6m6.com/#/register?code=Ap1bRu77','相对稳定，L站每月有免费的优惠码','','','[]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('vpns','魔戒','https://mojie.co/register?aff=s2HJRZse','老牌的一个了','','','[]','',2,'active','2026-11-02T01:50:56.941Z',NULL),
('vpns','良心云','https://liangxin.xyz/#/register?code=AQKiSMPs','便宜','','','[]','',3,'active','2026-11-02T01:50:56.941Z',NULL);
insert or replace into ai_items (board, name, url, descr, models, ratio, tags, content, sort, status, created_at, updated_at) values
('servers','nvidia','https://build.nvidia.com/models','免费，就是慢','','','["国际"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','cline','https://docs.cline.bot/usage/cline-desktop','免费的一些模型，但是用多要等cd','','','["国际"]','',0,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','美团龙猫','https://longcat.chat/platform/product?inviteCode=ATAEFO9T','美团龙猫是美团官方推出的AI接入平台，提供直连服务。','','','["官方直连","国内"]','',3,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','Deepseek','https://platform.deepseek.com/usage','DeepSeek官方AI直连平台，提供直接模型接入服务。','','','["官方直连","全球"]','',3,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','智谱全球','https://open.bigmodel.cn','智谱AI的官方直连平台，支持全球用户接入大模型服务。','','','["官方直连","全球"]','',3,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','阿里云百炼','https://bailian.console.aliyun.com/cn-beijing/model/market','阿里云官方AI模型服务平台，提供模型市场、微调及应用构建服务。','','','["tokenhub","国内"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','腾讯云hub','https://console.cloud.tencent.com/tokenhub/models?tab=all','腾讯云官方推出的AI模型直连平台，支持多种模型接入服务。','','','["tokenhub","全球"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','京东云','https://joyagent.jd.com/pl/model-retrieval','京东云提供的AI模型检索官方直连平台，支持便捷接入服务','','','["tokenhub","全球"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','百度云','https://console.bce.baidu.com/qianfan/modelcenter/model/buildIn/list','百度官方AI接入平台，通过千帆模型中心提供模型直连服务。','','','["tokenhub","国内"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','字节火山云','https://console.volcengine.com/ark/region:cn-beijing/model/leaderboard','字节跳动官方 AI 模型直连平台，支持开发者快速接入服务','','','["tokenhub","国内"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','硅基流动_中转站','https://cloud.siliconflow.cn/i/YPTRToh2','硅基流动的中转站平台，提供 AI 模型的聚合接入服务','','','["tokenhub","全球"]','',4,'active','2026-11-02T01:50:56.941Z',NULL),
('servers','华为云','https://console.huaweicloud.com/modelarts/?region=cn-southwest-2#/model-studio/square','华为云官方 AI 开发平台，提供一站式模型开发服务。','','','["tokenhub","国内"]','',5,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','常用的js片段','','介绍获取选中文本、阻止右键、动态加载脚本与样式表以及DOM加载完成执行等常用JavaScript实用代码片段。','','','[]','# 获取选择到的字
``` JavaScript
function getSelectedText() {
	if (window.getSelection) { // This technique is the most likely to be standardized.         
		// getSelection() returns a Selection object, which we do not document.        
		return window.getSelection()
			.toString();
	} else if (document.getSelection) {
		// This is an older, simpler technique that returns a string        
		return document.getSelection();
	} else if (document.selection) {
		// This is the IE-specific technique.         
		// We do not document the IE selection property or TextRange objects.         
		return document.selection.createRange()
			.text;
	}
}
```

# 阻止右键
``` JavaScript
document.body.onselectstart = document.body.oncontextmenu = function() {
	return false;
}
```

# 动态加载
``` JavaScript
//NO.1
function loadScript(url, callback){
    var script = document.createElement ("script")
    script.type = "text/javascript";
    if (script.readyState){ //IE
        script.onreadystatechange = function(){
            if (this.readyState == "loaded" || this.readyState == "complete"){
                this.onreadystatechange = null;
                callback();
            }
        };
    } else { //Others
        script.onload = function(){
            callback();
        };
    }
    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}

//NO.2
function loadScript(url, callback){
    var xhr = new XMLHttpRequest();
    xhr.open("get", url, true);
    xhr.onreadystatechange = function(){
        if (xhr.readyState == 4){
            if (xhr.status >= 200 && xhr.status < 300 || xhr.status == 304){
                var script = document.createElement ("script");
                script.type = "text/javascript";
                script.text = xhr.responseText;
                document.body.appendChild(script);
                callback();
            }
        }
    };
    xhr.send(null);
}
```

# dom加载完执行
``` JavaScript
function domLoad(fn){
    if(document.addEventListener){
        document.addEventListener("DOMContentLoaded", fn, false);
    }else{
        if(window.ActiveXObject){
            document.write("<script id=''ie_onload'' defer src=''javascript:void(0)''><\/script>");
            document.getElementById("ie_onload").onreadystatechange = function(){
                if(this.readyState == "complete"){
                    this.onreadystatechange = null;
                    fn();
                }
            }
        }
        if(/WebKit/i.test(navigator.userAgent)){
            var _timer = setInterval(function(){
                if(/loaded|complete/.test(document.readyState)){
                    clearInterval(_timer);
                    fn();
                }
            }, 10);
        }
    }
}
```

# 加载样式表
``` JavaScript
function addSheet(url){
    var oLink = document.createElement(''link''),oHead = document.getElementsByTagName(''head'')[0];
    oLink.rel = ''stylesheet'';
    oLink.type = ''text/css'';
    oLink.href = url;
    oHead.appendChild(oLink);
}
```

# 获取css
``` JavaScript
function getStyle(o, attr){
    if(o.currentStyle){
        return o.currentStyle[attr];
    }
    else{
        return getComputedStyle(o,false)[attr];
    }
}
```

# 获取服务器时间
``` JavaScript
function getNowDate(callback){
    var xhr = new XMLHttpRequest();
    xhr.open(''get'', ''null.txt'', true); //null.txt不存在，我们不需要
    xhr.onreadystatechange = function(){
        if(xhr.readyState == 3){ //状态3响应
            callback(xhr.getResponseHeader(''Date'')); //返回时间，那么可以利用获得的时间做倒计时程序了。
        }
    };
    xhr.send(null);
}
```

# cookie处理
``` JavaScript
function Cookie(name, value, options){
    if(typeof value != ''undefined''){
        options = options || {};
        if(value === null){
            options.expires = -1; //过期
        }
        var expires = '''';
        //存在时间选项
        if(options.expires && (typeof options.expires == ''number'' || options.expires.toUTCString)){
            var date;
            if(typeof options.expires == ''number''){
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            }else{
                date = options.expires;
            }
            expires = ''; expires=''+date.toUTCString();
        }
        var path = options.path ? ''; path=''+options.path : '''';
        var domain = options.domain ? ''; domain=''+options.domain : '''';
        var secure = options.secure ? ''; secure'' : '''';
        //写入cookie
        document.cookie = [name, ''='', encodeURIComponent(value), expires, path, domain, secure].join('''');
    }else{//读取cookie
        var cookValue = null;
        if(document.cookie && document.cookie != ''''){
            var cookie = document.cookie.split('';'');
            for(var i = 0, len = cookie.length; i < len; i++){
                var c = cookie[i].replace(/^\s+|\s+$/g, '''');
                if(c.substring(0, name.length + 1) == (name + ''='')){
                    cookValue = decodeURIComponent(c.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookValue;
    }
}
//设置
Cookie("user", "Jununx");
//获取
Cookie("user");
//删除
Cookie("user", null);
```',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','免费数据库资源','','本教程分享了两款免费数据库资源，提供了 Upstash 的 Redis 和 Neon 的 PostgreSQL 控制台访问地址。','','','[]','# Redis

控制台地址：<https://console.upstash.com/redis?teamid=0>

# PostgreSQL

控制台地址：<https://console.neon.tech/app/org-blue-cloud-93852540/projects>',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','estk工具','','介绍estk工具（OpenEUICC v1.2.0）的下载地址，以及获取爱沙尼亚eSIM的方法。','','','[]','# estk 工具

## 工具下载

下载地址：[OpenEUICC unpriv-v1.2.0](https://gitea.angry.im/PeterCxy/OpenEUICC/releases/tag/unpriv-v1.2.0)

## eSIM 获取

- 爱沙尼亚 eSIM（需 GitHub 登录）：[esim.gg](https://esim.gg/)',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','导出ai工具中的个人画像','','本教程指导让AI导出个人使用画像，按指令、身份、职业、项目和偏好分类，以特定日期格式输出于代码块，实现跨工具体验一致。','','','[]','请帮我整理一份我的个人使用画像，用途是让我在不同 AI 工具之间保持一致的协作体验。请基于你当前能访问到的、与我相关的长期信息和本次会话上下文进行整理。在涉及我的指令和偏好时，请尽量保留我原本的表述方式，不要过度改写。

分类（按以下顺序输出）
指令：我明确要求遵循的规则，包括语气、格式、风格、"始终做 X"、"绝不做 Y" 以及对助手行为的纠正。仅整理可从长期记忆中明确识别并客观存在的规则，不临时新增、不强加、不脑补未明确提出的要求。

身份：姓名、年龄、所在地、教育背景、家庭、人际关系、语言能力和个人兴趣（仅包含我主动分享过的非敏感信息，不输出证件号、联系方式、账号等隐私数据）。

职业：当前和过往的职位、公司以及主要技能领域。

项目：我实际参与构建或投入精力的项目。每个项目一条。包含项目功能、当前状态以及关键决策。以项目名称或简短描述作为条目开头。

偏好：广泛适用的观点、品味和工作风格偏好。

格式
使用分类标题作为每个类别的节标题。每个类别内，每行一条记录，按日期从早到晚排列。每行格式：

[YYYY-MM-DD] - 条目内容

如果日期未知，使用 [unknown] 代替。

输出
将整个画像包裹在一个代码块中，方便我复制。
代码块之后，简要说明：这是否已覆盖你当前能整理出的全部相关信息；若还有未纳入的维度或你不确定的条目，请列出来，由我判断是否补充。',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','综合资源推荐','','推荐涵盖流量卡、eSIM、银行证券、API中转、VPN机场、VPS、接码平台及多个开源项目的综合资源合集。','','','[]','# 国内流量卡

- [国内流量卡](https://www.hemorn.cn/index?k=bzBzYWFuSDkvYXM9)

# 海外旅游 eSIM

- [Redteago](http://app.redteago.com/invite/index.html?id=LEEB0018)

# 银行及证券

- 众安（邀请码：`DF5367`）
    - [注册链接](https://l.za.group/F0t26)
    - 填写邀请码可获得部分奖励。
- 蚂蚁澳门（邀请码：`LPTSTX2U`）
    - [注册链接](https://m.antbank.mo/s/j1tDQ)
    - 通过邀请注册可获赠 2 股阿里巴巴股票（09988.HK）。

# API 中转站

- 薄荷公益站（L站）
    - [注册链接](https://x666.me/register?aff=BIob)
- 君公益站（L站）
    - [注册链接](https://muyuan.do/register?aff=GWXL)
- Xrouter 公益站
    - [注册链接](https://api.xrouter.dev/register?aff=Q4Mh)
- 一坨屎中转站
    - [注册链接](https://yituoshiai.com/register?aff=qKbX)
- Krill
    - [注册链接](https://www.krill-ai.com/register?invite=RB1HTMRG0R)
- XFastAPI
    - [注册链接](https://xfastapi.ai/register?aff=C95CW43PDZLC)

# VPN / 代理机场

- Bigme
    - `aHR0cHM6Ly8xcy5iaWdtZW9rLm1lL3VzZXIjL3JlZ2lzdGVyP2NvZGU9WlRySVVPQnI=`
- 赔钱机场
    - `aHR0cHM6Ly9wcWpjLnNpdGUvcmVnaXN0ZXI/Y29kZT1zMjRNcGpOQSZjb3Zlcj1zZnc=`
- 宝可梦
    - `aHR0cHM6Ly9sb3ZlLnA2bTYuY29tLyMvcmVnaXN0ZXI/Y29kZT1BcDFiUnU3Nw==`
- 良心云
    - `aHR0cHM6Ly9saWFuZ3hpbi54eXovIy9yZWdpc3Rlcj9jb2RlPUFRS2lTTVBz`

# VPS 服务商

- Vultr
    - [访问链接](https://www.vultr.com/?ref=9864425)
- RackNerd（稳定性较好）
    - [访问链接](https://my.racknerd.com/aff.php?aff=13897)
- ColoCrossing（价格便宜，有 11 美元/年的 1核1G 套餐）
    - [访问链接](https://cloud.colocrossing.com/aff.php?aff=1191)

# 短信接码平台 (SMS)

- Hero-SMS
    - [访问链接](https://hero-sms.com/?ref=380169)
- Redteago
    - [访问链接](http://app.redteago.com/invite/index.html?id=LEEB0018)

# 其他工具

- [AstrBot 机器人框架](https://docs.astrbot.app/deploy/astrbot/cli.html)
- [QQ 机器人 (NapCatQQ)](https://github.com/NapNeko/NapCatQQ)

# 已部署的开源项目

- 股票持仓看板
    - [GitHub 仓库](https://github.com/ice-a/ai-stock-dashboard)
    - [在线演示](https://stock.020417.xyz)
    - ![持仓看板](https://img.020417.xyz/file/1781252667167_PixPin_2026-06-12_16-24-14.png)
- AI 能力辅助
    - [GitHub 仓库](https://github.com/ice-a/learnpilot-ai-frontend/tree/main)
    - ![AI 能力辅助](https://img.020417.xyz/file/1781252816674_PixPin_2026-06-12_16-26-42.png)
- HTML 转 Markdown
    - [GitHub 仓库](https://github.com/ice-a/html_to_markdown_by_ai)
    - ![HTML 转 Markdown](https://img.020417.xyz/file/1781253049186_PixPin_2026-06-12_16-30-33.png)
- CTF 工具
    - [GitHub 仓库](https://github.com/HoshinoSuzumi/CTFever)
    - ![CTF 工具](https://img.020417.xyz/file/1781252917571_PixPin_2026-06-12_16-28-18.png)
- 基金持仓
    - [GitHub 仓库](https://github.com/hzm0321/real-time-fund)
    - ![基金持仓](https://img.020417.xyz/file/1781253172564_PixPin_2026-06-12_16-32-41.png)
- 新闻聚合
    - [GitHub 仓库](https://github.com/ourongxing/newsnow)
    - ![新闻聚合](https://img.020417.xyz/file/1781254403105_PixPin_2026-06-12_16-53-05.png)
- 开发者备忘录
    - [GitHub 仓库](https://github.com/jaywcjlove/reference)
    - ![开发者备忘录](https://img.020417.xyz/file/1781253543951_PixPin_2026-06-12_16-38-45.png)
- 模型验纯（聊胜于无）
    - [GitHub 仓库](https://github.com/ice-a/verify_model)
    - ![模型验纯](https://img.020417.xyz/file/1781253312487_PixPin_2026-06-12_16-35-02.png)
- 个人主页 Slog
    - [GitHub 仓库](https://github.com/imsyy/home)
    - ![个人主页](https://img.020417.xyz/file/1781254647484_PixPin_2026-06-12_16-57-10.png)
- 60秒新闻
    - [GitHub 仓库](https://github.com/vikiboss/60s)
    - ![60秒新闻](https://img.020417.xyz/file/1781255236180_PixPin_2026-06-12_17-07-04.png)

# 云部署平台

- [Vercel](https://vercel.com/)
- [阿里云](https://www.aliyun.com/)
- [腾讯云](https://cloud.tencent.com/product/tcb)

# 实用技巧

- 查看 GitHub 注册时间（将 URL 中的 `ice-a` 替换为自己的用户名即可）
    - [https://api.github.com/users/ice-a](https://api.github.com/users/ice-a)

# AI 技能

更多技能请访问：[虫盒](https://spiderbox.cn/)

![虫盒](https://img.020417.xyz/file/1781156397543_PixPin_2026-06-11_13-39-44.png)

## Web 逆向

- spider-king
    - [GitHub 仓库](https://github.com/aoyunyang/spider-king-skill)
- chrome-cdp
    - [GitHub 仓库](https://github.com/pasky/chrome-cdp-skill)
- hello_js_reverse_skill
    - [GitHub 仓库](https://github.com/WhiteNightShadow/hello_js_reverse_skill)
- reverse-skill
    - [GitHub 仓库](https://github.com/715494637/reverse-skill)
- js-reverse-automation--skill
    - [GitHub 仓库](https://github.com/Fausto-404/js-reverse-automation--skill)
- jshook-skill
    - [GitHub 仓库](https://github.com/wuji66dde/jshook-skill)
- js-env-patcher
    - [GitHub 仓库](https://github.com/zhizhuodemao/js-env-patcher)
- xbsReverseSkill
    - [GitHub 仓库](https://github.com/lwjjike/xbsReverseSkill)
- web-content-fetcher
    - [GitHub 仓库](https://github.com/shirenchuang/web-content-fetcher)

## 移动端逆向

- android-reverse-engineering-skill
    - [GitHub 仓库](https://github.com/SimoneAvogadro/android-reverse-engineering-skill)
- android-sec-skills
    - [GitHub 仓库](https://github.com/geekbyter/android-sec-skills)
- reverse-skills
    - [GitHub 仓库](https://github.com/P4nda0s/reverse-skills)
- android-reverse-engineering-claude-skill
    - [GitHub 仓库](https://github.com/incogbyte/android-reverse-engineering-claude-skill)
- Agent Skills
    - [GitHub 仓库](https://github.com/betab0t/skills)
- bin-deobf-skills
    - [GitHub 仓库](https://github.com/P4nda0s/bin-deobf-skills)

## 网络安全

- codex-session-patcher
    - [GitHub 仓库](https://github.com/ryfineZ/codex-session-patcher)
- secknowledge-skill
    - [GitHub 仓库](https://github.com/Pa55w0rd/secknowledge-skill)
- ctf-skills
    - [GitHub 仓库](https://github.com/ljagiello/ctf-skills)
- java-audit-skills
    - [GitHub 仓库](https://github.com/RuoJi6/java-audit-skills)
- PHP-Code-Audit-Skill
    - [GitHub 仓库](https://github.com/0xShe/PHP-Code-Audit-Skill)
- skill-dfyx_code_security_review
    - [GitHub 仓库](https://github.com/EastSword/skill-dfyx_code_security_review)',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','内地资金出境以及美国券商入金','','详解内地资金经港卡出境至嘉信或盈透等美国券商的入金路径，对比不同转账方式的损耗，并提供小额与大额资金的最优方案。','','','[]','# 内地资金出境以及美国券商入金

## 由 Kongsama 于 1月 10 日 发布

[![](https://cdn.ldstatic.com/user_avatar/linux.do/kongsama/48/655686_2.png)](https://linux.do/u/kongsama)

> 本篇笔记基于个人探索与信息搜罗整理而成，部分操作未经亲身试验，因此仅供参考。
> 
> 本篇教程适用于已持有港卡的用户；若尚未办理港卡，需先完成开户方可进行后续操作。
> 
> 如需盈透（IBKR）、嘉信及众安银行的邀请码或邀请链接，欢迎私信联系。
> 
> 如有错误或遗漏，欢迎指正与补充。

## 名词解释

### 美国券商

-   **嘉信理财：** 美国最大的股票经纪商之一，目前唯一允许中国身份居民开通的美资券商。交易佣金低，适合长线投资。
-   **盈透证券（IBKR）：** 美资跨国电子经纪商，美国上市公司。业务覆盖全球，接入全球外汇报价系统，在外汇兑换上极具优势。同时融资利率较低，支持较高杠杆。

### 转账方式

-   **电汇：** 通常指经由 **SWIFT**（环球银行金融电信协会）系统的转账，适用于跨国界、跨币种转账。
-   **转数快（FPS）：** 香港推出的快速支付系统，支持以手机号码、电邮地址或 FPS ID 作为识别码，在香港银行和储值账户间进行资金划转。**类比国内银行转账，免费。**
-   **eDDA：** 香港推出的快速支付授权，基于 FPS，类似于**授权扣款**。无感操作，即时到账，**免费**。

## 第一步：资金出境（内地 → 港卡）

### 大额出金：兴业银行 → 香港汇丰

-   **原理：** 兴业银行“寰宇人生”借记卡前 30 笔电汇免手续费，且汇丰银行汇入免手续费。因此，通过电汇从兴业银行汇入香港汇丰是无损的。
-   **步骤：** 在兴业银行 App 购汇（可选 HKD 或 USD）——电汇至香港汇丰。
-   **损耗：HKD 约 0.19%。** 在兴业银行购汇时会产生汇差（约 0.19%），因为银行换汇会有一定利润空间。但电汇环节无损，因此总损失仅为购汇汇差。
-   **时间：** 大约 1-3 个工作日到账。
-   **限制：** 建议单月不超过 2 笔，单笔金额建议控制在 5000 美元左右，金额过大大概率会触发风控。

### 小额出金：跨境支付通

-   **步骤：** 登录手机银行 App——选择“跨境支付通”。
-   **损耗：CNY 无损，HKD 损耗略高于兴业。** 汇款时可选择汇 CNY 或 HKD。若选择 HKD，系统会直接换汇，汇率相比兴业银行稍贵。
-   **时间：** 实时到账。
-   **限制：** 单次最多 1 万 CNY，操作频繁易触发风控。每年 5 万美元的购汇额度通常用不完。

## 第二步：券商入金（港卡 → 券商）

经过前面的步骤，你的港卡里大概率已有 HKD、USD 或 CNH（离岸人民币），此时即可进行券商入金。入金过程存在一定损耗，可根据不同金额选择最优路径。

### 入金嘉信理财

#### 小额路径（< $13,750 USD）

-   **步骤：** 汇丰/众安（HKD）—— FPS —— 嘉信香港花旗账户
-   **损耗：** 转数快（FPS）环节无损。嘉信会自动将港币转为美元，换汇点差约 0.16%，因此总损耗约为 **0.16%**。
-   **时间：** 一般次日到账，周末可能需顺延至工作日。

#### 大额路径（> $13,750 USD）

-   **步骤：** 汇丰/众安（USD）—— SWIFT 电汇 —— 嘉信纽约花旗账户
-   **损耗：** 汇丰收取电汇费，单次 22 美元。
-   **时间：** 约 1-3 个工作日。

#### 分界点说明

-   电汇通道固定费用为 22 美元，FPS 通道仅有汇损。
-   22 USD ≈ 156 RMB。若 156 RMB 占汇款金额的 0.16%，反推本金约为 **$13,750 USD**。以此为界选择最优路径。

### 入金盈透证券（IBKR）

-   **步骤：**
    -   汇丰（CNH/HKD）—— eDDA/FPS —— IBKR
    -   众安（CNH/HKD）—— FPS/电汇 —— IBKR
-   **损耗：** 汇丰的 eDDA 和 FPS 均免费；众安不支持 eDDA，只能通过 FPS 或电汇（均无损）。因此该入金环节无损。

#### 为什么转 CNH/HKD？

-   **汇率最优：** IBKR 接入外汇市场，在 IBKR 内部换汇汇率极佳，最接近实时中间价，优于兴业银行。
-   **换汇便宜：** 汇入 CNH/HKD 后，可在 IBKR 内通过购买美股实现自动换汇。

#### 选择手动换汇还是被动换汇？

-   **现金账户：** 金额 > $5,500 建议手动换汇（手续费 2 美元）；金额 < $5,500 可通过买美股自动换汇（如购买 SGOV 美国国债，损耗仅为佣金）。
-   **保证金账户：** 只能选择手动换汇，手续费 2 美元。
-   **$5,500 分界线怎么算的？**（估算）
    -   IBKR 有固定式和阶梯式两种佣金制度。SGOV 约 100 美元/股，买入 100 股（即 10,000 美元以内）佣金均为 0.35 美元。
    -   **固定式：** `min ( max(0.005美元/股 × 股数, 1.00美元), 成交额 × 1% )`
    -   **阶梯式：** `max ( 0.0035美元/股 × 股数, 0.35美元 ) + 第三方规费`
    -   **计算公式：** `(2 - 0.35) / 0.0003 ≈ 5500`（即手动换汇 2 美元手续费与股票佣金 0.35 美元的平衡点）。

### 转仓（嘉信到盈透）

还有一种曲线救国的方式：先入金 IBKR 并在 IBKR 内换汇，随后通过转仓将资产转移至嘉信。此过程不产生额外费用。

## 总结

### 小额推荐线路（跨境支付通）

-   **有 IBKR：** 国内任意银行（CNY）——（跨境支付通）—— 汇丰/众安（CNH）——（FPS/eDDA）—— IBKR（CNH）——（购买股票换汇）—— IBKR（USD）—— 嘉信（可选）
    -   **损耗：理论最低 0.35 美元。** 跨境支付通无损，FPS/eDDA 无损，购买股票换汇产生佣金最低 0.35 美元。
-   **无 IBKR：** 国内任意银行（CNY）——（跨境支付通）—— 汇丰/众安（CNH）——（FPS）—— 嘉信香港花旗——（自动换汇）—— 嘉信（USD）
    -   **损耗：约 0.16%。** 跨境支付通无损，FPS 无损，嘉信自动换汇产生汇差。

### 大额推荐线路（电汇）

-   **有 IBKR：** 兴业（HKD/USD）——（电汇）—— 汇丰（HKD/USD）——（FPS/eDDA）—— IBKR（HKD/USD）——（购买股票换汇）—— IBKR（USD）—— 嘉信（可选）
    -   **损耗：汇损 0.19% + 理论最低 0.35 美元。** 电汇无损，FPS/eDDA 无损，购买股票换汇产生佣金最低 0.35 美元。
-   **无 IBKR：** 兴业（HKD/USD）——（电汇）—— 汇丰（HKD/USD）——（FPS）—— 嘉信香港花旗/纽约花旗——（自动换汇）—— 嘉信（USD）
    -   **损耗：约 0.19% + 0.16%。** 兴业换汇汇差 0.19%，FPS 无损，嘉信自动换汇产生汇差 0.16%。

*阅读时间 5 分钟*',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','idea激活','','介绍通过执行特定命令行脚本激活 IDEA 的方法，涵盖 Mac/Linux 及 Windows 系统的具体操作指令。','','','[]','# idea激活

## mac/linux
```bash
curl -L -o ckey.run ckey.run/debug && bash ckey.run
```

## windows
1.先正常安装 pycharm
2.然后 powershell 管理员运行这个
3.windows是这个  `irm ckey.run|iex`',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','根据图片的md5值进行去重','','本教程介绍使用 Python 计算图片文件的 MD5 值，通过遍历目录比对哈希值，自动识别并删除重复图片以实现去重。','','','[]','```python
#!/usr/bin/env python3  
# -*- coding: UTF-8 -*-  
"""  
@Project ：all_daily_tasks_code @File    ：根据图片的md5值进行去重.py  
@Author  ：木子  
@Date    ：2024/5/29 上午11:12 """  
  
import hashlib  
import os  
  
  
# 读取文件获取md5  
def get_md5(file_path):  
    if not os.path.isfile(file_path):  
        return None  
    with open(file_path, ''rb'') as f:  
        md5 = hashlib.md5(f.read()).hexdigest()  
    return md5  
  
  
path = r"F:\upload\others\ios\img\微博"  
md5_list = []  
for item in os.listdir(path):  
    t = os.path.join(path, item)  
    md5 = get_md5(t)  
    if md5 not in md5_list:  
        md5_list.append(md5)  
    else:  
        os.remove(t)  
        print(f"{t} 已删除")
```',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','港澳通行证','','介绍通过支付宝预约办理港澳通行证及签注的流程，包括选择办理地点与时间、填写户籍信息及旅游签注类型，并支持同时申请护照。','','','[]','## 港澳通行证
1. 支付宝搜索
	- `港澳通行证` -> 选择 `预约办证`
2. 选择往来港澳通行证 
	- 台湾的暂时办了没用去不了(上次去办的时候问了工作人员，所以只需要选择港澳通行证就可以了)
3. 选择要办理的地址
4. 选择时间
	- 一般都是`工作日` 偶尔可能会有`周六日`可以办
5. 填写信息
	- 户口所在地  `身份证上面的地址`
	- 办证类型 `往来港澳通行证和签注` 右边有个蓝色的信息 `填写办理信息`
	- 选择 `通行证和签注` -> `首次申请` -> `香港`-> `团队旅游` -> `按照需要选择就可以 1年2次差不多就可以`
	- `也可以把澳门的一块填写了`
	- 护照可以一块申请',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','生活不止眼前的苟且','','本文记录了作者已游览的苏州、香港、澳门等地的旅行足迹，并列出了未来想去的国内各省份与名胜古迹的旅行愿望清单。','','','["life","travel"]','# 已经去过的地方
- [X] 苏州
	- [x] 平江路
	- [x] 观塘街
	- [x] 苏州博物馆
- [x] 香港
	- [x] 维多利亚港
	- [x] 星光大道
	- [x] 香港历史博物馆
	- [x] 坚尼地城
	- [x] 中环
	- [x] 九龙公园
- [x] 澳门
	- [x] 大三巴
	- [x] 威尼斯人
	- [x] 伦敦人
	- [x] 永利澳门
	- [x] 永利皇宫
	- [x] 澳门银河
	- [x] 新葡京
	- [x] 上葡京
	- [x] 葡京
	- [x] 美高梅
	- [x] 美狮美高梅
	- [x] 官也街
- [x] 洛阳
	- [x] 洛邑古城
- [ ] 南阳

# 想去玩的地方
- [ ] 万里长城
- [ ] 大兴安岭
- [ ] 青海湖
- [ ] 陕西
- [ ] 甘肃
- [ ] 内蒙
- [ ] 四川
- [ ] 湖北
- [ ] 新疆
- [ ] 西藏
- [ ] 安徽
- [ ] 福建
- [ ] 广西
- [ ] 浙江
- [ ] 贵州
- [ ] 云南
- [ ] 江苏
- [ ] 山西
- [ ] 湖南
- [ ] 河南',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','面试题库01','','本教程解析爬虫开发中的 HTTP 面试题，涵盖传输编码、PATCH请求、Link头、状态码处理及内容类型等核心知识。','','','[]','### HTTP的Transfer-Encoding在爬虫中有何影响？

HTTP的Transfer-Encoding对爬虫有多方面的影响：

1.  1. **分块传输(chunked)处理**：爬虫需要正确解析分块编码的响应，否则可能导致数据解析错误。分块传输允许爬虫流式处理数据，而不必将整个响应加载到内存中，提高大文件处理效率。
   
2.  2. **压缩编码处理**：当Transfer-Encoding包含gzip、deflate等压缩算法时，爬虫需要解压数据才能获取原始内容。虽然压缩减少了网络传输量，但会增加CPU解压开销。
   
3.  3. **性能优化**：分块传输使爬虫可以提前开始处理部分数据而不必等待完整响应，特别适合处理大文件或流式数据。
   
4.  4. **内存使用**：正确处理Transfer-Encoding尤其是分块传输，可以显著降低爬虫的内存使用，避免因大响应导致的内存溢出。
   
5.  5. **错误处理**：爬虫需要能够处理Transfer-Encoding与Content-Encoding的组合情况，以及各种编码解析错误，避免数据损坏。
   
6.  6. **协议兼容性**：现代爬虫需要同时支持HTTP/1.1(使用Transfer-Encoding)和HTTP/2(不使用Transfer-Encoding)，需注意协议差异。
   

### 如何在爬虫中实现 HTTP 的 PATCH 请求？

在爬虫中实现HTTP PATCH请求主要有以下几种方法：

1.  1\. 使用Python的requests库（最常用）:
   

```
import requests

url = ''https://example.com/api/resource''
data = {''key'': ''new_value''}  # 要更新的数据
headers = {''Content-Type'': ''application/json''}  # 根据API要求设置适当的headers

response = requests.patch(url, json=data, headers=headers)
print(response.status_code)
print(response.json())
```

1.  2\. 如果需要发送表单数据而不是JSON:
   

```
response = requests.patch(url, data=data, headers=headers)
```

1.  3\. 使用urllib库实现:
   

```
from urllib.request import Request, urlopen
import json

url = ''https://example.com/api/resource''
data = {''key'': ''new_value''}
data = json.dumps(data).encode(''utf-8'')
headers = {''Content-Type'': ''application/json''}

request = Request(url, data=data, method=''PATCH'', headers=headers)
response = urlopen(request)
print(response.status)
print(response.read().decode(''utf-8''))
```

注意事项：

-   • 确保目标API支持PATCH请求
   
-   • 检查API文档，了解正确的请求格式和headers
   
-   • 处理可能的认证，如API密钥、OAuth等
   
-   • 添加适当的错误处理代码
   

### HTTP 的 Link 头在爬虫链接发现中有何用途？

HTTP的Link头在爬虫链接发现中有多种重要用途：1) 分页处理，提供下一页、上一页等导航链接；2) 发现相关资源，如作者信息、相关文章等；3) API版本控制，指向不同版本的API资源；4) 搜索结果导航，提供过滤、排序等参数链接；5) 预加载提示，提高抓取效率；6) 资源关系描述，通过rel属性说明资源间语义联系；7) 提供替代格式，指向同一资源的不同格式版本；8) 实现HATEOAS原则，动态提供可执行的操作链接。Link头使爬虫能够更智能地导航和发现内容，特别是在现代Web API和RESTful服务中。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests？

处理HTTP 429 Too Many Requests错误的方法包括：1) 实现速率限制，添加请求延迟或使用指数退避算法；2) 解析响应头中的Retry-After字段，按建议等待时间重试；3) 使用代理IP轮换分散请求；4) 实现请求队列控制发送速率；5) 遵守robots.txt规则；6) 使用Scrapy等框架内置的限速功能；7) 添加随机延迟模拟人类行为；8) 设置合理的重试机制；9) 轮换User-Agent避免识别；10) 监控请求日志分析模式。

### HTTP 的 Retry-After 头如何指导爬虫重试？

HTTP的Retry-After头用于告知爬虫应该在多长时间后重试请求。它通常出现在429(Too Many Requests)或503(Service Unavailable)响应中，包含两种可能的值：1)相对秒数(如120表示120秒后重试)；2)绝对时间(如''Wed, 21 Oct 2015 07:28:00 GMT''表示具体时间点)。爬虫应当严格遵守这个延迟时间，在等待期间不向该服务器发送新请求或大幅降低请求频率。这种机制帮助爬虫避免被服务器封禁IP，减轻服务器负载，并体现尊重目标网站资源的行为准则。

### 如何在爬虫中处理 HTTP 的 502 Bad Gateway？

处理爬虫中的502 Bad Gateway错误可以采取以下策略：1) 实现重试机制，使用指数退避策略并设置合理的重试次数；2) 控制请求频率，避免短时间内大量请求；3) 使用代理IP池，在出现502时切换代理；4) 记录错误日志并分析错误模式；5) 设置合理的请求头，包括User-Agent等；6) 实现熔断机制，连续出现502时暂停请求；7) 准备备用数据源；8) 使用分布式爬虫分散请求；9) 遵守robots.txt规则；10) 使用成熟的爬虫框架如Scrapy，它们通常内置了错误处理机制。

### HTTP的Content-Type头在爬虫数据解析中有何作用？

HTTP的Content-Type头在爬虫数据解析中起着关键作用：1)指定响应数据的格式(HTML、JSON、XML等)，帮助爬虫选择正确的解析方法；2)提供字符编码信息(charset)，确保正确处理非英文文本，避免乱码；3)帮助爬虫识别并处理不同类型的数据；4)防止错误解析，如将JSON误认为HTML；5)处理没有明确Content-Type的特殊情况；6)增强安全性，防止将响应内容误作为可执行代码处理；7)提高爬虫健壮性，处理服务器返回错误页面但状态码为200的情况。

### 如何在爬虫中实现 HTTP 的 HEAD 请求？

在爬虫中实现 HTTP 的 HEAD 请求可以使用多种编程语言和库：

1.  1\. Python 使用 requests 库：
   

```
import requests
url = "https://example.com"
response = requests.head(url)
print(response.status_code)  # 查看响应状态码
print(response.headers)     # 查看响应头
```

1.  2\. Python 使用 urllib 库：
   

```
from urllib.request import Request, urlopen
url = "https://example.com"
req = Request(url, method=''HEAD'')
response = urlopen(req)
print(response.status)       # 查看响应状态码
print(response.headers)     # 查看响应头
```

1.  3\. Node.js 使用 axios：
   

```
const axios = require(''axios'');
axios.head(''https://example.com'')
  .then(response => {
    console.log(''Status:'', response.status);
    console.log(''Headers:'', response.headers);
  });
```

HEAD 请求只获取资源的头部信息而不返回内容体，适用于检查资源是否存在、获取元数据或检查资源是否被修改。

### HTTP 的 Accept-Language 头在爬虫本地化中有何用途？

HTTP的Accept-Language头在爬虫本地化中有多项重要用途：1) 获取特定语言版本的内容，而不是默认语言；2) 模拟来自不同地区的用户访问，获取本地化内容；3) 绕过基于IP或浏览器的语言重定向，直接请求特定语言版本；4) 分析网站的多语言SEO策略，如检查hreflang标签实现；5) 对比同一网站在不同语言下的内容差异；6) 评估自动翻译质量；7) 尊重网站的语言偏好设置，提高爬取相关性和减少被封禁风险。通过设置合适的Accept-Language头，爬虫可以更精准地获取本地化信息，提升数据采集的针对性和质量。

### 如何在爬虫中处理 HTTP 的 406 Not Acceptable？

处理HTTP 406 Not Acceptable错误的主要方法包括：1) 修改请求头中的Accept字段，使其更通用或删除特定要求；2) 添加或修改User-Agent模拟浏览器；3) 添加适当的请求延迟；4. 使用会话管理(requests.Session)；5. 考虑使用代理IP；6. 完善其他请求头如Accept-Language、Accept-Encoding等；7. 对于需要JavaScript渲染的网站，使用Selenium等工具；8. 遵守robots.txt规定。示例代码：使用requests库时，可以捕获406错误，然后修改请求头重试；使用Scrapy时，可以在中间件中处理406状态码，修改请求头后重试。

### HTTP 的 Content-Disposition 头在爬虫文件下载中有何作用？

在爬虫文件下载中，Content-Disposition 头主要有以下作用：1) 提供服务器推荐的文件名（通过 filename 参数），使爬虫能以原始名称保存文件；2) 指示响应类型（inline 或 attachment），帮助爬虫确定是否需要下载；3) 处理特殊字符和编码（如 filename\* 参数）；4) 避免文件名冲突，特别是当 URL 不包含有意义的名称时；5) 支持内容协商，获取更适合的文件格式。爬虫通常解析此头以获取正确的文件名和下载行为指示。

### 如何在爬虫中处理 HTTP 的 400 Bad Request？

处理 HTTP 400 Bad Request 错误的几种方法：

1.  1\. 检查请求参数：
   

-   • 验证所有必需参数是否已提供
   
-   • 检查参数格式是否正确（如日期格式、ID格式等）
   
-   • 确认参数值在有效范围内
   

3.  2\. 完善请求头：
   

-   • 设置合适的 User-Agent
   
-   • 添加必要的 Referer 头
   
-   • 确保 Content-Type 正确（特别是 POST 请求）
   

5.  3\. 处理编码问题：
   

-   • 确保请求数据编码正确（UTF-8 通常是最安全的选择）
   
-   • 检查 URL 参数是否正确编码
   

7.  4\. 实现重试机制：
   

-   • 使用指数退避算法重试失败的请求
   
-   • 设置最大重试次数避免无限循环
   

9.  5\. 模拟浏览器行为：
   

-   • 添加必要的 cookies
   
-   • 处理会话和认证信息
   
-   • 遵循 robots.txt 规则
   

11.  6\. 错误日志记录：
   

-   • 记录详细的错误信息以便分析
   
-   • 记录请求参数和响应内容
   

13.  7\. 使用工具辅助：
   

-   • 使用开发者工具查看浏览器实际发送的请求
   
-   • 对比正常请求与爬虫请求的差异
   

### HTTP 的 Accept-Charset 头在爬虫编码处理中有何用途？

HTTP的Accept-Charset头在爬虫编码处理中有多方面用途：1) 编码协商：爬虫通过此头告诉服务器它接受的字符编码，使服务器返回适当编码的内容；2) 提高效率：减少因编码不匹配导致的解析错误和额外处理；3) 多语言支持：表示支持多种字符编码(如UTF-8、GBK等)，便于处理多语言内容；4) 防止乱码：明确指定接受的编码减少乱码可能性；5) 与Content-Type头配合：服务器可根据此信息返回适当编码并在Content-Type中指定实际编码；6) 编码检测备选：即使服务器返回编码不匹配，可作为备选方案尝试；7) 处理老旧网站：包含多种编码提高兼容性。虽然现代Web普遍使用UTF-8，但在处理特定区域内容或老旧系统时仍很有价值。

### 如何在爬虫中处理 HTTP 的 409 Conflict？

处理HTTP 409 Conflict（冲突）状态码的方法：

1.  1. **实现重试机制**：使用带有指数退避的重试策略，避免立即重试导致服务器负担
   
2.  2. **解析响应内容**：检查响应体中的错误详情，了解具体冲突原因（如资源已存在、版本冲突等）
   
3.  3. **使用条件请求**：添加If-Match、If-None-Match或If-Unmodified-Since等条件请求头
   
4.  4. **修改请求策略**：根据冲突原因调整请求参数，如修改数据、改变请求时间等
   
5.  5. **处理并发冲突**：对于多线程爬虫，实现请求队列和适当的锁机制
   
6.  6. **实现退避策略**：遇到409错误时，随机或按比例增加等待时间再重试
   
7.  7. **记录冲突情况**：记录冲突URL和原因，便于后续分析优化爬虫策略
   

### HTTP 的 X-Frame-Options 头如何影响爬虫？

X-Frame-Options 头主要设计用于防止点击劫持攻击，对爬虫的影响相对有限：1) 它限制页面在 iframe/框架中的显示，但不直接阻止内容获取；2) 大多数现代爬虫直接获取HTML源码而非依赖框架渲染，因此通常不受影响；3) 依赖JavaScript在iframe中加载内容的爬虫可能会受到限制；4) 它不是专门的反爬虫机制，而是网站安全策略的一部分；5) 当与其他反爬虫头部配合使用时，可能增强反爬效果。总体而言，X-Frame-Options对专业爬虫的阻挡作用有限。

### 如何在爬虫中处理 HTTP 的 504 Gateway Timeout？

处理HTTP 504 Gateway Timeout错误可以采取以下策略：

1.  1. **实现重试机制**：
   

-   • 使用指数退避算法进行重试（如第一次重试等待1秒，第二次等待2秒，第三次等待4秒等）
   
-   • 设置合理的最大重试次数（通常3-5次）
   

3.  2. **调整请求参数**：
   

-   • 增加请求超时时间
   
-   • 使用连接池复用连接
   

5.  3. **使用代理IP轮换**：
   

-   • 当频繁出现504错误时，切换代理IP
   
-   • 使用代理IP池进行轮换
   

7.  4. **请求频率控制**：
   

-   • 实现请求间隔，避免过于频繁的请求
   
-   • 使用随机延迟模拟人类行为
   

9.  5. **分布式爬虫**：
   

-   • 将爬取任务分散到多个节点
   
-   • 使用分布式框架如Scrapy-Redis
   

11.  6. **代码实现示例（Python requests）**：
   

```
import time
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

defget_session_with_retry():
    session = requests.Session()
    retry_strategy = Retry(
        total=3,
        backoff_factor=1,
        status_forcelist=[504, 502, 503, 408]
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    session.mount("http://", adapter)
    session.mount("https://", adapter)
    return session

deffetch_url(url, timeout=30):
    session = get_session_with_retry()
    try:
        response = session.get(url, timeout=timeout)
        response.raise_for_status()
        return response
    except requests.exceptions.RequestException as e:
        print(f"请求失败: {e}")
        return None
```

1.  7. **预防措施**：
   

-   • 遵守robots.txt规则
   
-   • 使用随机User-Agent
   
-   • 实现请求限速
   
-   • 监控目标网站状态
   

### HTTP 的 Content-MD5 头在爬虫数据验证中有何用途？

Content-MD5 头在爬虫数据验证中主要有以下用途：1) 数据完整性验证，爬虫可以通过比较接收到的数据的MD5值与服务器提供的Content-MD5值，确认数据在传输过程中未被篡改或损坏；2) 内容变化检测，通过比较同一URL不同时间爬取的Content-MD5值，判断内容是否发生变化；3) 缓存优化，当MD5值与缓存中的一致时，可直接使用缓存数据，减少重复下载；4) 避免重复爬取，记录已爬取内容的MD5值，防止爬取相同内容；5) 在分布式爬虫系统中，确保不同节点获取到相同内容。需要注意的是，MD5算法已存在安全局限，在安全性要求高的场景建议使用更安全的哈希算法或依赖TLS机制。

### TCP 的三次握手和四次挥手过程对爬虫有何影响？

TCP的三次握手和四次挥手过程对爬虫有多方面的影响：

1.  1. **延迟增加**：每次请求都需要三次握手，这会增加请求的延迟，影响爬取效率。爬虫通常需要快速获取大量数据，而握手过程会消耗时间。
   
2.  2. **资源消耗**：频繁的握手和挥手会消耗大量系统资源（CPU、内存、端口资源），对于大规模爬虫来说，这种消耗更为显著。
   
3.  3. **连接管理**：爬虫需要实现连接复用机制（如HTTP Keep-Alive）和连接池，以减少握手次数。同时要处理TIME\_WAIT状态，避免端口耗尽问题。
   
4.  4. **反爬虫限制**：频繁的连接建立和断开可能被服务器识别为异常行为，触发反爬机制，导致IP被封禁或请求被限制。
   
5.  5. **代理IP使用**：使用代理时，每次切换代理都需要重新建立连接，增加握手次数和延迟，影响爬取效率。
   
6.  6. **超时处理**：爬虫需要正确处理握手超时、连接失败等异常情况，确保爬取任务的稳定性和可靠性。
   
7.  7. **性能优化**：现代爬虫框架通常会实现连接复用、异步请求、域名分片等技术，以减少TCP握手带来的性能影响。
   

### TCP的滑动窗口机制如何影响爬虫性能？

TCP滑动窗口机制对爬虫性能有多方面影响：1)提高吞吐量，允许在未收到确认时发送多个数据包，减少等待时间；2)优化带宽利用率，避免因等待确认导致的带宽闲置；3)结合拥塞控制机制，动态调整窗口大小适应网络状况；4)减少网络往返延迟，特别是在高延迟网络环境下；5)与HTTP Keep-Alive配合，在单个TCP连接上传输多个HTTP请求，减少连接建立开销；6)合理的窗口大小设置能平衡传输效率与资源占用，过小会降低吞吐量，过大可能导致拥塞；7)影响TCP缓冲区管理，爬虫可调整缓冲区大小优化性能；8)与Nagle算法和延迟确认协同工作，但可能需要针对爬虫场景进行参数调整；9)零窗口问题需要特别处理，避免接收方处理速度跟不上数据到达速度；10)良好的TCP拥塞控制能帮助爬虫在高并发场景下避免触发网络限制。

### UDP 在爬虫中有哪些潜在应用场景？

UDP在爬虫中的潜在应用场景包括：1) DNS查询，爬虫通过UDP进行域名解析；2) 大规模数据采集，利用UDP的高效率快速收集数据；3) 网络发现和端口扫描，快速探测目标主机；4) 分布式爬虫系统中的节点通信；5) 实时监控和数据收集，利用UDP的低延迟特性；6) 高频率数据更新场景；7) 多播/广播数据获取，一次性接收多个数据源；8) 需要容忍一定数据丢失的高效率场景；9) 访问仅支持UDP的网络服务；10) 快速探测网站可用性。

### DNS 的解析过程如何影响爬虫效率？

DNS解析过程对爬虫效率有多方面影响：1)延迟问题：完整的DNS解析需要多次网络请求(从本地缓存到根域名服务器)，每次带来几十到几百毫秒延迟，频繁访问不同域名时这些延迟会累积显著降低效率；2)连接数限制：浏览器对同时进行的DNS请求数量有限制，爬虫可能遇到DNS瓶颈无法充分利用带宽；3)缓存利用：合理利用DNS缓存可提高效率，爬虫可手动维护域名-IP映射表避免重复解析；4)CDN和负载均衡：现代网站使用CDN可能导致同一域名解析到不同IP，增加复杂性但提供更好性能；5)DNS污染和劫持：某些地区DNS可能被污染，爬虫需处理这种情况并使用可靠DNS服务器；6)并发请求优化：通过预解析域名、使用连接池和会话复用可减少DNS解析影响；7)加密DNS协议：DoH/DoT提供更好隐私但可能增加延迟。优化措施包括：实现DNS缓存、使用连接池、预解析域名、异步DNS解析、选择高性能DNS服务器、实现重试机制、批量解析和使用本地hosts文件。

### 什么是 DNS 污染，如何在爬虫中应对？

DNS污染（DNS Spoofing或DNS Poisoning）是一种网络攻击技术，攻击者通过向DNS缓存中插入错误的DNS记录，使用户访问特定网站时被重定向到恶意或错误的IP地址。这干扰了域名系统的正常解析过程。

在爬虫中应对DNS污染的方法：

1.  1\. 使用可信的DNS服务（如Google DNS 8.8.8.8、Cloudflare DNS 1.1.1.1）
   
2.  2\. 实施短DNS缓存超时，减少使用被污染记录的时间
   
3.  3\. 坚持使用HTTPS，即使DNS被污染也能验证服务器身份
   
4.  4\. 实现IP白名单机制，验证解析结果
   
5.  5\. 从多个DNS源获取解析结果并交叉验证
   
6.  6\. 使用DNS over HTTPS (DoH)或DNS over TLS (DoT)加密查询
   
7.  7\. 通过VPN或代理服务器绕过可能被污染的本地DNS
   
8.  8\. 实现IP轮换，定期更换爬虫使用的IP地址
   
9.  9\. 定期验证域名解析结果，发现异常及时切换
   
10.  10\. 实现健康检查机制，监控目标网站可访问性
   

### WebSocket 协议在爬虫中有哪些应用场景？

WebSocket协议在爬虫中有多种应用场景：1) 实时数据抓取，如股票行情、体育比分等；2) 获取动态加载的内容，超越传统HTTP请求的限制；3) 作为REST API的高效替代方案；4) 监控聊天应用和社交媒体的实时消息流；5) 抓取在线游戏或直播平台的实时数据；6) 采集物联网设备的实时数据流；7) 进行网站性能监控和自动化测试；8) 更真实地模拟用户行为，结合WebSocket和HTTP请求实现完整交互流程。

### HTTP/3 的 QUIC 协议对爬虫有何影响？

HTTP/3的QUIC协议对爬虫有显著影响：1) 连接建立更快(0-RTT)，提高爬取效率但也更容易触发速率限制；2) 多路复用和队头阻塞解决，使爬虫能更高效地利用带宽；3) 基于UDP的特性使爬虫流量模式更灵活但也更容易被识别为自动化流量；4) 连接迁移特性让爬虫在IP切换时保持连接状态，可能使反爬虫更难检测；5) 内置加密增加了安全但也增加了计算开销。爬虫需要调整策略以适应这些变化，包括更精细的请求频率控制和更接近人类用户的行为模式。

### 如何在爬虫中处理 TLS 证书验证失败？

处理爬虫中的 TLS 证书验证失败有几种方法：1) 禁用验证（不推荐用于生产环境）：Python requests 库中使用 verify=False 参数；Scrapy 中设置 ssl\_verify = False。2) 提供自定义 CA 证书：使用 verify=''/path/to/cacert.pem'' 指定证书包。3) 处理异常：捕获 requests.exceptions.SSLError 并实现重试逻辑。4) 证书固定：预先保存目标网站证书指纹并验证。5) 更新证书信任库：更新系统 CA 证书或下载最新证书包。注意：禁用验证会降低安全性，应谨慎使用。

### 什么是 HTTP 的 Content-Security-Policy 头，如何绕过？

Content-Security-Policy (CSP) 是一个HTTP安全头，用于帮助网站防止跨站脚本(XSS)、点击劫持和其他代码注入攻击。它通过指定哪些资源(脚本、样式、图像等)可以被加载和执行来限制攻击面。

CSP通过一系列指令定义策略，如:

-   • `default-src`: 默认资源策略
   
-   • `script-src`: 脚本来源
   
-   • `style-src`: 样式来源
   
-   • `img-src`: 图像来源
   
-   • `connect-src`: 连接来源
   
-   • `frame-src`: 嵌套框架来源
   

关于绕过CSP(仅用于授权安全测试):

1.  1\. 利用不安全配置: 如`unsafe-inline`、`unsafe-eval`或过于宽松的通配符策略
   
2.  2\. 利用白名单漏洞: 找到被允许但不安全的域名
   
3.  3\. 利用遗留功能: 如HTML注释、SVG中的脚本、`data:` URI等
   
4.  4\. 服务器错误配置: 如CSP头未正确验证或缓存问题
   
5.  5\. 利用浏览器漏洞: 某些浏览器可能存在CSP实现缺陷
   
6.  6\. 利用其他HTTP头: 通过Content-Type头等方式混淆
   

注意: 绕过CSP通常违反法律法规，仅应在明确授权的安全测试环境中使用。

### 如何在爬虫中处理 IPv6 地址的请求？

在爬虫中处理IPv6地址的请求，需要注意以下几点：

1.  1\. 确认环境支持IPv6：使用`socket.has_ipv6`检查Python环境是否支持IPv6。
   
2.  2\. 使用支持IPv6的HTTP客户端库：如`requests`、`urllib`、`aiohttp`或`httpx`等库默认都支持IPv6。
   
3.  3\. IPv6地址的特殊处理：IPv6地址在URL中需要用方括号括起来，例如：`http://[2001:db8::1]:8080/`。
   
4.  4\. 示例代码：
   

```
import requests
import socket

# 直接通过IPv6地址请求
url = "http://[2001:db8::1]:8080/"
try:
    response = requests.get(url, timeout=10)
    print(response.status_code)
except requests.exceptions.RequestException as e:
    print(f"请求失败: {e}")

# 通过DNS解析获取IPv6地址
hostname = "example.com"
try:
    addr_info = socket.getaddrinfo(hostname, 80, socket.AF_INET6)
    ipv6_addr = addr_info[0][4][0]
    url = f"http://[{ipv6_addr}]/"
    response = requests.get(url, timeout=10)
    print(response.status_code)
except (socket.gaierror, requests.exceptions.RequestException) as e:
    print(f"请求失败: {e}")
```

1.  5\. 处理连接问题：实现重试机制、设置合理的超时时间，考虑使用代理解决网络连接问题。
   
2.  6\. 错误处理：处理IPv6特有的错误，实现IPv6不可用时的降级策略。
   

### HTTP 的 Expect-CT 头在爬虫中有何意义？

Expect-CT（证书透明度）头在爬虫中有多方面意义：首先，它帮助爬虫验证网站是否实施了证书透明度政策，增强SSL/TLS连接的安全性检测；其次，爬虫可利用此头评估网站的安全性和可信度，识别潜在的安全风险；第三，对于需要合规性检查的爬虫任务，Expect-CT头可作为网站安全合规性的一个指标；此外，了解此头配置有助于爬虫更准确地模拟浏览器行为，避免被反爬虫机制识别；最后，爬虫可以监控Expect-CT头的变化，及时发现网站安全配置的变更，为安全审计提供数据支持。

### 如何在爬虫中处理 HTTP 的 451 Unavailable For Legal Reasons？

在爬虫中处理 HTTP 451 ''Unavailable For Legal Reasons'' 状态码需要采取以下方法：

1.  1. **识别和记录**：在爬虫代码中检查响应状态码，当遇到 451 时进行特殊处理并记录这些 URL 和原因。
   
2.  2. **尊重法律限制**：不要尝试绕过法律限制（如使用代理或更改 User-Agent），这可能导致法律问题。
   
3.  3. **调整爬取策略**：跳过这些受限制的内容，更新爬虫的排除列表避免重复尝试访问。
   
4.  4. **寻找替代数据源**：记录缺失的数据，寻找其他合法获取相关信息的途径。
   
5.  5. **代码实现示例**（Python）：
   

```
import requests

deffetch_url(url):
    try:
        response = requests.get(url, timeout=10)
        if response.status_code == 451:
            print(f"法律限制: {url} - {response.reason}")
            # 记录到日志文件
            log_restricted_url(url, response.reason)
            returnNone
        elif response.status_code == 200:
            return response.text
        else:
            returnNone
    except Exception as e:
        print(f"请求 {url} 时出错: {str(e)}")
        returnNone

deflog_restricted_url(url, reason):
    withopen("restricted_urls.log", "a") as f:
        f.write(f"{url} - {reason}\n")
```

1.  6. **法律咨询**：如果涉及大量 451 响应，建议咨询法律专业人士了解相关法规。
   
2.  7. **长期策略**：建立合规审查流程，考虑实施地理围栏避免在某些司法管辖区访问受限内容。
   

### HTTP 的 Alt-Svc 头在爬虫中有何用途？

HTTP的Alt-Svc头(Alternative Service)在爬虫中有以下几方面用途：1) 协议升级，允许爬虫使用更高效的协议如HTTP/2或HTTP/3获取资源；2) 负载均衡，将爬虫请求分散到不同的服务器或CDN节点；3) 故障转移，当主服务不可用时引导爬虫使用备用服务；4) 地理优化，指示爬虫使用地理位置更近的服务器减少延迟；5) 资源优化，为特定资源提供更高效的服务端点。爬虫应合理使用这些机制，同时遵守网站的robots.txt和使用条款。

### 如何在爬虫中实现 HTTP/2 的 Server Push？

在爬虫中实现 HTTP/2 的 Server Push 需要以下几个步骤：

1.  1\. 选择支持 HTTP/2 的客户端库：
   

-   • Python: 使用 httpx、requests-http2 或 aiohttp
   
-   • Node.js: 使用 http2 模块
   
-   • Java: 使用 HttpClient 5+ 或 OkHttp
   

3.  2\. 配置客户端启用 HTTP/2：
   
    ```
    # Python 示例 (httpx)
    import httpx
    client = httpx.Client(http2=True)
    response = client.get("https://example.com")
    ```
   
4.  3\. 处理服务器推送的资源：
   

-   • 监听 PUSH\_PROMISE 帧
   
-   • 接收并缓存推送的资源
   
-   • 避免重复请求已推送的资源
   

6.  4\. 注意事项：
   

-   • 不是所有服务器都支持 Server Push
   
-   • 某些 CDN 和反向代理可能禁用 Server Push
   
-   • 现代浏览器已逐渐弃用此特性
   
-   • 需要合理处理推送资源的缓存和生命周期
   

8.  5\. 高级实现：
   

-   • 使用 HTTP/2 的流控制和优先级设置
   
-   • 实现资源预测算法，提高推送效率
   
-   • 自定义中间件处理推送的资源
   

### HTTP 的 Strict-Transport-Security 头如何影响爬虫？

HTTP Strict-Transport-Security (HSTS) 头对爬虫有多方面影响：1) 强制使用HTTPS连接，爬虫必须通过安全协议访问网站，否则会收到重定向或连接失败；2) 要求有效的SSL/TLS证书，爬虫必须正确处理证书验证；3) 若设置includeSubDomains参数，所有子域名也必须通过HTTPS访问；4) 影响爬虫灵活性，特别是在需要临时切换到HTTP的开发环境中；5) 可能降低爬虫性能，因为HTTPS连接需要额外的SSL/TLS握手；6) 爬虫需要正确处理HSTS的max-age参数，即在指定时间内只能使用HTTPS；7) 对于预加载到浏览器HSTS列表的网站，爬虫即使首次访问也必须使用HTTPS。这些因素都要求爬虫能够正确处理HTTPS连接和SSL证书验证。

### 如何在爬虫中处理 HTTP 的 413 Payload Too Large？

处理HTTP 413 Payload Too Large错误的方法有：1) 减小请求体大小，分批请求数据；2) 修改请求头，如添加Accept-Encoding启用压缩；3) 实现分块传输编码；4) 添加指数退避重试机制；5) 使用代理或IP轮换；6) 降低爬取速度，增加请求间隔；7) 使用流式处理大文件下载；8) 优化数据格式，使用更高效的序列化方式；9) 只请求必要字段而非全部数据；10) 考虑实现分布式爬取分散负载。

### HTTP 的 X-XSS-Protection 头在爬虫中有何意义？

X-XSS-Protection 头在爬虫中有以下几方面的意义：

1.  1. **网站安全策略指示**：爬虫可以通过这个头部了解目标网站是否启用了XSS防护机制，这有助于评估网站的安全级别。
   
2.  2. **反爬虫检测**：某些网站可能会检查请求是否包含适当的X-XSS-Protection头来识别非浏览器行为。高级爬虫可能需要伪造这个头部以更好地模拟真实浏览器。
   
3.  3. **数据处理方式**：如果网站设置了X-XSS-Protection为1; mode=block，爬虫获取的数据可能已经过XSS过滤，这会影响数据的原始性和完整性。
   
4.  4. **安全研究**：对于安全研究人员，这个头部可以作为评估网站安全实践的一个指标。
   
5.  5. **合规性评估**：爬虫可以通过检查这个头部来了解网站是否符合某些安全合规要求。
   

需要注意的是，随着现代浏览器逐渐弃用X-XSS-Protection而转向内容安全策略(CSP)，这个头部在爬虫中的实际意义已经有所降低。

### 如何在爬虫中处理 HTTP 的 416 Range Not Satisfiable？

处理HTTP 416 Range Not Satisfiable错误的方法包括：

1.  1\. 检测416错误状态码并捕获异常
   
2.  2\. 禁用范围请求：在请求头中移除''Range''字段，改用完整下载
   
3.  3\. 实现重试机制：当收到416错误时，重新获取资源实际大小并调整下载策略
   
4.  4\. 验证资源大小：先发送HEAD请求获取Content-Length，再计算合适的范围
   
5.  5\. 使用分块下载：将大文件分成多个小块下载，每个块独立处理
   
6.  6\. 检查资源是否被修改：实现ETag或Last-Modified检查，避免过时数据
   
7.  7\. 降级处理：当范围请求不可用时，切换到普通下载模式
   
8.  8\. 实现指数退避重试：遇到416错误后，等待一段时间再重试
   

### HTTP 的 Content-Range 头在爬虫断点续传中有何作用？

HTTP的Content-Range头在爬虫断点续传中起着关键作用。当爬虫使用Range头请求资源的部分内容时，服务器通过Content-Range头返回以下信息：1) 标识返回内容在整个资源中的位置和范围，格式为''bytes start-end/total''；2) 配合206 Partial Content状态码表示这是一个部分响应；3) 帮助爬虫将多个部分正确组合成完整资源；4) 在请求范围无效时(416状态码)，提供资源实际大小帮助调整请求；5) 使爬虫能够精确跟踪下载进度，计算已下载字节数和总字节数，从而实现高效、可靠的断点续传功能。

### 如何在爬虫中处理 HTTP 的 417 Expectation Failed？

HTTP 417 Expectation Failed 表示服务器无法满足请求头中Expect字段的期望值。处理方法：1) 移除Expect请求头，如headers中不包含''Expect''字段；2) 使用try-except捕获417错误后移除Expect头重试；3) 禁用100-continue机制(如requests中设置stream=False)；4) 实现重试机制，遇到417时自动重试；5) 使用更底层的HTTP客户端库进行更精细控制。最佳实践是避免发送Expect头并实现适当的错误处理机制。

### HTTP 的 Access-Control-Allow-Origin 在爬虫中有何影响？

Access-Control-Allow-Origin 是 CORS(跨域资源共享)机制中的关键响应头，在爬虫中有以下影响：

1.  1. **浏览器环境爬虫的影响**：使用Puppeteer、Selenium等基于浏览器的爬虫工具时，若目标网站未设置适当的CORS头，浏览器会阻止跨域请求，导致爬虫无法获取数据。
   
2.  2. **非浏览器环境爬虫的影响**：使用requests、urllib等库的直接HTTP请求不受CORS限制，可以绕过此限制直接获取资源。
   
3.  3. **反爬虫策略**：网站可通过CORS限制特定域的访问，作为简单的反爬手段。即使允许跨域，服务器也可能通过检查Origin/Referer头拒绝爬虫请求。
   
4.  4. **预检请求处理**：对于复杂请求(自定义头、非简单方法等)，浏览器会发送OPTIONS预检请求，爬虫需正确处理此类请求才能成功获取数据。
   
5.  5. **配置风险**：若网站使用通配符(\*)过于宽松配置CORS，可能导致敏感数据暴露，但也可能使爬虫更容易获取数据。
   
6.  6. **JSONP替代方案**：不支持CORS的旧系统可能使用JSONP，爬虫需识别并处理这种特殊的数据格式。
   

总之，CORS对爬虫的影响取决于实现方式：浏览器环境爬虫必须处理CORS限制，而非浏览器环境爬虫通常不受此影响，但仍需应对网站可能的其他反爬措施。

### 如何在爬虫中处理 HTTP 的 426 Upgrade Required？

处理HTTP 426 Upgrade Required状态码的几种方法：

1.  1\. 自动协议升级：检测到426响应后，将HTTP请求自动转换为HTTPS请求
   
    ```
    if response.status_code == 426:
        https_url = url.replace("http://", "https://")
        response = requests.get(https_url)
    ```
   
2.  2\. 遵循响应头中的Upgrade字段：解析响应头中的Upgrade字段，了解需要升级到的协议
   
    ```
    if response.status_code == 426:
        upgrade_header = response.headers.get(''Upgrade'')
        print(f"服务器要求升级到: {upgrade_header}")
    ```
   
3.  3\. 使用支持协议升级的HTTP客户端库：如httpx、aiohttp等，它们内置了协议升级支持
   
4.  4\. 设置适当的请求头：在初始请求中添加Connection: Upgrade头部
   
    ```
    headers = {''Connection'': ''Upgrade''}
    response = requests.get(url, headers=headers)
    ```
   
5.  5\. 实现重试机制：对426响应进行自动重试，避免因协议不匹配导致的请求失败
   

### HTTP 的 X-Content-Type-Options 头在爬虫中有何意义？

X-Content-Type-Options 头（通常设置为 ''nosniff''）在爬虫中的意义主要体现在以下几个方面：1) 防止内容类型混淆，确保爬虫严格按照服务器声明的 Content-Type 处理资源，而不是尝试猜测或嗅探类型；2) 提高爬虫解析的可靠性，避免因 MIME 类型猜测错误导致的解析失败；3) 保证不同爬虫处理内容的一致性，减少因各自嗅探算法差异导致的处理差异；4) 虽然主要是为浏览器设计，但在某些情况下也能增强爬虫处理资源的安全性，防止可能利用类型嗅探的漏洞。

### 如何在爬虫中处理 HTTP 的 428 Precondition Required？

在爬虫中处理HTTP 428 Precondition Required状态码，需要遵循以下步骤：

1.  1. **理解428状态码的含义**：
   

-   • 428表示服务器要求请求必须满足某些先决条件才能处理
   
-   • 通常是为了防止客户端修改过时的数据版本
   

3.  2. **检查响应头**：
   

-   • 查看''Precondition-Required''响应头
   
-   • 查找服务器提供的其他相关信息，如''Retry-After''或具体的条件要求
   

5.  3. **获取当前资源状态**：
   

-   • 如果需要先获取资源的当前版本信息，发送HEAD或GET请求获取ETag或Last-Modified值
   
-   • ETag是资源的唯一标识符，Last-Modified是资源的最后修改时间
   

7.  4. **构造条件请求**：
   

-   • 在后续请求中添加适当的条件头：
   

-   • ''If-Match'': 用于PUT或DELETE请求，确保资源ETag与指定值匹配
   
-   • ''If-None-Match'': 用于GET或HEAD请求，确保资源ETag与指定值不匹配
   
-   • ''If-Modified-Since'': 用于GET或HEAD请求，确保资源在指定时间后未被修改
   
-   • ''If-Unmodified-Since'': 用于PUT或DELETE请求，确保资源在指定时间前未被修改
   

9.  5. **处理重试**：
   

-   • 如果服务器提供了''Retry-After''头，等待指定的时间后再重试
   
-   • 实现适当的退避策略，避免频繁请求
   

11.  6. **代码示例**（Python使用requests库）：
   
    ```
    import requests
    from time import sleep
   
    # 第一次请求获取ETag
    response = requests.get(''http://example.com/resource'')
    etag = response.headers.get(''ETag'')
   
    # 如果遇到428，使用条件请求重试
    if response.status_code == 428:
        # 等待重试时间（如果有）
        retry_after = response.headers.get(''Retry-After'')
        if retry_after:
            sleep(int(retry_after))
        
        # 使用条件头重试
        headers = {''If-Match'': etag}
        response = requests.get(''http://example.com/resource'', headers=headers)
    ```
   
12.  7. **异常处理**：
   

-   • 实现适当的错误处理逻辑
   
-   • 考虑请求失败后的重试机制
   

### HTTP 的 Content-Encoding 头在爬虫数据解压中有何作用？

HTTP的Content-Encoding头在爬虫数据解压中起着关键作用。它指示服务器对响应体使用了哪种压缩算法（如gzip、deflate、br等），使爬虫能够正确选择解压方法。正确识别这个头部可以确保爬虫成功解压压缩数据，减少传输时间，提高效率，并避免因解压错误导致的数据损坏。现代爬虫框架通常自动处理这个头部，但在自定义爬虫时，需要根据这个头部的值选择相应的解压库或函数来处理压缩数据。

### 如何在爬虫中处理 HTTP 的 431 Request Header Fields Too Large？

处理HTTP 431错误（请求头字段过大）的几种方法：1) 精简请求头，移除非必要字段如过长的User-Agent或多个Accept-\*头；2) 分批发送请求头，避免一次性发送过多信息；3) 减少Cookie数量，只发送必要的认证信息；4) 实现重试机制，捕获431错误后精简请求头再重试；5) 使用代理或轮换User-Agent分散请求；6) 增加请求间隔，避免触发服务器限流；7) 查看目标网站文档了解其请求头限制并相应调整。

### HTTP 的 X-DNS-Prefetch-Control 头在爬虫中有何用途？

X-DNS-Prefetch-Control 头在爬虫中主要用于控制 DNS 预取行为，具有以下用途：1) 优化性能：通过控制是否提前解析域名，减少实际请求时的延迟；2) 资源管理：可以禁用不必要的 DNS 预取以节省网络资源；3) 提高爬取效率：对于需要访问多个域名的爬虫，适当的预取可以显著提升速度；4) 模拟真实用户：遵循网站的 DNS 预取指示，使爬虫行为更接近普通浏览器；5) 避免检测：减少异常的 DNS 查询模式，降低被反爬系统识别的风险。

### 如何在爬虫中处理 HTTP 的 508 Loop Detected？

HTTP 508 Loop Detected 表示服务器检测到了请求循环，通常是由于服务器配置问题导致的重定向循环。处理方法包括：1) 检查URL是否正确，避免请求路径错误；2) 实现请求重试机制但设置最大重试次数限制(如3次)；3) 使用指数退避策略增加重试间隔时间；4) 轮换User-Agent和请求头，避免被识别为爬虫；5) 实现代理IP池，切换不同IP发送请求；6) 设置合理的超时时间；7) 添加请求间隔，模拟人类行为；8) 记录错误日志，分析特定模式；9) 使用会话(Session)保持连接；10) 检查并避免无限重定向循环。代码上可以使用try-catch捕获508错误，并在达到最大重试次数后跳过该URL或标记为无效。

### HTTP 的 Server-Timing 头在爬虫性能分析中有何作用？

HTTP 的 Server-Timing 头在爬虫性能分析中具有多方面的重要作用：

1.  1. **性能监控与诊断**：提供服务器处理请求的详细时间分解，帮助爬虫开发者识别性能瓶颈，如慢查询、高延迟API调用等。
   
2.  2. **请求优化**：通过分析Server-Timing数据，爬虫可以调整请求频率和并发数，优先爬取响应较快的端点，实现更智能的爬虫调度。
   
3.  3. **反爬策略分析**：帮助理解网站的反爬机制，识别哪些操作触发了额外处理时间，从而调整爬虫策略以避免触发反爬措施。
   
4.  4. **负载感知**：服务器可能通过Server-Timing指示当前负载情况，爬虫可根据这些信息调整抓取频率，实现更礼貌的爬虫行为。
   
5.  5. **缓存策略优化**：指示缓存命中率和服务端生成时间，帮助爬虫区分静态和动态内容，优化爬取频率。
   
6.  6. **合规性监控**：监控爬虫请求对目标服务器的影响，确保爬虫行为符合网站使用条款，避免过度请求导致服务器问题。
   
7.  7. **API调用优化**：对于API驱动的网站，揭示各API端点的性能特征，帮助优化API调用顺序和频率。
   

通过合理利用Server-Timing头，爬虫可以实现更高效、稳定的运行，同时减少对目标服务器的负担。

### 如何在爬虫中处理 HTTP 的 511 Network Authentication Required？

HTTP 511 ''Network Authentication Required'' 表示客户端需要先对网络进行身份验证才能访问资源。在爬虫中处理此错误的方法如下：

1.  1. **识别 511 错误**：捕获 HTTP 511 状态码，检查响应内容通常包含认证表单
   
2.  2. **处理认证流程**：
   

-   • 分析认证页面的表单结构
   
-   • 提取必要的认证参数（用户名、密码、隐藏字段等）
   
-   • 向认证服务器发送认证请求
   

4.  3. **代码示例（Python requests）**：
   

```
import requests
from bs4 import BeautifulSoup

defhandle_511_auth(url, credentials):
    session = requests.Session()
    
    # 尝试访问目标URL
    response = session.get(url)
    
    # 如果是511错误，处理认证
    if response.status_code == 511:
        soup = BeautifulSoup(response.text, ''html.parser'')
        form = soup.find(''form'')
        
        # 提取表单数据和action
        form_data = {}
        forinputin form.find_all(''input''):
            name = input.get(''name'')
            value = input.get(''value'', '''')
            if name:
                form_data[name] = value
                
        form_data.update(credentials)
        action = form.get(''action'', url)
        
        # 提交认证
        auth_response = session.post(action, data=form_data)
        
        # 认证后再次尝试访问原始URL
        return session.get(url)
    
    return response
```

1.  4. **使用注意事项**：
   

-   • 确保你有权限访问目标网络
   
-   • 分析认证页面的实际结构，可能需要调整表单提交逻辑
   
-   • 处理认证后的 cookies 维护会话
   
-   • 对于复杂的认证（如JavaScript重定向），可能需要使用Selenium等工具
   

### HTTP 的 Public-Key-Pins 头在爬虫中有何意义？

HTTP Public-Key-Pins (HPKP) 头在爬虫中具有重要意义：首先，它增强了爬虫的安全性，通过强制验证网站公钥哈希值，防止中间人攻击和伪造证书；其次，爬虫需要实现HPKP缓存和验证机制，确保只连接到使用已验证密钥的网站；第三，这增加了爬虫的复杂性，需要处理密钥轮换和HPKP验证失败的情况；最后，遵守网站的HPKP策略已成为合规爬虫的基本要求，有助于建立更可靠的网络爬取环境。

### 如何在爬虫中实现 HTTP 的 Expect-CT 验证？

在爬虫中实现 HTTP 的 Expect-CT 验证需要以下几个步骤：

1.  1. **理解 Expect-CT 头部**：
   

-   • Expect-CT 头部格式为：`Expect-CT: max-age=seconds, enforce, report-uri="URL"`
   
-   • max-age: 指定客户端应记住CT策略的时间（秒）
   
-   • enforce: 表示客户端必须强制执行CT验证
   
-   • report-uri: 指定违反CT策略时应报告的URL
   

3.  2. **使用支持 Expect-CT 的 HTTP 客户端**：
   
    Python 中可以使用 requests 或 httpx 库，它们默认会处理 Expect-CT 头部。
   
4.  3. **实现验证逻辑**：
   
    ```
    import requests
   
    deffetch_with_expect_ct(url):
        try:
            response = requests.get(url, verify=True)
            
            # 检查响应中的 Expect-CT 头部
            expect_ct = response.headers.get(''Expect-CT'')
            if expect_ct:
                print(f"服务器发送的 Expect-CT 头部: {expect_ct}")
                
                # 解析头部参数
                parts = expect_ct.split('','')
                max_age = None
                enforce = False
                report_uri = None
                
                for part in parts:
                    part = part.strip()
                    if part.startswith(''max-age=''):
                        max_age = int(part.split(''='')[1])
                    elif part == ''enforce'':
                        enforce = True
                    elif part.startswith(''report-uri=''):
                        report_uri = part.split(''='')[1].strip(''"'')
                
                print(f"Max-Age: {max_age}, Enforce: {enforce}, Report URI: {report_uri}")
                
                # 根据 enforce 参数决定是否验证
                if enforce:
                    # 这里可以添加额外的验证逻辑
                    print("必须执行 CT 验证")
                    
            return response.text
        
        except requests.exceptions.SSLError as e:
            print(f"SSL 错误（可能由于 CT 验证失败）: {e}")
            returnNone
   
    # 使用示例
    url = "https://example.com"
    content = fetch_with_expect_ct(url)
    ```
   
5.  4. **处理 CT 报告**：
   
    如果服务器提供了 report-uri，你可能需要实现一个端点来接收这些报告：
   
    ```
    from flask import Flask, request
   
    app = Flask(__name__)
   
    @app.route(''/ct-report'', methods=[''POST''])
    def handle_ct_report():
        report_data = request.json
        # 处理报告数据
        print(f"收到 CT 报告: {report_data}")
        return "OK", 200
    ```
   
6.  5. **注意事项**：
   

-   • 确保爬虫遵守网站的 `robots.txt` 和使用条款
   
-   • 考虑添加适当的延迟以避免对目标服务器造成过大负担
   
-   • 处理可能出现的异常和错误情况
   
-   • 考虑使用会话和连接池以提高性能
   

### HTTP的Feature-Policy头在爬虫中有何影响？

HTTP的Feature-Policy头对爬虫有多方面影响：1) 功能限制：可能阻止爬虫使用摄像头、麦克风、地理位置等API；2) 资源加载控制：限制从特定来源加载资源，影响爬虫获取数据的能力；3) 沙箱环境：创建更严格的JavaScript执行环境，影响基于JS的爬虫；4) 浏览器兼容性：不同爬虫工具对Feature-Policy的支持程度各异；5) 合规性：爬虫应尊重这些策略以避免违反网站条款；6) 反爬虫措施：网站可能利用此作为阻止自动化工具的手段。爬虫开发者需要了解这些限制，并可能需要调整策略或使用支持绕过限制的工具。

### 如何在爬虫中处理 HTTP 的 421 Misdirected Request？

处理HTTP 421 Misdirected Request可以采取以下策略：1) 检查URL是否正确，服务器可能已更改地址；2) 实现带延迟和最大重试次数的重试机制，因为此错误可能是暂时的；3) 尝试更换User-Agent，某些服务器可能拒绝特定UA；4) 检查代理设置，必要时更换代理或直接连接；5) 如果响应包含Location头部，尝试重定向到新地址；6) 降低请求频率，避免服务器过载；7) 实现退避策略，多次遇到错误时增加重试间隔；8) 确保使用服务器支持的HTTP协议版本。

### HTTP 的 Clear-Site-Data 头在爬虫中有何意义？

HTTP 的 Clear-Site-Data 头在爬虫中有以下几个重要意义：1) 帮助爬虫清除访问过程中留下的数据痕迹（如cookies、localStorage等），减少被追踪的风险；2) 使爬虫行为更接近真实浏览器，表明爬虫会清除会话数据，降低被反爬系统识别的概率；3) 支持负责任的爬虫行为，遵守网站的数据清理政策；4) 在GDPR等数据保护法规下，确保爬虫不存储不必要的用户数据；5) 对于网站开发者而言，了解此头有助于设计更智能的反爬策略或识别恶意爬虫。需要注意的是，Clear-Site-Data 主要是服务器发送给客户端的指示，而非爬虫直接使用的工具。

### 如何在爬虫中处理 HTTP 的 423 Locked？

处理 HTTP 423 Locked 状态码（表示资源被锁定）的爬虫策略包括：1) 实现指数退避重试机制，随重试次数增加等待时间；2) 使用代理IP轮换，避免基于IP的锁定；3) 降低请求频率，减少触发锁定的可能；4) 检查并优化请求头，确保符合服务器期望；5) 实现分布式爬虫系统，由不同节点轮流请求；6) 记录锁定状态，分析模式并调整策略；7) 如果可能，了解锁定原因并等待解锁；8) 确保爬虫行为遵守robots.txt规定；9) 使用会话管理或重置会话；10) 在必要时联系网站管理员获取访问许可。

### HTTP 的 Cross-Origin-Resource-Policy 头如何影响爬虫？

Cross-Origin-Resource-Policy (CORP) 头通过限制跨域资源访问来影响爬虫操作。具体影响包括：1) 当网站设置 ''same-origin'' 或 ''same-site'' 策略时，爬虫从不同域名发起的请求会被拒绝；2) 爬虫需要处理由此产生的 CORS 错误；3) 爬虫可能需要使用代理服务器或调整请求策略来绕过这些限制。然而，爬虫开发者应当尊重网站的访问规则，避免过度请求，并优先考虑使用合规的爬虫技术，而不是试图绕过安全措施。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的限流？

处理HTTP 429 Too Many Requests错误的方法包括：1) 检测429状态码并解析Retry-After头确定等待时间；2) 实现指数退避算法，如等待时间=基础延迟×(2^重试次数)；3) 使用请求队列控制发送频率，添加随机延迟(0.5-2秒)；4) 实现令牌桶或漏桶算法控制请求速率；5) 轮换User-Agent和IP地址；6) 添加真实浏览器请求头；7) 使用会话管理维护cookies；8) 遵守robots.txt中的爬虫延迟指令；9) 使用Scrapy等框架的内置限流功能；10) 监控错误频率并动态调整策略。

### HTTP 的 Timing-Allow-Origin 头在爬虫中有何用途？

Timing-Allow-Origin 头是 HTTP 响应头，用于控制哪些来源可以访问资源的性能计时信息。在爬虫中，它的主要用途包括：1) 允许爬虫获取跨域资源的精确加载时间，有助于性能分析和监控；2) 帮助爬虫工具遵守网站的安全策略，尊重服务器对计时信息访问的限制；3) 优化爬虫策略，通过分析不同资源的加载时间来调整爬取顺序和效率；4) 支持网站性能分析工具，使其能够全面评估包含跨域资源的网站性能。爬虫在使用此信息时应注意遵守相关爬取规范，避免对目标网站造成过大负担。

### 如何在爬虫中处理 HTTP 的 499 Client Closed Request？

处理爬虫中的499 Client Closed Request(客户端关闭请求)可以从以下几个方面入手：1) 降低请求频率，增加请求间隔时间；2) 设置合理的超时参数，避免长时间等待；3) 使用异步请求机制，避免阻塞；4) 实现智能重试机制，但控制重试频率；5) 优化请求头，如设置Connection: keep-alive；6) 使用分布式爬虫分散负载；7) 完善错误处理和日志记录；8) 遵守robots.txt规则；9) 使用代理IP池轮换请求；10) 优化爬取策略，减少不必要的请求。499错误通常表示服务器处理请求时间过长，客户端已提前关闭连接，因此核心思路是提高爬虫效率并减少对服务器的压力。

### HTTP 的 X-Permitted-Cross-Domain-Policies 头在爬虫中有何意义？

X-Permitted-Cross-Domain-Policies 头在爬虫中的意义主要体现在以下几个方面：1) 它指示了网站对跨域访问的限制，帮助爬虫了解哪些资源可以跨域访问；2) 作为合规性参考，爬虫需要尊重这些策略以避免违反网站政策；3) 影响爬虫对特定类型资源（如Flash内容或PDF文档）的处理方式；4) 可能是网站反爬虫机制的一部分，爬虫需要识别并遵守这些限制；5) 帮助爬虫设计者确保其行为不会无意中绕过网站的安全措施；6) 在某些情况下可能与数据保护法规相关，爬虫需考虑法律因素。总的来说，这个头帮助爬虫在获取数据的同时保持合法合规。

### 如何在爬虫中处理 HTTP 的 451 Unavailable For Legal Reasons？

处理HTTP 451错误(由于法律原因不可用)的策略包括：1)识别并尊重法律限制，不尝试绕过；2)记录遇到451的URL以便后续分析；3)调整爬取策略，跳过受限内容；4)使用代理和IP轮换；5)添加适当的请求头；6)严格遵守robots.txt规则；7)优先考虑使用官方API；8)实现适当的错误处理和重试机制；9)必要时咨询法律专业人士；10)记录和分析错误模式以优化爬虫行为。最重要的是确保爬虫操作合法合规。

### HTTP 的 Referrer-Policy 头如何影响爬虫？

HTTP 的 Referrer-Policy 头通过控制 Referer 头的发送方式对爬虫产生多方面影响：1) 限制来源信息：当网站设置严格策略(如 no-referrer)时，爬虫请求资源可能导致目标服务器无法识别请求来源，影响需要验证来源的API访问；2) 影响链式爬取：使用 same-origin 或 origin 等策略时，跨域请求只发送有限信息，可能影响依赖完整来源信息的爬虫逻辑；3) 干扰反爬机制：网站可能通过 Referer 检测爬虫，爬虫需正确设置 Referer 头以避免被识别；4) 影响资源加载：某些依赖 Referer 验证合法性的资源可能因策略而无法加载；爬虫应对策略包括正确设置 Referer 头、处理不同策略、遵守 robots.txt 以及尊重网站设置的隐私保护意图。

### 如何在爬虫中实现 HTTP 的 Expect-CT 验证？

在爬虫中实现 HTTP 的 Expect-CT 验证可以通过以下几种方式：

1.  1\. 使用 requests 库：
   

```
import requests

headers = {
    ''User-Agent'': ''MyCrawler/1.0'',
    ''Expect-CT'': ''max-age=86400, enforce, report-uri="https://example.com/ct-report"''
}

response = requests.get(''https://example.com'', headers=headers)

# 检查响应头
if ''Expect-CT'' in response.headers:
    print(''服务器支持 Expect-CT:'', response.headers[''Expect-CT''])
```

1.  2\. 在 Scrapy 爬虫中通过中间件实现：
   

```
class ExpectCTMiddleware:
    def process_request(self, request, spider):
        request.headers.setdefault(''Expect-CT'', ''max-age=86400, enforce'')
        return None
    
    def process_response(self, request, response, spider):
        if ''Expect-CT'' in response.headers:
            spider.logger.debug(''服务器支持 Expect-CT'')
        return response
```

1.  3\. 使用 aiohttp 进行异步爬虫：
   

```
import aiohttp

headers = {
    ''User-Agent'': ''MyCrawler/1.0'',
    ''Expect-CT'': ''max-age=86400, enforce''
}

async with aiohttp.ClientSession() as session:
    async with session.get(''https://example.com'', headers=headers) as response:
        if ''Expect-CT'' in response.headers:
            print(''服务器支持 Expect-CT'')
```

1.  4\. 处理强制执行模式下的证书验证错误：
   

```
try:
    response = requests.get(''https://example.com'', headers=headers, verify=True)
except requests.exceptions.SSLError as e:
    print(f''证书验证失败: {e}'')
```

Expect-CT 头格式为：`max-age=<seconds>, enforce, report-uri="<uri>"`，其中 enforce 表示强制执行模式，不符合CT策略的证书将被拒绝。

### HTTP 的 Cross-Origin-Opener-Policy 头在爬虫中有何影响？

Cross-Origin-Opener-Policy (COOP) 头在爬虫中会产生多方面影响：1) 当设置为''same-origin''或''deny''时，会限制跨源窗口交互，可能导致爬虫无法获取完整页面内容；2) 影响JavaScript渲染，因为现代爬虫工具(如Puppeteer)使用的无头浏览器可能被隔离，导致执行环境受限；3) 可能阻碍跨源资源加载，影响数据提取；4) 可能被用作反爬虫机制，阻止自动化工具访问；5) 与Cross-Origin-Embedder-Policy (COEP)结合使用时，会启用跨源隔离，增加爬取难度。爬虫开发者需要调整策略或寻找替代方案(如使用API)来应对这些限制。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的动态限流？

处理 HTTP 429 Too Many Requests 的动态限流可以采取以下策略：

1.  1. **检测并响应 429 状态码**：在爬虫代码中捕获 429 错误，解析响应头中的 Retry-After 字段，确定需要等待的时间。
   
2.  2. **实现动态延迟机制**：
   

-   • 基于服务器响应动态调整请求间隔
   
-   • 实现指数退避算法，每次遇到限流时等待时间加倍
   
-   • 使用自适应速率控制，根据成功率调整请求频率
   

4.  3. **使用成熟的爬虫框架**：
   

-   • Scrapy 的 AutoThrottle 扩展可自动调整请求延迟
   
-   • 实现基于服务器响应时间的动态速率限制
   

6.  4. **分布式爬取与代理轮换**：
   

-   • 使用多个 IP 地址分散请求压力
   
-   • 实现请求队列和分布式爬取架构
   

8.  5. **遵守 robots.txt**：
   

-   • 检查并遵守网站的爬取规则
   
-   • 设置合理的 User-Agent 和请求间隔
   

10.  6. **使用速率限制库**：
   

-   • 使用如 ratelimit、pyrate-limiter 等库实现令牌桶或漏桶算法
   

12.  7. **监控与日志记录**：
   

-   • 记录 429 错误频率和响应时间
   
-   • 根据历史数据优化爬取策略
   

14.  8. **设置合理的爬取时段**：
   

-   • 避开网站流量高峰期
   
-   • 根据目标网站特点调整爬取时间表
   

### HTTP 的 CORP 头在爬虫中有何意义？

CORP(Cross-Origin Read Policy)头是HTTP响应头，用于控制跨域资源共享策略，在爬虫场景中有以下意义：1) 访问控制：网站可通过CORP头限制爬虫访问权限，防止未授权抓取；2) 数据保护：对敏感数据实施来源限制，防止数据滥用；3) 反爬虫机制：作为反爬策略的一部分，保护内容安全和服务器负载；4) 安全增强：减少跨域攻击风险，提高数据安全性；5) 合规性：帮助网站满足数据保护法规要求；6) 资源保护：防止图片、视频等资源被其他网站直接引用。对爬虫开发者而言，理解CORP意味着需遵守网站访问政策，处理跨域访问限制，并确保爬虫的合规性和道德性。

### 如何在爬虫中处理 HTTP 的 418 I''m a teapot？

HTTP 48 ''I''m a teapot'' 是一个非标准状态码，通常表示服务器拒绝请求，可能是反爬虫机制。处理方法包括：1) 降低请求频率，添加随机延迟；2) 更换User-Agent模拟真实浏览器；3) 使用代理IP避免IP封锁；4) 添加完整的浏览器请求头；5) 处理可能出现的验证码；6) 使用会话管理保持cookies；7) 检查并遵守robots.txt；8) 实现合理的重试机制；9) 考虑使用官方API代替爬虫；10) 调整爬取策略使其更符合网站预期。

### HTTP 的 X-Robots-Tag 头在爬虫中有何作用？

X-Robots-Tag 是一个 HTTP 响应头，用于向搜索引擎爬虫传递指令，控制它们如何处理网页内容。其主要作用包括：1) 通过 ''noindex'' 指示爬虫不要索引特定页面；2) 使用 ''nofollow'' 指示爬虫不要跟随页面上的链接；3) 针对特定资源类型设置指令，如 ''noimageindex'' 阻止图片被索引；4) 提供比 robots.txt 更细粒度的控制，可以针对单个页面而非整个目录；5) 与 robots.txt 协同工作，提供更全面的爬虫控制；6) 解决 robots.txt 无法控制内容索引的局限性。它允许网站管理员直接通过 HTTP 头部传递爬虫指令，特别适用于没有 robots.txt 文件或需要针对特定页面设置规则的情况。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的自适应限流？

处理 429 Too Many Requests 的自适应限流可以采取以下方法：

1.  1. **识别并响应 429 状态码**：立即暂停请求并检查响应头中的 Retry-After 字段，获取建议的等待时间。
   
2.  2. **实现令牌桶或漏桶算法**：控制请求速率，使请求以固定速率发出，避免突发流量。
   
3.  3. **指数退避策略**：每次收到 429 后，等待时间按指数增长(如1s, 2s, 4s, 8s)，同时加入随机性避免同步请求。
   
4.  4. **动态调整请求间隔**：根据最近收到的 429 频率自动调整请求间隔，高频率时增加间隔，低频率时适当减少。
   
5.  5. **请求队列管理**：实现请求缓冲队列，当检测到限流时，将请求放入队列等待合适时机发送。
   
6.  6. **用户代理和IP轮换**：使用代理IP池和不同的User-Agent分散请求来源。
   
7.  7. **监控和日志记录**：记录429响应的出现频率和模式，用于优化限流策略。
   
8.  8. **遵守robots.txt**：解析并遵守目标网站的爬取规则，尊重Crawl-delay指令。
   
9.  9. **模拟人类行为**：在请求间加入随机延迟，模拟人类浏览行为模式。
   
10.  10. **分布式协调**：如果是分布式爬虫，确保各节点协调工作，避免集中请求同一资源。
   

### HTTP 的 Cross-Origin-Embedder-Policy 头在爬虫中有何影响？

Cross-Origin-Embedder-Policy (COEP) 头对爬虫有多方面影响：1) 资源获取限制：当设置为''require-corp''时，只允许加载返回了Cross-Origin-Resource-Policy头的资源，可能导致爬虫无法获取某些跨域资源；2) JavaScript渲染障碍：使用无头浏览器(如Puppeteer)的爬虫可能因COEP限制而无法完全渲染页面，影响动态内容获取；3) 反爬虫机制：网站可能利用COEP作为反爬策略，阻止自动化工具获取完整内容；4) 技术兼容性：传统爬虫工具可能不完全支持COEP，导致功能受限；5) 性能影响：额外的策略验证可能增加爬虫请求时间；6) 合规要求：爬虫需遵守COEP策略，避免违反网站使用条款。爬虫开发者可能需要调整策略，如使用支持COEP的浏览器引擎或寻找替代数据获取方式。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式限流？

处理HTTP 429 Too Many Requests的分布式限流需要多层次的策略：

1.  1. **Redis分布式限流**：使用Redis的原子操作实现令牌桶或漏桶算法，协调多个爬虫节点。
   
2.  2. **中央队列调度**：建立中央请求队列，由调度器按适当速率分发请求到各节点。
   
3.  3. **滑动窗口算法**：实现基于时间窗口的限流，统计全局请求速率。
   
4.  4. **自适应退避策略**：收到429错误时，解析Retry-After头并实现指数退避算法。
   
5.  5. **分层限流控制**：实现全局、域名级和URL级的多层限流。
   
6.  6. **请求分散与随机化**：在多个IP间分散请求，随机化请求间隔避免固定模式。
   
7.  7. **监控与动态调整**：监控请求成功率，动态调整限流参数。
   

关键实现包括使用Redis的原子操作确保分布式一致性，实现智能重试机制，以及结合IP轮换和User-Agent轮换降低被检测的风险。

### HTTP的NEL头在爬虫网络错误日志中有何用途？

NEL(Network Error Logging)头在爬虫网络错误日志中有多种用途：1)错误监控与诊断，帮助开发者识别爬虫在抓取过程中遇到的网络问题；2)性能分析，通过收集的错误数据评估爬虫在不同网络条件下的表现；3)问题定位，识别特定URL或模式下的网络问题；4)改进爬虫策略，基于错误数据调整重试机制、超时设置等参数；5)网络质量评估，分析目标网站在不同网络环境下的可访问性；6)合规性监控，确保爬虫遵守robots.txt等规则；7)安全监控，检测网站对爬虫的限制措施；8)负载均衡优化，帮助识别表现不佳的服务器或数据中心。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的指数退避？

处理爬虫中的HTTP 429 Too Many Requests错误时，指数退避算法是一种有效策略。以下是实现方法：

1.  1. **基本原理**：每次收到429错误后，等待时间按指数增长（基础延迟 × 2^重试次数）
   
2.  2. **实现步骤**：
   

-   • 解析响应头中的Retry-After（服务器指定重试时间）
   
-   • 如果没有Retry-After，使用指数退避算法计算等待时间
   
-   • 添加随机抖动避免多爬虫同步重试
   
-   • 等待后重试请求，直到达到最大重试次数
   

4.  3. **代码示例**：
   

```
import time
import random

defhandle_429_retry(retry_count, base_delay=1, max_delay=60):
    delay = base_delay * (2 ** retry_count)
    # 添加随机抖动(±10%)
    jitter = random.uniform(-0.1, 0.1) * delay
    delay = min(delay + jitter, max_delay)
    return delay

defmake_request(url, max_retries=5):
    retry_count = 0
    while retry_count <= max_retries:
        try:
            response = requests.get(url)
            if response.status_code != 429:
                return response
                
            # 使用服务器指定的时间或指数退避
            delay = int(response.headers.get(''Retry-After'', 0)) or handle_429_retry(retry_count)
            print(f"等待 {delay:.2f} 秒后重试...")
            time.sleep(delay)
            retry_count += 1
        except Exception as e:
            print(f"请求出错: {str(e)}")
            returnNone
    return None
```

1.  4. **优化建议**：
   

-   • 优先使用服务器指定的Retry-After头
   
-   • 设置最大延迟时间避免过长等待
   
-   • 在分布式爬虫中增加更多随机性
   
-   • 监控429错误频率动态调整策略
   

### HTTP 的 Reporting-Endpoints 头在爬虫中有何意义？

HTTP的Reporting-Endpoints头在爬虫中有多方面的意义：1) 它为网站和爬虫之间提供了一种正式的通信渠道，使网站能够向爬虫发送关于使用政策的反馈；2) 爬虫开发者可以通过此机制接收违规警告，及时调整爬取策略以避免被封禁；3) 它支持更智能的反爬虫策略，网站可以发送警告或限制请求而非直接封禁IP；4) 有助于提高爬虫的合规性，确保爬取行为符合网站的使用条款和法律法规；5) 爬虫可以通过报告端点提交问题反馈，促进与网站管理者的良性互动；6) 在遵守robots.txt规则的同时，提供了一种更灵活的沟通方式；7) 有助于建立负责任的爬取行为，维护互联网生态系统的健康发展。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的令牌桶算法？

在爬虫中使用令牌桶算法处理429 Too Many Requests错误，主要步骤如下：

1.  1. **令牌桶原理**：令牌桶以固定速率生成令牌，每个请求消耗一个令牌，桶有最大容量限制，允许突发流量。
   
2.  2. **实现步骤**：
   

-   • 初始化令牌桶：设置容量和令牌生成速率
   
-   • 请求前获取令牌：发送HTTP请求前检查是否有可用令牌
   
-   • 处理429错误：收到429时，根据Retry-After字段等待
   
-   • 动态调整：根据服务器响应调整请求速率
   

4.  3. **代码示例**：
   

```
class TokenBucket:
    def__init__(self, capacity, refill_rate):
        self.capacity = capacity
        self.refill_rate = refill_rate
        self.tokens = capacity
        self.last_refill_time = time.time()
        self.lock = Lock()
    
    defconsume(self, tokens=1):
        withself.lock:
            now = time.time()
            elapsed = now - self.last_refill_time
            new_tokens = elapsed * self.refill_rate
            self.tokens = min(self.capacity, self.tokens + new_tokens)
            self.last_refill_time = now
            
            ifself.tokens >= tokens:
                self.tokens -= tokens
                returnTrue
            returnFalse
    
    defwait_for_token(self, tokens=1):
        withself.lock:
            whileself.tokens < tokens:
                now = time.time()
                elapsed = now - self.last_refill_time
                new_tokens = elapsed * self.refill_rate
                self.tokens = min(self.capacity, self.tokens + new_tokens)
                self.last_refill_time = now
                
                ifself.tokens < tokens:
                    wait_time = (tokens - self.tokens) / self.refill_rate
                    time.sleep(wait_time)
```

1.  4. **爬虫集成**：
   

-   • 在发送请求前调用wait\_for\_token方法
   
-   • 收到429错误时，根据Retry-After等待后重试
   
-   • 实现自适应速率调整机制
   

3.  5. **高级考虑**：
   

-   • 多线程环境下的线程安全
   
-   • 分布式爬虫中的全局速率控制
   
-   • 结合robots.txt和User-Agent轮换
   
-   • 实现指数退避策略处理持续429错误
   

通过令牌桶算法，爬虫可以平滑控制请求速率，避免触发服务器的速率限制，提高爬取成功率和稳定性。

### HTTP 的 Permissions-Policy 头在爬虫中有何影响？

HTTP 的 Permissions-Policy 头对爬虫有多方面的影响：

1.  1. **功能访问限制**：Permissions-Policy 头可以限制浏览器 API 的使用，如地理位置、摄像头、麦克风等。爬虫如果模拟浏览器行为并尝试使用这些受限 API，可能会遇到功能不可用的情况。
   
2.  2. **影响无头浏览器渲染**：现代爬虫常使用无头浏览器（如 Headless Chrome）来渲染 JavaScript。Permissions-Policy 可能会限制这些环境中的某些功能，导致爬虫无法获取完整的动态加载内容。
   
3.  3. **自动化检测**：网站可以通过 Permissions-Policy 限制特定功能（如访问传感器、支付功能等），使自动化工具更容易被识别，从而实现反爬虫策略。
   
4.  4. **存储访问限制**：爬虫可能依赖 localStorage、IndexedDB 等存储机制来维护会话状态。Permissions-Policy 可以限制对这些存储的访问，干扰爬虫的状态管理。
   
5.  5. **跨域资源访问**：Permissions-Policy 可以限制跨域 iframe 或脚本访问某些功能，这可能影响爬虫从第三方资源中获取数据的能力。
   
6.  6. **JavaScript 执行环境**：爬虫执行的 JavaScript 可能会因 Permissions-Policy 改变的环境特性而表现异常，影响数据提取的准确性。
   
7.  7. **反爬虫机制**：作为网站安全策略的一部分，Permissions-Policy 可以与其他反爬虫措施结合使用，增加爬虫获取数据的难度。
   
8.  8. **影响 API 调用**：某些爬虫可能通过浏览器 API 获取数据，Permissions-Policy 限制这些 API 的使用会直接影响爬虫的数据采集能力。
   

爬虫开发者需要了解这些限制，并可能需要调整爬虫策略，如使用不同的用户代理、绕过特定限制或寻找替代的数据获取方法。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的滑动窗口限流？

处理HTTP 429 Too Many Requests的滑动窗口限流可以采取以下方法：

1.  1\. 检测429响应并提取Retry-After信息：
   

-   • 当收到429响应时，检查响应头中的Retry-After字段
   
-   • 如果没有Retry-After，使用默认退避时间（如5-60秒）
   

3.  2\. 实现滑动窗口限流算法：
   

-   • 维护一个时间窗口（如60秒）和该窗口内的请求数量
   
-   • 在发送新请求前，检查当前窗口内的请求数是否已达到限制
   
-   • 如果已达到限制，计算需要等待的时间并休眠
   

5.  3\. 动态调整请求速率：
   

-   • 根据服务器返回的限制信息（如X-RateLimit-Remaining）动态调整请求间隔
   
-   • 实现请求队列，按固定间隔从队列中取出请求发送
   

7.  4\. 随机化请求间隔：
   

-   • 在固定间隔基础上添加随机延迟（±20%），避免被检测为自动化爬虫
   
-   • 例如：如果间隔为1秒，实际延迟可以是0.8-1.2秒之间的随机值
   

9.  5\. 实现指数退避算法：
   

-   • 当连续收到429错误时，以指数方式增加等待时间（如2^N秒）
   
-   • 成功发送请求后重置退避计数器
   

11.  6\. 使用分布式限流（如果适用）：
   

-   • 如果爬虫是分布式的，实现基于共享存储的限流机制
   
-   • 如使用Redis等工具记录各节点的请求情况
   

13.  7\. 尊重robots.txt和API限制：
   

-   • 在发送请求前检查robots.txt文件
   
-   • 遵循API文档中的速率限制建议
   

15.  8\. 实现请求重试机制：
   

-   • 对429错误进行有限次数的重试
   
-   • 每次重试间增加等待时间
   

示例代码（Python）：

```
import time
import random
from collections import deque

classsliding_window_rate_limiter:
    def__init__(self, window_size=60, max_requests=30):
        self.window_size = window_size  # 时间窗口大小（秒）
        self.max_requests = max_requests  # 窗口内最大请求数
        self.requests = deque()  # 存储请求时间戳的双端队列
        self.retry_after = 0# 服务器返回的等待时间
        self.backoff = 0# 指数退避计数器
        self.last_request_time = 0# 上次请求时间
    
    defcan_request(self):
        now = time.time()
        
        # 清理过期请求
        whileself.requests and now - self.requests[0] > self.window_size:
            self.requests.popleft()
        
        # 如果有退避时间未结束，不能请求
        ifself.retry_after > 0and now < self.last_request_time + self.retry_after:
            returnFalse
        
        # 如果窗口内请求数已达上限，不能请求
        iflen(self.requests) >= self.max_requests:
            returnFalse
        
        returnTrue
    
    defwait_if_needed(self):
        ifnotself.can_request():
            # 计算需要等待的时间
            wait_time = 0
            
            # 如果有退避时间，使用退避时间
            ifself.retry_after > 0:
                wait_time = self.retry_after - (time.time() - self.last_request_time)
            
            # 如果窗口内请求数已达上限，计算窗口剩余时间
            iflen(self.requests) >= self.max_requests:
                oldest_request = self.requests[0]
                wait_time = max(wait_time, oldest_request + self.window_size - time.time())
            
            # 添加随机延迟（±20%）
            wait_time *= random.uniform(0.8, 1.2)
            
            if wait_time > 0:
                time.sleep(wait_time)
    
    defrecord_request(self, retry_after=None):
        now = time.time()
        self.requests.append(now)
        self.last_request_time = now
        
        if retry_after:
            self.retry_after = retry_after
            self.backoff += 1# 增加退避计数器
        else:
            self.retry_after = 0
            self.backoff = 0# 重置退避计数器

# 使用示例
limiter = sliding_window_rate_limiter(window_size=60, max_requests=30)

for url in urls:
    limiter.wait_if_needed()
    
    try:
        response = requests.get(url)
        if response.status_code == 429:
            retry_after = int(response.headers.get(''Retry-After'', 5))
            limiter.record_request(retry_after)
        else:
            limiter.record_request()
            # 处理响应
    except Exception as e:
        # 处理异常
        pass
```

### HTTP 的 Cross-Origin-Resource-Sharing 头在爬虫中有何作用？

CORS（跨域资源共享）头主要用于解决浏览器中的同源策略限制，但在爬虫中的作用有限：1) 大多数爬虫库不受CORS限制，因为它们不遵循浏览器的同源安全策略；2) 爬虫通常不会自动发送或处理CORS相关的头部；3) 即使目标网站设置了严格的CORS策略，通常也无法阻止爬虫获取资源；4) CORS对爬虫的影响主要体现在需要模拟浏览器行为的场景，如执行JavaScript渲染内容的网站；5) 爬虫可以通过不发送Origin头部或使用代理来绕过CORS限制。简而言之，CORS主要是浏览器安全机制，对传统爬虫影响较小。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的漏桶算法？

处理HTTP 429 Too Many Requests错误使用漏桶算法的步骤：

1.  1. **理解漏桶算法原理**：
   

-   • 桶有固定容量，表示最大允许的请求数
   
-   • 请求以任意速率流入桶中
   
-   • 请求以固定速率从桶中流出
   
-   • 桶满时，新请求需要等待或被丢弃
   

3.  2. **实现漏桶算法**：
   

-   • 创建桶结构，记录当前请求数量和最后处理时间
   
-   • 设置桶容量(如100个请求)和漏出速率(如每秒10个请求)
   
-   • 每次发送请求前检查桶的状态
   
-   • 如果桶已满，计算需要等待的时间
   

5.  3. **处理429响应**：
   

-   • 解析响应头中的Retry-After字段，获取建议等待时间
   
-   • 根据Retry-After调整桶的漏出速率
   
-   • 记录限流信息，动态调整爬取策略
   

7.  4. **代码实现示例**：
   

```
import time

classLeakyBucket:
    def__init__(self, capacity, rate):
        self.capacity = capacity  # 桶容量
        self.rate = rate  # 漏出速率(请求/秒)
        self.water = 0# 当前请求数量
        self.last_leak = time.time()  # 上次漏出时间
        
    defleak(self):
        # 计算应该漏掉多少请求
        now = time.time()
        elapsed = now - self.last_leak
        leak_count = elapsed * self.rate
        self.water = max(0, self.water - leak_count)
        self.last_leak = now
        
    defcan_request(self):
        self.leak()
        returnself.water < self.capacity
        
    defadd_request(self):
        ifself.can_request():
            self.water += 1
            returnTrue
        returnFalse
        
    defwait_time(self):
        # 计算还需等待多久才能发送请求
        self.leak()
        ifself.water < self.capacity:
            return0
        return (self.water - self.capacity + 1) / self.rate
```

1.  5. **在爬虫中的使用**：
   

```
# 初始化漏桶
bucket = LeakyBucket(capacity=100, rate=10)

# 发送请求前检查
ifnot bucket.can_request():
    wait = bucket.wait_time()
    time.sleep(wait)

# 发送请求并处理响应
try:
    response = send_request(url)
    if response.status_code == 429:
        retry_after = int(response.headers.get(''Retry-After'', 60))
        time.sleep(retry_after)
        # 可以调整桶的参数
        bucket.rate = 1 / retry_after  # 根据Retry-After调整速率
except Exception as e:
    # 错误处理
    pass
```

1.  6. **最佳实践**：
   

-   • 结合其他限流算法如令牌桶提高效率
   
-   • 实现动态调整策略，根据服务器响应自动调整
   
-   • 设置合理的User-Agent和请求头
   
-   • 考虑使用代理IP池分散请求
   
-   • 遵守robots.txt规则
   

### HTTP 的 X-Download-Options 头在爬虫文件下载中有何意义？

X-Download-Options 是一个 HTTP 响应头，通常设置为 ''X-Download-Options: noopen''。在爬虫文件下载中，它的主要意义体现在以下几个方面：1) 安全防护：防止下载的文件被直接执行，降低爬虫无意中运行恶意代码的风险；2) 合规性：尊重网站设置的安全限制，避免违反网站使用条款；3) 文件处理：指导爬虫将下载内容保存到磁盘而非尝试执行；4) 模拟真实浏览器行为：使爬虫行为更接近真实用户，提高隐蔽性。当爬虫遇到此头部时，应避免直接打开或执行下载的文件，而是将其保存到本地后再进行后续处理。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的固定窗口限流？

处理HTTP 429 Too Many Requests的固定窗口限流有几种有效方法：

1.  1. **基本请求延迟**：在每次请求后添加固定延迟，如每分钟限制60个请求则每次请求后等待1秒。
   
2.  2. **动态延迟调整**：基于服务器返回的`Retry-After`头信息动态调整延迟时间，并添加随机性避免所有爬虫同步重试。
   
3.  3. **令牌桶算法**：实现令牌桶算法更平稳地控制请求速率，避免突发流量触发的限流。
   
4.  4. **固定窗口计数器**：精确模拟固定窗口限流，在每个时间窗口内限制请求数量。
   
5.  5. **使用爬虫框架**：利用Scrapy等框架内置的限流机制，如AUTOTHROTTLE\_ENABLED。
   
6.  6. **分布式限流**：在分布式爬虫中使用Redis等工具协调各节点的请求频率。
   
7.  7. **结合代理和请求头**：使用代理轮换和随机请求头减少被识别为爬虫的风险。
   
8.  8. **自适应限流**：根据服务器响应自动调整请求频率，遇到429时增加延迟，成功一段时间后尝试减小延迟。
   

最佳实践包括：尊重`Retry-After`头信息、添加随机延迟、监控请求频率、使用专业限流库、在分布式环境中协调请求、优雅降级而非完全停止。

### HTTP 的 Content-Security-Policy-Report-Only 头在爬虫中有何用途？

Content-Security-Policy-Report-Only (CSP-RO) 头在爬虫中有多种用途：1) 安全策略分析 - 爬虫可以检测网站的安全策略而不被阻止访问资源；2) 合规性测试 - 模拟 CSP-RO 头测试网站策略是否过于严格；3) 安全审计 - 收集违规报告识别潜在漏洞；4) 监控和日志 - 帮助管理员了解资源加载问题；5) 策略优化 - 收集触发违规的信息帮助调整更精确的安全策略；6) 竞争对手分析 - 了解其他网站的安全策略；7) 安全研究 - 收集分析各类网站的 CSP 报告了解安全趋势。使用时需遵守网站 robots.txt 和服务条款，避免过度请求造成负担。

### HTTP 的 X-Content-Security-Policy 头在爬虫中有何影响？

X-Content-Security-Policy (CSP) 头对爬虫有多方面影响：1) 限制资源加载来源，可能阻止爬虫获取完整页面内容；2) 禁止内联脚本执行，影响JavaScript渲染的爬虫工具；3) 限制iframe等嵌入内容，影响嵌套内容抓取；4) 限制连接端点，可能阻止AJAX数据获取；5) 增加网站对自动化工具的检测能力；6) 可能影响表单提交和数据收集。爬虫开发者需调整策略，如设置真实User-Agent、启用JavaScript执行、处理认证cookie、遵守robots.txt、控制请求频率等。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的自适应重试？

处理HTTP 429 Too Many Requests的自适应重试策略包括：

1.  1. **检测与响应头解析**：捕获429状态码并解析响应头中的''Retry-After''字段，该字段可能包含重试等待时间(秒数)或具体日期。
   
2.  2. **智能等待机制**：根据''Retry-After''值设置等待时间，若没有该字段，则采用指数退避算法(如第一次等待1秒，第二次2秒，第三次4秒等)。
   
3.  3. **请求限流控制**：实现速率限制器(如令牌桶算法)，在发送请求前检查是否允许发送，避免触发429错误。
   
4.  4. **随机化延迟**：在固定间隔基础上添加随机抖动(jitter)，避免所有请求同时重试形成新的请求高峰。
   
5.  5. **IP/代理轮换**：当IP被限流时，切换到不同的IP地址或使用代理池分散请求压力。
   
6.  6. **动态调整策略**：监控429错误率，动态调整请求频率；实现最大重试次数限制，避免无限重试。
   
7.  7. **分布式协调**：在分布式爬虫中，使用共享存储(如Redis)协调各节点的请求速率，避免整体超出限制。
   
8.  8. **尊重robots.txt**：检查并遵守目标网站的爬取规则，合理设置User-Agent和请求头。
   

这些策略组合使用可以有效避免触发429错误，提高爬虫的稳定性和效率。

### HTTP 的 X-WebKit-CSP 头在爬虫中有何意义？

X-WebKit-CSP（X-WebKit-Content-Security-Policy）是内容安全策略(CSP)的早期实现，在爬虫中具有重要意义：1) 它限制资源加载来源，可能阻碍爬虫获取完整页面资源；2) 禁止内联脚本执行，影响需要运行JavaScript的动态内容抓取；3) 作为反爬虫机制的一部分，可阻止自动化工具访问；4) 爬虫需理解并遵守这些策略以避免被封禁；5) 现代爬虫需处理CSP策略以有效模拟真实浏览器行为；6) CSP常与其他反爬虫技术结合使用，形成综合防御系统。爬虫开发者需在遵守网站安全策略与有效抓取内容间找到平衡。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的动态重试？

处理 HTTP 429 Too Many Requests 错误的动态重试策略包括以下几个关键步骤：

1.  1. **检测 429 错误**：监控 HTTP 响应状态码，识别 429 错误。
   
2.  2. **解析 Retry-After 头**：从响应头中提取 ''Retry-After'' 字段，它可能包含秒数或具体的重试时间点。
   
3.  3. **实现动态等待**：根据解析到的信息设置等待时间，如未提供则使用指数退避算法（如 2^retry\_count 秒）。
   
4.  4. **添加重试限制**：设置最大重试次数避免无限循环。
   
5.  5. **实现装饰器模式**：创建可重用的重试装饰器：
   

```
import functools
import time
from datetime import datetime

defretry_on_429(max_retries=5):
    defdecorator(func):
        @functools.wraps(func)
        defwrapper(*args, **kwargs):
            retry_count = 0
            while retry_count < max_retries:
                response = func(*args, **kwargs)
                if response.status_code != 429:
                    return response
                
                retry_after = response.headers.get(''Retry-After'')
                if retry_after:
                    try:
                        wait_time = int(retry_after)
                    except ValueError:
                        try:
                            retry_date = datetime.strptime(retry_after, ''%a, %d %b %Y %H:%M:%S GMT'')
                            wait_time = (retry_date - datetime.utcnow()).total_seconds()
                        except ValueError:
                            wait_time = 60
                else:
                    wait_time = min(2 ** retry_count, 60)
                
                time.sleep(wait_time)
                retry_count += 1
            raise Exception(f"Max retries ({max_retries}) exceeded due to rate limiting")
        return wrapper
    return decorator
```

1.  6. **使用框架内置功能**：如 Scrapy 的 AutoThrottle 扩展或 requests 的 Session 配置。
   
2.  7. **考虑分布式协调**：在分布式爬虫中使用共享存储协调请求速率。
   
3.  8. **记录和监控**：记录速率限制事件，持续优化策略。
   

### HTTP 的 X-Frame-Options 头在爬虫中有何作用？

X-Frame-Options 头在爬虫中有以下几个方面的作用：1) 防止内容被嵌入：通过设置 DENY 或 SAMEORIGIN 值，网站可以防止其内容被 iframe 或 frame 嵌入，间接限制了爬虫通过框架方式获取内容的能力；2) 作为反爬虫策略的一部分：网站可能将其与其他技术结合使用，增加爬虫获取数据的难度；3) 内容保护：防止爬虫将网站内容嵌入到其他平台或应用中；4) 安全防护：虽然主要是安全机制，但也间接影响了爬虫的行为方式。需要注意的是，大多数爬虫库（如 requests）默认不会像浏览器一样严格遵守此头部，除非有专门处理逻辑。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的指数退避重试？

处理 HTTP 429 Too Many Requests 的指数退避重试是爬虫开发中的重要技能，以下是实现方法：

1.  1. **基本指数退避算法**：每次重试的等待时间呈指数增长，例如第一次1秒，第二次2秒，第三次4秒，以此类推。
   
2.  2. **优先使用 Retry-After 头**：检查服务器响应中的 Retry-After 头，优先使用服务器建议的延迟时间。
   
3.  3. **添加随机性**：在指数退避基础上加入随机延迟（如 ±0.5秒），避免多个爬虫同时重试造成"惊群效应"。
   
4.  4. **设置最大延迟上限**：避免等待时间过长影响爬取效率。
   
5.  5. **设置最大重试次数**：防止无限重试浪费资源。
   

Python 实现示例：

```
import time
import random
import requests

deffetch_with_retry(url, max_retries=5, initial_delay=1, max_delay=60):
    retries = 0
    delay = initial_delay
    
    while retries < max_retries:
        try:
            response = requests.get(url)
            
            if response.status_code == 200:
                return response
            
            elif response.status_code == 429:
                # 检查Retry-After头
                retry_after = response.headers.get(''Retry-After'')
                if retry_after:
                    try:
                        delay = min(float(retry_after), max_delay)
                    except ValueError:
                        pass
                else:
                    # 指数退避 + 随机性
                    delay = min(delay * 2 + random.uniform(0, 1), max_delay)
                
                print(f"收到429错误，将在{delay:.2f}秒后重试...")
                time.sleep(delay)
                retries += 1
            
            else:
                return response
                
        except requests.exceptions.RequestException as e:
            print(f"请求出错: {e}")
            delay = min(delay * 2 + random.uniform(0, 1), max_delay)
            time.sleep(delay)
            retries += 1
    
    print(f"达到最大重试次数 {max_retries}，放弃请求")
    return None
```

1.  6. **高级优化**：
   

-   • 使用代理池分散请求
   
-   • 设置请求头模拟浏览器行为
   
-   • 实现分布式爬虫协调
   
-   • 使用 Scrapy 等框架的中间件机制
   

这种策略能有效避免触发服务器的限流机制，提高爬虫的稳定性和效率。

### HTTP 的 X-Content-Duration 头在爬虫中有何用途？

X-Content-Duration 是一个非标准的HTTP头字段，用于指示内容的预期持续时间或长度，通常以秒为单位。在爬虫中，这个头字段有以下用途：1) 内容筛选和优先级排序，爬虫可以根据内容时长决定抓取优先级；2) 带宽和资源管理，帮助预估下载内容所需的资源；3) 内容分类，将不同时长的内容（如短视频、长视频等）分开处理；4) 遵守爬取政策，如果robots.txt规定了只允许爬取特定时长的内容；5) 性能优化，对长时间内容采用特殊处理方式。需要注意的是，由于X-Content-Duration不是标准HTTP头，并非所有网站都会提供此信息。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的固定重试？

处理爬虫中的429 Too Many Requests错误需要实现一个带有固定重试策略的机制。以下是关键实现步骤：

1.  1. **识别429错误**：捕获HTTP 429状态码
   
2.  2. **解析Retry-After头**：从响应中获取服务器建议的等待时间
   
3.  3. **实现重试机制**：在遇到429错误时，按照建议时间延迟后重试
   
4.  4. **设置最大重试次数**：避免无限重试导致程序卡死
   

Python实现示例：

```
import time
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

defcreate_session_with_retry(max_retries=3):
    session = requests.Session()
    retry_strategy = Retry(
        total=max_retries,
        status_forcelist=[429],
        backoff_factor=1
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    session.mount("http://", adapter)
    session.mount("https://", adapter)
    return session

deffetch_with_retry(url, max_retries=3):
    session = create_session_with_retry(max_retries)
    
    for attempt inrange(max_retries):
        try:
            response = session.get(url)
            
            if response.status_code == 429:
                retry_after = response.headers.get(''Retry-After'', 5)
                delay = int(retry_after) if retry_after.isdigit() else5
                print(f"遇到429错误，等待 {delay} 秒后重试...")
                time.sleep(delay)
                continue
                
            return response
            
        except requests.exceptions.RequestException as e:
            print(f"请求出错: {e}")
            if attempt == max_retries - 1:
                raise
            
    return None
```

关键点：

-   • 使用Retry-After头获取服务器建议的等待时间
   
-   • 实现指数退避策略作为后备方案
   
-   • 设置合理的最大重试次数
   
-   • 添加适当的日志记录以便调试
   

### HTTP 的 X-Content-Security 头在爬虫中有何意义？

X-Content-Security-Policy (CSP) 头在爬虫中有多方面意义：1) 限制资源加载，可能影响爬虫获取数据的完整性；2) 防止内容篡改，保护爬虫免受某些攻击；3) 影响JavaScript执行，对依赖JS渲染的爬虫(如无头浏览器)有直接影响；4) 控制iframe/frame加载，影响页面解析；5) 可能限制表单提交，影响需要填写表单的爬虫；6) 限制某些API使用，要求爬虫调整数据获取策略；7) 提出合规性考量，爬虫开发者需权衡遵守CSP与获取数据的关系。爬虫应尊重网站的CSP策略，同时考虑如何在不违反网站政策的前提下有效获取所需数据。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的随机重试？

处理HTTP 429 Too Many Requests错误的随机重试策略包括：

1.  1. **检测429错误**：捕获状态码429并解析响应头中的Retry-After字段(如果有)
   
2.  2. **实现随机延迟**：使用随机延迟代替固定延迟，避免触发更多限制
   

-   • 基础延迟 = 服务器建议等待时间(或默认值)
   
-   • 总延迟 = 基础延迟 + 随机增量(如0~基础延迟的50%)
   

4.  3. **指数退避算法**：每次重试延迟时间逐渐增加
   

-   • delay = (2^attempt) + random.uniform(0, 1)
   

6.  4. **随机重试限制**：设置最大重试次数(通常3-5次)
   
7.  5. **请求头随机化**：每次重试随机更换User-Agent和请求头
   
8.  6. **IP/代理轮换**：如有代理，重试时切换不同IP
   
9.  7. **示例代码(Python)**：
   

```
import time
import random
import requests

deffetch_with_retry(url, max_retries=5):
    for attempt inrange(max_retries):
        try:
            if attempt > 0:
                # 解析Retry-After或使用随机延迟
                retry_after = response.headers.get(''Retry-After'', 2)
                delay = float(retry_after) + random.uniform(0, retry_after/2)
                time.sleep(delay)
            
            # 随机User-Agent
            headers = {
                ''User-Agent'': random.choice(user_agent_pool)
            }
            
            response = requests.get(url, headers=headers)
            
            if response.status_code == 429:
                continue# 触发重试
                
            return response
            
        except Exception as e:
            if attempt == max_retries - 1:
                raise
            time.sleep((2 ** attempt) + random.uniform(0, 1))
```

1.  8. **高级策略**：实现请求队列、令牌桶算法控制请求速率，或使用分布式爬虫分散请求
   

### HTTP 的 X-DNS-Prefetch-Control 头在爬虫中有何作用？

X-DNS-Prefetch-Control 头在爬虫中主要有以下作用：1) 控制DNS预获取行为，可设为''off''减少不必要的DNS查询，提高爬取效率；2) 帮助爬虫模拟浏览器行为，避免因缺少该头而被网站识别为爬虫；3) 在大规模爬取时，禁用DNS预获取可减少系统资源消耗；4) 增加爬虫的匿名性，减少网站收集DNS记录的机会。使用requests库时可通过headers参数设置此头。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的自适应指数退避？

处理HTTP 429 Too Many Requests的自适应指数退避策略包括以下关键步骤：

1.  1. **基础指数退避算法**：每次遇到429错误时， exponentially 增加等待时间，例如：2^1秒、2^2秒、2^3秒...
   
2.  2. **实现自适应调整**：
   

-   • 检查响应头中的Retry-After字段，优先使用服务器建议的等待时间
   
-   • 根据历史成功率调整延迟（成功率低时增加延迟）
   
-   • 添加随机抖动(jitter)避免多个客户端同步重试
   

4.  3. **Python实现示例**：
   

```
class AdaptiveBackoff:
    def__init__(self, max_retries=5, base_delay=1, max_delay=60):
        self.max_retries = max_retries
        self.base_delay = base_delay
        self.max_delay = max_delay
        self.history = []
    
    defwait_time(self, attempt, retry_after=None):
        if retry_after:
            try:
                returnmin(int(retry_after), self.max_delay)
            except ValueError:
                pass
        
        delay = self.base_delay * (2 ** attempt)
        jitter = delay * random.uniform(0.1, 0.5)
        delay += jitter
        
        returnmin(delay, self.max_delay)
    
    deffetch(self, url):
        attempt = 0
        while attempt < self.max_retries:
            try:
                response = requests.get(url)
                if response.status_code == 429:
                    retry_after = response.headers.get(''Retry-After'')
                    delay = self.wait_time(attempt, retry_after)
                    time.sleep(delay)
                    attempt += 1
                    continue
                return response
            except requests.exceptions.RequestException:
                delay = self.wait_time(attempt)
                time.sleep(delay)
                attempt += 1
        raise Exception(f"Failed after {self.max_retries} attempts")
```

1.  4. **Scrapy框架实现**：通过自定义DownloaderMiddleware处理429状态码并应用退避策略
   
2.  5. **最佳实践**：
   

-   • 设置合理的最大重试次数和最大延迟时间
   
-   • 实现请求速率限制，避免触发429错误
   
-   • 使用代理池和User-Agent轮换
   
-   • 遵守robots.txt规则和网站API的使用条款
   

### HTTP 的 X-Download-Options 头在爬虫中有何用途？

X-Download-Options 头（通常值为 ''noopen''）在爬虫中主要用于限制爬虫对下载内容的直接访问。它的主要用途包括：1) 防止爬虫直接打开下载的文件（如PDF、Excel等）而必须通过下载流程获取；2) 增加爬取难度，使爬虫需要额外处理下载过程；3) 保护受版权或使用限制的资源；4) 帮助网站检测爬虫行为，因为正常浏览器会遵循此头的指示。爬虫在遇到设置了此头的网站时，可能需要调整策略，模拟浏览器行为或处理下载对话框。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的动态指数退避？

处理HTTP 429 Too Many Requests错误的动态指数退避策略如下：

1.  1. **基本指数退避算法**：每次遇到429错误后，等待时间按指数增长，例如：
   
    ```
    import time
   
    def exponential_backoff(retry_count, base_delay=1, max_delay=60):
        delay = min(base_delay * (2 ** retry_count), max_delay)
        time.sleep(delay)
    ```
   
2.  2. **添加随机抖动(jitter)**：避免多个爬虫同步退避：
   
    ```
    import random
   
    def jittered_backoff(retry_count, base_delay=1, max_delay=60):
        delay = min(base_delay * (2 ** retry_count), max_delay)
        jittered_delay = delay * (0.5 + random.random() * 0.5)  # 50%-100%的随机延迟
        time.sleep(jittered_delay)
    ```
   
3.  3. **结合Retry-After头**：如果服务器提供了Retry-After值，优先使用它：
   
    ```
    def handle_429(response, retry_count=0):
        if response.status_code == 429:
            if ''Retry-After'' in response.headers:
                delay = int(response.headers[''Retry-After''])
            else:
                delay = min(1 * (2 ** retry_count), 60)
            time.sleep(delay)
            return True
        return False
    ```
   
4.  4. **完整实现示例**：
   
    ```
    import time
    import random
    import requests
   
    deffetch_with_backoff(url, max_retries=5):
        retry_count = 0
        while retry_count <= max_retries:
            try:
                response = requests.get(url)
                if response.status_code == 429:
                    if''Retry-After''in response.headers:
                        delay = int(response.headers[''Retry-After''])
                    else:
                        delay = min(1 * (2 ** retry_count), 60)
                        # 添加随机抖动
                        delay = delay * (0.5 + random.random() * 0.5)
                    
                    print(f"429错误，等待 {delay:.2f} 秒后重试...")
                    time.sleep(delay)
                    retry_count += 1
                    continue
                
                response.raise_for_status()
                return response
                
            except requests.exceptions.RequestException as e:
                if retry_count == max_retries:
                    raise e
                retry_count += 1
                time.sleep(min(1 * (2 ** retry_count), 60))
    ```
   
5.  5. **高级策略**：
   

-   • 实现请求计数器，在达到阈值前主动降低请求频率
   
-   • 根据目标网站特性调整基础延迟和最大延迟
   
-   • 使用分布式锁协调多个爬虫实例
   
-   • 实现自适应算法，根据历史响应时间动态调整参数
   

### HTTP 的 X-Permitted-Cross-Domain-Policies 头在爬虫中有何作用？

X-Permitted-Cross-Domain-Policies 头在爬虫中主要用于控制跨域访问行为，具体作用包括：1) 定义哪些域名可以访问网站资源；2) 限制爬虫获取跨域数据；3) 作为反爬虫机制的一部分，阻止未授权的跨域抓取；4) 帮助爬虫理解网站的访问政策，确保合规抓取；5) 控制Flash等技术的跨域数据访问。该头通常设置为''none''、''master-only''、''by-content-type''或''all''等不同值，表示不同程度的跨域访问限制。爬虫在抓取时应尊重这些策略，避免违反网站规则。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的自适应滑动窗口？

在爬虫中处理429 Too Many Requests的自适应滑动窗口方法包括：

1.  1. **基本实现原理**：
   

-   • 监控服务器响应的429错误和返回的重试时间(Retry-After头)
   
-   • 动态调整请求窗口大小和请求间隔
   
-   • 实现请求队列的平滑控制
   

3.  2. **核心实现步骤**：
   

-   • 初始化一个初始窗口大小(如5个请求)
   
-   • 记录每个请求的时间戳
   
-   • 当收到429错误时，提取Retry-After值
   
-   • 根据错误信息调整窗口大小或增加等待时间
   
-   • 实现指数退避算法，如等待时间 = 基础延迟 × (2 ^ 重试次数)
   

5.  3. **代码示例(Python)**：
   
    ```
    import time
    from collections import deque
   
    classAdaptiveSlidingWindow:
        def__init__(self, max_requests=5, time_window=60):
            self.max_requests = max_requests
            self.time_window = time_window
            self.requests = deque()
            self.wait_time = 1
            self.retry_count = 0
        
        defcan_make_request(self):
            now = time.time()
            # 清除过期的请求记录
            whileself.requests and now - self.requests[0] > self.time_window:
                self.requests.popleft()
            
            # 如果请求队列未满，可以发送请求
            iflen(self.requests) < self.max_requests:
                returnTrue
            returnFalse
        
        defrecord_request(self):
            self.requests.append(time.time())
        
        defhandle_429(self, retry_after=None):
            self.retry_count += 1
            if retry_after:
                self.wait_time = int(retry_after)
            else:
                # 指数退避
                self.wait_time = min(60, 2 ** self.retry_count)
            time.sleep(self.wait_time)
    ```
   
6.  4. **优化策略**：
   

-   • 实现多级窗口控制(全局窗口和单域名窗口)
   
-   • 根据不同网站特性调整初始参数
   
-   • 添加随机抖动(jitter)避免同步请求
   
-   • 实现请求优先级队列
   

8.  5. **最佳实践**：
   

-   • 遵守robots.txt规则
   
-   • 设置合理的User-Agent
   
-   • 实现请求失败重试机制
   
-   • 记录日志用于分析和调优
   

### HTTP 的 X-Pingback 头在爬虫中有何意义？

X-Pingback 头在爬虫中有几个重要意义：1) 帮助爬虫发现网站的 Pingback 端点，了解网站如何处理引用通知；2) 让爬虫能够尊重网站的引用政策，如果网站使用 Pingback，爬虫可以判断是否需要触发通知；3) 帮助爬虫避免不必要的请求，特别是当只是临时访问页面而不打算长期引用时；4) 有助于分析网站之间的引用关系和网络结构；5) 帮助爬虫识别网站使用的内容管理系统（如 WordPress 等）；6) 使爬虫能够更好地遵守 robots.txt 中与 Pingback 相关的规则；7) 促进爬虫尊重网站的版权和引用规范。了解并尊重 X-Pingback 机制是负责任爬虫行为的重要部分。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式滑动窗口？

处理 HTTP 429 Too Many Requests 的分布式滑动窗口可以采用以下方法：

1.  1. **基于 Redis 的滑动窗口实现**：
   

-   • 使用 Redis 的 ZSET 数据结构存储请求时间戳
   
-   • 每个请求到来时，将当前时间戳加入 ZSET，并移除窗口外的旧请求
   
-   • 检查 ZSET 长度是否超过限制，超过则触发限流
   
-   • 利用 Redis 的原子操作确保分布式环境下的线程安全
   

3.  2. **分布式限流策略**：
   

-   • 实现中心化限流器：所有节点共享同一个限流窗口
   
-   • 或实现分散式限流：每个节点维护自己的限流窗口，但共享限流配置
   

5.  3. **处理 429 响应**：
   

-   • 解析 Retry-After 头，确定延迟时间
   
-   • 实现指数退避算法，逐步增加重试间隔
   
-   • 记录错误信息，用于后续优化限流策略
   

7.  4. **优化措施**：
   

-   • 使用连接池减少连接开销
   
-   • 实现请求优先级队列
   
-   • 添加监控指标，跟踪限流触发频率
   
-   • 根据目标网站特性动态调整限流参数
   

9.  5. **代码示例（Redis实现）**：
   
    ```
    def is_allowed(request_key, window_size, max_requests):
        current_time = time.time()
        pipe = redis.pipeline()
        pipe.zadd(request_key, {str(current_time): current_time})
        pipe.zremrangebyscore(request_key, 0, current_time - window_size)
        pipe.zcard(request_key)
        pipe.expire(request_key, window_size)
        _, _, count, _ = pipe.execute()
        return count <= max_requests
    ```
   

### HTTP 的 X-Powered-By 头在爬虫中有何用途？

X-Powered-By头在爬虫中有多种用途：1) 识别目标网站使用的技术栈，帮助爬虫确定适当的爬取策略；2) 绕过反爬机制，通过了解技术特征模拟真实浏览器请求；3) 进行网站指纹识别，在安全研究中寻找潜在漏洞；4) 进行竞争对手分析，了解行业技术趋势；5) 辅助自动化测试，根据不同技术调整测试策略。不过，出于安全考虑，许多现代网站已禁用此头字段以避免技术信息泄露。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式固定窗口？

处理HTTP 429 Too Many Requests的分布式固定窗口算法需要以下关键步骤：

1.  1. **使用Redis作为共享存储**：Redis的原子操作和过期特性非常适合实现分布式限流
   
2.  2. **实现固定窗口算法**：
   

-   • 将时间划分为固定大小的窗口（如每秒、每分钟）
   
-   • 为每个资源或API端点创建唯一的限流键
   
-   • 使用Redis的INCR命令和EXPIRE命令实现窗口计数器
   

4.  3. **伪代码实现**：
   

```
class DistributedFixedWindowRateLimiter:
    def__init__(self, redis_client, window_size, max_requests):
        self.redis = redis_client
        self.window_size = window_size
        self.max_requests = max_requests
        
    defacquire(self, resource_key):
        now = int(time.time())
        window_start = (now // self.window_size) * self.window_size
        current_window_key = f"rate_limit:{resource_key}:{window_start}"
        
        current_count = self.redis.get(current_window_key)
        current_count = int(current_count) if current_count else0
        
        if current_count < self.max_requests:
            self.redis.incr(current_window_key)
            self.redis.expireat(current_window_key, window_start + self.window_size)
            returnTrue
        return False
```

1.  4. **处理429响应**：
   

-   • 检测429状态码
   
-   • 解析Retry-After头获取建议等待时间
   
-   • 实现退避算法避免立即重试
   

3.  5. **分布式协调**：
   

-   • 确保所有爬虫节点使用相同的限流策略
   
-   • 考虑时间同步问题
   
-   • 实现Lua脚本保证原子性操作
   

5.  6. **优化策略**：
   

-   • 为不同API端点设置差异化限流
   
-   • 实现动态调整机制
   
-   • 添加容错处理（如Redis不可用时的降级方案）
   

这种方法可以有效防止爬虫被网站封禁，同时提高爬虫的效率和稳定性。

### HTTP 的 X-Request-ID 头在爬虫日志追踪中有何作用？

HTTP 的 X-Request-ID 头在爬虫日志追踪中扮演着重要角色：1) 提供唯一标识符，用于追踪单个请求在系统中的完整生命周期；2) 帮助分布式系统中关联不同节点处理同一请求的日志；3) 便于错误排查和故障定位，通过ID快速找到相关日志记录；4) 支持请求去重，避免重复爬取；5) 有助于性能分析，评估爬虫处理特定请求的效率；6) 在负载均衡中保持会话一致性；7) 为安全审计提供可追踪的请求路径。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式漏桶算法？

处理429 Too Many Requests的分布式漏桶算法实现方案：

1.  1\. 系统架构设计：
   

-   • 使用Redis作为中央存储系统记录请求状态
   
-   • 每个爬虫节点实现漏桶逻辑
   
-   • 建立监控机制检测429错误并动态调整
   

3.  2\. 核心实现步骤：
   
    a. 定义漏桶参数：桶容量、流出速率、时间窗口
   
    b. 使用Redis实现分布式漏桶：
   

4.  1\. 检查漏桶状态
   
5.  2\. 桶未满时允许请求并更新状态
   
6.  3\. 桶已满时等待或丢弃请求
   
7.  4\. 收到429响应时记录并延长等待时间
   
    d. 动态调整机制：根据响应时间和错误率自动调整
   

-   • 采用有序集合或计数器记录请求
   
-   • 每个请求记录时间戳和令牌数量
   
-   • 定期清理过期记录
   
    c. 请求处理流程：
   

6.  3\. 代码实现要点：
   
    ```
    class DistributedLeakyBucket:
        def__init__(self, redis_host, capacity, rate):
            self.redis = redis.StrictRedis(host=redis_host)
            self.capacity = capacity  # 桶容量
            self.rate = rate  # 每秒请求数
            self.key = "leaky_bucket"
        
        defallow_request(self):
            # 使用Redis事务确保原子性
            withself.redis.pipeline() as pipe:
                whileTrue:
                    try:
                        pipe.watch(self.key)
                        current = int(pipe.get(self.key) or0)
                        if current >= self.capacity:
                            pipe.unwatch()
                            returnFalse
                        pipe.multi()
                        pipe.incr(self.key)
                        pipe.expire(self.key, 60)
                        pipe.execute()
                        returnTrue
                    except redis.WatchError:
                        continue
    ```
   
7.  4\. 高级优化策略：
   

-   • 多级漏桶：为不同优先级请求设置不同漏桶
   
-   • 自适应速率调整：根据响应时间动态调整
   
-   • 请求预热：开始时低速率，逐渐增加到目标
   
-   • 分布式协调：使用消息队列协调多节点
   

9.  5\. 监控与日志：
   

-   • 记录请求速率、错误率、响应时间
   
-   • 设置异常情况告警
   
-   • 定期分析日志优化策略
   

通过以上方案，可以有效控制爬虫请求速率，避免触发429错误，同时提高爬取效率和稳定性。

### HTTP 的 X-Robots-Tag 头在爬虫中有何意义？

X-Robots-Tag 是一个 HTTP 响应头，用于向搜索引擎爬虫和其他网络爬虫提供指令，指导它们如何处理特定网页或资源。它的主要意义包括：1) 提供比 robots.txt 更精细的内容控制；2) 可以针对特定 URL、文件类型或资源设置不同指令；3) 能够控制非 HTML 资源（如图片、PDF）的索引行为；4) 支持多种指令如 noindex（禁止索引）、nofollow（禁止跟随链接）、noarchive（禁止缓存）等；5) 可在服务器级别设置，适用于无法修改 HTML 内容的情况；6) 提供跨网站应用的能力，特别是在 CDN 或反向代理环境中。这使得网站管理员能够更灵活地管理爬虫行为，优化内容展示和保护敏感信息。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式随机重试？

处理429 Too Many Requests的分布式随机重试策略包括以下几个关键点：

1.  1\. 解析Retry-After头：首先检查响应头中的Retry-After字段，如果有，则按照建议的时间等待；如果没有，使用默认退避策略。
   
2.  2\. 实现指数退避算法：采用指数退避策略，每次重试的等待时间 = 基础延迟 × (2^重试次数) + 随机抖动，避免多个节点同时重试。
   
3.  3\. 分布式协调：使用Redis或Zookeeper等分布式服务实现全局锁或延迟队列，确保不同节点的重试请求在时间上分散开。
   
4.  4\. 请求限流：实现全局请求速率限制，使用令牌桶或漏桶算法控制所有节点的总请求频率。
   
5.  5\. IP轮换：在分布式环境中使用代理IP池，结合随机重试策略分散请求压力。
   
6.  6\. 监控与自适应：监控429错误率，根据错误动态调整请求频率，实现自适应重试策略。
   
7.  7\. 唯一标识符：为每个请求生成唯一ID，在分布式系统中跟踪请求状态，避免重复处理。
   
8.  8\. 降级策略：当持续收到429错误时，临时降低爬取频率或切换到备用数据源。
   

### HTTP 的 X-Runtime 头在爬虫性能分析中有何用途？

X-Runtime头在爬虫性能分析中有多种用途：1) 监控目标服务器响应时间，及时发现性能异常；2) 根据响应时间动态调整爬取频率，避免给服务器过大压力；3) 评估服务器负载状况，优化爬取策略；4) 检测反爬机制，当响应时间异常时可能表示触发了反爬；5) 作为性能基准，测试不同爬取策略对目标网站的影响；6) 帮助爬虫决定请求优先级，优先爬取响应快的页面。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式指数退避？

处理HTTP 429 Too Many Requests的分布式指数退避策略如下：

1.  1. **基本概念**：
   

-   • 429状态码表示请求频率过高
   
-   • 指数退避：每次重试前等待时间按指数增长(1s, 2s, 4s, 8s...)
   
-   • 分布式协调：确保所有爬虫实例遵循一致的退避策略
   

3.  2. **实现方案**：
   

-   • **中心化协调器**：使用Redis等存储全局请求状态，所有爬虫实例共享退避时间
   
-   • **分布式锁**：通过分布式锁机制协调各实例的退避行为
   
-   • **随机化退避**：基础退避时间加上随机偏移量，避免同步恢复
   

5.  3. **代码实现(Python示例)**：
   

```
import time
import random
import redis

classDistributedBackoff:
    def__init__(self, redis_host=''localhost''):
        self.redis = redis.StrictRedis(host=redis_host)
        self.base_backoff = 1
        self.max_backoff = 300
        self.jitter_factor = 0.1
    
    defget_backoff_time(self, retry_count):
        backoff = min(self.base_backoff * (2 ** retry_count), self.max_backoff)
        jitter = backoff * self.jitter_factor * (2 * random.random() - 1)
        returnmax(backoff + jitter, 1)
    
    defhandle_429(self, retry_count):
        backoff_time = self.get_backoff_time(retry_count)
        
        # 使用Redis设置全局退避状态
        key = f"backoff:{int(time.time() // 300)}"
        self.redis.setex(key, int(backoff_time), "1")
        
        time.sleep(backoff_time)
        
        # 等待全局退避结束
        whileself.redis.exists(key):
            time.sleep(1)
```

1.  4. **优化策略**：
   

-   • 自适应退避：根据历史响应时间动态调整
   
-   • 分级退避：对不同类型请求应用不同策略
   
-   • 服务器特定策略：针对不同目标服务器定制参数
   

3.  5. **最佳实践**：
   

-   • 设置最大退避时间上限(通常为5-10分钟)
   
-   • 添加随机抖动(±10%)避免同步恢复
   
-   • 记录退避历史，分析优化策略
   
-   • 考虑使用成熟库如tenacity或backoff
   

### HTTP 的 X-UA-Compatible 头在爬虫中有何作用？

X-UA-Compatible 头在爬虫中主要有以下几方面的作用：1) 控制渲染模式：帮助爬虫确定使用哪种浏览器引擎(如IE9模式、IE8模式等)来解析页面，确保内容被正确渲染；2) 模拟浏览器行为：使爬虫能够模拟特定版本的IE浏览器，获取与真实用户一致的内容；3) 处理兼容性问题：某些网站依赖特定渲染模式正确显示内容，设置此头可避免因渲染差异导致的内容获取不完整；4) 影响JavaScript执行：不同渲染模式对JS支持不同，此头会影响JS执行环境，进而影响动态内容的获取；5) 反爬虫检测：正确设置此头可以帮助爬虫伪装成正常浏览器，避免被网站识别为爬虫程序。

### 如何在爬虫中处理 HTTP 的 429 Too Many Requests 的分布式自适应重试？

处理HTTP 429 Too Many Requests的分布式自适应重试策略包括以下几个方面：

1.  1. **集中式限流管理**：使用Redis等共享存储记录请求历史和限流状态，实现令牌桶或漏桶算法控制全局请求速率，避免所有实例同时突破限制。
   
2.  2. **自适应重试策略**：
   

-   • 优先解析并使用服务器返回的`Retry-After`头部值
   
-   • 若无明确等待时间，采用指数退避算法：初始等待时间 = 基础延迟 × (2 ^ 重试次数)
   
-   • 添加随机抖动(25%-75%)避免多个实例同步重试
   
-   • 设置最大等待时间上限(如300秒)，避免无限等待
   

4.  3. **分布式协调机制**：
   

-   • 实现分布式锁确保同一时间只有一个实例处理特定资源重试
   
-   • 使用消息队列管理重试任务，避免实例间竞争
   
-   • 实现背压机制，过载时自动减少并发请求数
   

6.  4. **实现示例代码**：
   

```
import time
import random
import redis
from requests.exceptions import HTTPError

classAdaptiveRetryHandler:
    def__init__(self, redis_host=''localhost'', redis_port=6379):
        self.redis = redis.StrictRedis(host=redis_host, port=redis_port)
        self.base_delay = 1
        self.max_delay = 300
        
    defshould_retry(self, response, retry_count=0):
        if response.status_code != 429:
            returnFalse
            
        retry_after = response.headers.get(''Retry-After'')
        if retry_after:
            try:
                delay = int(retry_after)
            except ValueError:
                retry_date = parsedate(retry_after)
                delay = max(0, (retry_date - datetime.now()).total_seconds())
        else:
            delay = min(self.base_delay * (2 ** retry_count), self.max_delay)
            jitter = random.uniform(0.25, 0.75)
            delay = delay * (1 + jitter)
            
        retry_key = f"retry:{response.url}"
        self.redis.setex(retry_key, int(delay), "1")
        
        returnTrue, delay
        
    defmake_request(self, request_func, *args, **kwargs):
        retry_count = 0
        whileTrue:
            try:
                response = request_func(*args, **kwargs)
                response.raise_for_status()
                return response
            except HTTPError as e:
                if e.response.status_code == 429:
                    should_retry, delay = self.should_retry(e.response, retry_count)
                    if should_retry:
                        print(f"Rate limited. Retrying after {delay:.2f} seconds...")
                        time.sleep(delay)
                        retry_count += 1
                        continue
                raise
```

1.  5. **高级优化**：
   

-   • 实现请求优先级队列，优先处理高价值请求
   
-   • 根据不同目标网站定制不同的限流策略
   
-   • 实现IP/用户代理轮换，避免单一标识符被限流
   
-   • 监控限流频率，自动调整爬取策略
   

### HTTP 的 X-XSS-Protection 头在爬虫中有何意义？

在爬虫中，X-XSS-Protection 头具有以下意义：1) 作为网站安全状况的指标，帮助爬虫评估目标网站的安全实践；2) 帮助爬虫识别可能存在XSS漏洞的网站；3) 指导爬虫调整行为，如对启用了XSS保护的网站可能采取更谨慎的内容处理方式；4) 在安全审计爬虫中作为合规性检查点；5) 帮助区分测试环境与生产环境，因为测试环境常禁用此类安全头。需要注意的是，现代浏览器已逐渐弃用此头，转而采用CSP，但它在爬虫安全评估中仍有参考价值。',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','代理工具','','本文综合评测多款主流代理工具，对比跨平台支持、WebDAV同步、DNS防泄露及分流等功能，并提供分类推荐清单。','','','[]','# 代理工具综合评测与推荐清单

> **原作者**：chx_1126（发布于 6 月 14 日）  
> **整理**：基于 Linux.do 社区讨论  
> **最后更新参考**：2025 年 1 月 18 日  

---

## 📖 术语与图例说明

### 同步能力 (WebDAV)
- `💻:✅`：仅 PC 端支持  
- `📱:✅`：仅移动端支持  
- `💻📱:✅✅`：双端支持  
- `💻:❌` / `📱:❌`：对应端不支持  
- `❌`：完全不支持  

### DNS 防泄露
- `✅`：**优秀**。China 占比 ≤ 5%。  
- `仅代理`：China 占比 > 5%（通常指 TUN 模式下）。  
- `仅TUN`：China 占比 > 5%（通常指普通代理模式下）。  
- `(需要设置)`：默认配置不防漏，需手动调整。  
- `(未测试)`：暂无定论。  

### 自定义分流 & 链式代理
- `✅`：支持。  
- `(配置文件)`：依赖编辑 YAML/JSON 配置文件实现，非 UI 原生便捷操作。  
- `☑️`：支持但配置复杂/受限。  
- `❌`：不支持。  

### 更新状态
- `✅`：活跃更新（6 个月内有更新）。  
- 未标记：通常视为活跃，具体请查阅仓库 Release 时间。  

> ⚠️ **免责声明**：数据仅供参考，软件更新频繁，请以实际体验为准。

---

## ⭐ 强烈推荐 (Editor''s Choice)

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **[V2rayN](https://github.com/2dust/v2rayN)** | `Win/Mac/Linux` | `💻:✅` | ✅ | — | — | 老牌稳定，功能全面 |
| **[Clash-verge-rev](https://github.com/clash-verge-rev/clash-verge-rev/releases)** | `Win/Mac/Linux` | `💻:✅` | ✅ (需设置) | ✅ (配置) | ✅ (配置) | 好评度高，社区活跃 |
| **[mihomo-party](https://github.com/mihomo-party-org/mihomo-party)** | `Win/Mac/Linux` | `💻:✅` | ✅ (需设置) | ✅ (配置) | ✅ (配置) | 界面个性化，支持 Sub-store |
| **[虎兕 (husi)](https://codeberg.org/xchacha20-poly1305/husi/releases)** | `Android` | `📱:✅` | ✅ | — | — | v2rayNG 继任者，体验佳 |
| **[Nekobox 官改版](https://github.com/starifly/NekoBoxForAndroid)** | `Android` | `📱:✅` | ✅ | — | — | 功能强大的 sing-box 前端 |
| **[Karing](https://github.com/KaringX/karing)** | `全平台` (含 iOS) | `💻📱:✅✅` | ✅ | — | — | **全平台覆盖**，同步体验好 |
| **[Loon](https://apps.apple.com/in/app/loon/id1373567447)** | `iOS/iPadOS/Mac/TV` | iCloud/Dropbox | ✅ | ✅ | ✅ | 插件多，抓包强，TF 版更新快 |
| **[Shadowrocket](https://apps.apple.com/ae/app/shadowrocket/id932747118)** | `iOS/Apple TV` | ✅ | ✅ | ✅ | ✅ | iOS 瑞士军刀，稳定高效 |

---

## 📱💻 支持多设备 (跨平台)

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **[Karing](https://github.com/KaringX/karing)** | **全平台** | `💻📱:✅✅` | ✅ | — | — | **首选跨平台方案** |
| **[FlClash](https://github.com/chen08209/FlClash)** | 全平台 | `💻📱:✅✅` | `💻:仅代理`<br>`📱:✅` | ✅ (配置) | ✅ (配置) | Flutter 开发，适合新手 |
| **[hiddify](https://github.com/hiddify/hiddify-app)** | 全平台 | ❌ | — | — | — | 界面美观，策略组强 |
| **[clashmi](https://github.com/KaringX/clashmi)** | `Win/Mac/Linux/Android` | `💻📱:✅✅` | ✅ (需配置) | ☑️ (仅移动端) | ✅ (配置) | Karing 同作者，目前有 BUG，不推荐 |
| **[AnyPortal](https://github.com/AnyPortal/AnyPortal)** | `Win/Mac/Linux/Android` | ❌ | ❌ | — | — | 聚合类客户端 |
| **[v2raytun](https://v2raytun.com/)** | `Win/Mac/Linux/Android` | ❌ | — | — | — | — |
| **[Bettbox](https://github.com/appshubcc/Bettbox)** | `Win/Mac/Linux/Android` | — | — | — | — | — |

---

## 🖥️ 仅电脑端 (Desktop Only)

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **[V2rayN](https://github.com/2dust/v2rayN)** | `Win/Mac/Linux` | `💻:✅` | ✅ | ✅ | ✅ | — |
| **[Clash-verge-rev](https://github.com/clash-verge-rev/clash-verge-rev/releases)** | `Win/Mac/Linux` | `💻:✅` | ✅ (需设置) | ✅ (配置) | ✅ (配置) | — |
| **[mihomo-party](https://github.com/mihomo-party-org/mihomo-party)** | `Win/Mac/Linux` | `💻:✅` | ✅ (需设置) | ✅ (配置) | ✅ (配置) | 支持 Sub-store |
| **[sparkle](https://github.com/INKCR0W/sparkle)** | `Win/Mac/Linux` | `💻:✅` | ✅ (需设置) | ✅ (配置) | ✅ (配置) | mihomo 系新秀 |
| **[Pandora-Box](https://github.com/snakem982/Pandora-Box/)** | `Win/Mac/Linux` | `💻:❌` | `仅代理` (需配) | ✅ (配置) | ✅ (配置) | UI 改进显著 |
| **[FlyClash](https://github.com/GtxFury/FlyClash/)** | `Win/Mac` | `💻📱:✅✅` | ✅ | ✅ (配置) | ✅ (配置) | — |
| **[Throne](https://github.com/throneproj/Throne)** | `Win/Mac/Linux` | `💻:❌` | ✅ | — | — | — |
| **[sing-box-windows](https://github.com/xinggaoya/sing-box-windows)** | `Win/Mac/Linux` | `💻:❌` | `仅代理` | ✅ (配置) | ✅ (配置) | 内核不稳定，有 BUG |
| **[OneBox](https://github.com/OneOhCloud/OneBox)** | `Win/Mac/Linux` | ❌ | (未测) | ❌ | — | — |
| **[UI for Freedom](https://github.com/UIforFreedom/UIF)** | `Win/Mac/Linux` | `💻:❌` | ❌ | — | — | — |
| **[GUI.for.Clash](https://github.com/GUI-for-Cores/GUI.for.Clash)** | `Win/Mac/Linux` | `💻:❌` | (未测) | ✅ (配置) | ✅ (配置) | 有 BUG，测试期难启动 |
| **[GUI.for.Singbox](https://github.com/GUI-for-Cores/GUI.for.SingBox)** | `Win/Mac/Linux` | `💻:❌` | (未测) | ✅ (配置) | ✅ (配置) | 有 BUG，测试期难启动 |
| **[ClashMac](https://github.com/666OS/ClashMac)** | `Mac` | — | ✅ (配置) | ✅ (配置) | — | 轻量级菜单栏应用 |
| **[FlowZ](https://github.com/dododook/FlowZ)** | `Win/Linux` | — | — | — | — | — |

---

## 🤖 仅 Android 端

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **[虎兕 (husi)](https://codeberg.org/xchacha20-poly1305/husi/releases)** | `Android` | `📱:✅` | ✅ | ✅ | — | — |
| **[Nekobox 官改版](https://github.com/starifly/NekoBoxForAndroid)** | `Android` | `📱:✅` | ✅ | ✅ | — | — |
| **[Exclave](https://github.com/dyhkwong/Exclave)** | `Android` | `📱:✅` | ✅ | — | — | — |
| **[FlyClash-Android](https://github.com/GtxFury/FlyClash-Android)** | `Android` | `💻📱:✅✅` | ✅ (需启用) | ✅ | — | — |
| **[NekoBoxForAndroid](https://github.com/MatsuriDayo/NekoBoxForAndroid)** | `Android` | `📱:✅` | ✅ | — | — | — |
| **[ClashMetaForAndroid](https://github.com/MetaCubeX/ClashMetaForAndroid)** | `Android` | `📱:❌` | ✅ (需启用) | ✅ | ✅ (配置) | — |
| **[V2rayNG](https://github.com/2dust/v2rayNG)** | `Android` | `📱:❌` | ✅ | ✅ | — | — |
| **[Surfboard](https://github.com/getsurfboard/surfboard)** | `Android` | `📱:❌` | ❌ | ✅ | — | — |
| **[YumeBox](https://github.com/YumeLira/YumeBox/tree/Yume)** | `Android` | `📱:✅` (SubStore) | ✅ (配置) | ✅ | ✅ (配置) | — |
| **[AeroBoxForAndroid](https://github.com/imengying/AeroBoxForAndroid)** | `Android` | — | — | — | — | — |

---

## 🍎 仅 iOS / macOS 端

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **[Surge](https://nssurge.com/)** | `iOS/Mac/TV` | ❌ (iCloud/Dropbox) | ❌ (需自配) | ✅ | ✅ | 功能最强，价格较高 |
| **[ClashX.Meta](https://github.com/MetaCubeX/ClashX.Meta)** | `Mac` | `💻:❌` | ✅ (需自配) | ✅ | — | OpenCore 用户常用 |
| **[Shadowrocket](https://apps.apple.com/ae/app/shadowrocket/id932747118)** | `iOS/Apple TV` | ✅ | ✅ | ✅ | ✅ | 性价比之王 |
| **[ClashBar](https://github.com/Sitoi/ClashBar)** | `Mac` | — | — | — | — | 菜单栏轻量工具 |
| **[Stash](https://apps.apple.com/us/app/stash-rule-based-proxy/id1596063349)** | `iOS/Mac/TV` | 暂无 | — | — | — | 类 Clash 体验 |
| **[Quantumult X](https://apps.apple.com/us/app/quantumult-x/id1443988620)** | `iOS/Mac/TV` | 规则订阅需备份 | — | ✅ | — | 脚本生态丰富，谨防规则库跑路 |
| **[Loon](https://apps.apple.com/in/app/loon/id1373567447)** | `iOS/Mac/TV` | iCloud/Dropbox | ✅ | ✅ | ✅ | 综合能力强，更新勤快 |
| **[V2Box](https://apps.apple.com/us/app/v2box-v2ray-client/id6446814690?l=zh-Hans-CN)** | `iOS/Mac/TV` | 暂无 | — | — | — | V2Ray 客户端 |
| **[LanceX (小长矛)](https://apps.apple.com/us/app/lancex/id1536754048)** | `iOS/Mac` | 暂无 | — | — | — | — |
| **[V2rayU](https://github.com/yanue/V2rayU/tree/master)** | `Mac` | 暂无 | — | — | — | 旧版 V2Ray 客户端 |
| **[clashMI](https://apps.apple.com/ae/app/clash-mi/id6744321968)** | `iOS` | ✅ | ✅ (需自配) | — | — | — |
| **[ClashMax](https://github.com/marvinli001/ClashMax)** | `Mac` | — | — | — | — | — |

> **💡 iOS 端优势提示**：  
> 苹果端代理工具最大的优势在于 **MitM（中间人解密）** 用于去复写请求与响应、以及 **抓包解密** 和 **执行脚本任务**。

---

## 📡 其他设备 (路由器 / 特定硬件)

| 软件名称 | 支持系统 | WebDAV 同步 | DNS 防泄露 | 自定义分流 | 链式代理 | 备注 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Passwall** | 路由器 (OpenWrt) | 内置 | — | — | — | OpenWrt 经典插件 |
| **ClashNEXT** | `HUAWEI` | — | — | — | — | 貌似闭源，华为相关 |

---

> **PS**：楼主无苹果端及华为设备，相关体验待补充。  
> **DNS 泄露测试工具**：[DNS Leak Test](https://dnsleaktest.org/dns-leak-test)',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','api接口','','本教程汇总了多个获取随机文本（笑话、古诗、情话等）与图片（壁纸、头像）的 API 接口配置，包含请求地址与参数等信息。','','','[]','# API 接口

以下为本教程整理的 API 接口配置列表，涵盖了文本、图片、视频及音频等多种媒体类型，可直接用于项目开发与接口调用参考：

```json
[{
    "讲讲社会": {
        "name": "讲讲社会",
        "url": "https://api.yuafeng.cn/API/ly/shehui.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲人生": {
        "name": "讲讲人生",
        "url": "https://api.yuafeng.cn/API/ly/rensheng.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲个笑话": {
        "name": "讲个笑话",
        "url": "https://api.yuafeng.cn/API/ly/xiaohua.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲爱情": {
        "name": "讲讲爱情",
        "url": "https://api.yuafeng.cn/API/ly/aiqing.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲温柔": {
        "name": "讲讲温柔",
        "url": "https://api.yuafeng.cn/API/ly/wenrou.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲摆烂": {
        "name": "讲讲摆烂",
        "url": "https://api.yuafeng.cn/API/ly/wzrjcs.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "来句古诗": {
        "name": "来句古诗",
        "url": "https://api.yuafeng.cn/API/ly/gushi.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "来碗毒鸡汤": {
        "name": "来碗毒鸡汤",
        "url": "https://api.yuafeng.cn/API/ly/djt.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲舔狗": {
        "name": "讲讲舔狗",
        "url": "https://api.yuafeng.cn/API/ly/tiangou.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "来句情话": {
        "name": "讲讲情话",
        "url": "https://api.yuafeng.cn/API/ly/twqh.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲伤感": {
        "name": "讲讲伤感",
        "url": "https://api.yuafeng.cn/API/ly/shanggan.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "来句骚话": {
        "name": "来句骚话",
        "url": "https://api.yuafeng.cn/API/ly/saohua.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "讲讲英汉": {
        "name": "讲讲英汉",
        "url": "https://api.yuafeng.cn/API/ly/yhyl.php",
        "type": "text",
        "params": {
            "type": "json"
        },
        "target": "Msg"
    },
    "电脑壁纸": {
        "name": "电脑壁纸",
        "url": "https://api.yuafeng.cn/API/dnbz/api.php",
        "type": "image"
    },
    "来个头像": {
        "name": "来个头像",
        "url": "https://api.yuafeng.cn/API/ecr/api.php",
        "type": "image"
    },
    "看看女大": {
        "name": "看看女大",
        "url": "https://api.yuafeng.cn/API/ly/cqng.php",
        "type": "video",
        "params": {},
        "target": ""
    },
    "看看骚的": {
        "name": "看看骚的",
        "url": "https://api.yuafeng.cn/API/ly/sjxl.php",
        "type": "video"
    },
    "看看玉足": {
        "name": "看看玉足",
        "url": "https://api.yuafeng.cn/API/ly/yzxl.php",
        "type": "video"
    },
    "看看漫画": {
        "name": "看看漫画",
        "url": "https://api.yuafeng.cn/API/ly/mhy.php",
        "type": "video"
    },
    "看看emo": {
        "name": "看看emo",
        "url": "https://api.yuafeng.cn/API/ly/emo.php",
        "type": "video"
    },
    "看看动漫": {
        "name": "看看动漫",
        "url": "https://api.yuafeng.cn/API/ly/dmxl.php",
        "type": "video"
    },
    "看看治愈": {
        "name": "看看治愈",
        "url": "https://api.yuafeng.cn/API/ly/zyxl.php",
        "type": "video"
    },
    "看看帅哥": {
        "name": "看看帅哥",
        "url": "https://api.yuafeng.cn/API/ly/sgxl.php",
        "type": "video"
    },
    "来点色色": {
        "url": "https://api.yuafeng.cn/API/ly/sp.php",
        "type": "video"
    },
    "电影票房": {
        "name": "电影票房",
        "url": "https://api.yuafeng.cn/API/dypf/api.php",
        "type": "text",
        "params": {
            "mod": "电影详细数据"
        },
        "target": "data"
    },
    "测CP": {
        "name": "测CP",
        "url": "http://api.xingchenfu.xyz/API/tu_lofter_cp.php",
        "type": "image",
        "params": {
            "n1": "",
            "n2": "你"
        }
    },
    "看看风景": {
        "name": "看看风景",
        "url": "http://api.xingchenfu.xyz/API/cgq4kjsdt.php",
        "type": "image"
    },
    "随便来点": {
        "name": "随便来点",
        "url": "http://api.xingchenfu.xyz/API/tu.php",
        "type": "image"
    },
    "来点龙图": {
        "name": "来点龙图",
        "url": "http://api.xingchenfu.xyz/API/long.php",
        "type": "image"
    },
    "来点cos": {
        "name": "来点cos",
        "url": "http://api.xingchenfu.xyz/API/cosplay.php",
        "type": "image"
    },
    "来点二次元": {
        "name": "来点二次元",
        "url": "http://api.xingchenfu.xyz/API/ecy.php",
        "type": "image"
    },
    "女高中生": {
        "name": "女高中生",
        "url": "http://api.xingchenfu.xyz/API/nvgao.php",
        "type": "video"
    },
    "女大": {
        "name": "女大",
        "url": "http://api.xingchenfu.xyz/API/nvda.php",
        "type": "video"
    },
    "欲梦": {
        "name": "欲梦",
        "url": "http://api.xingchenfu.xyz/API/ndym.php",
        "type": "video"
    },
    "看看黑丝": {
        "name": "看看黑丝",
        "url": "http://api.xingchenfu.xyz/API/hssp.php",
        "type": "video"
    },
    "看看白丝": {
        "name": "看看白丝",
        "url": "http://api.xingchenfu.xyz/API/bsxl.php",
        "type": "video"
    },
    "看看小葫芦": {
        "name": "看看小葫芦",
        "url": "http://api.xingchenfu.xyz/API/xiaohulu.php",
        "type": "video"
    },
    "看看jk": {
        "name": "看看jk",
        "url": "http://api.xingchenfu.xyz/API/jk.php",
        "type": "video"
    },
    "看看猫猫": {
        "name": "看看猫猫",
        "url": "http://api.xingchenfu.xyz/API/sjmm.php",
        "type": "image"
    },
    "脑筋急转弯": {
        "name": "脑筋急转弯",
        "url": "http://api.xingchenfu.xyz/API/BrainTwister.php",
        "type": "text"
    },
    "随机谜语": {
        "name": "随机谜语",
        "url": "http://api.xingchenfu.xyz/API/shouji.php",
        "type": "text"
    },
    "随机姓名": {
        "name": "随机姓名",
        "url": "http://api.xingchenfu.xyz/API/xingming.php",
        "type": "text"
    },
    "晚安": {
        "name": "晚安",
        "url": "https://api.317ak.com/API/tp/zawa.php",
        "type": "image"
    },
    "来点腹肌": {
        "name": "来点腹肌",
        "url": "https://api.317ak.com/API/tp/fjtp.php",
        "type": "image"
    },
    "原神": {
        "name": "原神",
        "url": "https://api.xingzhige.com/API/yshl/",
        "type": "image"
    },
    "看看腿": {
        "name": "看看腿",
        "url": "http://api.xingchenfu.xyz/API/tu.php",
        "type": "image",
        "target": "text"
    },
    "来点帅哥": {
        "name": "来点帅哥",
        "url": "https://api.lolimi.cn/API/boy/api.php",
        "type": "image"
    },
    "来点段子": {
        "name": "来点段子",
        "url": "https://api.lolimi.cn/API/yiyan/dz.php",
        "type": "text"
    },
    "看看黄历": {
        "name": "看看黄历",
        "url": "https://api.lolimi.cn/API/huang/api.php",
        "type": "text",
        "target": "text"
    },
    "超甜辣妹": {
        "name": "超甜辣妹",
        "url": "https://api.lolimi.cn/API/xjj/lt.php",
        "type": "image"
    },
    "每日一签": {
        "name": "每日一签",
        "url": "https://api.lolimi.cn/API/riq/",
        "type": "image"
    },
    "二次元形象": {
        "name": "二次元形象",
        "url": "https://api.lolimi.cn/API/Ser/api.php",
        "type": "text",
        "params": {
            "name": ""
        },
        "target": "text"
    },
    "动漫一言": {
        "name": "动漫一言",
        "url": "https://api.lolimi.cn/API/dmyiyan/api.php",
        "type": "text",
        "target": "text"
    },
    "光遇日历": {
        "name": "光遇日历",
        "url": "https://api.lolimi.cn/API/gy/ril.php",
        "type": "image"
    },
    "香烟价格": {
        "name": "香烟价格",
        "url": "https://api.lolimi.cn/API/xyan/api.php",
        "type": "text",
        "params": {
            "msg": "雪莲"
        }
    },
    "斗图": {
        "name": "斗图",
        "url": "https://api.lolimi.cn/API/dou/api.php",
        "type": "image",
        "target": "data.image"
    },
    "人品运势": {
        "name": "人品运势",
        "url": "https://api.lolimi.cn/API/Ren/api.php",
        "type": "text",
        "params": {
            "name": "",
            "type": "json"
        },
        "target": "text"
    },
    "看看久喵": {
        "name": "看看久喵",
        "url":',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','图片api','','介绍了一个随机图片API接口，涵盖动漫、风景、壁纸等多种类型，支持直接返回图片或JSON格式数据。','','','[]','### 图片返回
[https://api.fw1028.top/acg.php?return=img（随机动漫图）](https://api.fw1028.top/acg.php?return=img)
[https://api.fw1028.top/car.php?return=img（随机跑车图）](https://api.fw1028.top/car.php?return=img)
[https://api.fw1028.top/heal.php?return=img(随机小清新图)](https://api.fw1028.top/heal.php?return=img)
[https://api.fw1028.top/model.php?return=img（随机模特图）](https://api.fw1028.top/model.php?return=img)
[https://api.fw1028.top/scenery.php?return=img（随机风景图）](https://api.fw1028.top/scenery.php?return=img)
[https://api.fw1028.top/beast_ear.php?return=img（随机兽耳娘）](https://api.fw1028.top/beast_ear.php?return=img)
[https://api.fw1028.top/choosen.php?return=img（随机精选图）](https://api.fw1028.top/choosen.php?return=img)
[https://api.fw1028.top/hd.php?return=img（随机横屏图）](https://api.fw1028.top/hd.php?return=img)
[https://api.fw1028.top/phone.php?return=img（随机竖屏图）](https://api.fw1028.top/phone.php?return=img)
[https://api.fw1028.top/bing.php?return=img（随机必应壁纸）](https://api.fw1028.top/bing.php?return=img)
[https://api.fw1028.top/game_wallpaper.php?return=img（随机游戏壁纸）](https://api.fw1028.top/game_wallpaper.php?return=img)

### json返回
[https://api.fw1028.top/acg.php?return=json（随机动漫图）](https://api.fw1028.top/acg.php?return=json)
[https://api.fw1028.top/car.php?return=json（随机跑车图）](https://api.fw1028.top/car.php?return=json)
[https://api.fw1028.top/heal.php?return=json(随机小清新图)](https://api.fw1028.top/heal.php)
[https://api.fw1028.top/model.php?return=json（随机模特图）](https://api.fw1028.top/model.php?return=json)
[https://api.fw1028.top/scenery.php?return=json（随机风景图）](https://api.fw1028.top/scenery.php?return=json)
[https://api.fw1028.top/beast_ear.php?return=json（随机兽耳娘）](https://api.fw1028.top/beast_ear.php?return=json)
[https://api.fw1028.top/choosen.php?return=json（随机精选图）](https://api.fw1028.top/choosen.php?return=json)
[https://api.fw1028.top/hd.php?return=json（随机横屏图）](https://api.fw1028.top/hd.php?return=json)
[https://api.fw1028.top/phone.php?return=json（随机竖屏图）](https://api.fw1028.top/phone.php?return=json)
[https://api.fw1028.top/bing.php?return=img（随机必应壁纸）](https://api.fw1028.top/bing.php?return=json)
[https://api.fw1028.top/game_wallpaper.php?return=json（随机游戏壁纸）](https://api.fw1028.top/game_wallpaper.php?return=json)',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','香港办卡指北','','本教程梳理了香港办卡所需准备材料，并详细讲解众安、中银香港、天星及建行亚洲四家银行的开户流程与注意事项。','','','[]','# 准备材料
- 身份证原件(验证身份)
- 港澳通行证(过关,证明文件)
- 出入境pdf证明文件(上传到开卡的那里)
	- 微信或支付宝搜索==移民局== 小程序
	- 点击 ==中国公民服务==
	- 点击 ==出入境记录查询== 查询本次入境==香港/澳门== 到开户申请当日的记录
	- 点击 ==预览文件== 查看文件
	- 点击==右上角== 打开更多功能
	- 保存文件到==手机本地(可以先转发一个朋友或文件助手在保存本地)==
- 内地手机号码(开通漫游，==提前在内地开通==，不然到了香港、澳门在开通特别麻烦 接收短信验证码)
- 连接香港网络(香港的流量卡或机场/酒店/银行的wifi等都可）
- NFC功能的手机(扫描身份证信息)
- 邮箱(接收验证码)

# 众安
- 可提前下载APP，ZA Bank（可一部手机进行多人账户申请，但后续使用建议多部设备）
- 选择开户类型，填写资料
	- ==DF5367==  **是我的邀请码，邀请码开户会有额外奖励**
- 身份验证
	- 根据指示拍摄身份证及完成人脸识别
- 确认开户资料
	- 填写住址、职业(互联网行业即可)、开户目的(储蓄、日常开支、个人财务)、税务信息及确认开户资料
- 设定用户名及登入密码，银行卡认证，提交入文件
	- 用户名和密码一定牢记，部分香港的银行APP设置了隐私保护，不可以进行截图，因此最好用别的方式进行记录
	- 银行卡是内地银联卡，手机号是该银行的预留手机号且开通了漫游服务确保可以接收到内地短信
	- 出入境文件可以通过微信小程序：”移民局“获取，首页-中国公民服务-出入境记录查询下载PDF
- 完成开户，等待下户。继续进行投资账户开通
- 再次进入app->底部投资按钮->开通投资账户
	- 1.风险评估；
	- 2.条款申明；
	- 3.衍生品确认；
	- 4.W-8BEN表格确认；
	- 5.客户协议确认。没有额外需要注意的内容，按照实际情况或者默认填写即可
### 新用户奖励
- 1.刷卡消费无上限进行1.5%回赠，新用户30天内享受额外1%回赠
- 2.基金持仓回赠券包共800HKD
- 3.股票现金回赠券包共1000HKD
- 4.货币兑换立减券126HKD
- 5.海外汇款现金回赠券100HKD
- 6.开户14天内单笔存入大于10000HKD，得年息20%的7天定存券
- 7.开户14天内账户余额大于10000且同时持有现金、基金、股票，再得年息20%的7天定存券
# 中银香港
- 下载「BOCHK中银香港」APP，打开后按顺序点：开立账户→内地居民身份→身处香港→即时开立→我不在分行，选「自在理财」账户
- 上传出入境记录：按提示上传刚才保存的出入境记录文件，不要改动任何内容
- 身份识别和验证：这一步比较繁琐，需要身份证和港澳通行证验证(这里经常会出现问题，经常验证失败，需要重新设置)
	- 只需把身份证放到对应的框框中，自动识别成功后才能继续下一步。需注意证件照片的清晰度问题
	- 这一步如果始终无法自动识别，一个办法是用另外一个手机或者ipad先将证件照片拍下来，然后放大，再用申请手机对着放大后的照片识别
- 人脸识别
	- 成功后，再进行港澳通行证的验证，同样过程
- 开户用途选“储蓄、投资、个人理财”；在香港开户原因选“在香港投资里的基金和股票”
- 个人资料如实填写，职业和资金来源一定要匹配，尽量别选和金融相关的职业以及zhengfu工作人员，也不要选一看上去就不正经的职业，如KTV经理
- 现居地址和通讯地址都填能收到快递的地址，两个地址填写要相同。实体卡会邮寄到这个地址(地址尽量携带手机号,中银卡是平邮的，没有快递单号,填写手机号理论会联系的，打电话的)
- 每月平均交易次数选26-50，收付形式选“转账交易、汇款、股票投资”，收付渠道选“电话银行、自动柜员机、网上/手机银行”
- 确认信息
- 登记发薪账户不要勾选，除非你在香港工作。最好的情况是当场收到账户开通成功通知，看到港元储蓄号和外汇宝账号。然后点“即时登入”，一定要启用流动保安编码
- 注册手机网银密码：选择【即时登入】，回到App首页，选择登录，设置账号和【登录密码】，==密码为9-12位组合==，千万注意保管好==账号和密码==。而且一定要==启用”流动保安编码==，不要点“稍后”，==流动保安==的意思就是下次打开App时，不用输入密码，直接用指纹和脸部识别就可以登录BOCHK的App
- 最后一步可能遇到的其他情况
	- 申请结果为【已接收指示】，【申请正在处理中】
		- 正常等待短信或email邮件通知就好了。一般3-7个工作日会收到开通成功，通过后等收到实体卡就可以登录网上银行使用了
	- 无法验证您的证件
		- 这个问题多为证件照片拍摄不清晰造成的，拍照时避免反光，重新提交流程即可
	- 您未能符合本行尽职审查考量
		- 这种情况多为重名（2个字的名字很容易重名），且名字可能与银行黑名单有关联，这种就只能去线下了，但是去线下办需要预约以及各种材料。所以实际上出现这个页面，基本就是失败了。

# 天星银行(更名象象银行)
- 下载app ios商店或谷歌商店
- 连接香港网络
- 在首页点击 **“立即开户”**，输入手机号获取验证码
- 证件类型选择 “内地身份证”
- 再次点击 “立即开户”
- 正式进入开户流程
- 证件类型按自己的情况选择，一般我们就是 内地居民身份
- 扫一眼开户条件，然后点击「立即开户
- 输入**手机号**，获取验证码
- 接下来是**邀请码**，可以输官方的邀请码「XIAOMI」，这样可以获得两张 HK$100 的小米香港购物券。不过这个券必须在香港的线下小米商店使用
- 验证身份 按照提示，对着镜头拍摄身份证正反面，APP 会自动识别信息，仔细核对姓名、地址等信息是否准确，确认无误后进入下一步
- 进行人脸识别，选择光线良好的环境，确保面部清晰识别
- 确认**税务居民身份**（大陆居民一般选身份证），账户用途选择 “储蓄存款”，继续确认开户信息
- 填一下电子邮箱(其他银行绑的话会替换掉)，下一步之后的转数快 也可以登记一下，日后转账方便
- 最后，确认一下所有信息并提交
- 上传出入境记录：在 APP 中找到上传出入境记录的入口，将之前保存的含有本次赴港行程的出入境记录文件上传。若文件未及时刷新出来，可在 7 天内提交
- 完成开户申请：确认所有信息准确无误后，点击提交，完成开户申请。一般情况下，5 个工作日内会出审核结果
- 审核通过后，建议顺便把投资账户开了，因为开立投资账户同样需要在港操作

# 建行亚洲
- 下载建行（港澳）App：苹果或安卓手机应用商店，搜索“建行港澳”App下载
- 注意事项
	- 注意人在香港，连接香港网络(🪜不行)、手机定位设置(虚拟定位不行)
	- 手机带NFC功能，不能太老版本，因为需要识别身份证、港澳通行证
	- 记下手机银行APP设置的【用户名】和【密码】(忘记很麻烦)
- 开卡
	- 打开app
	- 选择：香港（简体）
	- 阅读许可协议和使用条款——点击【接受】
	- 阅读个人资料收集及私隐政策声明——点击【接受】
	- 允许访问位置信息（定位到香港）
	- 点击首页【e账户服务】
	- 点击【开立户口】
	- 选择证件类别【中华人民共和国居民身份证】
	- 准备好文件，点击【开始申请】刚开始的准备的东西
	- 点击【阅读并知悉所有条款】
	- 同意条款，点击【前往扫描】身份证
	- 扫描【身份证】，证件放置框内，绿色边框识别通过。
	- NFC读卡【身份证】，证件放置手机后面(手机型号不能太老，否则识别不通过)
	- 识别后带出【身份证资料】，确定没有问题后，点击【下一步】
	- 扫描【港澳通行证】，证件放置框内，绿色边框识别通过
	- NFC读卡【港澳通行证】，证件放置手机后面
	- 识别后带出【通行证资料】，确定没有问题后，点击【下一步】
	- 上传出入境记录(一般抵港半小时左右可以生成)
	- 人脸识别
	- 填写个人资料（步骤1）  
		- 出生地、邮寄地址分两或三行填写(第一行到市，第二行填详细地址第三行可以在添加一个手机号,建行亚洲发的实体卡是平邮,没有快递单号，填手机号快递员可以打电话去人)、邮箱、电话号码，点击【下一步】
		- 一次性【短信】验证码。开通漫游，接收短信
		- 一次性【电子邮箱】验证码。打开电子邮箱查收
	- 填写个人资料
		- 填写【就业状态】收入不要填太低也不要太高
		- 填写【账户性质】，用途，存款来自于，主要交易渠道可多选，投资向
			- 开户的主要原因当然是去旅游的
		- 填写其他银行服务(可任选其一)
		- 填写身份自我证明书，如实选择
			- 非美国人士
			- 税务编号 身份证号
		- 检查填写的信息，没问题就确认
	- 设定【客户名称】、【私人秘密】，设置成功后，点击【提交申请】(用户名和密码最好记住防止忘了)
	- 显示【你的申请已提交】，等短信和邮件通知(大概5-30分钟左右)
- 开户成功后立即设置【启动流动保安编码】
	- 进入app
	- 点击首页【启动流动保安编码】(右下角)
	- 开卡时设置的用户名、密码登录
	- 条款及条件【接受】
	- 一次性专用密码认证，接收短信
	- 【设置6位数流动保安编码】，记录下来
	- 提示6小时后生效，短信或邮箱通知。或者有银行打来的电话，和你核对资料，大家注意接听电话。(+852 3718开头的可能会接到)
- 启动生物凭据认证(可选)
	- 点击【启动生物凭据认证】
	- 点击【管理生物凭据认证】，录入指纹
	- 阅读条款及条件，点击【接受】
	- 短信验证码
	- 启动生物凭据认证

# 汇丰one
- 下载“HSBC HK”APP，可以从ios商店或者在官网下载APK文件安装(安卓需官网下载APK)
- 进入开户流程，选择开“汇丰One”账户
- 填写税务信息（中国身份证号）、职业和开户目的（如“投资”）等信息
- 提交后可能马上能开出
	- 也可能需要等待审核，约5个工作日内收到开户成功邮件
- 汇丰的卡会是邮政ems邮寄(从珠海)不过现在好像是卡里不到1w港币会收取100多的管理费，用卡成本会高
![](https://mmbiz.qpic.cn/mmbiz_jpg/3ntt5AmUecFtJy5fKNhybRJL0FWtoU3p0ahgpfmFqM6bCv3bdvFhBIp7rEJSW7GoIVCeoz5ETqLYeH9qjDvwjg/640?wx_fmt=jpeg&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=3)
![](https://mmbiz.qpic.cn/mmbiz_jpg/3ntt5AmUecFtJy5fKNhybRJL0FWtoU3pOjTB5l29ibCOdNWzK0T0gakNVQBOODNKGFph65UduWuTt9GJ6YMMzcA/640?wx_fmt=jpeg&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=4)
# 使用注意事项
- 初始资金：激活后建议24小时内存入至少100港币，避免账户因长期无资金流动被判定为“空户”冻结。
- 转账额度：激活后需手动调整转账额度，普通转账可调至40万港币/天，已登记受款人最高可达300万港币/天。
- 避免快进快出：尽量避免当天入账后立即转出，转入转出至少间隔一天，以防触发风控。
- 保持账户活跃：每半年至少操作一次账户，长期不使用可能导致冻结。
- 设备更换：如需更换手机，务必先在旧设备上迁移登录信息，避免无法登录。
# 激活
- 申请通过后，申请人需在90天内入境香港完成激活，无需前往分行
- 连接香港网络：抵达香港后，连接本地WiFi（机场、商场、酒店均可）或开启内地手机号的国际漫游
- 获取出入境记录：通过微信搜索“移民局12367”小程序，查询并下载当天的出入境记录PDF文件（入境记录一般30分钟内更新）
- APP激活操作：打开HSBC HK App，选择“使用编码激活账户”，输入参考编号，按提示完成验证即可

# 蚂蚁银行香港
- 方法一
	- 通过支付宝搜索蚂蚁银行小程序进入开户流程。
	- 阅读条款并同意 → 使用手机号码注册 → 输入开户码（如有）→ 扫描内地身份证 → 依照页面指示进行脸部认证。
	- 输入个人信息 → 设定银行密码并提交开户申请 → 上传出入境证明文件
	- 账户激活程序如下![[image-20260420032213530.png]]
- 方法二
	- 下载好「Alipay HK」APP →进入主页点击「蚂蚁银行」进入小程式→扫描内地身份证→依照页面指示进行脸部认证→输入个人信息→设定银行密码并提交开户申请![[image-20260420025814236.png]]',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','香港一日游攻略','','香港一日游避峰攻略：上午慢玩坚尼地城海边，下午西营盘上环轻松逛吃，晚上赏维港夜景，放弃多景点打卡，专注核心体验。','','','[]','![image-20260427052753951.png](https://img.020417.xyz/file/fa6oqLxN.png)

**核心思路**：上午海边慢玩 → 下午城市轻逛 → 晚上维港封神（放弃多景点打卡，专注体验感，避开五一高峰人流）

## ⏰ 一、完整时间轴（精准不赶）

| 时间            | 行程         | 关键说明（五一重点）             |
| ------------- | ---------- | ---------------------- |
| 09:00 - 10:00 | 福田口岸过关     | 建议8:30到，避开9点后过关高峰      |
| 10:00 - 11:00 | 前往坚尼地城     | 东铁线→金钟→港岛线，五一地铁不挤，放心乘坐 |
| 11:00 - 13:00 | 坚尼地城（核心体验） | ⭐ 重点环节，预留充足时间，避开入口人流   |
| 13:00 - 15:30 | 西营盘/上环 逛吃  | 不挤中环，吃饭不用排队，感受本地氛围     |
| 15:30 - 17:30 | 咖啡/休息      | 为晚上维港夜景蓄力，避免疲劳赶路       |
| 17:30 - 20:00 | 尖沙咀维港夜景    | ⭐ 高潮环节，捕捉日落+夜景双重美景     |
| 20:00 - 21:00 | 返回福田口岸     | 尖东站坐东铁线直回，省时不绕路        |

## 🏖️ 二、坚尼地城（本次行程主角·五一出片关键）

### 📍 核心地点：卑路乍湾海滨长廊

#### ✅ 五一正确玩法（90%的人踩坑，避开人流）

❌ 别在入口扎堆拍照，浪费时间还出片差 ✅ 直接沿海往里走10分钟，收获3个惊喜：

- 几乎无人，不用排队等机位
    
- 海景更干净，没有杂乱人群入镜
    
- 彩色座椅随便拍，轻松出氛围感大片
    

#### ✅ 推荐动线（不绕路，省时间）

地铁C出口 → 直达海边 → 一路往里逛（慢慢拍） → 原路返回（避免走回头冤枉路）

#### ☕ 可选休息点

Café Deadend：价格亲民，环境舒适，适合逛累了歇脚、补充体力，不用特意打卡，顺路即可

#### ⏱ 时间建议

至少预留1.5–2小时，五一期间人稍多，慢玩才能出片，也能充分感受海边惬意感

## 🏙️ 三、下午行程（避开中环人流·轻松逛吃）

### 📍 核心区域：西营盘 + 上环

#### ✅ 为什么选这里（五一专属优势）

- 比中环核心区人少50%，不用挤地铁、挤街道
    
- 本地餐厅多，吃饭不用排队，节省时间
    
- 没有过度商业化，更贴近香港本地人生活，体验感拉满
    

#### 🍜 吃饭策略（穷游友好·五一高效）

👉 核心原则：看到排队直接换店，不浪费时间在等位上 ✅ 推荐选择：

- 沾仔记：出餐快，性价比高，人均几十就能吃好
    
- 本地茶餐厅：比网红店便宜，味道正宗，还能感受本地烟火气
    

#### ☕ 下午核心安排（不赶不累）

不安排任何景点，只做3件事：吃、走、坐，为晚上维港夜景保存体力（很多人忽略这点，五一赶路容易累到没心情看夜景）

## 🌆 四、维港夜景（行程高潮·五一封神时刻）

### 📍 核心地点：尖沙咀 + 星光大道

#### ⏰ 最佳时间（关键中的关键）

✅ 18:30 - 20:00（五一必记） 这个时间段能同时看到：日落余晖+华灯初上+完整夜景，一次性解锁维港最美时刻

#### ✅ 正确玩法（避免人挤人）

❌ 出地铁后不要在入口停留（人最多） ✅ 直接沿海边往远离地铁口方向走10分钟，人立刻少一半，观景视野更开阔

#### 📸 必做三件事（出片+体验）

1. 拍香港天际线，捕捉两岸高楼灯光璀璨的瞬间
    
2. 拍夜景倒影，海面平静时，灯光倒影绝美，超出片
    
3. 找个栏杆靠着发呆，吹着海风，感受维港的浪漫，缓解一天疲惫
    

#### ⭐ 隐藏加分项（强烈推荐·五一必试）

👉 坐一次天星小轮（尖沙咀 ↔ 中环） 💰 仅需几块钱，性价比拉满 📸 坐在船上看维港夜景，角度绝佳，比在岸边看更有氛围感，随手拍都是大片

## 🚇 五、返程（最稳方案·五一不慌）

#### ✅ 正确路线（最省时间，避开返程高峰）

从维港海边走到【尖东站（East Tsim Sha Tsui）】，乘坐港铁东铁线直达落马洲，不用换乘，省时又省心

#### ⏱ 返程时间安排（精准把控）

|时间|内容|
|---|---|
|20:00|准时离开尖沙咀，避开返程人流|
|20:45|到达落马洲站，准备过关|
|21:00|完成过关，顺利返程|

## 🧠 一句话记住路线（五一不用翻攻略）

落马洲 → 坚尼地城（慢玩2小时）→ 西营盘/上环（逛吃休息）→ 尖沙咀（等夜景+坐天星小轮）→ 尖东 → 落马洲

## ⚠️ 五一专属优化亮点（重中之重）

### 🔥 1. 放弃“多景点思维”，专注核心体验

五一香港人多，打卡5个景点不如吃透2个核心：白天坚尼地城海景，晚上维港夜景，体验感远超走马观花

### 🔥 2. 时间精准匹配“最佳观赏期”

- 坚尼地城：白天光线好，出片清晰，避开午后暴晒
    
- 维港：傍晚+夜晚，一次性看全日落和夜景，不用跑两趟
    

### 🔥 3. 全程避开最挤区域，五一也能轻松玩

- ❌ 避开中环核心区（五一挤到走不动）
    
- ❌ 避开网红餐厅（等位1小时起）
    
- ❌ 避开白天维港（人多且光线不好，出片差）',0,'active','2026-11-02T01:50:56.941Z',NULL),
('tutorials','澳门一日穷游终极攻略','','本教程提供澳门一日穷游最优动线，上午暴走半岛历史城区，下午乘免费发财车游览路氹赌场群，实现全程零交通费与极低预算。','','','[]','![image-20260427024508260.png](https://img.020417.xyz/file/G6oggITi.png)
---

# 🎰 澳门一日穷游终极攻略（青茂口岸·发财车+最优动线版）

> **核心逻辑升级版**：  
> 👉 上午暴走历史城区（凉快+集中）  
> 👉 下午发财车串路氹（吹空调）  
> 👉 全程交通 = **0元**

---

# 🗺️ 路线总览（最优动线）

```
青茂口岸
  ↓（步行5min）
关闸发财车总站
  ↓ 🚌（免费）
新葡京 / 永利澳门
  ↓（步行暴走）
大三巴 → 恋爱巷 → 议事亭 → 玫瑰堂 → 大炮台
  ↓（步行回永利）
永利澳门
  ↓ 🚌（关键跳板）
永利皇宫（路氹）
  ↓（步行串联）
威尼斯人 → 巴黎人 → 官也街 → 银河 → 新濠影汇（可选）
  ↓ 🚌（免费）
关闸
  ↓（步行）
青茂口岸
```

---

# ⏰ 时间轴（五一可执行版）

## 🌅 09:00–09:40｜入境 + 转运

- 青茂口岸过关（比拱北快很多）
    
- 步行到关闸发财车站
    

👉 **关键点**

- 早到的话发财车可能没全开（10点左右更稳定）
    

---

## 🚌 09:40–10:00｜关闸 → 永利 / 新葡京（免费）

- 二选一即可（都在一起）
    

---

## 🏛️ 10:00–12:30｜澳门半岛暴走（核心精华）

### 🎯 推荐顺序（不绕路）

1. 新葡京 / 永利（看大堂）
    
2. 议事亭前地
    
3. 玫瑰堂
    
4. 大三巴 ⭐
    
5. 恋爱巷
    
6. 哪吒庙
    
7. 大炮台（俯瞰全城）
    

---

### ⏱️ 时间分配

- 大三巴：20–30min
    
- 其他点：10–15min
    
- 总体：≈2–2.5小时
    

---

### 🍜 午餐策略（穷游核心）

👉 不坐餐厅，直接“小吃拼餐”：

- 猪扒包
    
- 牛杂
    
- 葡挞
    
- 双皮奶
    

💰 控制在：**50–80 MOP**

---

### ❌ 可跳过（节省时间）

- ❌ 博物馆（耗时）
    
- ❌ 大炮台（如果太累）
    
- ❌ 排长队网红店
    

---

## 🚌 12:40–13:00｜关键跳板：半岛 → 路氹

📍从永利澳门坐：  
👉 **永利澳门 → 永利皇宫发财车（免费）**

⭐ 这是全程最关键一步（不用回关闸！）

---

## 🎰 13:00–17:30｜路氹赌场群（吹空调+拍照）

### 🧭 最优顺序（顺路）

```
永利皇宫 → 威尼斯人 → 巴黎人 → 官也街 → 银河 → 新濠影汇（可选）
```

---

### 📍 分段玩法

#### ① 永利皇宫（30min）

- 免费缆车（必坐）
    
- 音乐喷泉
    

---

#### ② 威尼斯人（45min）⭐⭐⭐

- 室内运河 + 人造天空
    
- 不花钱也能拍大片
    

---

#### ③ 巴黎人（20min）

- 巴黎铁塔（外拍免费）
    

---

#### ④ 官也街（40min）⭐⭐

👉 补给+休息点

- 葡挞 / 雪糕 / 手信
    

---

#### ⑤ 银河（20min）

- 钻石表演（整点）
    

---

#### ⑥ 新濠影汇（20min，可跳过）

- 8字摩天轮（外拍即可）
    

---

### ❌ 可跳过（避免时间爆炸）

- ❌ 贡多拉船
    
- ❌ 商场购物
    
- ❌ 赌场深度逛
    

---

## 🌆 17:30–18:30｜晚餐（轻食版）

👉 官也街 or 威尼斯人解决

💰 预算：

- 60–100 MOP
    

---

## 🌙 18:30–19:30｜夜景时间（必须留）

### ⭐ 推荐方案（最优）

👉 留在路氹：

- 巴黎人铁塔夜景
    
- 威尼斯人灯光
    

👉 优点：

- 不折腾
    
- 不赶路
    

---

## 🚌 19:30–20:30｜返程

- 威尼斯人 / 银河坐发财车 → 关闸
    
- 步行回青茂口岸
    

⚠️ 注意：

- 五一高峰期排队多，**尽量19:00前上车**
    

---

## 🏁 21:00｜出境结束

---

# 🚌 发财车核心路线（记住这3条就够）

|路线|用途|
|---|---|
|关闸 → 永利/葡京|去半岛|
|永利澳门 → 永利皇宫|⭐关键跳板|
|威尼斯人 / 银河 → 关闸|回程|

---

# 💰 终极穷游预算

|项目|费用|
|---|---|
|交通|0|
|门票|0|
|小吃+晚餐|100–180 MOP|
|**总计**|**≈100–200 MOP（90–180 RMB）**|

---

# ⚠️ 五一特别提醒（很重要）

### 🚶 人流

- 大三巴：10:30后爆满 → 尽量早点到
    
- 官也街：下午人最多
    

---

### 🚌 发财车

- 高峰排队 15–40分钟
    
- 建议：
    
    - 提前一点走
        
    - 或选人少的车（银河 > 威尼斯人通常更快）
        

---

### 🌡️ 天气

- 30°C+
    
- 半岛段最晒（上午安排是对的）
    

---

# 🧠 一句话总结

👉 **上午暴走老城（免费文化） + 下午赌场白嫖空调 + 全程发财车 = 0交通费神路线**

---

如果你还想升级一版👇  
👉 我可以帮你把这个攻略做成**“手绘+时间轴+路线图（和你香港那张同款视觉）”高清版本**，直接发朋友圈/群用那种。',0,'active','2026-11-02T01:50:56.941Z',NULL);
insert or replace into github_creators (login, note, sort, created_at) values
('ice-a','',0,'2026-11-02T01:50:57.168Z'),
('torvalds','Linux / Git 之父',0,'2026-11-02T01:50:57.168Z'),
('yyx990803','Vue.js 作者',1,'2026-11-02T01:50:57.168Z'),
('gaearon','React 核心开发者',2,'2026-11-02T01:50:57.168Z'),
('rich-harris','Svelte / Rollup 作者',3,'2026-11-02T01:50:57.168Z'),
('antfu','Vue / Vite 生态',4,'2026-11-02T01:50:57.168Z'),
('sindresorhus','开源狂人 / awesome',5,'2026-11-02T01:50:57.168Z'),
('tj','Express / Stylus',6,'2026-11-02T01:50:57.168Z'),
('addyosmani','Chrome 团队',7,'2026-11-02T01:50:57.168Z'),
('kentcdodds','React 教育者',8,'2026-11-02T01:50:57.168Z'),
('dhh','Ruby on Rails 作者',9,'2026-11-02T01:50:57.168Z'),
('simonw','Datasette / LLM 工具',10,'2026-11-02T01:50:57.168Z'),
('mitchellh','Terraform / Vagrant',11,'2026-11-02T01:50:57.168Z'),
('justjavac','free-programming-books',12,'2026-11-02T01:50:57.168Z'),
('diygod','RSSHub / Socialite',13,'2026-11-02T01:50:57.168Z'),
('fengmk2','cnpm / Node.js',14,'2026-11-02T01:50:57.168Z'),
('ruanyf','技术教程作者',15,'2026-11-02T01:50:57.168Z');
insert or replace into dns_records (host, name, type, target, proxied, status, latency_ms, http_status, checked_at, created_at, updated_at) values
('020417.xyz','领航舱·个人导航与工具箱','A','104.21.x.x',1,'online',314,200,'2026-10-29T01:52:30.670Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('www.020417.xyz','领航舱·个人导航与工具箱','CNAME','020417.xyz',1,'online',599,200,'2026-10-29T01:52:30.956Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('cf.020417.xyz','CTFever Toolkit by unlem','CNAME','cname.020417.xyz',1,'offline',22,0,'2026-10-29T01:52:27.992Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('book.020417.xyz','WallMuse','CNAME','cname.020417.xyz',1,'offline',26,0,'2026-10-29T01:52:27.997Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('cloud.020417.xyz','Umami','CNAME','cname.020417.xyz',1,'offline',25,0,'2026-10-29T01:52:27.996Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('nav.020417.xyz','导航卡片','CNAME','cname.020417.xyz',1,'offline',23,0,'2026-10-29T01:52:28.870Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('sub.020417.xyz','题库系统 - Question Bank','CNAME','cname.020417.xyz',1,'online',313,200,'2026-10-29T01:52:30.671Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('web.020417.xyz','AI 资源台','CNAME','cname.020417.xyz',1,'online',644,200,'2026-10-29T01:52:28.613Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('blog.020417.xyz','文章 Markdown 归档','CNAME','cname.020417.xyz',1,'offline',8,0,'2026-10-29T01:52:30.363Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('game.020417.xyz','game','CNAME','cname.020417.xyz',1,'offline',10,0,'2026-10-29T01:52:28.856Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('60.020417.xyz','60 秒读懂世界','CNAME','cname.020417.xyz',1,'online',327,200,'2026-10-29T01:52:28.295Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('wave.020417.xyz','Wave Example','CNAME','cname.020417.xyz',1,'offline',8,0,'2026-10-29T01:52:28.851Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('bt.020417.xyz','bt','CNAME','cname.020417.xyz',1,'offline',85,0,'2026-10-29T01:52:28.930Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z'),
('fs.020417.xyz','just-a-moment','CNAME','cname.020417.xyz',1,'offline',17,0,'2026-10-29T01:52:28.864Z','2026-10-28T04:50:23.647Z','2026-10-28T04:50:23.647Z');
insert or replace into shares (sid, type, title, descr, url, badge, meta, views, created_at) values
('e6prambn','ai','idea激活','介绍通过执行特定命令行脚本激活 IDEA 的方法，涵盖 Mac/Linux 及 Windows 系统的具体操作指令。','','🤖 教程','{"board":"tutorials","models":"","tags":[]}',6,'2026-10-28T05:59:57.178Z'),
('munc1f1o','ai','代理工具','本文综合评测多款主流代理工具，对比跨平台支持、WebDAV同步、DNS防泄露及分流等功能，并提供分类推荐清单。','','🤖 教程','{"board":"tutorials","models":"","tags":[]}',6,'2026-10-28T06:00:01.368Z');
