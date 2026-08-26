#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing wayscriber"

mkdir -p "$HOME/.config/wayscriber/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/wayscriber/config/"* \
	"$HOME/.config/wayscriber/"
