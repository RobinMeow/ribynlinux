#!/usr/bin/env bash
set -euo pipefail

# Usage: bar.sh <value 0-100> <length>
val=$1
len=${2:-16}

filled=$((val * len / 100))
empty=$((len - filled))

bar=""
for ((i = 0; i < filled; i++)); do bar+="▰"; done
for ((i = 0; i < empty; i++)); do bar+="▱"; done

echo "$bar"
