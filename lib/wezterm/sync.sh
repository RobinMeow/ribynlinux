#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing wezterm"

RIBYN_WEZTERM_ENABLED=${RIBYN_WEZTERM_ENABLED:-"no"}

if [[ "$RIBYN_WEZTERM_ENABLED" == "no" ]]; then
	info "wezterm disabled. Skipping sync."
	exit 0
fi

# set to "no" if you test in docker, which doesnt have /mnt/c/Users
# mounted causing detect_win_user to fail. so wezterm cant sync the config.
# when skipped, will normally sync to linux home
RIBYN_SKIP_DETECT_SLOP_USER=${RIBYN_SKIP_DETECT_SLOP_USER:-"no"}

# solid | transparent | wallpaper
RIBYN_WEZTERM_BG=${RIBYN_WEZTERM_BG:-"wallpaper"}

source "$RIBYN_ROOT/config.sh"

mkdir -p "$HOME/.config/wezterm"

cp \
	"$RIBYN_ROOT/assets/images/wallpapers/fallen-knight-blossom-field-3840x2160.png" \
	"$HOME/.config/wezterm/wallpaper.png"

rsync -rlpt \
	"$RIBYN_ROOT/lib/wezterm/wezterm.lua" \
	"$HOME/.wezterm.lua"

# WSL
source "$RIBYN_ROOT/core/detect_env.sh"
detect_env
if [[ "$OS_TYPE" == "wsl" && "$RIBYN_SKIP_DETECT_SLOP_USER" != "yes" ]]; then
	source "$RIBYN_ROOT/core/detect_win_user.sh"
	detect_win_user

	# do the same as above for linux,
	# but replace $HOME with $WINDOWS_HOME

	mkdir -p "$WINDOWS_HOME/.config/wezterm"

	cp \
		"$RIBYN_ROOT/assets/images/wallpapers/fallen-knight-blossom-field-3840x2160.png" \
		"$WINDOWS_HOME/.config/wezterm/wallpaper.png"

	rsync -rlpt \
		"$RIBYN_ROOT/lib/wezterm/wezterm.lua" \
		"$WINDOWS_HOME/.wezterm.lua"
fi
