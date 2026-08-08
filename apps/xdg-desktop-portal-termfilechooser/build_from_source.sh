#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

gitdest="$HOME/.config/ribyn/xdg-desktop-portal-filechooser"
if [[ -d "$gitdest" ]]; then
	info "xdg-desktop-portal-termfilechooser is already installed. Skipping build from source."
else
	run_on_arch sudo pacman -S --needed --noconfirm \
		git \
		xdg-desktop-portal \
		libinih \
		ninja \
		meson \
		scdoc

	run_on_fedora sudo dnf install -y \
		git \
		xdg-desktop-portal \
		inih \
		ninja \
		meson \
		scdoc

	mkdir -p "$HOME/.config/ribyn"
	git clone --depth 1 "https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser.git" "$gitdest"

	(
		cd "$gitdest"
		meson build
		ninja -C build
		sudo ninja -C build install
	)

	ribyn_rsync \
		"$RIBYN_ROOT/apps/xdg-desktop-portal-termfilechooser/config/" \
		"$HOME/.config/xdg-desktop-portal-termfilechooser/"
fi
