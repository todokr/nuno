# web

nuno の CLI が生成したメトリクス JSON を可視化するフロントエンド。

- ビルドツール: [Vite](https://vite.dev/)
- UI: React 19 + [Chakra UI v3](https://www.chakra-ui.com/)
- グラフ: [Chart.js 4](https://www.chartjs.org/) + react-chartjs-2
- 日付: [Day.js](https://day.js.org/)

## セットアップ

```sh
npm install
```

## 開発サーバー

```sh
npm run dev
```

[http://localhost:3000](http://localhost:3000) で開く。

`public/out.json`（メトリクスデータ）と `public/objectives.json`（目標値）を読み込む。
メトリクスデータは親ディレクトリの CLI で生成する。

## ビルド / プレビュー

```sh
npm run build      # dist/ に本番ビルドを出力
npm run preview    # ビルド成果物をローカルで確認
npm run typecheck  # 型チェックのみ
```
