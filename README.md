# nuno

> Not only does it help you have great timing, but it helps you understand how a band works.  
> -- Nuno Bettencourt


GitHub のプルリクエストからリードタイム等のメトリクスを収集する CLI ツールと、それを可視化する Web フロントエンド (React) で構成される。

CLI は直近 6 ヶ月分のクローズ済み PR を GitHub API から取得し、集計結果を `web/public/out.json` に書き出す。Web フロントは生成された JSON を読み込んで表示する。

## 構成

- `src/` — CLI 本体 (TypeScript / Node.js)
- `web/` — 可視化用フロントエンド (React + TypeScript)

## 必要環境

- Node.js >= 18 (組み込み `fetch` を利用)

## セットアップ

```sh
npm install
```

## 実行

以下の環境変数を設定して実行する。

| 環境変数              | 必須 | 説明                                                                                              |
| --------------------- | ---- | ------------------------------------------------------------------------------------------------- |
| `GITHUB_TOKEN`        | ○    | GitHub のアクセストークン                                                                          |
| `TARGET_ORGANIZATION` | ○    | 対象の Organization / User                                                                         |
| `TARGET_REPOSITORY`   | ○    | 対象のリポジトリ名                                                                                 |
| `TARGET_AUTHORS`      |      | 集計対象とする作者の GitHub ユーザー名 (login)。カンマ区切りで複数指定可。未指定なら全員を対象とする |

```sh
GITHUB_TOKEN=xxx TARGET_ORGANIZATION=your-org TARGET_REPOSITORY=your-repo npm start

# 特定ユーザーの PR のみ集計する場合（大文字小文字は区別しない）
GITHUB_TOKEN=xxx TARGET_ORGANIZATION=your-org TARGET_REPOSITORY=your-repo \
  TARGET_AUTHORS=octocat,torvalds npm start
```

実行すると `web/public/out.json` が生成される。

## out.json のスキーマと各指標の意味（分析 AI 向け）

`web/public/out.json` を読んで生産性を分析する AI / 人間のためのリファレンス。

### トップレベル構造

```jsonc
{
  "targetMonths": ["2026-01", ...],  // 集計対象の月 (YYYY-MM)、古い順
  "pullRequests": [ /* PullRequest オブジェクトの配列 */ ]
}
```

### PullRequest の生フィールド

CLI が GitHub API から取得・集計してそのまま出力する値。日時はすべて **ISO 8601 文字列 (UTC)**。値が取得できない場合は `null`。

| フィールド | 型 | 意味 / 取得元 |
| --- | --- | --- |
| `title` | string | PR タイトル。`type(module): 本文` 形式ならプレフィックスを除いた本文部分 |
| `url` | string | PR の HTML URL |
| `oldestCommitDate` | string\|null | PR 内で**最も古いコミット**の author date。作業着手時刻の近似 |
| `createdAt` | string | **PR 作成**日時 (GitHub `created_at`) |
| `oldestReactionDate` | string\|null | **作者以外による最初のレビュー**の日時。最初のレビュー反応 |
| `latestApprovalDate` | string\|null | **作者以外による最新の APPROVED レビュー**の日時 |
| `mergedAt` | string\|null | **マージ**日時。`null` は未マージ（クローズのみ） |
| `issueCreatedAt` | string\|null | PR にリンクされた issue (GraphQL `closingIssuesReferences`) のうち**最も古い issue の作成日時**。リンクが無ければ `null` |
| `commits` | number | コミット数 |
| `additions` | number | 追加行数 |
| `deletions` | number | 削除行数 |
| `changedFiles` | number | 変更ファイル数 |
| `reviewRounds` | number | **作者以外による `CHANGES_REQUESTED`（変更要求）レビューの件数**。`0` は一発承認 |
| `state` | string | PR の状態 (`open` / `closed`) |
| `moduleName` | string\|null | タイトルの `type(module):` の `module` 部分（例: `feat(auth): ...` → `auth`） |
| `changeType` | string\|null | タイトルの `type` 部分（例: `feat`, `fix`, `chore`, `refactor` ...） |

> 注: 生フィールドに `month` は含まれない。月別集計が必要なら `createdAt` から `YYYY-MM` を導出する。

### 派生指標（分析の主役）

上記の生フィールドから計算される指標。**いずれも単位は「時間 (hour)」で、ゼロ方向に切り捨て**（web フロントの `requestFromJson` での算出と同一）。被演算子のどちらかが欠損していれば `undefined`（＝集計から除外）。**すべて小さいほど良い**。

| 指標 | 計算式 | 意味 |
| --- | --- | --- |
| `timeToRequest` | `createdAt - oldestCommitDate` | 最初のコミットから PR 作成まで（PR を上げるまでの時間） |
| `timeToResponse` | `oldestReactionDate - createdAt` | PR 作成から最初のレビューまで（レビュー着手の速さ） |
| `timeToApproval` | `latestApprovalDate - oldestReactionDate` | 最初のレビューから最終 Approve まで（レビューの往復にかかる時間） |
| `timeToMerge` | `mergedAt - latestApprovalDate` | 最終 Approve からマージまで |
| `totalLeadTime` | `latestApprovalDate - oldestCommitDate` | コミット起点の総リードタイム（着手 → Approve） |
| `issueToFirstCommit` | `oldestCommitDate - issueCreatedAt` | issue 作成から最初のコミットまで（**着手までの待ち時間**） |
| `issueToMerge` | `mergedAt - issueCreatedAt` | issue 作成からマージまで（**課題起点の総リードタイム**） |
| `changeSize` | `additions + deletions` | 変更行数（単位は「行」） |

### 分析時の注意点

