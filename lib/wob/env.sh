#!/usr/bin/env bash
set -euo pipefail

# you wan't to enable this on laptops with multimedia keys
# for a volume bar on screen
export RIBYN_WOB_ENABLED=${RIBYN_WOB_ENABLED:-"no"}
