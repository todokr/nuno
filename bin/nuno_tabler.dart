import 'dart:io';
import 'dart:convert' show json;

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
// import 'package:collection/collection.dart' as collection;
// import 'package:intl/intl.dart';

import 'package:nuno/pull_request.dart';
import 'package:nuno/tabler/tabler_env.dart';
import 'package:nuno/tabler/pull_request_plus.dart';



Future<void> main() async {
  await NunoTabler().main();
}

class NunoTabler {
  Future<void> main() async {
    print('nuno Tabler is CSV transforming command for nuno');
    final env = TablerEnv.init();
    print('Opening: ${env.inFilePath}');
    final content = importAsJson(env.inFilePath);
    print('Extracting PR data');
    final prList = extractPrList(content);
    print('Transforming for CSV optimization');
    final transformed = transformPrList(prList);
    print('Saving: ${env.outFilePath}');
    exportAsCsv(transformed, env.outFilePath);
    print('Saved successfully !');

    /// デプロイ回数の取得 (中止。テストしてない)
    // final deployCounts = transformAsDeployCounts(prList);
    // exportAsCsv(deployCounts, '${env.outFilePath}/deploy_counts.csv');
  }


  /// ファイルをインポートする
  ///
  static dynamic importAsJson(String fileName) {
    final content = File(fileName).readAsStringSync();

    return json.decode(content);
  }


  /// マージされたPullRequest部分を抽出する
  ///
  static Iterable<PullRequest> extractPrList(dynamic content) {
    final Iterable<dynamic> prListJson = content['pullRequests'];
    final prList = prListJson
        .map((pr) => PullRequest.fromJson(pr))
        .where((pr) => pr.mergedAt != null)
        .toList();

    return prList;
  }


  /// 二次元データに変換する
  ///
  static List<List<dynamic>> transformPrList(Iterable<PullRequest> prList) {
    final data = prList.map((pr) => PullRequestPlus(pr).asRowData()).toList();
    data.insert(0, PullRequestPlus.titles);

    return data;
  }


  /// 二次元データをCSVに出力する
  ///
  static void exportAsCsv(List<List<dynamic>> cells, outFilePath) {

    // null文字列ができてしまうので、予め空文字に置き換えておく
    final nullToEmptyString = (dynamic v) => v ?? '';
    // 日付のフォーマットも微妙なので予め文字列に置き換えておく
    final dateToString = (dynamic v) {
      if (v is DateTime) {
        return DateFormat('yyyy-MM-dd HH:mm:ss').format(v);
      } else {
        return v;
      }
    };


    final formattedCells =
    cells.map((list) =>
        list.map((cell) =>
            dateToString(nullToEmptyString(cell))
        ).toList()
    ).toList();

    final string = ListToCsvConverter().convert(formattedCells);
    File(outFilePath).writeAsStringSync(string);

  }


/// デプロイ回数の取得 (中止。テストしてない)
// final deployCounts = transformAsDeployCounts(prList);
// exportAsCsv(deployCounts, '${env.outFilePath}/deploy_counts.csv');

///
/// デプロイをカウントする  (中止。テストしてない)
///
// List<List<String>> transformAsDeployCounts(Iterable<PullRequest>  prList) {
//   final mergedDates = prList.map((pr) => DateFormat('yyyy-MM').format(pr.mergedAt));
//   final countsByMonth = collection.groupBy(mergedDates, (p0) => p0)
//     .entries
//     .map((e) => [e.key.toString(), e.value.toString()])
//     .toList();
//
//   countsByMonth.sort((a, b) => a[0].compareTo(b[0]));
//
//   return countsByMonth;
// }
}





