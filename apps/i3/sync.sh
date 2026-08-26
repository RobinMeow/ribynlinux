#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "Syncing i3"

if [[ "$RIBYN_I3_ENABLED" == "no" ]]; then
	info "i3 disabled. skipping."
	exit 0
fi

mkdir -p "$HOME/.config/i3/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/i3/config/"* \
	"$HOME/.config/i3/"

if command -v i3-msg >/dev/null 2>&1; then
	i3-msg reload
else
	warn "i3 config synced but could not reload without i3-msg."
fi
