import 'package:freezed_annotation/freezed_annotation.dart';
import 'pull_request.dart';

part 'metrics.freezed.dart';
part 'metrics.g.dart';

@freezed
abstract class Metrics with _$Metrics {
  const factory Metrics({
      List<String> targetMonths,
      List<PullRequest> pullRequests
  }) = _Metrics;
  factory Metrics.fromJson(Map<String, dynamic> json) => _$MetricsFromJson(json);
}
