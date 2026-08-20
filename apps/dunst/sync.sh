#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/dunst/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/dunst/config/"* \
	"$HOME/.config/dunst/"
