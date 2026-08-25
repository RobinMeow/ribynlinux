#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/config.sh"

# NOTE: i can still use wezterm from within wsl.
# so might as well install as normally and for wsl copy additionially

DEST_CONFIG_DIR="$HOME/.config/wezterm"
WEZTERM_LUA_ORIGIN="$RIBYN_ROOT/apps/wezterm/wezterm.lua"
DEST_HOME_DIR="$HOME"
. "$RIBYN_ROOT/lib/detect_env.sh"
detect_env

mkdir -p "$DEST_CONFIG_DIR"

# copying the background image to both dirs, since I cant bother
cp "$RIBYN_ROOT/assets/images/wallpapers/fallen-knight-blossom-field-3840x2160.png" "$DEST_CONFIG_DIR/background.png"

if [[ "$OS_TYPE" == "wsl" && "$RIBYN_SKIP_DETECT_SLOP_USER" != "yes" ]]; then
	. "$RIBYN_ROOT/lib/detect_win_user.sh"
	detect_win_user

	DEST_CONFIG_DIR="$WINDOWS_HOME/.config/wezterm"
	DEST_HOME_DIR="$WINDOWS_HOME"
	# NOTE: now using wsl as default. because I dont use wezterm outside wsl
	WEZTERM_LUA_ORIGIN="$RIBYN_ROOT/apps/wezterm/wezterm.lua"
	mkdir -p "$DEST_CONFIG_DIR"
	cp "$RIBYN_ROOT/assets/images/wallpapers/fallen-knight-blossom-field-3840x2160.png" "$DEST_CONFIG_DIR/background.png"
fi

rsync -rlpt \
	"$WEZTERM_LUA_ORIGIN" \
	"$DEST_HOME_DIR/.wezterm.lua"

source "$RIBYN_ROOT/config.sh"
if [[ "$RIBYN_WEZTERM_CLEAN_ON_SYNC" == "yes" ]]; then
	info "Cleaning up wezterm config dir"
	rm -rf "$DEST_CONFIG_DIR"
fi

mkdir -p "$DEST_CONFIG_DIR/wallpapers"
if [[ -d "$RIBYN_ROOT/assets/images/wallpapers" ]]; then
	cp "$RIBYN_ROOT/assets/images/wallpapers/"* "$DEST_CONFIG_DIR/wallpapers/"
fi

# copy .config/wezterm content (excluding my-workspaces.lua)
for file in "$RIBYN_ROOT/apps/wezterm/config/"*; do
	if [[ "$(basename "$file")" != "my-workspaces.lua" ]]; then
		cp -r "$file" "$DEST_CONFIG_DIR/"
	fi
done

# WARN: motions on other branches are not yet transferred to the new dir structure
motions_dir="$RIBYN_ROOT/images/motions"
if [[ -d $motions_dir ]]; then
	info "Syncing motions $motions_dir"
	mkdir -p "$DEST_CONFIG_DIR/motions"
	cp "$RIBYN_ROOT/images/motions/"* "$DEST_CONFIG_DIR/motions/"
else
	source "$RIBYN_ROOT/lib/utils.sh"
	warn "No motions found in $motions_dir"
	info "Motions are found in the branches named 'motions*'"
fi
