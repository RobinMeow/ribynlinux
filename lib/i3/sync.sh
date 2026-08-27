#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/i3/env.sh"
if [[ "$RIBYN_I3_ENABLED" == "no" ]]; then
	exit 0
fi

source "$RIBYN_ROOT/core/utils.sh"
info "syncing i3"

mkdir -p "$HOME/.config/i3/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/i3/config/"* \
	"$HOME/.config/i3/"

if command -v i3-msg >/dev/null 2>&1; then
	i3-msg reload
else
	warn "i3 config synced but could not reload without i3-msg."
fi
