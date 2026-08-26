#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
info "Syncing bat"

mkdir -p "$HOME/.config/bat"
cp -r "$RIBYN_ROOT/apps/bat/config/"* "$HOME/.config/bat/"
