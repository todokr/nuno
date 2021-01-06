// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PullRequest _$_$_PullRequestFromJson(Map<String, dynamic> json) {
  return _$_PullRequest(
    title: json['title'] as String,
    url: json['url'] as String,
    oldestCommitDate: json['oldestCommitDate'] == null
        ? null
        : DateTime.parse(json['oldestCommitDate'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    oldestReactionDate: json['oldestReactionDate'] == null
        ? null
        : DateTime.parse(json['oldestReactionDate'] as String),
    latestApprovalDate: json['latestApprovalDate'] == null
        ? null
        : DateTime.parse(json['latestApprovalDate'] as String),
    mergedAt: json['mergedAt'] == null
        ? null
        : DateTime.parse(json['mergedAt'] as String),
    commits: json['commits'] as int,
    additions: json['additions'] as int,
    deletions: json['deletions'] as int,
    changeFiles: json['changeFiles'] as int,
    state: json['state'] as String,
    moduleName: json['moduleName'] as String,
    changeType: json['changeType'] as String,
  );
}

Map<String, dynamic> _$_$_PullRequestToJson(_$_PullRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'oldestCommitDate': instance.oldestCommitDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'oldestReactionDate': instance.oldestReactionDate?.toIso8601String(),
      'latestApprovalDate': instance.latestApprovalDate?.toIso8601String(),
      'mergedAt': instance.mergedAt?.toIso8601String(),
      'commits': instance.commits,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'changeFiles': instance.changeFiles,
      'state': instance.state,
      'moduleName': instance.moduleName,
      'changeType': instance.changeType,
    };