- **集計母集団**: ダッシュボードは `mergedAt != null`（マージ済み）の PR のみを集計対象にしている。分析でも同様にマージ済みへ絞ると整合する。
- **代表値は中央値推奨**: `changeSize` と各リードタイムは分布の歪みが大きく、平均は少数の巨大 PR / 長期滞留 issue に強く引っ張られる。中央値・分位点での評価が望ましい。
- **issue 起点指標の母数**: `issueCreatedAt` が取れるのは issue がリンクされた PR のみ。リンク率が低いと `issueToMerge` / `issueToFirstCommit` の n は他指標より小さくなる。
- **issue 起点指標は滞留を含む**: `closingIssuesReferences` は古い issue も拾うため、長期バックログを回収した PR では `issueToMerge` / `issueToFirstCommit` が極端に大きくなる。p90 等の外れ値や「直近作成 issue 限定」での再集計に注意。
- **`issueToFirstCommit` は負になりうる**: 先にブランチ作業を始めてから issue を立てた場合。「issue 化が後追い」のシグナルとして値はそのまま保持している。
- **時刻は UTC**: 営業時間・曜日での分析を行う場合はタイムゾーン変換が必要。

### 分析プロンプト例（AI に分析させる場合）

`out.json` を AI に渡して分析させるときのプロンプト指針とテンプレート。

#### 効果的なプロンプトの原則

1. **スキーマと派生指標の定義を最初に渡す** — 上記「out.json のスキーマと各指標の意味」節をそのまま貼る。これがないと `additions + deletions` の誤計算や `reviewRounds` の取り違えが起きる。
2. **集計ルールを明示** — 「マージ済み (`mergedAt != null`) に絞る」「代表値は**中央値**（平均は巨大 PR に引っ張られる）」「各指標の `n` も出す」。
3. **注意点を制約として与える** — 「issue 起点指標は滞留を含むので外れ値 / p90 に注意」「UTC」「issue リンク無しは除外され母数が減る」。
4. **出力形式を指定** — 「指標サマリ表 ＋ 示唆 ＋ 施策（効果順・根拠データ付き）」のように構造を決める。
5. **観点を絞る** — 「AI 駆動開発での開発速度向上」のように目的のレンズを与えると、深掘り先を選んでくれる。

#### ベースとなるコンテキストプロンプト（先頭に置く）

```
あなたは開発生産性アナリスト。添付の out.json は GitHub PR メトリクス。
スキーマと派生指標の定義は以下に従うこと（README より）:
<README の「out.json のスキーマと各指標の意味」節を貼り付け>

分析ルール:
- 母集団は mergedAt != null（マージ済み）に限定
- 代表値は中央値を主とし、平均・p90 も併記。各指標の n を必ず示す
- 派生指標は上記の計算式で算出（単位: 時間、changeSize は行）
- issue 起点指標(issueToMerge / issueToFirstCommit)は古い issue の滞留を含むため外れ値に注意
- 時刻は UTC
出力: ①指標サマリ表 ②主要インサイト3〜5点（根拠の数値付き）③施策（効果順・各々に根拠データ）
```

#### 目的別タスクプロンプト

**ボトルネック特定**

```
totalLeadTime と issueToMerge を分解し、どのフェーズ(timeToRequest/Response/Approval/Merge、
および issue→着手)が最も時間を占めるかを中央値で示せ。最大のボトルネックを1つ挙げ、なぜか説明せよ。
```

**PR サイズの影響（崖の検証）**

```
changeSize を [0-50,50-200,200-500,500-1000,1000+] でバケット分けし、各バケットの
totalLeadTime・timeToApproval・一発承認率(reviewRounds==0の割合)の中央値とPR数を表にせよ。
リードタイムが跳ねる閾値(崖)があるか判定せよ。
```

**レビュー効率**

```
reviewRounds 別(0/1/2/3+)に PR数・中央 changeSize・中央 totalLeadTime を出し、
差し戻し1回あたりの遅延コストを定量化せよ。一発承認率も算出せよ。
```

**相関分析**

```
changeSize, commits, reviewRounds と totalLeadTime の Pearson 相関係数(と n)を算出し、
遅延に最も効く要因を特定せよ。「行数」と「コミット数」のどちらがより効くか比較せよ。
```

**ワースト PR 抽出（具体アクション用）**

```
totalLeadTime と issueToMerge それぞれのワースト10 PR を title/url/値/changeSize 付きで列挙し、
共通パターン(大規模・特定モジュール・差し戻し多)を要約せよ。
```

**月次トレンド**

```
createdAt から月(YYYY-MM)を導出し、月次の中央 changeSize・totalLeadTime・一発承認率・
issueToMerge を時系列表にし、改善/悪化の傾向を述べよ。
```

**施策立案（観点付き）**

```
上記の分析を踏まえ、「AI駆動開発での開発速度向上」の観点で施策を効果が大きい順に提案せよ。
各施策に (a)根拠となる数値 (b)期待効果 (c)計測方法 を付けること。
AIで生成が速くなる前提で、削れる時間と削れない時間を区別せよ。
```

#### アンチパターン（精度が落ちる）

- スキーマを渡さず「このJSONを分析して」だけ → 指標の誤計算・的外れな集計
- 「平均は？」とだけ聞く → 巨大 PR / 滞留 issue に歪められた数字を鵜呑み
- 母集団(マージ済み)や `n` を指定しない → open PR や未マージが混ざる
- 注意点を渡さない → issue 滞留の外れ値を「最近の着手遅延」と誤読

## ビルド / テスト

```sh
npm run build      # dist/ に JS を出力
npm run typecheck  # 型チェックのみ
npm test           # ユニットテスト
```

## Web フロントエンド

```sh
cd web
npm install
npm start
```
