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

	sudo dnf install --assumeyes \
		wayland-protocols-devel \
		xorg-x11-server-Xwayland \
		wayland-devel

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
	"$RIBYN_ROOT/apps/hypr/build-stack-item-from-source.sh" \
		"hyprland-protocols" \
		"https://github.com/hyprwm/hyprland-protocols" \
		$RIBYN_HYPR_HYPRLAND_PROTOCOLS_GIT_REF \
		"hyprland-protocols"

	"$RIBYN_ROOT/apps/hypr/build-hyprwayland-scanner-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprutils-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprgraphics-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprlang-from-source.sh"
	# TODO: build from source hyprcursor
	"$RIBYN_ROOT/apps/hypr/build-aquamarine-from-source.sh"
	# TODO: build from source xdg-desktop-portal-hyprland
	"$RIBYN_ROOT/apps/hypr/build-hyprwire-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprtoolkit-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprland-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprland-guiutils-from-source.sh"

	# NOTE: copr is also available. if you trust the person who maintains it
	# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
else
	error "distro not supported"
fi
