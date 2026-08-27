#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/wob/env.sh"
[[ "$RIBYN_WOB_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
rsync -rlpt "$RIBYN_ROOT/lib/wob/wob_volume.sh" "$HOME/.local/bin/wob_volume"
