#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

info "Syncing qt6ct"

mkdir -p "$HOME/.config/qt6ct/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/qt6ct/config/" \
	"$HOME/.config/qt6ct/"
