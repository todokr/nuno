/**
 * GitHub API のレスポンスを表す型とパース処理。
 * Dart 版の pull_request_response / pull_request_detail_response /
 * pull_reqeust_commits_response / pull_request_reviews_response に対応する。
 */

/** PR 一覧 (GET /pulls) の 1 要素。 */
export interface PullRequestResponse {
  title: string;
  authorId: number;
  authorLogin: string;
  number: number;
  url: string;
  createdAt: Date;
  mergedAt: Date | null;
  state: string;
}

export function parsePullRequestResponse(githubResponse: any): PullRequestResponse {
  return {
    title: githubResponse.title,
    authorId: githubResponse.user.id,
    authorLogin: githubResponse.user.login,
    number: githubResponse.number,
    url: githubResponse.html_url,
    createdAt: new Date(githubResponse.created_at),
    mergedAt: githubResponse.merged_at != null ? new Date(githubResponse.merged_at) : null,
    state: githubResponse.state,
  };
}

/** PR 詳細 (GET /pulls/:number)。 */
export interface PullRequestDetailResponse {
  commits: number;
  additions: number;
  deletions: number;
  changedFiles: number;
}

export function parsePullRequestDetailResponse(githubResponse: any): PullRequestDetailResponse {
  return {
    commits: githubResponse.commits,
    additions: githubResponse.additions ?? 0,
    deletions: githubResponse.deletions ?? 0,
    changedFiles: githubResponse.changed_files,
  };
}

/** コミット 1 件。 */
export interface CommitResponse {
  date: Date | null;
}

/** PR のコミット一覧 (GET /pulls/:number/commits)。 */
export class PullRequestCommitsResponse {
  constructor(readonly commits: CommitResponse[]) {}

  /** 最も古いコミットを返す。コミットが無ければ null。 */
  oldest(): CommitResponse | null {
    if (this.commits.length === 0) return null;
    return this.commits.reduce((a, b) => {
      if (a.date == null) return b;
      if (b.date == null) return a;
      return a.date < b.date ? a : b;
    });
  }
}

export function parsePullRequestCommitsResponse(jsonBody: any[]): PullRequestCommitsResponse {
  const commits = jsonBody.map((c) => {
    const rawDate = c.commit?.author?.date;
    return { date: rawDate != null ? new Date(rawDate) : null } satisfies CommitResponse;
  });
  return new PullRequestCommitsResponse(commits);
}

/** レビュー 1 件。 */
export interface ReviewResponse {
  reviewerId: number;
  date: Date | null;
  state: string;
}

/** PR のレビュー一覧 (GET /pulls/:number/reviews)。 */
export class PullRequestReviewsResponse {
  constructor(
    readonly pullRequestAuthorId: number,
    readonly reviews: ReviewResponse[],
  ) {}

  /** 作者以外による最も古いレビュー（最初の反応）を返す。 */
  oldestReaction(): ReviewResponse | null {
    const others = this.reviews.filter((r) => r.reviewerId !== this.pullRequestAuthorId);
    if (others.length === 0) return null;
    return others.reduce((a, b) => {
      if (a.date == null) return b;
      if (b.date == null) return a;
      return a.date < b.date ? a : b;
    });
  }

  /**
   * レビューの往復回数。作者以外による CHANGES_REQUESTED (変更要求) の件数を数える。
   * 0 なら修正のやり直しが発生しなかった「一発承認」を意味する。
   */
  reviewRounds(): number {
    return this.reviews.filter(
      (r) => r.reviewerId !== this.pullRequestAuthorId && r.state === 'CHANGES_REQUESTED',
    ).length;
  }

  /** 作者以外による最新の APPROVED レビューを返す。 */
  latestApproval(): ReviewResponse | null {
    const others = this.reviews.filter(
      (r) => r.reviewerId !== this.pullRequestAuthorId && r.state === 'APPROVED',
    );
    if (others.length === 0) return null;
    return others.reduce((a, b) => {
      if (a.date == null) return b;
      if (b.date == null) return a;
      return a.date > b.date ? a : b;
    });
  }
}

export function parsePullRequestReviewsResponse(
  jsonBody: any[],
  authorId: number,
): PullRequestReviewsResponse {
  const reviews = jsonBody.map((c) => {
    const rawDate = c.submitted_at;
    return {
      reviewerId: c.user.id,
      date: rawDate != null ? new Date(rawDate) : null,
      state: c.state,
    } satisfies ReviewResponse;
  });
  return new PullRequestReviewsResponse(authorId, reviews);
}

/**
 * GraphQL の closingIssuesReferences.nodes から、PR にリンクされた issue のうち
 * 最も古い createdAt を返す。リンクが無ければ null。
 * 複数 issue がリンクされている場合は最古を「起点の課題」とみなす。
 */
export function parseLinkedIssueResponse(nodes: any[] | null | undefined): Date | null {
  if (nodes == null || nodes.length === 0) return null;
  const dates = nodes
    .map((n) => (n?.createdAt != null ? new Date(n.createdAt) : null))
    .filter((d): d is Date => d != null);
  if (dates.length === 0) return null;
  return dates.reduce((a, b) => (a < b ? a : b));
}
