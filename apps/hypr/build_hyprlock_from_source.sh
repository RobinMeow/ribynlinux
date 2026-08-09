#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hyprwm/hyprlock
# https://wiki.hypr.land/Hypr-Ecosystem/hyprlock

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	cmake \
	cairo \
	hyprgraphics \
	hyprlang \
	hyprutils \
	hyprwayland-scanner \
	mesa \
	pam \
	pango \
	sdbus-cpp \
	wayland
# WARN: not sure if wayland includes wayland-client and wayland-protocols

run_on_fedora sudo dnf install -y \
	cmake \
	cairo \
	hyprgraphics \
	hyprlang \
	hyprutils \
	hyprwayland-scanner-devel \
	mesa-libgbm \
	libdrm \
	mesa-libEGL \
	mesa-libGL \
	pam \
	pango \
	sdbus-cpp \
	wayland-devel
# WARN: not sure if wayland-devel includes client and protocols

mkdir -p "$HOME/.local/share/ribyn/"
dest="$HOME/.local/share/ribyn/hyprlock"
if [[ -d "$dest" ]]; then
	info "hyprlock is already installed. Skipping."
else
	(
		git clone --depth 1 "https://github.com/hyprwm/hyprlock.git" "$dest"
		cd "$dest"

		# build
		cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
		cmake --build ./build --config Release --target hyprlock -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)

		# install
		sudo cmake --install build
	)
fi
