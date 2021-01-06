import React from 'react';
import { PullRequest } from '../types';
import {Line} from 'react-chartjs-2';
import groupBy from 'lodash.groupby';
import { palette } from '../palette';
import { mean } from '../calc';
import { statusBadge } from './statusBadge';

import {
    Box,
    Heading,
    Stat,
    StatLabel,
    StatNumber,
    StatGroup,
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
    const groupedByType = groupBy(mergedPrs, (pr) => pr.changeType);
    const avgOfTypeDatasets = Object.entries(groupedByType).map(([type, prs], index) => {
        const avgOfType = Object.entries(groupBy(prs, (pr) => pr.month)).map(([month, prs]) => {
            const avgHours = mean(prs.map((pr) => pr.changeSize));
            return { month, avgHours }
        });
        const avgOfTypeByMonth = prop.months.map((targetMonth) =>
            avgOfType.find((x) => x.month === targetMonth)?.avgHours
        );

        return {
            label: type,
            borderColor: palette[index],
            borderWidth: 1,
            pointBorderWidth: 2,
            pointRadius: 2,
            lineTension: 0,
            fill: false,
            hidden: true,
            data: avgOfTypeByMonth
        }
    });

    const avgOfAllType =
        Object.entries(groupBy(mergedPrs, (pr) => pr.month)).map(([month, prs]) => {
            const avgHours = mean(prs.map((pr) => pr.changeSize));
            return { month, avgHours }
        });
    const avgOfAllTypeByMonth = prop.months.map((targetMonth) =>
        avgOfAllType.find((x) => x.month === targetMonth)?.avgHours
    );
    const avgOfAllTypeDataset = {
        label: '全体',
        borderColor: '#444',
        borderWidth: 2,
        pointBorderWidth: 2,
        pointRadius: 2,
        lineTension: 0,
        fill: false,
        data: avgOfAllTypeByMonth
    }
    const targetDataset = {
        label: '目標値',
        borderColor: '#666',
        borderWidth: 1,
        pointBorderWidth: 0,
        borderDash: [2],
        pointRadius: 0,
        lineTension: 0,
        fill: false,
        data: prop.months.map(() => prop.changeSize)
    };

    const data = {
        labels: prop.months,
        datasets: [avgOfAllTypeDataset, ...avgOfTypeDatasets, targetDataset]
    }
    const chartOption = {
        legend: {
            labels: {
                filter: function(items: any){
                    return items.text !== '目標値';
                }
            }
        },
        maintainAspectRatio: true,
        animation: { duration: 0 },
        hover: { animationDuration: 0 },
        responsiveAnimationDuration: 0,
        spanGaps: true
    }

    return (
        <Box mt="10">
            <Heading size="lg">{prop.title}</Heading>
            <Text fontSize="sm" mt="2">{prop.description}</Text>
            <StatGroup mt="6">
                <Stat>
                    <StatLabel>平均変更行数 ({startMonth} - {endMonth})</StatLabel>
                    <StatNumber>{avgOfWhole ? avgOfWhole.toFixed(1) : ' - '}行{statusBadge(prop.changeSize, avgOfWhole)}</StatNumber>
                </Stat>
                <Stat>
                    <StatLabel>目標値</StatLabel>
                    <StatNumber>{prop.changeSize ? `${prop.changeSize} 行` : '-' }</StatNumber>
                </Stat>
            </StatGroup>
            <Box mt="2">
                <Line data={data}  width={100}
                      height={20}
                      options={chartOption}/>
            </Box>
        </Box>
    );
}

export default CodeSizeMetric;
