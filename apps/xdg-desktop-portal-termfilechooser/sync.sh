#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser

. "$RIBYN_ROOT/lib/utils.sh"

ribyn_rsync \
	"$RIBYN_ROOT/apps/xdg-desktop-portal-termfilechooser/config/" \
	"$HOME/.config/xdg-desktop-portal-termfilechooser/"
