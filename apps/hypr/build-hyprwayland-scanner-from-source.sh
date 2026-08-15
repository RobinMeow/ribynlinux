#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hypr/hyprwayland-scanner-build-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	error "ERROR: Use pacman on archlinux to install hyperland. use pacman -S hyprland instead."
	exit 1
elif on_fedora; then
	# sudo dnf install --assumeyes \
	# 	ninja-build \
	# 	cmake \
	# 	meson \
	# 	gcc \
	# 	libxcb \
	# 	libxcb-devel \
	# 	xcb-proto \
	# 	xcb-util \
	# 	xcb-util-devel \
	# 	xcb-util-keysyms \
	# 	xcb-util-keysyms-devel \
	# 	libXfixes \
	# 	libX11 \
	# 	libX11-devel \
	# 	libXcomposite \
	# 	libXcomposite-devel \
	# 	libXrender \
	# 	libXrender-devel \
	# 	libXcursor \
	# 	libXcursor-devel \
	# 	pixman \
	# 	pixman-devel \
	# 	wayland-protocols-devel \
	# 	cairo-devel \
	# 	pango-devel \
	# 	libxkbcommon \
	# 	libxkbcommon-devel \
	# 	xcb-util-wm \
	# 	xcb-util-wm-devel \
	# 	xorg-x11-server-Xwayland \
	# 	libinput \
	# 	libinput-devel \
	# 	libliftoff \
	# 	libliftoff-devel \
	# 	libdisplay-info \
	# 	libdisplay-info-devel \
	# 	cpio \
	# 	tomlplusplus \
	# 	tomlplusplus-devel \
	# 	hyprcursor \
	# 	hyprcursor-devel \
	# 	hyprwayland-scanner-devel \
	# 	xcb-util-errors \
	# 	xcb-util-errors-devel \
	# 	hyprgraphics \
	# 	hyprgraphics-devel \
	# 	re2 \
	# 	re2-devel \
	# 	muParser \
	# 	muParser-devel \
	# 	gcc-c++ \
	# 	xcb-util-devel \
	# 	xcb-util-keysyms-devel \
	# 	libxcb-devel \
	# 	libseat-devel \
	# 	hwdata-devel \
	# 	libX11-devel \
	# 	pixman-devel \
	# 	wayland-devel \
	# 	mesa-libgbm \
	# 	mesa-libgbm-devel \
	# 	libdrm \
	# 	libdrm-devel \
	# 	mesa-libEGL \
	# 	mesa-libGL \
	# 	mesa-libGL-devel \
	# 	mesa-libEGL-devel \
	# 	mesa-libGLES-devel \
	# 	libglvnd-devel \
	# 	glslang-devel \
	# 	pugixml-devel \
	# 	libjpeg-turbo-devel \
	# 	libwebp-devel \

	# file has libmagick

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprwayland-scanner"
		if [[ -d "$dest" ]]; then
			info "hyprwayland-scanner already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprwayland-scanner.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF
			cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
			cmake --build build -j "$(nproc)"
			sudo cmake --install build
		fi
	)
else
	error "distro not supported"
fi
