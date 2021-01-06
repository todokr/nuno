// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Metrics _$_$_MetricsFromJson(Map<String, dynamic> json) {
  return _$_Metrics(
    targetMonths:
        (json['targetMonths'] as List)?.map((e) => e as String)?.toList(),
    pullRequests: (json['pullRequests'] as List)
        ?.map((e) =>
            e == null ? null : PullRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_MetricsToJson(_$_Metrics instance) =>
    <String, dynamic>{
      'targetMonths': instance.targetMonths,
      'pullRequests': instance.pullRequests?.map((e) => e?.toJson())?.toList(),
    };
