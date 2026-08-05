#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh" # warn, ribyn_rsync

# removing deprecated hyprland.conf file
hypr_conf="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$hypr_conf" ]]; then
	warn "Deprecated hyprland.conf file detected. Delete it to get rid of this warning."
fi

mkdir -p "$HOME/.config/hypr"
ribyn_rsync \
	--exclude="local/" \
	"$RIBYN_ROOT/apps/hypr/config/" \
	"$HOME/.config/hypr/"

mkdir -p "$HOME/.config/hypr/local"
ribyn_rsync \
	--ignore-existing \
	"$RIBYN_ROOT/apps/hypr/config/local/" \
	"$HOME/.config/hypr/local/"

ribyn_rsync "$RIBYN_ROOT/assets/images/wallpapers/hypr_chan.png" "$HOME/.config/hypr/"

hyprctl reload
