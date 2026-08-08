#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser
# TODO: window rule to have it behave like a floating window? or at least it should take focus

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

mkdir -p "$HOME/local/share/ribyn/"
gitdest="$HOME/.local/share/ribyn/xdg-desktop-portal-filechooser"
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

	sudo ln -s "/usr/local/share/xdg-desktop-portal/portals/termfilechooser.portal" "/usr/share/xdg-desktop-portal/portals/"

	ribyn_rsync \
		"$RIBYN_ROOT/apps/xdg-desktop-portal-termfilechooser/config/" \
		"$HOME/.config/xdg-desktop-portal-termfilechooser/"
fi
