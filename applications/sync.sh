#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

ribyn_rsync \
	"$RIBYN_ROOT/applications/"*".desktop" \
	"$HOME/.local/share/applications/"
