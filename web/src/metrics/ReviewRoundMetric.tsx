import { PullRequest } from '../types';
import { Line } from 'react-chartjs-2';
import type { ChartData, ChartOptions } from 'chart.js';
import groupBy from 'lodash.groupby';
import { palette } from '../palette';
import { mean, median } from '../calc';
import WorstPrList from './WorstPrList';

import {
    Box,
    Flex,
    Heading,
    Stat,
    Text,
} from "@chakra-ui/react"


interface Prop {
    months: string[]
    pullRequests: PullRequest[],
    title: string,
    description: string,
}

// 一発承認率 (%) = reviewRounds が 0 の PR の割合。母集団が空なら undefined。
function oneShotRate(prs: PullRequest[]): number | undefined {
    if (prs.length === 0) return undefined;
    const oneShot = prs.filter((pr) => pr.reviewRounds === 0).length;
    return (oneShot / prs.length) * 100;
}

const ReviewRoundMetric: React.FC<Prop> = (prop) => {
    const startMonth = prop.months[0];
    const endMonth = prop.months[prop.months.length - 1];
    const mergedPrs = prop.pullRequests.filter((pr) => !!pr.mergedAt);

    const rateOfWhole = oneShotRate(mergedPrs);
    const avgRounds = mean(mergedPrs.map((pr) => pr.reviewRounds));
    const medianRounds = median(mergedPrs.map((pr) => pr.reviewRounds));

    // 変更タイプ別の月次一発承認率（デフォルト非表示）。
    const groupedByType = groupBy(mergedPrs, (pr) => pr.changeType);
    const rateOfTypeDatasets = Object.entries(groupedByType).map(([type, prs], index) => {
        const rateOfType = Object.entries(groupBy(prs, (pr) => pr.month)).map(([month, prs]) => {
            return { month, rate: oneShotRate(prs) }
        });
        const rateByMonth = prop.months.map((targetMonth) =>
            rateOfType.find((x) => x.month === targetMonth)?.rate ?? null
        );
        return {
            label: type,
            borderColor: palette[index],
            borderWidth: 1,
            pointBorderWidth: 2,
            pointRadius: 2,
            tension: 0,
            fill: false,
            hidden: true,
            spanGaps: true,
            data: rateByMonth
        }
    });

    const rateOfAllType =
        Object.entries(groupBy(mergedPrs, (pr) => pr.month)).map(([month, prs]) => {
            return { month, rate: oneShotRate(prs) }
        });
    const rateOfAllTypeByMonth = prop.months.map((targetMonth) =>
        rateOfAllType.find((x) => x.month === targetMonth)?.rate ?? null
    );
    const rateOfAllTypeDataset = {
        label: '全体(一発承認率)',
        borderColor: '#487ca3',
        borderWidth: 2,
        pointBorderWidth: 2,
        pointRadius: 2,
        tension: 0,
        fill: false,
        spanGaps: true,
        data: rateOfAllTypeByMonth
    }

    const data: ChartData<'line'> = {
        labels: prop.months,
        datasets: [rateOfAllTypeDataset, ...rateOfTypeDatasets]
    }
    const chartOption: ChartOptions<'line'> = {
        plugins: {
            legend: {
                labels: {
                    filter: (item) => item.text.startsWith('全体')
                }
            }
        },
        scales: {
            y: { min: 0, max: 100 }
        },
        maintainAspectRatio: true,
        animation: { duration: 0 },
        spanGaps: true
    }

    return (
        <Box mt="10">
            <Heading size="lg">{prop.title}</Heading>
            <Text fontSize="sm" mt="2">{prop.description}</Text>
            <Flex gap="8" mt="6">
                <Stat.Root>
                    <Stat.Label>一発承認率 ({startMonth} - {endMonth})</Stat.Label>
                    <Stat.ValueText>{rateOfWhole !== undefined ? `${rateOfWhole.toFixed(1)}%` : ' - '}</Stat.ValueText>
                </Stat.Root>
                <Stat.Root>
                    <Stat.Label>平均ラウンド数</Stat.Label>
                    <Stat.ValueText>{avgRounds !== undefined ? avgRounds.toFixed(2) : ' - '}回</Stat.ValueText>
                </Stat.Root>
                <Stat.Root>
                    <Stat.Label>中央ラウンド数</Stat.Label>
                    <Stat.ValueText>{medianRounds !== undefined ? medianRounds.toFixed(1) : ' - '}回</Stat.ValueText>
                </Stat.Root>
            </Flex>
            <Box mt="2">
                <Line data={data} width={100} height={20} options={chartOption} />
            </Box>
            <WorstPrList
                pullRequests={mergedPrs}
                metricValue={(pr) => pr.reviewRounds}
                unit="回" />
        </Box>
    );
}

export default ReviewRoundMetric;
