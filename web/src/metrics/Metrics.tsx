import React, {useState} from 'react';

import { Box, Center, RadioGroup, Radio, Stack, Grid, Heading, Spinner} from '@chakra-ui/react';
import { PullRequest, Source, requestFromJson } from '../types';
import LeadTimeMetric from './LeadTimeMetric';
import CodeSizeMetric from './CodeSizeMetric';
import './Metrics.scss';


const Metrics: React.FC = () => {
    const SourceJsonFile = '/out.json';
    const ObjectiveJsonFile = '/objectives.json';
    const ModuleFilterValue = 'moduleFilterValue';

    const [selectedModuleFilter, setModuleFilter] = useState<string>(localStorage.getItem(ModuleFilterValue) ?? 'all');
    const [source, setSource] = useState<Source>();
    const [objectives, setObjectives] = useState<Map<string, number>>();

    if (source === undefined) {
        fetch(SourceJsonFile).then((res) => res.json().then(setSource));
        return (<Box w="100%" mt="100px"><Center><Spinner /></Center></Box>);
    }

    if (objectives === undefined) {
        fetch(ObjectiveJsonFile)
            .then((res) => res.json().then((obj) => setObjectives(new Map(Object.entries(obj)))))
            .catch(() => setObjectives(new Map<string, number>()));
    }

    const prs = source!.pullRequests.map(requestFromJson);
    const months = source!.targetMonths;
    const moduleFilterItems = [{ label: 'All', value: 'all'}, ...unique(prs, 'moduleName')];
    const moduleFilteredPrs = (selectedModuleFilter === 'all') ? prs : prs.filter((pr) => pr.moduleName === selectedModuleFilter);
    const filteredPrs = moduleFilteredPrs;

    const handleModuleFilterChange = (e: any) => {
        localStorage.setItem(ModuleFilterValue, e);
        setModuleFilter(e);
    }

    return (
        <Box pb="10" w="100%">
            <Heading size="md" mt="6">Module</Heading>
            <RadioGroup onChange={handleModuleFilterChange} value={selectedModuleFilter} mt="2">
                <Stack direction="row" spacing="4">
                    { moduleFilterItems.map((item) => <Radio key={item.value} value={item.value}>{item.label}</Radio>)}
                </Stack>
            </RadioGroup>
            {/* <Heading size="md" mt="6">Change Type</Heading>
                <RadioGroup onChange={handleChangeTypeFilterChange} value={selectedChangeTypeFilter} mt="2">
                <Stack direction="row" spacing="4">
                { changeTypeFilterItems.map((item) => <Radio key={item.value} value={item.value}>{item.label}</Radio>)}
                </Stack>
                </RadioGroup> */}
            <Grid templateColumns="repeat(1, 1fr)" gap={0}>
                <LeadTimeMetric
                    months={months}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('totalLeadTime')}
                    title="Pull Request Lead Time"
                    description="最初のcommitからマージされるまでのリードタイムの平均時間"
                    metricName="totalLeadTime"></LeadTimeMetric>
                <CodeSizeMetric
                    months={months}
                    pullRequests={filteredPrs}
                    changeSize={objectives?.get('changeSize')}
                    title="Change Size"
                    description="Pull Requestの平均変更行数"
                ></CodeSizeMetric>
                <LeadTimeMetric
                    months={months}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToRequest')}
                    title="Time To Pull Request (TTPR)"
                    description="最初のcommitからPull Requestが作成されるまでの平均時間"
                    metricName="timeToRequest"></LeadTimeMetric>
                <LeadTimeMetric
                    months={months}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToResponse')}
                    title="Time To Response (TTR)"
                    description="Pull Requestが作成されてから最初のコードレビューが行われるまでの平均時間"
                    metricName="timeToResponse"></LeadTimeMetric>
                <LeadTimeMetric
                    months={months}
                    pullRequests={filteredPrs}
                    targetHours={objectives?.get('timeToApproval')}
                    title="Time To Approval (TTA)"
                    description="最初のコードレビューから、Pull Requestが最終的にApproveされるまでの平均時間"
                    metricName="timeToApproval"></LeadTimeMetric>
                <LeadTimeMetric
                    months={months}
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

interface SelectionItem {
    label: string,
    value: string | undefined
}

function unique(prs: PullRequest[], kind: 'moduleName' | 'changeType'): SelectionItem[] {
    const names = Array.from(new Set(prs.map((pr) => pr[kind]))).filter((m) => !!m);
    return names.map((name) => {
      return {
        label: `${name}`,
        value: name
      }
    }).sort();
};
