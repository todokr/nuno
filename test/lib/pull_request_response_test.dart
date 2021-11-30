import 'package:test/test.dart';

import 'dart:convert' show json;

import 'package:nuno/pull_request_response.dart';


void main() {
  group('JSON', () {
      final jsonString = '''
  {
    "url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134",
    "id": 790232883,
    "node_id": "PR_kwDOBQg4t84vGf8z",
    "html_url": "https://github.com/bizreach-inc/hrmony-prf/pull/5134",
    "diff_url": "https://github.com/bizreach-inc/hrmony-prf/pull/5134.diff",
    "patch_url": "https://github.com/bizreach-inc/hrmony-prf/pull/5134.patch",
    "issue_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/5134",
    "number": 5134,
    "state": "open",
    "locked": false,
    "title": "refactor: SBPRF-12887 Update cats-core to 2.7.0",
    "user": {
      "login": "usaitani",
      "id": 34016317,
      "node_id": "MDQ6VXNlcjM0MDE2MzE3",
      "avatar_url": "https://avatars.githubusercontent.com/u/34016317?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/usaitani",
      "html_url": "https://github.com/usaitani",
      "followers_url": "https://api.github.com/users/usaitani/followers",
      "following_url": "https://api.github.com/users/usaitani/following{/other_user}",
      "gists_url": "https://api.github.com/users/usaitani/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/usaitani/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/usaitani/subscriptions",
      "organizations_url": "https://api.github.com/users/usaitani/orgs",
      "repos_url": "https://api.github.com/users/usaitani/repos",
      "events_url": "https://api.github.com/users/usaitani/events{/privacy}",
      "received_events_url": "https://api.github.com/users/usaitani/received_events",
      "type": "User",
      "site_admin": false
    },
    "body": "Updates [org.typelevel:cats-core](https://github.com/typelevel/cats) from 2.1.1 to 2.7.0.\\n[GitHub Release Notes](https://github.com/typelevel/cats/releases/tag/v2.7.0) - [Changelog](https://github.com/typelevel/cats/blob/master/CHANGES.md) - [Version Diff](https://github.com/typelevel/cats/compare/v2.1.1...v2.7.0)\\n\\nI'll automatically update this PR to resolve conflicts as long as you don't change it yourself.\\n\\nIf you'd like to skip this version, you can just close this PR. If you have any feedback, just mention me in the comments below.\\n\\nConfigure Scala Steward for your repository with a [`.scala-steward.conf`](https://github.com/scala-steward-org/scala-steward/blob/572c6925b850fae4a582d3aad470c650d56c2822/docs/repo-specific-configuration.md) file.\\n\\nHave a fantastic day writing Scala!\\n\\n<details>\\n<summary>Applied Migrations</summary>\\n\\n* github:typelevel/cats/Cats_v2_2_0?sha=v2.2.0\\n\\nDocumentation:\\n\\n* https://github.com/typelevel/cats/blob/v2.2.0/scalafix/README.md#migration-to-cats-v220\\n</details>\\n<details>\\n<summary>Files still referring to the old version number</summary>\\n\\nThe following files still refer to the old version number (2.1.1).\\nYou might want to review and update them manually.\\n```\\n.github/workflows/pr-jira-linker/package-lock.json\\ndb/README.md\\ndocker/core-mock-server/package-lock.json\\ndocker/image-server/package-lock.json\\ndocs/rest-api/package-lock.json\\n```\\n</details>\\n<details>\\n<summary>Ignore future updates</summary>\\n\\nAdd this to your `.scala-steward.conf` file to ignore future updates of this dependency:\\n```\\nupdates.ignore = [ { groupId = \\"org.typelevel\\", artifactId = \\"cats-core\\" } ]\\n```\\n</details>\\n\\nlabels: library-update, semver-minor, scalafix-migrations, old-version-remains",
    "created_at": "2021-11-29T01:25:30Z",
    "updated_at": "2021-11-29T01:27:08Z",
    "closed_at": null,
    "merged_at": null,
    "merge_commit_sha": "f5465600db8c70b5afb88ca339a7f3099b9903be",
    "assignee": null,
    "assignees": [

    ],
    "requested_reviewers": [

    ],
    "requested_teams": [

    ],
    "labels": [
      {
        "id": 1457078808,
        "node_id": "MDU6TGFiZWwxNDU3MDc4ODA4",
        "url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/labels/xem",
        "name": "xem",
        "color": "0949b7",
        "default": false,
        "description": "XEM"
      },
      {
        "id": 3539497732,
        "node_id": "LA_kwDOBQg4t87S-HME",
        "url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/labels/steward",
        "name": "steward",
        "color": "ededed",
        "default": false,
        "description": "Created by scala-steward"
      }
    ],
    "milestone": null,
    "draft": false,
    "commits_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134/commits",
    "review_comments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134/comments",
    "review_comment_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/comments{/number}",
    "comments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/5134/comments",
    "statuses_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/statuses/9cc31e03095937352c897bc92b855f3d3599f3b6",
    "head": {
      "label": "bizreach-inc:update/cats-core-2.7.0",
      "ref": "update/cats-core-2.7.0",
      "sha": "9cc31e03095937352c897bc92b855f3d3599f3b6",
      "user": {
        "login": "bizreach-inc",
        "id": 61264651,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjYxMjY0NjUx",
        "avatar_url": "https://avatars.githubusercontent.com/u/61264651?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/bizreach-inc",
        "html_url": "https://github.com/bizreach-inc",
        "followers_url": "https://api.github.com/users/bizreach-inc/followers",
        "following_url": "https://api.github.com/users/bizreach-inc/following{/other_user}",
        "gists_url": "https://api.github.com/users/bizreach-inc/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/bizreach-inc/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/bizreach-inc/subscriptions",
        "organizations_url": "https://api.github.com/users/bizreach-inc/orgs",
        "repos_url": "https://api.github.com/users/bizreach-inc/repos",
        "events_url": "https://api.github.com/users/bizreach-inc/events{/privacy}",
        "received_events_url": "https://api.github.com/users/bizreach-inc/received_events",
        "type": "Organization",
        "site_admin": false
      },
      "repo": {
        "id": 84424887,
        "node_id": "MDEwOlJlcG9zaXRvcnk4NDQyNDg4Nw==",
        "name": "hrmony-prf",
        "full_name": "bizreach-inc/hrmony-prf",
        "private": true,
        "owner": {
          "login": "bizreach-inc",
          "id": 61264651,
          "node_id": "MDEyOk9yZ2FuaXphdGlvbjYxMjY0NjUx",
          "avatar_url": "https://avatars.githubusercontent.com/u/61264651?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/bizreach-inc",
          "html_url": "https://github.com/bizreach-inc",
          "followers_url": "https://api.github.com/users/bizreach-inc/followers",
          "following_url": "https://api.github.com/users/bizreach-inc/following{/other_user}",
          "gists_url": "https://api.github.com/users/bizreach-inc/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/bizreach-inc/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/bizreach-inc/subscriptions",
          "organizations_url": "https://api.github.com/users/bizreach-inc/orgs",
          "repos_url": "https://api.github.com/users/bizreach-inc/repos",
          "events_url": "https://api.github.com/users/bizreach-inc/events{/privacy}",
          "received_events_url": "https://api.github.com/users/bizreach-inc/received_events",
          "type": "Organization",
          "site_admin": false
        },
        "html_url": "https://github.com/bizreach-inc/hrmony-prf",
        "description": "HRMOS評価管理",
        "fork": false,
        "url": "https://api.github.com/repos/bizreach-inc/hrmony-prf",
        "forks_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/forks",
        "keys_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/teams",
        "hooks_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/hooks",
        "issue_events_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/events{/number}",
        "events_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/events",
        "assignees_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/assignees{/user}",
        "branches_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/branches{/branch}",
        "tags_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/tags",
        "blobs_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/languages",
        "stargazers_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/stargazers",
        "contributors_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/contributors",
        "subscribers_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/subscribers",
        "subscription_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/subscription",
        "commits_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/contents/{+path}",
        "compare_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/merges",
        "archive_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/downloads",
        "issues_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues{/number}",
        "pulls_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/labels{/name}",
        "releases_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/releases{/id}",
        "deployments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/deployments",
        "created_at": "2017-03-09T09:42:52Z",
        "updated_at": "2021-11-30T00:33:28Z",
        "pushed_at": "2021-11-30T02:20:56Z",
        "git_url": "git://github.com/bizreach-inc/hrmony-prf.git",
        "ssh_url": "git@github.com:bizreach-inc/hrmony-prf.git",
        "clone_url": "https://github.com/bizreach-inc/hrmony-prf.git",
        "svn_url": "https://github.com/bizreach-inc/hrmony-prf",
        "homepage": null,
        "size": 80022,
        "stargazers_count": 6,
        "watchers_count": 6,
        "language": "Scala",
        "has_issues": true,
        "has_projects": false,
        "has_downloads": true,
        "has_wiki": false,
        "has_pages": true,
        "forks_count": 3,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 62,
        "license": null,
        "allow_forking": false,
        "is_template": false,
        "topics": [

        ],
        "visibility": "private",
        "forks": 3,
        "open_issues": 62,
        "watchers": 6,
        "default_branch": "develop"
      }
    },
    "base": {
      "label": "bizreach-inc:develop",
      "ref": "develop",
      "sha": "72b4de97f342bfb3078e5b3a55ad76bb4a4bed3e",
      "user": {
        "login": "bizreach-inc",
        "id": 61264651,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjYxMjY0NjUx",
        "avatar_url": "https://avatars.githubusercontent.com/u/61264651?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/bizreach-inc",
        "html_url": "https://github.com/bizreach-inc",
        "followers_url": "https://api.github.com/users/bizreach-inc/followers",
        "following_url": "https://api.github.com/users/bizreach-inc/following{/other_user}",
        "gists_url": "https://api.github.com/users/bizreach-inc/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/bizreach-inc/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/bizreach-inc/subscriptions",
        "organizations_url": "https://api.github.com/users/bizreach-inc/orgs",
        "repos_url": "https://api.github.com/users/bizreach-inc/repos",
        "events_url": "https://api.github.com/users/bizreach-inc/events{/privacy}",
        "received_events_url": "https://api.github.com/users/bizreach-inc/received_events",
        "type": "Organization",
        "site_admin": false
      },
      "repo": {
        "id": 84424887,
        "node_id": "MDEwOlJlcG9zaXRvcnk4NDQyNDg4Nw==",
        "name": "hrmony-prf",
        "full_name": "bizreach-inc/hrmony-prf",
        "private": true,
        "owner": {
          "login": "bizreach-inc",
          "id": 61264651,
          "node_id": "MDEyOk9yZ2FuaXphdGlvbjYxMjY0NjUx",
          "avatar_url": "https://avatars.githubusercontent.com/u/61264651?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/bizreach-inc",
          "html_url": "https://github.com/bizreach-inc",
          "followers_url": "https://api.github.com/users/bizreach-inc/followers",
          "following_url": "https://api.github.com/users/bizreach-inc/following{/other_user}",
          "gists_url": "https://api.github.com/users/bizreach-inc/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/bizreach-inc/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/bizreach-inc/subscriptions",
          "organizations_url": "https://api.github.com/users/bizreach-inc/orgs",
          "repos_url": "https://api.github.com/users/bizreach-inc/repos",
          "events_url": "https://api.github.com/users/bizreach-inc/events{/privacy}",
          "received_events_url": "https://api.github.com/users/bizreach-inc/received_events",
          "type": "Organization",
          "site_admin": false
        },
        "html_url": "https://github.com/bizreach-inc/hrmony-prf",
        "description": "HRMOS評価管理",
        "fork": false,
        "url": "https://api.github.com/repos/bizreach-inc/hrmony-prf",
        "forks_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/forks",
        "keys_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/teams",
        "hooks_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/hooks",
        "issue_events_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/events{/number}",
        "events_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/events",
        "assignees_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/assignees{/user}",
        "branches_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/branches{/branch}",
        "tags_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/tags",
        "blobs_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/languages",
        "stargazers_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/stargazers",
        "contributors_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/contributors",
        "subscribers_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/subscribers",
        "subscription_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/subscription",
        "commits_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/contents/{+path}",
        "compare_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/merges",
        "archive_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/downloads",
        "issues_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues{/number}",
        "pulls_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/labels{/name}",
        "releases_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/releases{/id}",
        "deployments_url": "https://api.github.com/repos/bizreach-inc/hrmony-prf/deployments",
        "created_at": "2017-03-09T09:42:52Z",
        "updated_at": "2021-11-30T00:33:28Z",
        "pushed_at": "2021-11-30T02:20:56Z",
        "git_url": "git://github.com/bizreach-inc/hrmony-prf.git",
        "ssh_url": "git@github.com:bizreach-inc/hrmony-prf.git",
        "clone_url": "https://github.com/bizreach-inc/hrmony-prf.git",
        "svn_url": "https://github.com/bizreach-inc/hrmony-prf",
        "homepage": null,
        "size": 80022,
        "stargazers_count": 6,
        "watchers_count": 6,
        "language": "Scala",
        "has_issues": true,
        "has_projects": false,
        "has_downloads": true,
        "has_wiki": false,
        "has_pages": true,
        "forks_count": 3,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 62,
        "license": null,
        "allow_forking": false,
        "is_template": false,
        "topics": [

        ],
        "visibility": "private",
        "forks": 3,
        "open_issues": 62,
        "watchers": 6,
        "default_branch": "develop"
      }
    },
    "_links": {
      "self": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134"
      },
      "html": {
        "href": "https://github.com/bizreach-inc/hrmony-prf/pull/5134"
      },
      "issue": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/5134"
      },
      "comments": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/issues/5134/comments"
      },
      "review_comments": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134/comments"
      },
      "review_comment": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/comments{/number}"
      },
      "commits": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/pulls/5134/commits"
      },
      "statuses": {
        "href": "https://api.github.com/repos/bizreach-inc/hrmony-prf/statuses/9cc31e03095937352c897bc92b855f3d3599f3b6"
      }
    },
    "author_association": "COLLABORATOR",
    "auto_merge": null,
    "active_lock_reason": null
  }''';

      test('test json extraction', () {
        final jsonRaw = json.decode(jsonString);

        final pr = PullRequestResponse.parse(jsonRaw);

        expect(pr.createdAt, DateTime.parse('2021-11-29T01:25:30Z'));
        expect(pr.labels, ['xem', 'steward']);
      });
  });
}
