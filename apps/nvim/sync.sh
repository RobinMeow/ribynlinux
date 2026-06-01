#!/usr/bin/env bash
set -euo pipefail

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
cp -r "$RIBYNS_ENV/apps/nvim/config/"* "$HOME/.config/nvim/"
