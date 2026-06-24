import { PullRequest } from '../types';
import { Box, Heading, Link, Table, Text } from '@chakra-ui/react';

interface Prop {
    pullRequests: PullRequest[],
    // 各 PR の評価対象となる値を取り出す。undefined を返した PR は対象外。
    metricValue: (pr: PullRequest) => number | undefined,
    // 値の単位（例: '時間', '行'）。
    unit: string,
    // 表示件数（既定 5 件）。
    count?: number,
}

// 値が大きいほどパフォーマンスが悪いメトリクスについて、ワースト N 件を一覧表示する。
const WorstPrList: React.FC<Prop> = (prop) => {
    const count = prop.count ?? 5;
    const worst = prop.pullRequests
        .map((pr) => ({ pr, value: prop.metricValue(pr) }))
        .filter((x): x is { pr: PullRequest, value: number } => x.value !== undefined)
        .sort((a, b) => b.value - a.value)
        .slice(0, count);

    if (worst.length === 0) {
        return null;
    }

    return (
        <Box mt="6">
            <Heading size="sm" mb="2">ワースト{worst.length}</Heading>
            <Table.Root size="sm" variant="line">
                <Table.Header>
                    <Table.Row>
                        <Table.ColumnHeader w="3rem">#</Table.ColumnHeader>
                        <Table.ColumnHeader>Pull Request</Table.ColumnHeader>
                        <Table.ColumnHeader w="6rem">月</Table.ColumnHeader>
                        <Table.ColumnHeader textAlign="end" w="8rem">{prop.unit}</Table.ColumnHeader>
                    </Table.Row>
                </Table.Header>
                <Table.Body>
                    {worst.map(({ pr, value }, index) => (
                        <Table.Row key={`${pr.url}`}>
                            <Table.Cell>{index + 1}</Table.Cell>
                            <Table.Cell>
                                <Link href={`${pr.url}`} target="_blank" rel="noopener noreferrer">
                                    {pr.title}
                                </Link>
                            </Table.Cell>
                            <Table.Cell><Text fontSize="sm">{pr.month}</Text></Table.Cell>
                            <Table.Cell textAlign="end">{value.toFixed(1)}{prop.unit}</Table.Cell>
                        </Table.Row>
                    ))}
                </Table.Body>
            </Table.Root>
        </Box>
    );
}

export default WorstPrList;
