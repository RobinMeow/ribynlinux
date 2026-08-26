#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "installing wl-freeze"

"$RIBYN_ROOT/lib/wl-freeze/build-from-source.sh"
