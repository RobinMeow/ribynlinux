#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser

source "$RIBYN_ROOT/core/utils.sh"

rsync -rlpt \
	"$RIBYN_ROOT/apps/xdg-desktop-portal-termfilechooser/config/" \
	"$HOME/.config/xdg-desktop-portal-termfilechooser/"
