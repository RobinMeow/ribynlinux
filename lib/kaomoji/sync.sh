#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "syncing kaomoji picker"

rsync -rlpt \
	"$RIBYN_ROOT/lib/kaomoji/kaomoji-picker" \
	"$HOME/.local/bin/"
