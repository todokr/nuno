export function mean(ns: (number | undefined)[]): number | undefined {
    const xs = ns.filter((m) => m !== undefined) as number[]
    if (xs.length === 0) {
        return undefined;
    } else {
        const sum = xs.reduce((a, b) => a + b, 0);
        return (sum / xs.length) || 0;
    }
}

export function median(ns: (number | undefined)[]): number | undefined {
    const xs = (ns.filter((m) => m !== undefined) as number[]).sort((a, b) => a - b);
    if (xs.length === 0) {
        return undefined;
    }
    const mid = Math.floor(xs.length / 2);
    return xs.length % 2 !== 0 ? xs[mid] : (xs[mid - 1] + xs[mid]) / 2;
}
