#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/wezterm/env.sh"
[[ "$RIBYN_WEZTERM_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "syncing wezterm"

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
if [[ "$OS_TYPE" == "wsl" ]]; then
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
