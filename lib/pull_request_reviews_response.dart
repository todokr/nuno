class ReviewResponse {
  int reviewerId;
  DateTime date;
  String state;

  ReviewResponse({this.reviewerId, this.date, this.state});
}

class PullRequestReviewsResponse {
  int pullRequestAuthorId;
  List<ReviewResponse> reviews;

  PullRequestReviewsResponse({this.pullRequestAuthorId, this.reviews});

  ReviewResponse oldestReaction() {
    final reviewsExcludeAuthor = reviews.where((r) => r.reviewerId != pullRequestAuthorId);
    if (reviewsExcludeAuthor.isEmpty) {
      return null;
    } else {
      return reviewsExcludeAuthor.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
    }
  }

  ReviewResponse latestApproval() {
    final reviewsExcludeAuthor =
      reviews.where((r) => r.reviewerId != pullRequestAuthorId && r.state == 'APPROVED');
    if (reviewsExcludeAuthor.isEmpty) {
      return null;
    } else {
      return reviewsExcludeAuthor.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    }
  }
}
