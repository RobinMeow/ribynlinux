#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing nvim"

CLEAN=false
for arg in "$@"; do
	if [[ "$arg" == "--clean" ]]; then
		CLEAN=true
	fi
done

if $CLEAN; then
	rm -rf "$HOME/.config/nvim/"
fi

mkdir -p "$HOME/.config/nvim"
cp -r "$RIBYN_ROOT/apps/nvim/config/"* "$HOME/.config/nvim/"
