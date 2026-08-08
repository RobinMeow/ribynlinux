#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

# https://github.com/catppuccin/cursors (see picture here for available themes and variants)

theme="latte"
variant="peach"

if [[ ! -d "$HOME/.icons/catppuccin-$theme-$variant-cursors" ]]; then
	. "$RIBYN_ROOT/lib/run_on_distro.sh"

	run_on_arch sudo pacman -S --needed --noconfirm \
		curl unzip

	run_on_fedora sudo dnf install -y \
		curl unzip

	(
		mkdir "$HOME/.icons"
		cd "$HOME/.icons"
		curl -LOsS "https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-$theme-$variant-cursors.zip"
		zipfile="catppuccin-$theme-$variant-cursors.zip"
		unzip "$zipfile"
		rm -f "$zipfile"
	)
else
	info "catppuccin-latte-peach-cursors is already installed. Skipping."
fi
