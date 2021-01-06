class CommitResponse {
  DateTime date;

  CommitResponse({this.date});
}

class PullRequestCommitsResponse {
  List<CommitResponse> commits;

  PullRequestCommitsResponse({this.commits});

  CommitResponse oldest() {
    if (commits.isEmpty) {
      return null;
    } else {
      return commits.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
    }
  }
}
