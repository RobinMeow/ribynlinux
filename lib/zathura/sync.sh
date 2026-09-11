#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "syncing zathura"

mkdir -p "$HOME/.config/zathura"
rsync -rlpt \
	"$RIBYN_ROOT/lib/zathura/config/"* \
	"$HOME/.config/zathura/"
