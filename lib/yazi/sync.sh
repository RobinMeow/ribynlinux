#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing yazi"

mkdir -p "$HOME/.config/yazi"
cp -r "$RIBYN_ROOT/lib/yazi/config/"* "$HOME/.config/yazi/"
