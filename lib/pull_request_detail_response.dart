class PullRequestDetailResponse {
  int commits;
  int additions;
  int deletions;
  int changeFiles;

  PullRequestDetailResponse({this.commits, this.additions, this.deletions, this.changeFiles});

  factory PullRequestDetailResponse.parse(Map<String, dynamic> githubResponse) {
    return PullRequestDetailResponse(
      commits: githubResponse['commits'],
      additions: githubResponse['additions'] ?? 0,
      deletions: githubResponse['deletions'] ?? 0,
      changeFiles: githubResponse['changed_files'] ?? 0,
    );
  }
}
