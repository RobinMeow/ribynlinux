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

sudo dnf install --assumeyes \
	glslang-devel \
	re2-devel \
	muParser-devel \
	libXcursor-devel \
	xcb-util-errors-devel \
	xcb-util-wm-devel

# TODO: continue with deps here
# Checking for one of the modules 'lua55;lua5.5;lua-55;lua-5.5;lua>=5.5;lua<5.6'
# CMake Error at /usr/share/cmake/Modules/FindPkgConfig.cmake:1203 (message):
#   None of the required 'lua55;lua5.5;lua-55;lua-5.5;lua>=5.5;lua<5.6' found
# Call Stack (most recent call first):
#   CMakeLists.txt:291 (pkg_search_module)
#
#
# -- Looking for execinfo.h
# -- Looking for execinfo.h - found
# -- Configuration supports execinfo
# -- Looking for backtrace in execinfo
# -- Looking for backtrace in execinfo - not found
# -- Looking for sys/timerfd.h
# -- Looking for sys/timerfd.h - found
# -- Checking for module 'epoll-shim'
# --   Package 'epoll-shim' not found
# -- Looking for sys/inotify.h
# -- Looking for sys/inotify.h - found
# -- Checking for module 'libinotify'
# --   Package 'libinotify' not found
# -- XWAYLAND Enabled (NO_XWAYLAND not defined) checking deps...
# -- Checking for modules 'xcb;xcb-render;xcb-xfixes;xcb-icccm;xcb-composite;xcb-res;xcb-errors'
# --   Found xcb, version 1.17.0
# --   Found xcb-render, version 1.17.0
# --   Found xcb-xfixes, version 1.17.0
# --   Found xcb-icccm, version 0.4.2
# --   Found xcb-composite, version 1.17.0
# --   Found xcb-res, version 1.17.0
# --   Found xcb-errors, version 1.0.1
# -- SYSTEMD support is requested (NO_SYSTEMD not defined)...
# -- UWSM support is enabled (NO_UWSM not defined)...
# -- Setting precompiled headers
# -- Setting link libraries
# -- Checking for module 'hyprland-protocols>=0.7.0'
# --   Found hyprland-protocols, version 0.7.0
# -- hyprland-protocols dependency set to //usr/share/hyprland-protocols
# -- Checking for modules 'hyprutils>=0.2.4;hyprwire;re2;readline'
# --   Package 'readline' not found
# CMake Error at /usr/share/cmake/Modules/FindPkgConfig.cmake:1093 (message):
#   The following required packages were not found:
#
#    - readline
#
# Call Stack (most recent call first):
#   /usr/share/cmake/Modules/FindPkgConfig.cmake:1166 (_pkg_check_modules_internal)
#   hyprctl/CMakeLists.txt:8 (pkg_check_modules)
#
#
# -- Configuring incomplete, errors occurred!
# make: *** [Makefile:7: release] Error 1

# 	hyprcursor-devel \
# 	libinput-devel \
# 	mesa-libgbm-devel \
# 	libdrm-devel \
# 	libxcb-devel \
# 	tomlplusplus-devel \
# 	pugixml-devel \
# 	libseat-devel

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
			libeis-devel
		# 	libuuid-devel \
		# 	lua-devel \
		# 	sdbus-cpp-devel \
		# 	readline-devel \
		# 	libcanberra-devel

		git clone --recurse-submodules "https://github.com/hyprwm/Hyprland" "$dest"
		cd "$dest"
		git checkout $RIBYN_HYPR_HYPRLAND_GIT_REF
		make release
		sudo make install
	fi
)
