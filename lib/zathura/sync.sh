#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing zathura"

mkdir -p "$HOME/.config/zathura"
cp -r "$RIBYN_ROOT/lib/zathura/config/"* "$HOME/.config/zathura/"
