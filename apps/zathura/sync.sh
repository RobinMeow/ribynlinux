#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
info "Syncing zathura"

mkdir -p "$HOME/.config/zathura"
cp -r "$RIBYN_ROOT/apps/zathura/config/"* "$HOME/.config/zathura/"
