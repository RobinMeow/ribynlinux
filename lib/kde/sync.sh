#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/kde/env.sh"
[[ "$RIBYN_SYNC_KDE_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "syncing kde"

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
rsync -rlpt \
	"$RIBYN_ROOT/lib/kde/kwalletrc" \
	"$HOME/.config/kwalletrc"

rsync -rlpt \
	"$RIBYN_ROOT/lib/kde/kscreenlockerrc" \
	"$HOME/.config/kscreenlockerrc"
