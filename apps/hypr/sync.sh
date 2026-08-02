#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh" # warn, rsync_dotfiles

# removing deprecated hyprland.conf file
hypr_conf="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$hypr_conf" ]]; then
	warn "Deprecated hyprland.conf file detected. Delete it to get rid of this warning."
fi

mkdir -p "$HOME/.config/hypr"
rsync_dotfiles \
	--exclude="local/" \
	"$RIBYN_ROOT/apps/hypr/config/" \
	"$HOME/.config/hypr/"

mkdir -p "$HOME/.config/hypr/local"
rsync_dotfiles \
	--ignore-existing \
	"$RIBYN_ROOT/apps/hypr/config/local/" \
	"$HOME/.config/hypr/local/"
