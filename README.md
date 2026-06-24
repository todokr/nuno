# nuno

> Not only does it help you have great timing, but it helps you understand how a band works.  
> -- Nuno Bettencourt


GitHub のプルリクエストからリードタイム等のメトリクスを収集する CLI ツールと、それを可視化する Web フロントエンド (React) で構成される。

CLI は直近 6 ヶ月分のクローズ済み PR を GitHub API から取得し、集計結果を `web/src/data/out.json` に書き出す。Web フロントは生成された JSON を読み込んで表示する。

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

| 環境変数              | 説明                       |
| --------------------- | -------------------------- |
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
