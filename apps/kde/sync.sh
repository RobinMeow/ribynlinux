#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/lib/utils.sh"

if [[ "$RIBYN_SYNC_KDE_ENABLED" == "no" ]]; then
	info "KDE sync disabled. skipping."
	exit 0
fi

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
rsync -rlpt \
	"$RIBYN_ROOT/apps/kde/kwalletrc" \
	"$HOME/.config/kwalletrc"

rsync -rlpt \
	"$RIBYN_ROOT/apps/kde/kscreenlockerrc" \
	"$HOME/.config/kscreenlockerrc"
