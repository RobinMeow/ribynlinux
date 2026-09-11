#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "syncing mimeapps"

rsync -rlpt \
	"$RIBYN_ROOT/xdg/mimeapps.list" \
	"$HOME/.config/mimeapps.list"
