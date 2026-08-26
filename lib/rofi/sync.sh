#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing rofi"

mkdir -p "$HOME/.config/rofi"
cp -r "$RIBYN_ROOT/lib/rofi/config/"* "$HOME/.config/rofi/"
