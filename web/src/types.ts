import moment, { Moment } from 'moment';

export interface Source {
    targetMonths: string[],
    pullRequests: any[],
}

export interface PullRequest {
    title: String;
    url: String;
    oldestCommitDate: Moment;
    createdAt: Moment;
    oldestReactionDate?: Moment;
    latestApprovalDate?: Moment;
    mergedAt?: Moment;
    state: string;
    month?: String;
    moduleName?: string;
    changeType?: string;
    timeToRequest: number;
    timeToResponse?: number;
    timeToApproval?: number;
    timeToMerge?: number;
    totalLeadTime?: number;
    commits: number;
    addedSize: number;
    deletedSize: number;
    changeSize: number;
}

export function requestFromJson(json: any): PullRequest {
    const oldestCommitDate = moment(json.oldestCommitDate);
    const createdAt = moment(json.createdAt);
    const oldestReactionDate = json.oldestReactionDate ? moment(json.oldestReactionDate) : undefined;
    const latestApprovalDate = json.latestApprovalDate ? moment(json.latestApprovalDate) : undefined;
    const mergedAt = json.mergedAt ? moment(json.mergedAt) : undefined;
    return {
        title: json.title,
        url: json.url,
        oldestCommitDate,
        createdAt,
        oldestReactionDate,
        latestApprovalDate,
        mergedAt: mergedAt,
        month: createdAt?.format('YYYY-MM'),
        state: json.state,
        moduleName: json.moduleName,
        changeType: json.changeType,
        timeToRequest: createdAt.diff(oldestCommitDate, 'hour'),
        timeToResponse: oldestReactionDate?.diff(createdAt, 'hour'),
        timeToApproval: oldestReactionDate ? latestApprovalDate?.diff(oldestReactionDate!, 'hour') : undefined,
        timeToMerge: latestApprovalDate ? mergedAt?.diff(latestApprovalDate, 'hour') : undefined,
        totalLeadTime: latestApprovalDate ? latestApprovalDate.diff(oldestCommitDate, 'hour') : undefined,
        commits: json.commits,
        addedSize: json.additions,
        deletedSize: json.deletions,
        changeSize: json.additions + json.deletions,
    }
}
