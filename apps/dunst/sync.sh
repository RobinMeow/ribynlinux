#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing dunst"

mkdir -p "$HOME/.config/dunst/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/dunst/config/"* \
	"$HOME/.config/dunst/"
