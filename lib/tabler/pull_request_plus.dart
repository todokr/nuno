import 'package:intl/intl.dart';

import 'package:nuno/pull_request.dart';

class PullRequestPlus {
  final PullRequest pr;

  PullRequestPlus(this.pr);

  int get prNumber => prNumberOf(pr.url);
  String get url => pr.url;
  int get mergeYear => pr.mergedAt?.year;
  int get mergeMonth => pr.mergedAt?.month;
  int get mergeWeek => weekNumberOf(pr.mergedAt);
  String get team => pr.moduleName;
  String get changeType => pr.changeType;
  int get duration => calcDuration(pr.oldestCommitDate, pr.mergedAt);
  DateTime get oldestCommitDate => pr.oldestCommitDate;
  DateTime get createdAt => pr.createdAt;
  DateTime get oldestReactionDate => pr.oldestReactionDate;
  DateTime get latestApprovalDate => pr.latestApprovalDate;
  DateTime get mergedAt => pr.mergedAt;
  int get commits => pr.commits;
  int get additions => pr.additions;
  int get deletions => pr.deletions;
  int get changeFiles => pr.changeFiles;
  String get title => pr.title;
  String get labels => pr.labels?.join(',');
  bool get isProductDev => !(pr.labels ?? []).contains('xem');
  bool get isMainPr => pr.baseBranch == 'develop';


  /// 出力用のフォーマット
  ///
  List<dynamic> asRowData() => [
    prNumber,
    url,
    mergeYear,
    mergeMonth,
    mergeWeek,
    team,
    changeType,
    duration,
    oldestCommitDate,
    createdAt,
    oldestReactionDate,
    latestApprovalDate,
    mergedAt,
    commits,
    additions,
    deletions,
    changeFiles,
    title,
    labels,
    isProductDev,
    isMainPr,
  ];


  /// Week Number を計算する
  ///  - 月曜始まり
  ///  - 第1週はその年における最初の木曜日が含まれる週
  ///
  /// https://stackoverflow.com/questions/49393231/how-to-get-day-of-year-week-of-year-from-a-datetime-dart-object : コピー元
  /// https://smdn.jp/programming/netfx/datetime/isoweek/ : ISO8601の説明
  static int weekNumberOf(DateTime date) {
    if (date == null) {
      return null;
    } else {
      final dayOfYear = int.parse(DateFormat('D').format(date));
      return ((dayOfYear - date.weekday + 10) / 7).floor();
    }
  }


  /// URLからPR番号を取得する
  ///
  static int prNumberOf(String url) {
    if (url == null) {
      return null;
    } else {
      final regex = r'https:\/\/github\.com\/[a-zA-Z-_\/]+\/pull\/(\d+)';
      return int.parse(RegExp(regex).allMatches(url).first.group(1));
    }
  }


  /// 時間を分単位で測る
  ///
  static int calcDuration(DateTime s, DateTime e) {
    if (s == null || e == null) {
      return null;
    } else {
      return e.difference(s).inMinutes;
    }
  }

  /// 出力用のタイトル
  ///
  static const List<String> titles = [
    'pr_number',
    'url',
    'merge_year',
    'merge_month',
    'merge_week',
    'team',
    'change_type',
    'duration',
    'oldest_commit_date',
    'created_at',
    'oldest_reaction_date',
    'latest_approval_date',
    'merged_at',
    'commits',
    'additions',
    'deletions',
    'changed_files',
    'title',
    'labels',
    'is_product_dev',
    'is_main_pr',
  ];
}
