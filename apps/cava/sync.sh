#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/cava/"
ribyn_rsync \
	"$RIBYN_ROOT/apps/cava/config/" \
	"$HOME/.config/cava/"
