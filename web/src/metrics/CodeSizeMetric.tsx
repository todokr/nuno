import { PullRequest } from '../types';
import { Line } from 'react-chartjs-2';
import type { ChartData, ChartOptions } from 'chart.js';
import groupBy from 'lodash.groupby';
import { palette } from '../palette';
import { mean, median } from '../calc';
import { statusBadge } from './statusBadge';
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
    changeSize?: number,
    title: string,
    description: string,
}

const CodeSizeMetric: React.FC<Prop> = (prop) => {
    const startMonth = prop.months[0];
    const endMonth = prop.months[prop.months.length - 1];
    const mergedPrs = prop.pullRequests.filter((pr) => !!pr.mergedAt);

    const avgOfWhole = mean(mergedPrs.map((pr) => pr.changeSize));
    const medianOfWhole = median(mergedPrs.map((pr) => pr.changeSize));
    const groupedByType = groupBy(mergedPrs, (pr) => pr.changeType);
    const avgOfTypeDatasets = Object.entries(groupedByType).map(([type, prs], index) => {
        const avgOfType = Object.entries(groupBy(prs, (pr) => pr.month)).map(([month, prs]) => {
            const avgHours = mean(prs.map((pr) => pr.changeSize));
            return { month, avgHours }
        });
        const avgOfTypeByMonth = prop.months.map((targetMonth) =>
            avgOfType.find((x) => x.month === targetMonth)?.avgHours ?? null
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
            data: avgOfTypeByMonth
        }
    });

    const avgOfAllType =
        Object.entries(groupBy(mergedPrs, (pr) => pr.month)).map(([month, prs]) => {
            const avgHours = mean(prs.map((pr) => pr.changeSize));
            return { month, avgHours }
        });
    const avgOfAllTypeByMonth = prop.months.map((targetMonth) =>
        avgOfAllType.find((x) => x.month === targetMonth)?.avgHours ?? null
    );
    const avgOfAllTypeDataset = {
        label: '全体(平均)',
        borderColor: '#444',
        borderWidth: 2,
        pointBorderWidth: 2,
        pointRadius: 2,
        tension: 0,
        fill: false,
        spanGaps: true,
        data: avgOfAllTypeByMonth
    }

    const medianOfAllType =
        Object.entries(groupBy(mergedPrs, (pr) => pr.month)).map(([month, prs]) => {
            const medianSize = median(prs.map((pr) => pr.changeSize));
            return { month, medianSize }
        });
    const medianOfAllTypeByMonth = prop.months.map((targetMonth) =>
        medianOfAllType.find((x) => x.month === targetMonth)?.medianSize ?? null
    );
    const medianOfAllTypeDataset = {
        label: '全体(中央値)',
        borderColor: '#c0542d',
        borderWidth: 2,
        pointBorderWidth: 2,
        pointRadius: 2,
        tension: 0,
        fill: false,
        spanGaps: true,
        data: medianOfAllTypeByMonth
    }
    const targetDataset = {
        label: '目標値',
        borderColor: '#666',
        borderWidth: 1,
        pointBorderWidth: 0,
        borderDash: [2],
        pointRadius: 0,
        tension: 0,
        fill: false,
        spanGaps: true,
        data: prop.months.map(() => prop.changeSize ?? null)
    };

    const data: ChartData<'line'> = {
        labels: prop.months,
        datasets: [avgOfAllTypeDataset, medianOfAllTypeDataset, ...avgOfTypeDatasets, targetDataset]
    }
    const chartOption: ChartOptions<'line'> = {
        plugins: {
            legend: {
                labels: {
                    filter: (item) => item.text.startsWith('全体')
                }
            }
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
                    <Stat.Label>平均変更行数 ({startMonth} - {endMonth})</Stat.Label>
                    <Stat.ValueText>{avgOfWhole ? avgOfWhole.toFixed(1) : ' - '}行{statusBadge(prop.changeSize, avgOfWhole)}</Stat.ValueText>
                </Stat.Root>
                <Stat.Root>
                    <Stat.Label>中央変更行数 ({startMonth} - {endMonth})</Stat.Label>
                    <Stat.ValueText>{medianOfWhole !== undefined ? medianOfWhole.toFixed(1) : ' - '}行{statusBadge(prop.changeSize, medianOfWhole)}</Stat.ValueText>
                </Stat.Root>
                <Stat.Root>
                    <Stat.Label>目標値</Stat.Label>
                    <Stat.ValueText>{prop.changeSize ? `${prop.changeSize} 行` : '-' }</Stat.ValueText>
                </Stat.Root>
            </Flex>
            <Box mt="2">
                <Line data={data} width={100} height={20} options={chartOption} />
            </Box>
            <WorstPrList
                pullRequests={mergedPrs}
                metricValue={(pr) => pr.changeSize}
                unit="行" />
        </Box>
    );
}

export default CodeSizeMetric;
