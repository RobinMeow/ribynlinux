#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/cava/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/cava/config/" \
	"$HOME/.config/cava/"
