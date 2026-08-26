#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "syncing desktop files"

# https://wiki.archlinux.org/title/Icons
# https://icon-icons.com/search/icons/netflix

# desktop files
rsync -rlpt \
	"$RIBYN_ROOT/lib/desktop-files/applications/" \
	"$HOME/.local/share/applications/"

# their icons
mkdir -p "$HOME/.icons"
rsync -rlpt \
	"$RIBYN_ROOT/lib/desktop-files/icons/" \
	"$HOME/.icons"
