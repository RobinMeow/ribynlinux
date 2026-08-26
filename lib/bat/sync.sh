#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing bat"

mkdir -p "$HOME/.config/bat"
cp -r "$RIBYN_ROOT/lib/bat/config/"* "$HOME/.config/bat/"
