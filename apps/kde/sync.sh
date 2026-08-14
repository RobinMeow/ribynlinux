#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"

if [[ "$RIBYN_SYNC_KDE_ENABLED" == "no" ]]; then
	info "KDE sync disabled. skipping."
	exit 0
fi

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
ribyn_rsync \
	"$RIBYN_ROOT/apps/kde/kwalletrc" \
	"$HOME/.config/kwalletrc"

ribyn_rsync \
	"$RIBYN_ROOT/apps/kde/kscreenlockerrc" \
	"$HOME/.config/kscreenlockerrc"
