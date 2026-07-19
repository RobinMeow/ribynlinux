#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$RIBYN_ROOT/apps/mpd/config/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"
