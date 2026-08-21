#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/wiremix/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/wiremix/config/"* \
	"$HOME/.config/wiremix/"
