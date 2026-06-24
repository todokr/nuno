import {
  parsePullRequestResponse,
  parsePullRequestDetailResponse,
  parsePullRequestCommitsResponse,
  parsePullRequestReviewsResponse,
  parseLinkedIssueResponse,
  PullRequestCommitsResponse,
  PullRequestReviewsResponse,
  type PullRequestResponse,
  type PullRequestDetailResponse,
} from './responses.js';

// PR にリンクされた issue (closing issue) を取得する GraphQL クエリ。
const LINKED_ISSUE_QUERY = `query($owner:String!,$repo:String!,$number:Int!){
  repository(owner:$owner,name:$repo){
    pullRequest(number:$number){
      closingIssuesReferences(first:10){ nodes{ number createdAt } }
    }
  }
}`;

interface ParsedResult<T> {
  values: T[];
  hasNext: boolean;
}

type ResProcessor<T> = (body: any, limitDate: Date) => ParsedResult<T>;

/** GitHub REST API クライアント。Dart 版の GitHubClient に対応する。 */
export class GitHubClient {
  constructor(
    private readonly token: string,
    private readonly org: string,
    private readonly repo: string,
  ) {}

  private get header(): Record<string, string> {
    return { Authorization: `token ${this.token}` };
  }

  private async getJson(url: string): Promise<{ body: any; linkHeader: string | null }> {
    const res = await fetch(url, { headers: this.header });
    const body = await res.json();
    return { body, linkHeader: res.headers.get('link') };
  }

  // GraphQL API に POST する。GraphQL は HTTP 200 でも errors を返すため body を検査する。
  private async postGraphql(query: string, variables: Record<string, unknown>): Promise<any> {
    const res = await fetch('https://api.github.com/graphql', {
      method: 'POST',
      headers: { ...this.header, 'Content-Type': 'application/json' },
      body: JSON.stringify({ query, variables }),
    });
    const json: any = await res.json();
    if (json.errors) {
      throw new Error(`GraphQL error: ${JSON.stringify(json.errors)}`);
    }
    return json.data;
  }

  /** limitDate より後に作成されたクローズ済み PR を新しい順にページングしながら列挙する。 */
  async *listPullRequests(limitDate: Date): AsyncGenerator<PullRequestResponse> {
    const startUrl =
      `https://api.github.com/repos/${this.org}/${this.repo}/pulls` +
      `?per_page=100&state=close&sort=created&direction=desc`;
    yield* this.list<PullRequestResponse>(startUrl, limitDate, (body) =>
      this.pullRequestProcessor(body, limitDate),
    );
  }

  async fetchPullRequest(number: number): Promise<PullRequestDetailResponse> {
    const url = `https://api.github.com/repos/${this.org}/${this.repo}/pulls/${number}`;
    console.log(`fetching: ${url}`);
    const { body } = await this.getJson(url);
    return parsePullRequestDetailResponse(body);
  }

  async fetchCommits(number: number): Promise<PullRequestCommitsResponse> {
    const url = `https://api.github.com/repos/${this.org}/${this.repo}/pulls/${number}/commits?per_page=100`;
    console.log(`fetching: ${url}`);
    const { body } = await this.getJson(url);
    return parsePullRequestCommitsResponse(body as any[]);
  }

  async fetchReviews(number: number, authorId: number): Promise<PullRequestReviewsResponse> {
    const url = `https://api.github.com/repos/${this.org}/${this.repo}/pulls/${number}/reviews?per_page=100`;
    console.log(`fetching: ${url}`);
    const { body } = await this.getJson(url);
    return parsePullRequestReviewsResponse(body as any[], authorId);
  }

  // PR にリンクされた issue のうち最古の作成日時を返す。リンクが無い・失敗時は null。
  // 1 件の失敗で全体を止めないよう、エラーは握りつぶして null を返す。
  async fetchLinkedIssue(number: number): Promise<Date | null> {
    console.log(`fetching(graphql): linked issue of #${number}`);
    try {
      const data = await this.postGraphql(LINKED_ISSUE_QUERY, {
        owner: this.org,
        repo: this.repo,
        number,
      });
      const nodes = data?.repository?.pullRequest?.closingIssuesReferences?.nodes;
      return parseLinkedIssueResponse(nodes);
    } catch (err) {
      console.warn(`failed to fetch linked issue of #${number}: ${err}`);
      return null;
    }
  }

  private async *list<T>(
    url: string,
    limitDate: Date,
    f: ResProcessor<T>,
  ): AsyncGenerator<T> {
    console.log(`precessing: ${url}`);
    const { body, linkHeader } = await this.getJson(url);
    const result = f(body, limitDate);

    for (const v of result.values) {
      yield v;
    }

    const link = this.parseLinkHeader(linkHeader);
    const nextUrl = link?.next ?? null;
    if (nextUrl != null && result.hasNext) {
      yield* this.list(nextUrl, limitDate, f);
    }
  }

  private parseLinkHeader(input: string | null): Record<string, string> | null {
    if (input == null) return null;
    const out: Record<string, string> = {};
    const parts = input.split(', ');
    for (const part of parts) {
      if (part[0] !== '<') {
        throw new Error('Invalid Link Header');
      }
      const kv = part.split('; ');
      let url = kv[0].substring(1);
      url = url.substring(0, url.length - 1);
      let key = kv[1];
      key = key.replace(/"/g, '').substring(4);
      out[key] = url;
    }
    return out;
  }

  private pullRequestProcessor(body: any, limitDate: Date): ParsedResult<PullRequestResponse> {
    // API がエラー応答（配列でなく {message,...} 等）を返した場合に分かりやすく失敗させる。
    if (!Array.isArray(body)) {
      const message = body?.message ?? JSON.stringify(body);
      throw new Error(`GitHub API が PR 一覧を返しませんでした: ${message}`);
    }
    const jsonBody = body as any[];
    const prs = jsonBody
      .map((pr) => parsePullRequestResponse(pr))
      .filter((pr) => pr.createdAt > limitDate);

    return { values: prs, hasNext: prs.length > 0 };
  }
}
