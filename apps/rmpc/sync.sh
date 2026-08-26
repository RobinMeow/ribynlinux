#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
info "Syncing rmpc"

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYN_ROOT/apps/rmpc/config/"* "$HOME/.config/rmpc/"
