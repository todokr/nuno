import type { PullRequest } from './pullRequest.js';

/**
 * out.json のトップレベル構造。Dart 版の freezed クラス Metrics に対応する。
 */
export interface Metrics {
  targetMonths: string[];
  pullRequests: PullRequest[];
}
