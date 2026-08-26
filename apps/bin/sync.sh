#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

info "Syncing binaries"

rsync -rlpt \
	"$RIBYN_ROOT/apps/bin/executables/"* \
	"$HOME/.local/bin/"

if [[ -d "$HOME/ribyns-state/" ]]; then
	rsync -rlpt \
		"$HOME/ribyns-state/bin/"* \
		"$HOME/.local/bin/"
fi
