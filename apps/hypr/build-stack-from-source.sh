#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/build-stack-from-source.log"
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

	# NOTE: according to ai I thought I had to manually build those.
	# didnt need to do so in docker. Ima keep the idea around tho
	#
	# bulid [https://github.com/stephenberry/glaze](https://github.com/stephenberry/glaze) from source
	# bulid hyprland-qtutils from source hyprland-qtutils-git
	# qt6-qtwayland-devel
	# qt6-qtbase-devel
	# qt6-qtwayland-devel

	# NOTE: should have all deps. if something is missing
	# maybe try randonly enabling all these :)

	# build order because some of these depend on one another:
	#  1. hyprland-protocols (According to Dergo from discord "it's a git submodule of most of the apps that require it. If you don't have it system-wide, cmake just uses the submodule. It's just a few xml files needed to build other stuff)
	#  2. hyprwayland-scanner
	#  3. hyprutils
	#  4. hyprgraphics
	#  5. hyprlang
	#  6. hyprcursor
	#  7. aquamarine
	#  8. xdg-desktop-portal-hyprland
	#  9. hyprwire
	# 10. hyprtoolkit
	# 11. hyprland
	# 12. hyprland-guiutils (runtime-only dependency. formerly hyprland-qtutils)

	# TODO: ensure they all can clean re-build
	# TODO: log into .local/state
	# TODO: build from source hyprland-protocols
	sudo dnf install --assumeyes \
		wayland-protocols-devel \
		wayland-devel \
		xorg-x11-server-Xwayland \
		cmake \
		gcc \
		gcc-c++

	# TODO: delete these two scripts
	# "$RIBYN_ROOT/apps/hypr/build-hyprwayland-scanner-from-source.sh"
	# "$RIBYN_ROOT/apps/hypr/build-hyprutils-from-source.sh"
	# "$RIBYN_ROOT/apps/hypr/build-hyprgraphics-from-source.sh"
	# "$RIBYN_ROOT/apps/hypr/build-hyprlang-from-source.sh"

	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprland-protocols" \
		"https://github.com/hyprwm/hyprland-protocols" \
		$RIBYN_HYPR_HYPRLAND_PROTOCOLS_GIT_REF

	sudo dnf install --assumeyes \
		pugixml-devel
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprwayland-scanner" \
		"https://github.com/hyprwm/hyprwayland-scanner.git" \
		$RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF

	sudo dnf install --assumeyes \
		pixman-devel
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprutils" \
		"https://github.com/hyprwm/hyprutils.git" \
		$RIBYN_HYPR_HYPRUTILS_GIT_REF

	sudo dnf install --assumeyes \
		libglvnd-devel \
		cairo-devel \
		pango-devel \
		libdrm-devel \
		libjpeg-turbo-devel \
		libwebp-devel \
		librsvg2-devel \
		file-devel
	# file has libmagick
	# file has libpng-devel
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprgraphics" \
		"https://github.com/hyprwm/hyprgraphics.git" \
		$RIBYN_HYPR_HYPRGRAPHICS_GIT_REF

	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprlang" \
		"https://github.com/hyprwm/hyprlang.git" \
		$RIBYN_HYPR_HYPRLANG_GIT_REF

	sudo dnf install --assumeyes \
		libzip-devel \
		tomlplusplus-devel
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprcursor" \
		"https://github.com/hyprwm/hyprcursor" \
		$RIBYN_HYPR_HYPRCURSOR_GIT_REF

	sudo dnf install --assumeyes \
		libinput-devel \
		libseat-devel \
		mesa-libgbm-devel \
		systemd-devel \
		libdisplay-info-devel \
		hwdata-devel
	# 	systemd-devel is fedoras version of libudev. see here https://github.com/dcuddeback/libudev-sys
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"aquamarine" \
		"https://github.com/hyprwm/aquamarine" \
		$RIBYN_HYPR_AQUAMARINE_GIT_REF

	sudo dnf install --assumeyes \
		qt6-qtbase-devel \
		libuuid-devel \
		pipewire-devel \
		sdbus-cpp-devel
	# sudo dnf install qt6-qtbase-devel qt6-qttools-devel qt6-qtwayland-devel

	# TODO: pkg-config check not working
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"xdg-desktop-portal-hyprland" \
		"https://github.com/hyprwm/xdg-desktop-portal-hyprland" \
		$RIBYN_HYPR_XDG_DESKTOP_PORTAL_HYPRLAND_GIT_REF

	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprwire" \
		"https://github.com/hyprwm/hyprwire.git" \
		$RIBYN_HYPR_HYPRWIRE_GIT_REF

	sudo dnf install --assumeyes \
		iniparser-devel
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprtoolkit" \
		"https://github.com/hyprwm/hyprtoolkit.git" \
		$RIBYN_HYPR_HYPRTOOLKIT_GIT_REF

	# TODO: pkg-config check not working
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprland-guiutils" \
		"https://github.com/hyprwm/hyprland-guiutils" \
		$RIBYN_HYPR_HYPRLAND_GUIUTILS_GIT_REF

	"$RIBYN_ROOT/apps/hypr/build-hyprland-from-source.sh"

	# NOTE: copr is also available. if you trust the person who maintains it
	# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
else
	error "distro not supported"
fi
