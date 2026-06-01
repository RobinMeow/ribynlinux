#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/mpd/playlists"
cp -r "$RIBYNS_ENV/apps/mpd/config/"* "$HOME/.config/mpd/"
mkdir -p "$HOME/.local/state/mpd"
