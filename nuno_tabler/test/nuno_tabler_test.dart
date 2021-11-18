import 'package:nuno/pull_request.dart';
import 'package:test/test.dart';

import 'dart:convert' show json;

import 'package:collection/collection.dart' as collection;
import 'package:intl/intl.dart';

void main() {
  test('sandbox', () {
    const jsonString = '''{"pullRequests": [
    {
      "title": "SBPRF-12426 Fix the action config and suppress rebase automation",
      "url": "https://github.com/bizreach-inc/hrmony-prf/pull/5107",
      "oldestCommitDate": "2021-11-18T05:00:11.000Z",
      "createdAt": "2021-11-18T05:02:45.000Z",
      "oldestReactionDate": "2021-11-18T05:16:07.000Z",
      "latestApprovalDate": "2021-11-18T05:16:07.000Z",
      "mergedAt": "2021-11-18T05:18:03.000Z",
      "commits": 1,
      "additions": 4,
      "deletions": null,
      "changeFiles": null,
      "state": "closed",
      "moduleName": null,
      "changeType": "chore"
    },
    {
      "title": "SBPRF-12668 delete permission when section delete",
      "url": "https://github.com/bizreach-inc/hrmony-prf/pull/5102",
      "oldestCommitDate": "2021-11-16T05:24:16.000Z",
      "createdAt": "2021-11-16T05:24:36.000Z",
      "oldestReactionDate": "2021-11-17T09:34:53.000Z",
      "latestApprovalDate": "2021-11-17T09:45:26.000Z",
      "mergedAt": "2021-11-18T06:03:59.000Z",
      "commits": 5,
      "additions": 46,
      "deletions": null,
      "changeFiles": null,
      "state": "closed",
      "moduleName": "goal",
      "changeType": "fix"
    }]}''';

    final jsonRaw = json.decode(jsonString);

    //test
    final dateRaw = jsonRaw['pullRequests'][0]['mergedAt'];
    expect(DateTime.parse(dateRaw), DateTime.parse('2021-11-18T05:18:03.000Z'));

    //test
    final pr1 = PullRequest.fromJson(jsonRaw['pullRequests'][0]);
    //print(pr1);

    final List<dynamic> prListJson = jsonRaw['pullRequests'];
    final prList = prListJson.map((pr) => PullRequest.fromJson(pr));
    expect(prList.length, 2);

    final mergedDates = prList.map((pr) => DateFormat('yyyy-MM').format(pr.mergedAt));
    final countsByMonth = collection.groupBy(mergedDates, (p0) => p0)
        .map((key, value) => MapEntry(key, value.length));

    print('PR count by month: ${countsByMonth}');

  });

}
