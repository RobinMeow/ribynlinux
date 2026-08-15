#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/build-all-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

# CMake Recommended
# https://wiki.hypr.land/Getting-Started/Installation/#cmake-recommended
#
# how to build hyprland on fedora
# https://github.com/hyprwm/Hyprland/discussions/284

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	error "ERROR: Use pacman on archlinux to install hyperland. use pacman -S hyprland instead."
	exit 1
elif on_fedora; then

	# TODO: bulid [https://github.com/stephenberry/glaze](https://github.com/stephenberry/glaze) from source
	# TODO: bulid hyprland-qtutils from source hyprland-qtutils-git

	# TODO: if I got some free time to throw away, move these deps into each build from source
	# and only install what is needed
	sudo dnf install --assumeyes \
		ninja-build \
		cmake \
		meson \
		gcc \
		libxcb \
		libxcb-devel \
		xcb-proto \
		xcb-util \
		xcb-util-devel \
		xcb-util-keysyms \
		xcb-util-keysyms-devel \
		libXfixes \
		libX11 \
		libX11-devel \
		libXcomposite \
		libXcomposite-devel \
		libXrender \
		libXrender-devel \
		libXcursor \
		libXcursor-devel \
		pixman \
		pixman-devel \
		wayland-protocols-devel \
		cairo-devel \
		pango-devel \
		libxkbcommon \
		libxkbcommon-devel \
		xcb-util-wm \
		xcb-util-wm-devel \
		xorg-x11-server-Xwayland \
		libinput \
		libinput-devel \
		libliftoff \
		libliftoff-devel \
		libdisplay-info \
		libdisplay-info-devel \
		cpio \
		tomlplusplus \
		tomlplusplus-devel \
		hyprcursor \
		hyprcursor-devel \
		hyprwayland-scanner-devel \
		xcb-util-errors \
		xcb-util-errors-devel \
		hyprgraphics \
		hyprgraphics-devel \
		re2 \
		re2-devel \
		muParser \
		muParser-devel \
		gcc-c++ \
		xcb-util-devel \
		xcb-util-keysyms-devel \
		libxcb-devel \
		libseat-devel \
		hwdata-devel \
		libX11-devel \
		pixman-devel \
		wayland-devel \
		mesa-libgbm \
		mesa-libgbm-devel \
		libdrm \
		libdrm-devel \
		mesa-libEGL \
		mesa-libGL \
		mesa-libGL-devel \
		mesa-libEGL-devel \
		mesa-libGLES-devel \
		libglvnd-devel \
		glslang-devel \
		pugixml-devel \
		libjpeg-turbo-devel \
		libwebp-devel \
		file-devel \
		librsvg2-devel

	# file has libmagick

	"$RIBYN_ROOT/apps/hypr/build-hyprutils-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprwayland-scanner-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-aquamarine-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprlang-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprgraphics-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprwire-from-source.sh"

	# NOTE: copr is also available. if you trust the person who maintains it
	# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
else
	error "distro not supported"
fi
