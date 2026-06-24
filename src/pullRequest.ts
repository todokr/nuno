import type {
  PullRequestResponse,
  PullRequestDetailResponse,
  PullRequestCommitsResponse,
  PullRequestReviewsResponse,
} from './responses.js';

/**
 * 集計済みの PR 1 件。out.json に書き出され、web フロント側で読み込まれる。
 * Dart 版の freezed クラス PullRequest に対応する。
 * 日付フィールドは JSON.stringify 時に Date.toJSON()（ISO8601）でシリアライズされる。
 */
export interface PullRequest {
  title: string;
  url: string;
  oldestCommitDate: Date | null;
  createdAt: Date;
  oldestReactionDate: Date | null;
  latestApprovalDate: Date | null;
  mergedAt: Date | null;
  issueCreatedAt: Date | null;
  commits: number;
  additions: number;
  deletions: number;
  changedFiles: number;
  reviewRounds: number;
  state: string;
  moduleName: string | null;
  changeType: string | null;
}

interface ParsedTitle {
  title: string;
  module: string | null;
  type: string | null;
}

const TITLE_PAREN_PATTERN = /\(|\)/g;
const TITLE_REGEXP = /(\w+)(\(\w+\))?: (.+)/;

/** `type(module): title` 形式の PR タイトルを分解する。マッチしなければ title のみ。 */
function parsePrTitle(rawTitle: string): ParsedTitle {
  const result = TITLE_REGEXP.exec(rawTitle);
  if (result == null) {
    return { title: rawTitle, module: null, type: null };
  }
  return {
    title: result[3],
    module: result[2] != null ? result[2].replace(TITLE_PAREN_PATTERN, '') : null,
    type: result[1],
  };
}

/** 各種レスポンスを 1 件の集計済み PullRequest にまとめる。 */
export function buildPullRequest(
  pr: PullRequestResponse,
  detail: PullRequestDetailResponse,
  commits: PullRequestCommitsResponse,
  reviews: PullRequestReviewsResponse,
  issueCreatedAt: Date | null,
): PullRequest {
  const parsedTitle = parsePrTitle(pr.title);
  const oldestCommit = commits.oldest();
  const oldestReaction = reviews.oldestReaction();
  const latestApproval = reviews.latestApproval();

  return {
    title: parsedTitle.title,
    url: pr.url,
    oldestCommitDate: oldestCommit?.date ?? null,
    createdAt: pr.createdAt,
    oldestReactionDate: oldestReaction?.date ?? null,
    latestApprovalDate: latestApproval?.date ?? null,
    mergedAt: pr.mergedAt,
    issueCreatedAt,
    commits: detail.commits,
    additions: detail.additions,
    deletions: detail.deletions,
    changedFiles: detail.changedFiles,
    reviewRounds: reviews.reviewRounds(),
    state: pr.state,
    moduleName: parsedTitle.module,
    changeType: parsedTitle.type,
  };
}
