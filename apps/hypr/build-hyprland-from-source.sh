#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hypr/hyprland-build-from-source.log"
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
	sudo dnf install --assumeyes \
		cmake \
		gcc \
		gcc-c++ \
		glslang-devel \
		hyprcursor-devel \
		libinput-devel \
		re2-devel \
		muParser-devel \
		mesa-libgbm-devel \
		libdrm-devel \
		libxcb-devel \
		xcb-util-errors-devel \
		xcb-util-wm-devel \
		tomlplusplus-devel \
		pugixml-devel \
		libseat-devel

	# 	libxcb \
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
	# 	xorg-x11-server-Xwayland \
	# 	libinput \
	# 	libliftoff \
	# 	libliftoff-devel \
	# 	libdisplay-info \
	# 	libdisplay-info-devel \
	# 	cpio \
	# 	tomlplusplus \
	# 	hyprcursor \
	# 	hyprwayland-scanner-devel \
	# 	xcb-util-errors \
	# 	hyprgraphics \
	# 	hyprgraphics-devel \
	# 	re2 \
	# 	muParser \
	# 	gcc-c++ \
	# 	xcb-util-devel \
	# 	xcb-util-keysyms-devel \
	# 	libxcb-devel \
	# 	hwdata-devel \
	# 	libX11-devel \
	# 	pixman-devel \
	# 	wayland-devel \
	# 	mesa-libgbm \
	# 	libdrm \
	# 	mesa-libEGL \
	# 	mesa-libGL \
	# 	mesa-libGL-devel \
	# 	mesa-libEGL-devel \
	# 	mesa-libGLES-devel \
	# 	libglvnd-devel \
	# 	libjpeg-turbo-devel \
	# 	libwebp-devel \

	# file has libmagick

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprland"
		if [[ -d "$dest" ]]; then
			info "hyprland already installed. skipping."
		else
			sudo dnf install --assumeyes \
				libuuid-devel \
				libeis-devel \
				lua-devel \
				sdbus-cpp-devel \
				readline-devel \
				libcanberra-devel

			git clone --recurse-submodules "https://github.com/hyprwm/Hyprland" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRLAND_GIT_REF
			make release
			sudo make install
		fi
	)
else
	error "distro not supported"
fi
