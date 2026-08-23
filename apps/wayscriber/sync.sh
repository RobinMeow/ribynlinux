#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/wayscriber/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/wayscriber/config/"* \
	"$HOME/.config/wayscriber/"
