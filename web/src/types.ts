import dayjs, { Dayjs } from 'dayjs';

export interface Source {
    targetMonths: string[],
    pullRequests: any[],
}

export interface PullRequest {
    title: String;
    url: String;
    oldestCommitDate: Dayjs;
    createdAt: Dayjs;
    oldestReactionDate?: Dayjs;
    latestApprovalDate?: Dayjs;
    mergedAt?: Dayjs;
    issueCreatedAt?: Dayjs;
    state: string;
    month?: String;
    moduleName?: string;
    changeType?: string;
    timeToRequest: number;
    timeToResponse?: number;
    timeToApproval?: number;
    timeToMerge?: number;
    totalLeadTime?: number;
    issueToMerge?: number;
    issueToFirstCommit?: number;
    commits: number;
    addedSize: number;
    deletedSize: number;
    changeSize: number;
    reviewRounds: number;
}

export function requestFromJson(json: any): PullRequest {
    const oldestCommitDate = dayjs(json.oldestCommitDate);
    const createdAt = dayjs(json.createdAt);
    const oldestReactionDate = json.oldestReactionDate ? dayjs(json.oldestReactionDate) : undefined;
    const latestApprovalDate = json.latestApprovalDate ? dayjs(json.latestApprovalDate) : undefined;
    const mergedAt = json.mergedAt ? dayjs(json.mergedAt) : undefined;
    const issueCreatedAt = json.issueCreatedAt ? dayjs(json.issueCreatedAt) : undefined;
    return {
        title: json.title,
        url: json.url,
        oldestCommitDate,
        createdAt,
        oldestReactionDate,
        latestApprovalDate,
        mergedAt: mergedAt,
        issueCreatedAt,
        month: createdAt?.format('YYYY-MM'),
        state: json.state,
        moduleName: json.moduleName,
        changeType: json.changeType,
        timeToRequest: createdAt.diff(oldestCommitDate, 'hour'),
        timeToResponse: oldestReactionDate?.diff(createdAt, 'hour'),
        timeToApproval: oldestReactionDate ? latestApprovalDate?.diff(oldestReactionDate, 'hour') : undefined,
        timeToMerge: latestApprovalDate ? mergedAt?.diff(latestApprovalDate, 'hour') : undefined,
        totalLeadTime: latestApprovalDate ? latestApprovalDate.diff(oldestCommitDate, 'hour') : undefined,
        issueToMerge: (issueCreatedAt && mergedAt) ? mergedAt.diff(issueCreatedAt, 'hour') : undefined,
        issueToFirstCommit: issueCreatedAt ? oldestCommitDate.diff(issueCreatedAt, 'hour') : undefined,
        commits: json.commits,
        addedSize: json.additions,
        deletedSize: json.deletions,
        changeSize: json.additions + json.deletions,
        reviewRounds: json.reviewRounds ?? 0,
    }
}
