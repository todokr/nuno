// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pull_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
PullRequest _$PullRequestFromJson(Map<String, dynamic> json) {
  return _PullRequest.fromJson(json);
}

/// @nodoc
class _$PullRequestTearOff {
  const _$PullRequestTearOff();

// ignore: unused_element
  _PullRequest call(
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
      String changeType}) {
    return _PullRequest(
      title: title,
      url: url,
      oldestCommitDate: oldestCommitDate,
      createdAt: createdAt,
      oldestReactionDate: oldestReactionDate,
      latestApprovalDate: latestApprovalDate,
      mergedAt: mergedAt,
      commits: commits,
      additions: additions,
      deletions: deletions,
      changeFiles: changeFiles,
      state: state,
      moduleName: moduleName,
      changeType: changeType,
    );
  }

// ignore: unused_element
  PullRequest fromJson(Map<String, Object> json) {
    return PullRequest.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $PullRequest = _$PullRequestTearOff();

/// @nodoc
mixin _$PullRequest {
  String get title;
  String get url;
  DateTime get oldestCommitDate;
  DateTime get createdAt;
  DateTime get oldestReactionDate;
  DateTime get latestApprovalDate;
  DateTime get mergedAt;
  int get commits;
  int get additions;
  int get deletions;
  int get changeFiles;
  String get state;
  String get moduleName;
  String get changeType;

  Map<String, dynamic> toJson();
  $PullRequestCopyWith<PullRequest> get copyWith;
}

/// @nodoc
abstract class $PullRequestCopyWith<$Res> {
  factory $PullRequestCopyWith(
          PullRequest value, $Res Function(PullRequest) then) =
      _$PullRequestCopyWithImpl<$Res>;
  $Res call(
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
      String changeType});
}

/// @nodoc
class _$PullRequestCopyWithImpl<$Res> implements $PullRequestCopyWith<$Res> {
  _$PullRequestCopyWithImpl(this._value, this._then);

  final PullRequest _value;
  // ignore: unused_field
  final $Res Function(PullRequest) _then;

  @override
  $Res call({
    Object title = freezed,
    Object url = freezed,
    Object oldestCommitDate = freezed,
    Object createdAt = freezed,
    Object oldestReactionDate = freezed,
    Object latestApprovalDate = freezed,
    Object mergedAt = freezed,
    Object commits = freezed,
    Object additions = freezed,
    Object deletions = freezed,
    Object changeFiles = freezed,
    Object state = freezed,
    Object moduleName = freezed,
    Object changeType = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      url: url == freezed ? _value.url : url as String,
      oldestCommitDate: oldestCommitDate == freezed
          ? _value.oldestCommitDate
          : oldestCommitDate as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      oldestReactionDate: oldestReactionDate == freezed
          ? _value.oldestReactionDate
          : oldestReactionDate as DateTime,
      latestApprovalDate: latestApprovalDate == freezed
          ? _value.latestApprovalDate
          : latestApprovalDate as DateTime,
      mergedAt: mergedAt == freezed ? _value.mergedAt : mergedAt as DateTime,
      commits: commits == freezed ? _value.commits : commits as int,
      additions: additions == freezed ? _value.additions : additions as int,
      deletions: deletions == freezed ? _value.deletions : deletions as int,
      changeFiles:
          changeFiles == freezed ? _value.changeFiles : changeFiles as int,
      state: state == freezed ? _value.state : state as String,
      moduleName:
          moduleName == freezed ? _value.moduleName : moduleName as String,
      changeType:
          changeType == freezed ? _value.changeType : changeType as String,
    ));
  }
}

/// @nodoc
abstract class _$PullRequestCopyWith<$Res>
    implements $PullRequestCopyWith<$Res> {
  factory _$PullRequestCopyWith(
          _PullRequest value, $Res Function(_PullRequest) then) =
      __$PullRequestCopyWithImpl<$Res>;
  @override
  $Res call(
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
      String changeType});
}

