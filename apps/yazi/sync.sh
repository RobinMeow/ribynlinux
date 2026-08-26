#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
info "Syncing yazi"

mkdir -p "$HOME/.config/yazi"
cp -r "$RIBYN_ROOT/apps/yazi/config/"* "$HOME/.config/yazi/"
