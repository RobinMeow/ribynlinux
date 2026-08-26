#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.config/cava/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/cava/config/" \
	"$HOME/.config/cava/"