/// @nodoc
class __$PullRequestCopyWithImpl<$Res> extends _$PullRequestCopyWithImpl<$Res>
    implements _$PullRequestCopyWith<$Res> {
  __$PullRequestCopyWithImpl(
      _PullRequest _value, $Res Function(_PullRequest) _then)
      : super(_value, (v) => _then(v as _PullRequest));

  @override
  _PullRequest get _value => super._value as _PullRequest;

  @override
  $Res call({
    Object title = freezed,
    Object url = freezed,
    Object oldestCommitDate = freezed,
    Object createdAt = freezed,
    Object oldestReactionDate = freezed,
    Object latestApprovalDate = freezed,
    Object mergedAt = freezed,
    Object commits = freezed,
    Object additions = freezed,
    Object deletions = freezed,
    Object changeFiles = freezed,
    Object state = freezed,
    Object moduleName = freezed,
    Object changeType = freezed,
  }) {
    return _then(_PullRequest(
      title: title == freezed ? _value.title : title as String,
      url: url == freezed ? _value.url : url as String,
      oldestCommitDate: oldestCommitDate == freezed
          ? _value.oldestCommitDate
          : oldestCommitDate as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      oldestReactionDate: oldestReactionDate == freezed
          ? _value.oldestReactionDate
          : oldestReactionDate as DateTime,
      latestApprovalDate: latestApprovalDate == freezed
          ? _value.latestApprovalDate
          : latestApprovalDate as DateTime,
      mergedAt: mergedAt == freezed ? _value.mergedAt : mergedAt as DateTime,
      commits: commits == freezed ? _value.commits : commits as int,
      additions: additions == freezed ? _value.additions : additions as int,
      deletions: deletions == freezed ? _value.deletions : deletions as int,
      changeFiles:
          changeFiles == freezed ? _value.changeFiles : changeFiles as int,
      state: state == freezed ? _value.state : state as String,
      moduleName:
          moduleName == freezed ? _value.moduleName : moduleName as String,
      changeType:
          changeType == freezed ? _value.changeType : changeType as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_PullRequest implements _PullRequest {
  const _$_PullRequest(
      {this.title,
      this.url,
      this.oldestCommitDate,
      this.createdAt,
      this.oldestReactionDate,
      this.latestApprovalDate,
      this.mergedAt,
      this.commits,
      this.additions,
      this.deletions,
      this.changeFiles,
      this.state,
      this.moduleName,
      this.changeType});

  factory _$_PullRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_PullRequestFromJson(json);

  @override
  final String title;
  @override
  final String url;
  @override
  final DateTime oldestCommitDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime oldestReactionDate;
  @override
  final DateTime latestApprovalDate;
  @override
  final DateTime mergedAt;
  @override
  final int commits;
  @override
  final int additions;
  @override
  final int deletions;
  @override
  final int changeFiles;
  @override
  final String state;
  @override
  final String moduleName;
  @override
  final String changeType;

  @override
  String toString() {
    return 'PullRequest(title: $title, url: $url, oldestCommitDate: $oldestCommitDate, createdAt: $createdAt, oldestReactionDate: $oldestReactionDate, latestApprovalDate: $latestApprovalDate, mergedAt: $mergedAt, commits: $commits, additions: $additions, deletions: $deletions, changeFiles: $changeFiles, state: $state, moduleName: $moduleName, changeType: $changeType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PullRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.oldestCommitDate, oldestCommitDate) ||
                const DeepCollectionEquality()
                    .equals(other.oldestCommitDate, oldestCommitDate)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.oldestReactionDate, oldestReactionDate) ||
                const DeepCollectionEquality()
                    .equals(other.oldestReactionDate, oldestReactionDate)) &&
            (identical(other.latestApprovalDate, latestApprovalDate) ||
                const DeepCollectionEquality()
                    .equals(other.latestApprovalDate, latestApprovalDate)) &&
            (identical(other.mergedAt, mergedAt) ||
                const DeepCollectionEquality()
                    .equals(other.mergedAt, mergedAt)) &&
            (identical(other.commits, commits) ||
                const DeepCollectionEquality()
                    .equals(other.commits, commits)) &&
            (identical(other.additions, additions) ||
                const DeepCollectionEquality()
                    .equals(other.additions, additions)) &&
            (identical(other.deletions, deletions) ||
                const DeepCollectionEquality()
                    .equals(other.deletions, deletions)) &&
            (identical(other.changeFiles, changeFiles) ||
                const DeepCollectionEquality()
                    .equals(other.changeFiles, changeFiles)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.moduleName, moduleName) ||
                const DeepCollectionEquality()
                    .equals(other.moduleName, moduleName)) &&
            (identical(other.changeType, changeType) ||
                const DeepCollectionEquality()
                    .equals(other.changeType, changeType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(oldestCommitDate) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(oldestReactionDate) ^
      const DeepCollectionEquality().hash(latestApprovalDate) ^
      const DeepCollectionEquality().hash(mergedAt) ^
      const DeepCollectionEquality().hash(commits) ^
      const DeepCollectionEquality().hash(additions) ^
      const DeepCollectionEquality().hash(deletions) ^
      const DeepCollectionEquality().hash(changeFiles) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(moduleName) ^
      const DeepCollectionEquality().hash(changeType);

  @override
  _$PullRequestCopyWith<_PullRequest> get copyWith =>
      __$PullRequestCopyWithImpl<_PullRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PullRequestToJson(this);
  }
}

abstract class _PullRequest implements PullRequest {
  const factory _PullRequest(
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
      String changeType}) = _$_PullRequest;

  factory _PullRequest.fromJson(Map<String, dynamic> json) =
      _$_PullRequest.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  DateTime get oldestCommitDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get oldestReactionDate;
  @override
  DateTime get latestApprovalDate;
  @override
  DateTime get mergedAt;
  @override
  int get commits;
  @override
  int get additions;
  @override
  int get deletions;
  @override
  int get changeFiles;
  @override
  String get state;
  @override
  String get moduleName;
  @override
  String get changeType;
  @override
  _$PullRequestCopyWith<_PullRequest> get copyWith;
}
