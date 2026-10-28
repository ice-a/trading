/**
 * 60s API（https://60.020417.xyz）端点清单与渲染规格。
 *
 * 按业务只保留 5 个分类共 19 个端点：
 *   热搜榜 9 / 科技资讯 6 / 生活服务 1（历史上的今天）/ 音乐 1 / 每日简报 2
 *
 * 每个端点声明一种 render：
 *   list   → 榜单/资讯列表
 *   fields → 键值对
 *   text   → 单段文本
 *   image  → 图片
 */

export type FeedCategory = 'hot' | 'info'
export type FeedRender = 'list' | 'fields' | 'text' | 'image'

export interface FeedSpec {
  /** 唯一 key，用于路由 /v2/[key] 与数据库主键 */
  key: string
  /** 上游路径（含 /v2 前缀） */
  path: string
  title: string
  /** 卡片副标题 */
  desc?: string
  category: FeedCategory
  render: FeedRender
  /** 数组挂在对象下时的字段路径 */
  listPath?: string
  /** 列表项字段映射 */
  map?: {
    title?: string
    desc?: string
    value?: string
    link?: string
    cover?: string
    badge?: string
  }
  /** text 渲染取哪个字段 */
  textField?: string
  textSubField?: string
  /** 卡片内最多展示多少条（默认 10） */
  previewCount?: number
}

export const CATEGORIES: Array<{ key: FeedCategory; label: string; icon: string }> = [
  { key: 'hot', label: '热搜榜', icon: '🔥' },
  { key: 'info', label: '资讯速览', icon: '📰' }
]

export const FEEDS: FeedSpec[] = [
  // ===== 热搜榜 =====
  { key: 'weibo', path: '/v2/weibo', title: '微博热搜', desc: '实时热搜榜', category: 'hot', render: 'list',
    map: { title: 'title', value: 'hot_value', link: 'link' } },
  { key: 'zhihu', path: '/v2/zhihu', title: '知乎热榜', desc: '全站热门问题', category: 'hot', render: 'list',
    map: { title: 'title', desc: 'detail', value: 'hot_value_desc', link: 'link' } },
  { key: 'douyin', path: '/v2/douyin', title: '抖音热搜', desc: '抖音热榜', category: 'hot', render: 'list',
    map: { title: 'title', value: 'hot_value', link: 'link', cover: 'cover' } },
  { key: 'bili', path: '/v2/bili', title: 'B站热搜', desc: '哔哩哔哩热搜', category: 'hot', render: 'list',
    map: { title: 'title', link: 'link' } },
  { key: 'toutiao', path: '/v2/toutiao', title: '头条热榜', desc: '今日头条', category: 'hot', render: 'list',
    map: { title: 'title', value: 'hot_value', link: 'link', cover: 'cover' } },
  { key: 'baidu-hot', path: '/v2/baidu/hot', title: '百度热搜', desc: '百度实时热搜', category: 'hot', render: 'list',
    map: { title: 'title', desc: 'desc', value: 'score_desc', link: 'url', cover: 'cover', badge: 'type_desc' } },
  { key: 'baidu-tieba', path: '/v2/baidu/tieba', title: '贴吧热议', desc: '贴吧热门话题', category: 'hot', render: 'list',
    map: { title: 'title', desc: 'desc', value: 'score_desc', link: 'url' } },
  { key: 'rednote', path: '/v2/rednote', title: '小红书热榜', desc: '小红书热搜', category: 'hot', render: 'list',
    map: { title: 'title', value: 'score', link: 'link', badge: 'word_type' } },
  { key: 'quark', path: '/v2/quark', title: '夸克热点', desc: '夸克热搜榜', category: 'hot', render: 'list',
    map: { title: 'title', desc: 'summary', link: 'link', badge: 'category' } },

  // ===== 科技资讯 =====
  { key: 'ai-news', path: '/v2/ai-news', title: 'AI 每日资讯', desc: 'AI 行业动态', category: 'info', render: 'list',
    listPath: 'news', map: { title: 'title', desc: 'detail', link: 'link' }, previewCount: 6 },
  { key: 'it-news', path: '/v2/it-news', title: 'IT 资讯', desc: '科技新闻流', category: 'info', render: 'list',
    map: { title: 'title', desc: 'description', link: 'link' } },
  { key: 'it-news-rank', path: '/v2/it-news/rank', title: 'IT 资讯榜', desc: '热度排行', category: 'info', render: 'list',
    map: { title: 'title', link: 'link' } },
  { key: 'hn-top', path: '/v2/hacker-news/top', title: 'Hacker News 热门', desc: 'HN Top', category: 'info', render: 'list',
    map: { title: 'title', value: 'score', link: 'link', badge: 'author' } },
  { key: 'hn-new', path: '/v2/hacker-news/new', title: 'Hacker News 最新', desc: 'HN New', category: 'info', render: 'list',
    map: { title: 'title', value: 'score', link: 'link', badge: 'author' } },
  { key: 'hn-best', path: '/v2/hacker-news/best', title: 'Hacker News 最佳', desc: 'HN Best', category: 'info', render: 'list',
    map: { title: 'title', value: 'score', link: 'link', badge: 'author' } },

  // ===== 生活服务（仅保留历史上的今天）=====
  { key: 'history-today', path: '/v2/today-in-history', title: '历史上的今天', desc: '当天历史事件', category: 'info', render: 'list',
    listPath: 'items', map: { title: 'title', desc: 'description', value: 'year', link: 'link' } },

  // ===== 音乐 =====
  { key: 'ncm-rank', path: '/v2/ncm-rank', title: '网易云音乐榜', desc: '官方榜单索引', category: 'info', render: 'list',
    map: { title: 'name', desc: 'description', value: 'update_frequency', cover: 'cover' } },

  // ===== 每日简报 =====
  { key: 'daily-60s', path: '/v2/60s', title: '每天 60 秒读懂世界', desc: '今日新闻速览', category: 'info', render: 'list',
    listPath: 'news', map: { title: 'self' }, previewCount: 15 },
  { key: 'bing-wallpaper', path: '/v2/bing', title: '必应每日壁纸', desc: '今日 Bing 壁纸', category: 'info', render: 'image',
    textField: 'cover', textSubField: 'copyright', map: { title: 'headline', desc: 'description' } }
]

export function feedByKey(key: string): FeedSpec | undefined {
  return FEEDS.find((f) => f.key === key)
}

export { FEEDS as default }
