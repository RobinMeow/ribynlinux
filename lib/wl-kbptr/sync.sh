#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.config/wl-kbptr/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/wl-kbptr/config/config.toml" \
	"$HOME/.config/wl-kbptr/config"
