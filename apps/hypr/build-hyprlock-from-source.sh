#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hyprwm/hyprlock
# https://wiki.hypr.land/Hypr-Ecosystem/hyprlock

. "$RIBYN_ROOT/lib/utils.sh"

if [[ -x "/usr/local/bin/hyprlock" ]]; then
	info "hyprlock is already installed. Skipping."
	exit 0
fi

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
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
		wayland \
		extra/wayland-protocols
# wayland provides wayland-client
# extra/wayland-protocols provides wayland-protocols
elif on_fedora; then
	# NOTE: these are available, but due to version missmatches I build all from source
	# for fedora at least
	#
	# hyprutils \
	# hyprgraphics \
	# hyprwayland-scanner-devel \
	# hyprlang \
	#
	# WARN: make sure they are installed before running this script.

	sudo dnf install -y \
		cmake \
		gcc-c++ \
		libxkbcommon-devel \
		libglvnd-devel \
		mesa-libgbm-devel \
		sdbus-cpp-devel \
		cairo-devel \
		pango-devel \
		libdrm-devel \
		pam-devel \
		wayland-devel \
		wayland-protocols-devel
	# mesa-libEGL \
	# mesa-libGL \
	# pam \
	# sdbus-cpp \
else
	error "distro not supported"
	exit 1
fi

dest="$HOME/.local/share/ribyn/hyprlock"

if [[ -d "$dest" ]]; then
	warn "existing git repo detected. cleaning for clean re-build."
	rm -rf "$dest"
fi

mkdir -p "$HOME/.local/share/ribyn/"
git clone "https://github.com/hyprwm/hyprlock.git" "$dest"

mkdir -p "$HOME/.local/bin/"
(
	cd "$dest"
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
	cmake --build ./build --config Release --target hyprlock -j"$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
	sudo cmake --install ./build
)
