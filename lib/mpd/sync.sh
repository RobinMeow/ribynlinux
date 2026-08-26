#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing mpd"

# apparently mpd is incapable to create dirs
mkdir -p "$HOME/.config/mpd/playlists"
mkdir -p "$HOME/.local/state/mpd"
mkdir -p "$HOME/.local/share/mpd/"

rsync -rlpt \
	"$RIBYN_ROOT/lib/mpd/config/"* \
	"$HOME/.config/mpd/"
