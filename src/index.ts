import { writeFileSync } from 'node:fs';
import { GitHubClient } from './githubClient.js';
import { buildPullRequest, type PullRequest } from './pullRequest.js';
import type { Metrics } from './metrics.js';
import { startOfMonth, subMonths, formatYearMonth } from './date.js';
import { buildAuthorFilter } from './authorFilter.js';

async function main(): Promise<void> {
  const token = process.env.GITHUB_TOKEN ?? '';
  const org = process.env.TARGET_ORGANIZATION ?? '';
  const repo = process.env.TARGET_REPOSITORY ?? '';

  // 必須の環境変数が欠けていると repos//... のような不正な URL になり、
  // API がエラー応答を返して分かりにくい例外になるため、起動時に明示的に検証する。
  const missing = [
    ['GITHUB_TOKEN', token],
    ['TARGET_ORGANIZATION', org],
    ['TARGET_REPOSITORY', repo],
  ]
    .filter(([, value]) => value.length === 0)
    .map(([name]) => name);
  if (missing.length > 0) {
    throw new Error(
      `必須の環境変数が設定されていません: ${missing.join(', ')}\n` +
        `例) GITHUB_TOKEN=xxx TARGET_ORGANIZATION=your-org TARGET_REPOSITORY=your-repo npm start`,
    );
  }

  const client = new GitHubClient(token, org, repo);

  // TARGET_AUTHORS で指定した GitHub ユーザー名 (login) の PR のみを対象とする。
  // 未指定 (空) の場合は全ユーザーの PR を対象とする。
  const authorFilter = buildAuthorFilter(process.env.TARGET_AUTHORS);
  if (authorFilter.logins.size > 0) {
    console.log(`filtering authors: ${[...authorFilter.logins].join(', ')}`);
  }

  const targetMonthSpan = 5;
  const now = new Date();
  const currentMonth = startOfMonth(now);
  // 直近 targetMonthSpan ヶ月分を古い順に並べる。
  const targetMonths = Array.from({ length: targetMonthSpan }, (_, i) =>
    subMonths(currentMonth, i),
  ).reverse();
  const limitDate = targetMonths[0];

  console.log(`from: ${formatYearMonth(limitDate)}, to: ${formatYearMonth(now)}`);

  const prs: PullRequest[] = [];
  for await (const pr of client.listPullRequests(limitDate)) {
    // 対象外の作者の PR は詳細取得もせずスキップする。
    if (!authorFilter.isTarget(pr.authorLogin)) {
      continue;
    }
    const [detail, commits, reviews, issueCreatedAt] = await Promise.all([
      client.fetchPullRequest(pr.number),
      client.fetchCommits(pr.number),
      client.fetchReviews(pr.number, pr.authorId),
      client.fetchLinkedIssue(pr.number),
    ]);
    prs.push(buildPullRequest(pr, detail, commits, reviews, issueCreatedAt));
  }

  const formattedTargetMonths = targetMonths.map((m) => formatYearMonth(m));
  const metrics: Metrics = { targetMonths: formattedTargetMonths, pullRequests: prs };

  const outPath = './web/public/out.json';
  writeFileSync(outPath, JSON.stringify(metrics, null, 2));
  console.log(`wrote: ${outPath}`);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
