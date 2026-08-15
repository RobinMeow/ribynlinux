#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/hyprland-build-from-source.log"
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

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprutils"
		if [[ -d "$dest" ]]; then
			info "hyprutils already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprutils.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRUTILS_GIT_REF
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
			sudo cmake --install build
		fi
	)
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprwayland-scanner"
		if [[ -d "$dest" ]]; then
			info "hyprwayland-scanner already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprwayland-scanner.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRLAND_SCANNER_GIT_REF
			cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
			cmake --build build -j "$(nproc)"
			sudo cmake --install build
		fi
	)
	(
		dest="$HOME/.local/share/ribyn/hypr/aquamarine"
		if [[ -d "$dest" ]]; then
			info "aquamarine already installed. skipping."
		else
			git clone --recurse-submodules "https://github.com/hyprwm/aquamarine" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_AQUAMARINE_GIT_REF
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
			sudo cmake --install build
		fi
	)
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprlang"
		if [[ -d "$dest" ]]; then
			info "hyprlang already installed. skipping."
		else
			info "hyprlang building from source"
			git clone "https://github.com/hyprwm/hyprlang.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRLANG_GIT_REF
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target hyprlang -j"$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
			sudo cmake --install ./build
		fi
	)
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprgraphics"
		if [[ -d "$dest" ]]; then
			info "hyprgraphics already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprgraphics.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRGRAPHICS_GIT_REF
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
			sudo cmake --install build
		fi
	)
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprwire"
		if [[ -d "$dest" ]]; then
			info "hyprwire already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprwire.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRWIRE_GIT_REF
			# WARN: they had no build installations on their readme
			# so I just copied one above, most of em are same
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
			sudo cmake --install build
		fi
	)
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

	# NOTE: copr is also available. if you trust the person who maintains it
	# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
else
	error "distro not supported"
fi
