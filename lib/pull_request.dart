import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuno/pull_reqeust_commits_response.dart';
import 'package:nuno/pull_request_detail_response.dart';
import 'package:nuno/pull_request_response.dart';
import 'package:nuno/pull_request_reviews_response.dart';

part 'pull_request.freezed.dart';
part 'pull_request.g.dart';

@freezed
abstract class PullRequest with _$PullRequest {
  const factory PullRequest(
      {String title,
      String url,
      DateTime oldestCommitDate,
      DateTime createdAt,
      DateTime oldestReactionDate,
      DateTime latestApprovalDate,
      DateTime mergedAt,
      int commits,
      int additions,
      int deletions,
      int changeFiles,
      String state,
      String moduleName,
      String changeType}) = _PullRequest;

  factory PullRequest.from(PullRequestResponse pr, PullRequestDetailResponse detail,
      PullRequestCommitsResponse commits, PullRequestReviewsResponse reviews) {
    final parsedTitle = _parse_pr_title(pr.title);
    final oldestCommit = commits.oldest();
    final oldestReaction = reviews.oldestReaction();
    final latestApproval = reviews.latestApproval();

    return PullRequest(
        title: parsedTitle['title'],
        url: pr.url,
        oldestCommitDate: oldestCommit?.date,
        createdAt: pr.createdAt,
        oldestReactionDate: oldestReaction?.date,
        latestApprovalDate: latestApproval?.date,
        mergedAt: pr.mergedAt,
        commits: detail.commits,
        additions: detail.additions,
        changeFiles: detail.changeFiles,
        state: pr.state,
        moduleName: parsedTitle['module'],
        changeType: parsedTitle['type']);
  }

  factory PullRequest.fromJson(Map<String, dynamic> json) =>
      _$PullRequestFromJson(json);
}

final title_paren_pattern = RegExp(r'\(|\)');
final title_regexp = RegExp(r'(\w+)(\(\w+\))?: (.+)');

Map<String, String> _parse_pr_title(String raw_title) {
  if (!title_regexp.hasMatch(raw_title)) return {'title': raw_title};

  final result = title_regexp.firstMatch(raw_title);
  return {
    'title': result.group(3),
    'module': result.group(2)?.replaceAll(title_paren_pattern, ''),
    'type': result.group(1)
  };
}
