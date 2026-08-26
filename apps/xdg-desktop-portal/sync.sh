#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

info "Syncing xdg-desktop-portal"

mkdir -p "$HOME/.config/xdg-desktop-portal"

rsync -rlpt \
	"$RIBYN_ROOT/apps/xdg-desktop-portal/config/" \
	"$HOME/.config/xdg-desktop-portal/"
