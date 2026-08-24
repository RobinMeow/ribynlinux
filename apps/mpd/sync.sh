#!/usr/bin/env bash
set -euo pipefail

# apparently mpd is incapable to create dirs
mkdir -p "$HOME/.config/mpd/playlists"
mkdir -p "$HOME/.local/state/mpd"
mkdir -p "$HOME/.local/share/mpd/"

rsync -rlpt \
	"$RIBYN_ROOT/apps/mpd/config/"* \
	"$HOME/.config/mpd/"
