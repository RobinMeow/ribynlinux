#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh" # warn, ribyn_rsync

# warn about deprecated hyprland.conf file
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
ribyn_rsync "$RIBYN_ROOT/assets/images/wallpapers/car-in-grass.jpg" "$HOME/.config/hypr/"

# for hyprlock
ribyn_rsync "$RIBYN_ROOT/assets/images/eeyore.png" "$HOME/.config/hypr/"
ribyn_rsync "$RIBYN_ROOT/apps/hypr/hyprbye.sh" "$HOME/.local/bin/hyprbye"

hypr_running=${HYPRLAND_INSTANCE_SIGNATURE:-"not running"}
if [[ $hypr_running == "not running" ]]; then
	info "hyprland is not running. skipping reload config."
else
	info "try reloading hyprland config."
	hyprctl reload
fi

# i-am-root
mkdir -p "$HOME/.config/hypr/i-am-root/"

# background
ribyn_rsync \
	"$RIBYN_ROOT/assets/images/groot-relaxing-in-grass.jpg" \
	"$HOME/.config/hypr/i-am-root/"

# profile image (appearance-wise)
ribyn_rsync \
	"$RIBYN_ROOT/assets/images/good-morning-groot.jpg" \
	"$HOME/.config/hypr/i-am-root/"
