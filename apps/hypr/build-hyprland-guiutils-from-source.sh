#!/usr/bin/env bash
set -euo pipefail

# this is the successor to hyprland-qtutils

mkdir -p "$HOME/.local/state/ribyn/hypr/"
logfile="$HOME/.local/state/ribyn/hypr/hyprland-guiutils-build-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

# TODO: add pkg-config to essentials
if pkg-config --exists hyprguiutils; then
	info "hyprland-guiutils already installed. Skipping."
	exit 0
fi

if on_arch; then
	error "hyprland-guiutils build from source is not needed on arch. use pacman -S hyprland to install hyprland."
	exit 1
elif on_fedora; then
	# WARN: depends on:
	# - hyprutils
	# - hyprlang > depends on hyprutils
	# - hyprtoolkit > depends on hyprwarland-scanner

	sudo dnf install --assumeyes \
		cmake \
		gcc \
		gcc-c++ \
		libxkbcommon-devel \
		libdrm-devel \
		libglvnd-devel \
		wayland-devel \
		wayland-protocols-devel \
		pixman-devel

	# wayland-devel contains wayland-client
	# wayland-protocols-devel contains wayland-protocols

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprland-guiutils"
		if [[ -d "$dest" ]]; then
			warn "hyprland-guiutils repo detected. cleaning for re-build."
			rm -rf "$dest"
		fi

		git clone "https://github.com/hyprwm/hyprland-guiutils" "$dest"
		cd "$dest"
		git checkout $RIBYN_HYPR_HYPRLAND_GUIUTILS_GIT_REF
		cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
		cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
		sudo cmake --install build
	)
else
	error "distro not supported"
fi
