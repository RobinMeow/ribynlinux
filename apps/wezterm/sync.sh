#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/utils.sh"
source "$RIBYNS_ENV/config.sh"

# NOTE: i can still use wezterm from within wsl.
# so might as well install as normally and for wsl copy additionially

DEST_CONFIG_DIR="$HOME/.config/wezterm"
DEST_HOME_DIR="$HOME"
source "$RIBYNS_ENV/lib/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$RIBYNS_ENV/lib/detect_win_user.sh"
	detect_win_user

	DEST_CONFIG_DIR="$WINDOWS_HOME/.config/wezterm"
	DEST_HOME_DIR="$WINDOWS_HOME"
fi

cp "$RIBYNS_ENV/apps/wezterm/wezterm.lua" "$DEST_HOME_DIR"

if [[ $RIBYN_WEZTERM_CLEAN_ON_SYNC ]]; then
	info "Cleaning up wezterm config dir"
	rm -rf "$DEST_CONFIG_DIR"
fi

mkdir -p "$DEST_CONFIG_DIR/wallpapers"
if [[ -d "$RIBYNS_ENV/assets/images/wallpapers" ]]; then
	cp "$RIBYNS_ENV/assets/images/wallpapers/"* "$DEST_CONFIG_DIR/wallpapers/"
fi

# copy .config/wezterm content (excluding my-workspaces.lua)
mkdir -p "$DEST_CONFIG_DIR"
for file in "$RIBYNS_ENV/apps/wezterm/config/"*; do
	if [[ "$(basename "$file")" != "my-workspaces.lua" ]]; then
		cp -r "$file" "$DEST_CONFIG_DIR/"
	fi
done

# WARN: motions on other branches are not yet transferred to the new dir structure
motions_dir="$RIBYNS_ENV/images/motions"
if [[ -d $motions_dir ]]; then
	mkdir -p "$DEST_CONFIG_DIR/motions"
	cp "$RIBYNS_ENV/images/motions/"* "$DEST_CONFIG_DIR/motions/"
else
	source "$RIBYNS_ENV/lib/utils.sh"
	warn "No motions found in $motions_dir"
	info "Motions are found in the branches named 'motions*'"
fi
