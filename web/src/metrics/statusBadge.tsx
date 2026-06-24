import { Badge } from "@chakra-ui/react"

export function statusBadge(targetHours?: number, actualHours?: number) {
    let badge;
    if (!targetHours || !actualHours) {
        badge = <Badge ml="1">UNKNOWN</Badge>;
    } else if (actualHours > targetHours) {
        badge = <Badge ml="1" colorPalette="red">NG</Badge>;
    } else if (actualHours > targetHours * 0.90) {
        badge = <Badge ml="1" colorPalette="yellow">WARN</Badge>;
    } else {
        badge = <Badge ml="1" colorPalette="green">OK</Badge>;
    }
    return badge;
}
