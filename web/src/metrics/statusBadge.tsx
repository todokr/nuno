import { Badge } from "@chakra-ui/react"

export function statusBadge(targetHours?: number, actualHours?: number) {
    var badge;
    if (!targetHours || !actualHours) {
        badge = <Badge ml="1">UNKNOWN</Badge>;
    } else if (actualHours! > targetHours) {
        badge = <Badge ml="1" colorScheme="red">NG</Badge>;
    } else if (actualHours! > targetHours * 0.90) {
        badge = <Badge ml="1" colorScheme="yellow">WARN</Badge>;
    } else {
        badge = <Badge ml="1" colorScheme="green">OK</Badge>;
    }
    return badge;
}
