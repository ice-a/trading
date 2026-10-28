/**
 * 带 TTL 的数据缓存 composable。
 *
 * 解决的问题：Nuxt 的 useAsyncData 在**客户端路由导航**时会重新执行 fetcher，
 * 所以「/v2 → / → /v2」每切一次就打一遍接口，页面要等几百毫秒才出内容。
 *
 * 这里在模块作用域维护一份内存缓存，配合 useAsyncData 的两个能力：
 *   getCachedData → 命中且未过期时**直接返回**，连 fetcher 都不执行（不闪烁、不发请求）
 *   lazy          → 未命中时也不阻塞渲染，先出骨架屏，数据后到
 */

interface CacheEntry<T> {
  at: number
  data: T
}

const store = new Map<string, CacheEntry<unknown>>()

/** 清空缓存（手动刷新时用） */
export function clearDataCache(prefix = ''): void {
  if (!prefix) {
    store.clear()
    return
  }
  for (const k of [...store.keys()]) {
    if (k.startsWith(prefix)) store.delete(k)
  }
}

export function peekDataCache<T>(key: string, ttl: number): T | undefined {
  const hit = store.get(key) as CacheEntry<T> | undefined
  if (!hit) return undefined
  if (Date.now() - hit.at > ttl) return undefined
  return hit.data
}

export function useCachedData<T>(
  keyFn: () => string,
  fetcher: (key: string) => Promise<T>,
  options: { ttl?: number; lazy?: boolean } = {}
) {
  const ttl = options.ttl ?? 60_000
  const key = computed(keyFn)

  const { data, pending, error, refresh, status } = useAsyncData<T>(
    key,
    async () => {
      const k = key.value
      const hit = peekDataCache<T>(k, ttl)
      if (hit !== undefined) return hit

      const fresh = await fetcher(k)
      store.set(k, { at: Date.now(), data: fresh })
      return fresh
    },
    {
      /**
       * 默认非 lazy：命中缓存时同步返回，组件立即渲染；
       * 未命中时最多等一次接口（预热后 2~20ms），保证 Suspense 正常 resolve。
       */
      lazy: options.lazy ?? false,
      getCachedData: (k, nuxtApp) => {
        /**
         * 第一优先级：SSR 传下来的 payload。
         *
         * 这一步绝不能省。自定义 getCachedData 会覆盖 Nuxt 默认的 payload 恢复逻辑，
         * 如果只查内存缓存，客户端 hydration 时拿不到首屏数据、先渲染成空态，
         * 与 SSR 输出不一致 → hydration mismatch → Vue 重排 DOM
         * （表现为首次打开时表格底部那行说明文字被挤成窄条）。
         */
        const payloadData = (nuxtApp as { payload?: { data?: Record<string, unknown> } })?.payload?.data
        if (payloadData && payloadData[k] !== undefined) {
          // 顺手塞进内存缓存，供后续页内导航命中
          if (!store.has(k)) store.set(k, { at: Date.now(), data: payloadData[k] as T })
          return payloadData[k] as T
        }

        // 第二优先级：客户端内存缓存（页内导航复用）
        return peekDataCache<T>(k, ttl)
      }
    }
  )

  return { data, pending, error, refresh, status }
}
