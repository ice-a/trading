import { listDays } from '../utils/store'
import { dayKeyOf, humanDay } from '../utils/date'

/** GET /api/days —— 有数据的日期列表（用于历史数据切换） */
export default defineEventHandler(async () => {
  const cfg = appConfig()
  const today = dayKeyOf(new Date(), cfg.timezone)
  const days = await listDays(120)
  return {
    today,
    days: days.map((d) => ({
      ...d,
      isToday: d.date === today,
      label: d.date === today ? `今天 · ${humanDay(d.date, cfg.timezone)}` : humanDay(d.date, cfg.timezone)
    }))
  }
})
