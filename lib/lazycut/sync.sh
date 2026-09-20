#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/lazycut/env.sh"
[[ "$RIBYN_LAZYCUT_ENABLED" == "no" ]] && exit 0

# source "$RIBYN_ROOT/core/utils.sh"
# info "syncing lazycut"
#
# mkdir -p "$HOME/.config/lazycut"
# rsync -rlpt \
#   "$RIBYN_ROOT/lib/lazycut/config/"* \
#   "$HOME/.config/lazycut/"
