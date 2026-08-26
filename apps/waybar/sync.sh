#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/waybar"
rsync -rlpt \
	"$RIBYN_ROOT/apps/waybar/config/" \
	"$HOME/.config/waybar/"
