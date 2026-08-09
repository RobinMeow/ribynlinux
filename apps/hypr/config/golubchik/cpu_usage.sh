#!/usr/bin/env bash
set -euo pipefail

mpstat 1 1 | awk '/Average:/ && $2 == "all" { printf "%.0f\n", 100 - $NF }'
