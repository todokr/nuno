import { test } from 'node:test';
import assert from 'node:assert/strict';
import { startOfMonth, subMonths, formatYearMonth } from '../src/date.js';
import { PullRequestReviewsResponse, PullRequestCommitsResponse, parseLinkedIssueResponse } from '../src/responses.js';
import { buildAuthorFilter } from '../src/authorFilter.js';

test('formatYearMonth formats as yyyy-MM', () => {
  assert.equal(formatYearMonth(new Date(2026, 0, 5)), '2026-01');
  assert.equal(formatYearMonth(new Date(2026, 11, 31)), '2026-12');
});

test('startOfMonth returns first day of month', () => {
  const d = startOfMonth(new Date(2026, 5, 22, 13, 45));
  assert.equal(d.getDate(), 1);
  assert.equal(d.getHours(), 0);
  assert.equal(d.getMonth(), 5);
});

test('subMonths goes back across year boundary', () => {
  const d = subMonths(new Date(2026, 0, 15), 2);
  assert.equal(d.getFullYear(), 2025);
  assert.equal(d.getMonth(), 10);
});

test('commits.oldest returns earliest commit', () => {
  const res = new PullRequestCommitsResponse([
    { date: new Date('2026-03-01T00:00:00Z') },
    { date: new Date('2026-01-01T00:00:00Z') },
    { date: new Date('2026-02-01T00:00:00Z') },
  ]);
  assert.equal(res.oldest()?.date?.toISOString(), '2026-01-01T00:00:00.000Z');
});

test('buildAuthorFilter: empty value targets everyone', () => {
  for (const raw of [undefined, '', '  ', ',', ' , ']) {
    const filter = buildAuthorFilter(raw);
    assert.equal(filter.logins.size, 0);
    assert.equal(filter.isTarget('anyone'), true);
  }
});

test('buildAuthorFilter: filters by login, case-insensitive, trims and ignores blanks', () => {
  const filter = buildAuthorFilter(' Octocat, torvalds ,, ');
  assert.deepEqual([...filter.logins].sort(), ['octocat', 'torvalds']);
  assert.equal(filter.isTarget('octocat'), true);
  assert.equal(filter.isTarget('OCTOCAT'), true);
  assert.equal(filter.isTarget('torvalds'), true);
  assert.equal(filter.isTarget('someone-else'), false);
});

test('reviews exclude the author and pick oldest reaction / latest approval', () => {
  const res = new PullRequestReviewsResponse(1, [
    { reviewerId: 1, date: new Date('2026-01-01T00:00:00Z'), state: 'COMMENTED' },
    { reviewerId: 2, date: new Date('2026-01-02T00:00:00Z'), state: 'APPROVED' },
    { reviewerId: 3, date: new Date('2026-01-03T00:00:00Z'), state: 'APPROVED' },
  ]);
  assert.equal(res.oldestReaction()?.reviewerId, 2);
  assert.equal(res.latestApproval()?.reviewerId, 3);
});

test('parseLinkedIssueResponse picks the oldest linked issue createdAt', () => {
  const nodes = [
    { number: 2, createdAt: '2026-03-01T00:00:00Z' },
    { number: 1, createdAt: '2026-01-01T00:00:00Z' },
    { number: 3, createdAt: '2026-02-01T00:00:00Z' },
  ];
  assert.equal(parseLinkedIssueResponse(nodes)?.toISOString(), '2026-01-01T00:00:00.000Z');
});

test('parseLinkedIssueResponse returns null when there is no linked issue', () => {
  assert.equal(parseLinkedIssueResponse([]), null);
  assert.equal(parseLinkedIssueResponse(null), null);
  assert.equal(parseLinkedIssueResponse(undefined), null);
});

test('reviewRounds counts non-author CHANGES_REQUESTED only', () => {
  const res = new PullRequestReviewsResponse(1, [
    { reviewerId: 1, date: new Date('2026-01-01T00:00:00Z'), state: 'CHANGES_REQUESTED' }, // author -> ignore
    { reviewerId: 2, date: new Date('2026-01-02T00:00:00Z'), state: 'CHANGES_REQUESTED' },
    { reviewerId: 3, date: new Date('2026-01-03T00:00:00Z'), state: 'CHANGES_REQUESTED' },
    { reviewerId: 2, date: new Date('2026-01-04T00:00:00Z'), state: 'APPROVED' },
  ]);
  assert.equal(res.reviewRounds(), 2);

  const oneShot = new PullRequestReviewsResponse(1, [
    { reviewerId: 2, date: new Date('2026-01-02T00:00:00Z'), state: 'APPROVED' },
  ]);
  assert.equal(oneShot.reviewRounds(), 0);
});
