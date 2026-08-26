#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing waybar"

mkdir -p "$HOME/.config/waybar"
rsync -rlpt \
	"$RIBYN_ROOT/apps/waybar/config/" \
	"$HOME/.config/waybar/"
