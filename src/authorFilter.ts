/**
 * 集計対象とする作者の絞り込み。
 * TARGET_AUTHORS で指定した GitHub ユーザー名 (login) の PR のみを対象とする。
 */

export interface AuthorFilter {
  /** 絞り込み対象の login 集合（小文字化済み）。空なら全員対象。 */
  readonly logins: ReadonlySet<string>;
  /** 指定 login が集計対象かどうかを返す。 */
  isTarget(login: string): boolean;
}

/**
 * 環境変数の値（カンマ区切り文字列）から AuthorFilter を構築する。
 * 未指定・空文字なら全員を対象とする。大文字小文字は区別しない。
 */
export function buildAuthorFilter(rawValue: string | undefined): AuthorFilter {
  const logins = new Set(
    (rawValue ?? '')
      .split(',')
      .map((a) => a.trim().toLowerCase())
      .filter((a) => a.length > 0),
  );
  return {
    logins,
    isTarget(login: string): boolean {
      return logins.size === 0 || logins.has(login.toLowerCase());
    },
  };
}
