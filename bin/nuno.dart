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
  final org = envVars['TARGET_ORGANIZATION'];
  final repo = envVars['TARGET_REPOSITORY'];
  final client = GitHubClient(token, org, repo);

  final backMonth = int.parse(envVars['BACK_MONTH'] ?? 0);
  final targetMonthSpan = int.parse(envVars['MONTH_SPAN'] ?? 6);
  final now = DateTime.now();
  final backDate = DateTime(now.year, now.month - backMonth, now.day);
  final startOfEndMonth = backDate.startOfMonth;
  final targetMonths = List.generate(targetMonthSpan, (i) => startOfEndMonth.subMonths(i)).reversed;
  final limitDate = targetMonths.first;

  print('from: ${limitDate.format("yyyy-MM")}, to: ${now.format("yyyy-MM")}');

  final prs = await client.listPullRequests(limitDate).asyncMap((pr) async {
      final responses = await Future.wait([
        client.fetchPullRequest(pr.number),
        client.fetchCommits(pr.number),
        client.fetchReviews(pr.number, pr.authorId)
    ]);
    final detail = responses[0] as PullRequestDetailResponse;
    final commits = responses[1] as PullRequestCommitsResponse;
    final reviews = responses[2] as PullRequestReviewsResponse;
    return PullRequest.from(pr, detail, commits, reviews);
  }).toList();
  final formattedTargetMonths = targetMonths.map((m) => m.format('yyyy-MM')).toList();
  final metrics = Metrics(targetMonths: formattedTargetMonths, pullRequests: prs);

  final encoder = JsonEncoder.withIndent('  ');
  final outJson = File('./web/public/out.json');
  await outJson.writeAsStringSync(encoder.convert(metrics), flush: true);
  print('wrote: ${outJson.path}');
}
