#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing rmpc"

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYN_ROOT/lib/rmpc/config/"* "$HOME/.config/rmpc/"
