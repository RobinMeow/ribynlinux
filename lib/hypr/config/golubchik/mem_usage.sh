#!/usr/bin/env bash
set -euo pipefail

# awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END {
#     printf "%d", (t-a)*100/t
# }' /proc/meminfo

awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END {printf "%.0f\n", (t-a)*100/t}' /proc/meminfo

# awk '
#     /MemTotal/     { total = $2 }
#     /MemAvailable/ { available = $2 }
#     END {
#         printf "%.0f\n", (total - available) * 100 / total
#     }
# ' /proc/meminfo
