import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:nuno/pull_reqeust_commits_response.dart';
import 'package:nuno/pull_request_detail_response.dart';
import 'package:nuno/pull_request_response.dart';
import 'package:nuno/pull_request_reviews_response.dart';

typedef ResProcessor<T> = _ParsedResult<T> Function(http.Response res);

class GitHubClient {
  final String _token;
  final String _org;
  final String _repo;

  Map<String, String> get header => {'Authorization': 'token ${_token}'};

  GitHubClient(this._token, this._org, this._repo);

  Stream<PullRequestResponse> listPullRequests(DateTime startDate) {
    final startUrl =
        'https://api.github.com/repos/${_org}/${_repo}/pulls?per_page=100&state=close&sort=created&direction=desc';
    return _list<PullRequestResponse>(
        startUrl, _PullRequestProcessor(startDate).create());
  }

  Future<PullRequestDetailResponse> fetchPullRequest(int number) async {
    final url = 'https://api.github.com/repos/${_org}/${_repo}/pulls/${number}';
    print('fetching: ${url}');
    final res = await http.get(url, headers: header);
    Map<String, dynamic> jsonBody = json.decode(res.body);
    return PullRequestDetailResponse.parse(jsonBody);
  }

  Future<PullRequestCommitsResponse> fetchCommits(int number) async {
    final url =
        'https://api.github.com/repos/${_org}/${_repo}/pulls/${number}/commits?per_page=100';
    print('fetching: ${url}');
    final res = await http.get(url, headers: header);
    final List<dynamic> jsonBody = json.decode(res.body);
    final commits = jsonBody.map((c) {
      c = c as Map<String, dynamic>;
      final rawDate = c['commit']['author']['date'];
      return CommitResponse(
          date: rawDate != null ? DateTime.parse(rawDate) : null);
    }).toList();
    return PullRequestCommitsResponse(commits: commits);
  }

  Future<PullRequestReviewsResponse> fetchReviews(
      int number, int authorId) async {
    final url =
        'https://api.github.com/repos/${_org}/${_repo}/pulls/${number}/reviews?per_page=100';
    print('fetching: ${url}');
    final res = await http.get(url, headers: header);
    final List<dynamic> jsonBody = json.decode(res.body);
    final reviews = jsonBody.map((c) {
      c = c as Map<String, dynamic>;
      final rawDate = c['submitted_at'];
      return ReviewResponse(
          reviewerId: c['user']['id'],
          date: rawDate != null ? DateTime.parse(rawDate) : null,
          state: c['state']);
    }).toList();
    return PullRequestReviewsResponse(
        pullRequestAuthorId: authorId, reviews: reviews);
  }

  Stream<T> _list<T>(String url, ResProcessor<T> f) async* {
    print('precessing: ${url}');

    //TODO HTTPステータスのチェック
    final res = await http.get(url, headers: header);
    final result = f(res);

    for (var v in result.values) {
      yield v;
    }

    final link = _parseLinkHeader(res.headers['link']);
    final nextUrl = link != null ? link['next'] : null;
    if (nextUrl != null && result.hasNext) {
      yield* _list(nextUrl, f);
    }
  }

  Map<String, String> _parseLinkHeader(String input) {
    final out = <String, String>{};
    final parts = input.split(', ');
    for (final part in parts) {
      if (part[0] != '<') {
        throw const FormatException('Invalid Link Header');
      }
      final kv = part.split('; ');
      var url = kv[0].substring(1);
      url = url.substring(0, url.length - 1);
      var key = kv[1];
      key = key.replaceAll('"', '').substring(4);
      out[key] = url;
    }
    return out;
  }


}

class _PullRequestProcessor {
  final DateTime startDate;

  _PullRequestProcessor(this.startDate);

  _ParsedResult<PullRequestResponse> Function(http.Response res) create() {
    return (http.Response res) {
      var hasNext = false;
      // 認証がうまく言っていないと次の行でキャストできずにエラー
      final List<dynamic> jsonBody = json.decode(res.body);
      final prs = jsonBody
          .map((pr) {
        pr = pr as Map<String, dynamic>;
        return PullRequestResponse.parse(pr);
      })
          .where((pr) => pr.createdAt.isAfter(startDate))
          .toList();

      hasNext = prs.isNotEmpty;
      return _ParsedResult(prs, hasNext);
    };
  }
}

class _ParsedResult<T> {
  final List<T> values;
  final bool hasNext;

  _ParsedResult(this.values, this.hasNext);
}
