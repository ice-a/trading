/**
 * 一言客户端 —— 静态站没有后端代理，浏览器直连 v1.hitokoto.cn（支持 CORS）。
 * 网络失败时用内置短句兜底，保证顶栏永不空白。
 */
export interface Quote {
  text: string
  from: string
  source: 'remote' | 'local'
}

const FALLBACK: Quote[] = [
  { text: '但凡不能杀死你的，最终都会使你更强大。', from: '尼采', source: 'local' },
  { text: '路漫漫其修远兮，吾将上下而求索。', from: '屈原', source: 'local' },
  { text: '千里之行，始于足下。', from: '老子', source: 'local' },
  { text: '种一棵树最好的时间是十年前，其次是现在。', from: '佚名', source: 'local' },
  { text: '保持热爱，奔赴山海。', from: '佚名', source: 'local' }
]

interface HitokotoApi {
  hitokoto?: string
  from?: string
  from_who?: string
}

export async function fetchHitokoto(): Promise<Quote> {
  try {
    const res = await $fetch<HitokotoApi>('https://v1.hitokoto.cn/', {
      query: { c: 'd', encode: 'json' },
      timeout: 8000
    })
    if (res?.hitokoto) {
      return {
        text: res.hitokoto,
        from: res.from_who || res.from || '一言',
        source: 'remote'
      }
    }
  } catch {
    /* 落到本地兜底 */
  }
  return FALLBACK[Math.floor(Math.random() * FALLBACK.length)]!
}
