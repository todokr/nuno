export function mean(ns: (number | undefined)[]): number | undefined {
    const xs = ns.filter((m) => m !== undefined) as number[]
    if (xs.length === 0) {
        return undefined;
    } else {
        const sum = xs.reduce((a, b) => a + b, 0);
        return (sum / xs.length) || 0;
    }
}
