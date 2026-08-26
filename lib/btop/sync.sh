#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing btop"

mkdir -p "$HOME/.config/btop"
cp -r "$RIBYN_ROOT/lib/btop/config/"* "$HOME/.config/btop/"
