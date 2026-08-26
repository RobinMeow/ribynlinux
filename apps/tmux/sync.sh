#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
info "Syncing tmux"

rsync -rlpt \
	"$RIBYN_ROOT/apps/tmux/tmux.conf" \
	"$HOME/.tmux.conf"
