#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

info "Syncing qt6ct"

mkdir -p "$HOME/.config/qt6ct/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/qt6ct/config/" \
	"$HOME/.config/qt6ct/"
