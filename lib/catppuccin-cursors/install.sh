#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/catppuccin-cursors/env.sh"
[[ "$RIBYN_CATPPUCCIN_CURSORS_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing catppuccin cursors"

# https://github.com/catppuccin/cursors (see picture here for available themes and variants)

theme="$RIBYN_CATPPUCCIN_CURSOR_THEME"
variant="$RIBYN_CATPPUCCIN_CURSOR_VARIANT"

if [[ ! -d "$HOME/.icons/catppuccin-$theme-$variant-cursors" ]]; then
	source "$RIBYN_ROOT/core/run_on_distro.sh"

	run_on_arch sudo pacman -S --needed --noconfirm \
		curl unzip

	run_on_fedora sudo dnf install -y \
		curl unzip

	(
		mkdir -p "$HOME/.icons"
		cd "$HOME/.icons"
		curl -LOsS "https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-$theme-$variant-cursors.zip"
		zipfile="catppuccin-$theme-$variant-cursors.zip"
		unzip "$zipfile"
		rm -f "$zipfile"
	)
else
	info "catppuccin-latte-peach-cursors is already installed. Skipping."
fi
