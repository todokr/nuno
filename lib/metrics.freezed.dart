// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Metrics _$MetricsFromJson(Map<String, dynamic> json) {
  return _Metrics.fromJson(json);
}

/// @nodoc
class _$MetricsTearOff {
  const _$MetricsTearOff();

// ignore: unused_element
  _Metrics call({List<String> targetMonths, List<PullRequest> pullRequests}) {
    return _Metrics(
      targetMonths: targetMonths,
      pullRequests: pullRequests,
    );
  }

// ignore: unused_element
  Metrics fromJson(Map<String, Object> json) {
    return Metrics.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Metrics = _$MetricsTearOff();

/// @nodoc
mixin _$Metrics {
  List<String> get targetMonths;
  List<PullRequest> get pullRequests;

  Map<String, dynamic> toJson();
  $MetricsCopyWith<Metrics> get copyWith;
}

/// @nodoc
abstract class $MetricsCopyWith<$Res> {
  factory $MetricsCopyWith(Metrics value, $Res Function(Metrics) then) =
      _$MetricsCopyWithImpl<$Res>;
  $Res call({List<String> targetMonths, List<PullRequest> pullRequests});
}

/// @nodoc
class _$MetricsCopyWithImpl<$Res> implements $MetricsCopyWith<$Res> {
  _$MetricsCopyWithImpl(this._value, this._then);

  final Metrics _value;
  // ignore: unused_field
  final $Res Function(Metrics) _then;

  @override
  $Res call({
    Object targetMonths = freezed,
    Object pullRequests = freezed,
  }) {
    return _then(_value.copyWith(
      targetMonths: targetMonths == freezed
          ? _value.targetMonths
          : targetMonths as List<String>,
      pullRequests: pullRequests == freezed
          ? _value.pullRequests
          : pullRequests as List<PullRequest>,
    ));
  }
}

/// @nodoc
abstract class _$MetricsCopyWith<$Res> implements $MetricsCopyWith<$Res> {
  factory _$MetricsCopyWith(_Metrics value, $Res Function(_Metrics) then) =
      __$MetricsCopyWithImpl<$Res>;
  @override
  $Res call({List<String> targetMonths, List<PullRequest> pullRequests});
}

/// @nodoc
class __$MetricsCopyWithImpl<$Res> extends _$MetricsCopyWithImpl<$Res>
    implements _$MetricsCopyWith<$Res> {
  __$MetricsCopyWithImpl(_Metrics _value, $Res Function(_Metrics) _then)
      : super(_value, (v) => _then(v as _Metrics));

  @override
  _Metrics get _value => super._value as _Metrics;

  @override
  $Res call({
    Object targetMonths = freezed,
    Object pullRequests = freezed,
  }) {
    return _then(_Metrics(
      targetMonths: targetMonths == freezed
          ? _value.targetMonths
          : targetMonths as List<String>,
      pullRequests: pullRequests == freezed
          ? _value.pullRequests
          : pullRequests as List<PullRequest>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Metrics implements _Metrics {
  const _$_Metrics({this.targetMonths, this.pullRequests});

  factory _$_Metrics.fromJson(Map<String, dynamic> json) =>
      _$_$_MetricsFromJson(json);

  @override
  final List<String> targetMonths;
  @override
  final List<PullRequest> pullRequests;

  @override
  String toString() {
    return 'Metrics(targetMonths: $targetMonths, pullRequests: $pullRequests)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Metrics &&
            (identical(other.targetMonths, targetMonths) ||
                const DeepCollectionEquality()
                    .equals(other.targetMonths, targetMonths)) &&
            (identical(other.pullRequests, pullRequests) ||
                const DeepCollectionEquality()
                    .equals(other.pullRequests, pullRequests)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(targetMonths) ^
      const DeepCollectionEquality().hash(pullRequests);

  @override
  _$MetricsCopyWith<_Metrics> get copyWith =>
      __$MetricsCopyWithImpl<_Metrics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MetricsToJson(this);
  }
}

abstract class _Metrics implements Metrics {
  const factory _Metrics(
      {List<String> targetMonths, List<PullRequest> pullRequests}) = _$_Metrics;

  factory _Metrics.fromJson(Map<String, dynamic> json) = _$_Metrics.fromJson;

  @override
  List<String> get targetMonths;
  @override
  List<PullRequest> get pullRequests;
  @override
  _$MetricsCopyWith<_Metrics> get copyWith;
}
