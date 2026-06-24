/**
 * 日付ユーティリティ。Dart 版で利用していた `dart_date` の
 * startOfMonth / subMonths / format("yyyy-MM") 相当をローカルタイムで実装する。
 */

/** その月の 1 日 00:00:00.000（ローカルタイム）を返す。 */
export function startOfMonth(date: Date): Date {
  return new Date(date.getFullYear(), date.getMonth(), 1, 0, 0, 0, 0);
}

/** 指定した月数だけ前にずらした日付を返す（日付は月初に丸めない）。 */
export function subMonths(date: Date, amount: number): Date {
  const result = new Date(date.getTime());
  result.setMonth(result.getMonth() - amount);
  return result;
}

/** `yyyy-MM` 形式の文字列に整形する。 */
export function formatYearMonth(date: Date): string {
  const year = date.getFullYear().toString().padStart(4, '0');
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  return `${year}-${month}`;
}
