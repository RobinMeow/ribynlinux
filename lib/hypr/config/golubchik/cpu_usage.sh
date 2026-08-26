#!/usr/bin/env bash
set -euo pipefail

# read -r _ c1 c2 c3 c4 c5 c6 c7 _ </proc/stat
# sleep 1
# read -r _ n1 n2 n3 n4 n5 n6 n7 _ </proc/stat
#
# idle_prev=$((c4))
# idle=$((n4))
# total_prev=$((c1 + c2 + c3 + c4 + c5 + c6 + c7))
# total=$((n1 + n2 + n3 + n4 + n5 + n6 + n7))
#
# diff_total=$((total - total_prev))
# diff_idle=$((idle - idle_prev))
#
# echo $(((diff_total - diff_idle) * 100 / diff_total))

# mpstat 1 1 | awk '/Average:/ && $2 == "all" { printf "%.0f\n", 100 - $NF }'

#!/usr/bin/env bash

mkdir -p "$HOME/.cache/ribyn/hypr/"
OUTPUT="$HOME/.cache/ribyn/hypr/cpu_usage"

while true; do
	printf '%d\n' "$(mpstat 1 1 | awk '/Average:/ && $2 == "all" { printf "%.0f\n", 100 - $NF }')" >"$OUTPUT"
done
