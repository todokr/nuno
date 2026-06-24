// chart.js v4 はツリーシェイク対応のため、使用するコンポーネントを明示的に登録する必要がある。
// 折れ線グラフ (Line) に必要なスケール・要素・プラグインをまとめて登録する。
import {
  Chart,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Legend,
  Tooltip,
  Filler,
} from 'chart.js';

Chart.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Legend,
  Tooltip,
  Filler,
);
