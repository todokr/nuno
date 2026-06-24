import { useEffect, useState } from 'react';

import { Box, Center, HStack, Grid, Heading, NativeSelect, Spinner, Text } from '@chakra-ui/react';
import { Source, requestFromJson } from '../types';
import LeadTimeMetric from './LeadTimeMetric';
import CodeSizeMetric from './CodeSizeMetric';
import ReviewRoundMetric from './ReviewRoundMetric';
import './Metrics.scss';

const SourceJsonFile = '/out.json';
const ObjectiveJsonFile = '/objectives.json';
const PeriodFromValue = 'periodFromValue';
const PeriodToValue = 'periodToValue';

const Metrics: React.FC = () => {
    const [periodFrom, setPeriodFrom] = useState<string | null>(localStorage.getItem(PeriodFromValue));
    const [periodTo, setPeriodTo] = useState<string | null>(localStorage.getItem(PeriodToValue));
    const [source, setSource] = useState<Source>();
    const [objectives, setObjectives] = useState<Map<string, number>>();

    useEffect(() => {
        fetch(SourceJsonFile)
            .then((res) => res.json())
            .then(setSource);
    }, []);

    useEffect(() => {
        fetch(ObjectiveJsonFile)
            .then((res) => res.json())
            .then((obj) => setObjectives(new Map(Object.entries(obj))))
            .catch(() => setObjectives(new Map<string, number>()));
    }, []);

    if (source === undefined) {
        return (<Box w="100%" mt="100px"><Center><Spinner /></Center></Box>);
    }

    const prs = source.pullRequests.map(requestFromJson);
    const months = source.targetMonths;

    // 保存値がデータの期間外なら全期間にフォールバックし、from > to でも自動的に並べ替える。
    const from = (periodFrom && months.includes(periodFrom)) ? periodFrom : months[0];
    const to = (periodTo && months.includes(periodTo)) ? periodTo : months[months.length - 1];
    const lo = from <= to ? from : to;
    const hi = from <= to ? to : from;
    const periodMonths = months.filter((m) => m >= lo && m <= hi);

    const filteredPrs = prs.filter((pr) => !!pr.month && periodMonths.includes(`${pr.month}`));

    const handlePeriodFromChange = (value: string) => {
        localStorage.setItem(PeriodFromValue, value);
        setPeriodFrom(value);
    }

    const handlePeriodToChange = (value: string) => {
        localStorage.setItem(PeriodToValue, value);
        setPeriodTo(value);
    }

    return (
        <Box pb="10" w="100%">
            <Heading size="md" mt="6">Period</Heading>
            <HStack gap="3" mt="2">
                <NativeSelect.Root w="auto" size="sm">
                    <NativeSelect.Field value={lo} onChange={(e) => handlePeriodFromChange(e.currentTarget.value)}>
                        { months.map((m) => <option key={m} value={m}>{m}</option>) }
                    </NativeSelect.Field>
                    <NativeSelect.Indicator />
                </NativeSelect.Root>
                <Text>〜</Text>
                <NativeSelect.Root w="auto" size="sm">
                    <NativeSelect.Field value={hi} onChange={(e) => handlePeriodToChange(e.currentTarget.value)}>
                        { months.map((m) => <option key={m} value={m}>{m}</option>) }
                    </NativeSelect.Field>
                    <NativeSelect.Indicator />
                </NativeSelect.Root>
            </HStack>
            <Grid templateColumns="repeat(1, 1fr)" gap={0}>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('totalLeadTime')}
                    title="Pull Request Lead Time"
                    description="最初のcommitからマージされるまでのリードタイムの平均時間"
                    metricName="totalLeadTime"></LeadTimeMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('issueToMerge')}
                    title="Issue Lead Time (Issue → Merge)"
                    description="紐づくIssueが作成されてからPull Requestがマージされるまでの平均時間"
                    metricName="issueToMerge"></LeadTimeMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('issueToFirstCommit')}
                    title="Time To First Commit (Issue → First Commit)"
                    description="紐づくIssueが作成されてから最初のcommitが行われるまでの平均時間（着手までのリードタイム）"
                    metricName="issueToFirstCommit"></LeadTimeMetric>
                <CodeSizeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    changeSize={objectives?.get('changeSize')}
                    title="Change Size"
                    description="Pull Requestの平均変更行数"
                ></CodeSizeMetric>
                <ReviewRoundMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    title="Review Rounds"
                    description="レビューで変更要求(CHANGES_REQUESTED)が発生した往復回数。0回=一発承認。PR規模が大きくてもレビューが速く回っているか（修正の往復が少ないか）を見る指標"
                ></ReviewRoundMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToRequest')}
                    title="Time To Pull Request (TTPR)"
                    description="最初のcommitからPull Requestが作成されるまでの平均時間"
                    metricName="timeToRequest"></LeadTimeMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToResponse')}
                    title="Time To Response (TTR)"
                    description="Pull Requestが作成されてから最初のコードレビューが行われるまでの平均時間"
                    metricName="timeToResponse"></LeadTimeMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToApproval')}
                    title="Time To Approval (TTA)"
                    description="最初のコードレビューから、Pull Requestが最終的にApproveされるまでの平均時間"
                    metricName="timeToApproval"></LeadTimeMetric>
                <LeadTimeMetric
                    months={periodMonths}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToMerge')}
                    title="Time To Merge (TTM)"
                    description="Pull Requestが最終的にApproveされてからマージされるまでの平均時間"
                    metricName="timeToMerge"></LeadTimeMetric>
            </Grid>
        </Box>

    );
}

export default Metrics;
