#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/xdg-desktop-portal"

ribyn_rsync \
	"$RIBYN_ROOT/apps/xdg-desktop-portal/config/" \
	"$HOME/.config/xdg-desktop-portal/"
