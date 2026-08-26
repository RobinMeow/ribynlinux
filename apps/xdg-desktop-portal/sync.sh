#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/xdg-desktop-portal"

rsync -rlpt \
	"$RIBYN_ROOT/apps/xdg-desktop-portal/config/" \
	"$HOME/.config/xdg-desktop-portal/"
