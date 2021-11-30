class PullRequestResponse {
  String title;
  int authorId;
  int number;
  String url;
  DateTime createdAt;
  DateTime mergedAt;
  String state;
  List<String> labels;
  String baseBranch;

  PullRequestResponse(
      {this.title,
      this.authorId,
      this.number,
      this.url,
      this.createdAt,
      this.mergedAt,
      this.state,
      this.labels,
      this.baseBranch});

  factory PullRequestResponse.parse(Map<String, dynamic> githubResponse) {
    final createdAt = DateTime.parse(githubResponse['created_at']);
    final mergedAt = githubResponse['merged_at'] != null
        ? DateTime.parse(githubResponse['merged_at'])
        : null;
    final List<dynamic> labels = githubResponse['labels'];
    final labelNames = labels.map((l) => l['name'].toString()).toList();
    return PullRequestResponse(
      title: githubResponse['title'],
      authorId: githubResponse['user']['id'],
      number: githubResponse['number'],
      url: githubResponse['html_url'],
      createdAt: createdAt,
      mergedAt: mergedAt,
      state: githubResponse['state'],
      labels: labelNames,
      baseBranch: githubResponse['base']['ref']);
  }
}
