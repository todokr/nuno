import 'dart:convert' show JsonEncoder;
import 'dart:io' show Platform, File;

import 'package:nuno/metrics.dart';
import 'package:nuno/pull_reqeust_commits_response.dart';
import 'package:nuno/pull_request.dart';
import 'package:dart_date/dart_date.dart';
import 'package:nuno/pull_request_detail_response.dart';
import 'package:nuno/pull_request_reviews_response.dart';

import 'github_client.dart';

Future<void> main() async {
  final envVars = Platform.environment;
  final token = envVars['GITHUB_TOKEN'];
  final org = envVars['TARGET_ORGANIZATION'] ?? 'bizreach-inc';
  final repo = envVars['TARGET_REPOSITORY'] ?? 'hrmony-prf';
  final client = GitHubClient(token, org, repo);

  // デフォルトは前月以前の6ヶ月間を取得
  final backMonth = int.parse(envVars['BACK_MONTH'] ?? '1');
  final targetMonthSpan = int.parse(envVars['MONTH_SPAN'] ?? '6');
  final now = DateTime.now();
  final startDate = DateTime(now.year, now.month - backMonth - targetMonthSpan + 1, now.day).startOfMonth;
  final endDate = DateTime(now.year, now.month - backMonth + 1, now.day).startOfMonth;
  final targetMonths = List.generate(targetMonthSpan, (i) => startDate.subMonths(i)).reversed;

  print('from: ${startDate.format("yyyy-MM-dd")}, to: ${endDate.format("yyyy-MM-dd")}');

  final prs = await client.listPullRequests(startDate).asyncMap((pr) async {
    if (pr.mergedAt != null && pr.mergedAt.isBefore(endDate)) {
      final responses = await Future.wait([
        client.fetchPullRequest(pr.number),
        client.fetchCommits(pr.number),
        client.fetchReviews(pr.number, pr.authorId)
      ]);
      final detail = responses[0] as PullRequestDetailResponse;
      final commits = responses[1] as PullRequestCommitsResponse;
      final reviews = responses[2] as PullRequestReviewsResponse;
      return PullRequest.from(pr, detail, commits, reviews);
    } else {
      return null;
    }
  }).toList();
  final nonNullPrs = prs.where((pr) => pr != null).toList();
  final formattedTargetMonths = targetMonths.map((m) => m.format('yyyy-MM')).toList();
  final metrics = Metrics(targetMonths: formattedTargetMonths, pullRequests: nonNullPrs);

  final encoder = JsonEncoder.withIndent('  ');
  final outJson = File('./web/public/out.json');
  await outJson.writeAsStringSync(encoder.convert(metrics), flush: true);
  print('wrote: ${outJson.path}');
}
