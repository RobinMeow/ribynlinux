#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser

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
		systemd-devel \
		git \
		xdg-desktop-portal \
		inih-devel \
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

	# NOTE: dir usually already exists, if xdg-desktop-portal and
	# xdg-desktop-portal-hyprland are already installed
	# ln: failed to create symbolic link '/usr/share/xdg-desktop-portal/portals/': No such file or directory
	mkdir -p "/usr/share/xdg-desktop-portal/portals"
	sudo ln -s "/usr/local/share/xdg-desktop-portal/portals/termfilechooser.portal" "/usr/share/xdg-desktop-portal/portals/"

	rsync -rlpt \
		"$RIBYN_ROOT/apps/xdg-desktop-portal-termfilechooser/config/" \
		"$HOME/.config/xdg-desktop-portal-termfilechooser/"
fi
