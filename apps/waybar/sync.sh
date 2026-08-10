#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/waybar"
ribyn_rsync \
	"$RIBYN_ROOT/apps/waybar/config/" \
	"$HOME/.config/waybar/"
