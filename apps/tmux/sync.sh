#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing tmux"

rsync -rlpt \
	"$RIBYN_ROOT/apps/tmux/tmux.conf" \
	"$HOME/.tmux.conf"
