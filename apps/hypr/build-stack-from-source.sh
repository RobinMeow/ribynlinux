#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/state/ribyn/"
logfile="$HOME/.local/state/ribyn/build-stack-from-source.log"
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

	function hypr_build() {
		# WARN: installs into /usr
		# so avoid using the package manager to install these
		# can cause conflicts.
		# will prevent juggling systemd/env vars
		# to excpose the /usr/local paths etc..
		cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

		# NOTE: consider -1 core, to prevent segementation fails ? if it happens again
		cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
		sudo cmake --install build
	}

	# base deps for almost all of them
	sudo dnf install --assumeyes \
		wayland-protocols-devel \
		wayland-devel \
		xorg-x11-server-Xwayland \
		cmake \
		gcc \
		gcc-c++

	. "$RIBYN_ROOT/lib/source-manager.sh"

	# TODO: source_exists is not yet implement.
	# requires source_manger to support updating to be relevant anyways

	function install_dep() {
		local name=$1
		local giturl=$2
		local gitrev=$3
		check_source_state "$name" "$gitrev"
		if [[ "$SOURCE_STATE" == "source n/a" ]]; then
			info "[$SOURCE_NAME] initialising..."
			init_source "$giturl"
			info "[$SOURCE_NAME] installing..."
			(cd "$SOURCE_DEST" && hypr_build)
		elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
			if source_pkg_config_exists; then
				info "$SOURCE_NAME already installed. Skipping."
			else
				# edge case. means its already cloned, but build probaly failed.
				clean_source
				info "[$SOURCE_NAME] installing..."
				(cd "$SOURCE_DEST" && hypr_build)
			fi
		elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
			clean_source
			update_source "$giturl"
			info "[$SOURCE_NAME] updating..."
			(cd "$SOURCE_DEST" && hypr_build)
		fi
	}

	install_dep "hyprland-protocols" \
		"https://github.com/hyprwm/hyprland-protocols" \
		"$RIBYN_HYPR_HYPRLAND_PROTOCOLS_GIT_REF"

	sudo dnf install --assumeyes \
		pugixml-devel
	install_dep "hyprwayland-scanner" \
		"https://github.com/hyprwm/hyprwayland-scanner.git" \
		"$RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF"

	sudo dnf install --assumeyes \
		pixman-devel
	install_dep "hyprutils" \
		"https://github.com/hyprwm/hyprutils.git" \
		"$RIBYN_HYPR_HYPRUTILS_GIT_REF"

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
	install_dep "hyprgraphics" \
		"https://github.com/hyprwm/hyprgraphics.git" \
		"$RIBYN_HYPR_HYPRGRAPHICS_GIT_REF"

	install_dep "hyprlang" \
		"https://github.com/hyprwm/hyprlang.git" \
		"$RIBYN_HYPR_HYPRLANG_GIT_REF"

	sudo dnf install --assumeyes \
		libzip-devel \
		tomlplusplus-devel
	install_dep "hyprcursor" \
		"https://github.com/hyprwm/hyprcursor" \
		"$RIBYN_HYPR_HYPRCURSOR_GIT_REF"

	sudo dnf install --assumeyes \
		libinput-devel \
		libseat-devel \
		mesa-libgbm-devel \
		systemd-devel \
		libdisplay-info-devel \
		hwdata-devel
	# 	systemd-devel is fedoras version of libudev. see here https://github.com/dcuddeback/libudev-sys
	install_dep "aquamarine" \
		"https://github.com/hyprwm/aquamarine" \
		"$RIBYN_HYPR_AQUAMARINE_GIT_REF"

	# xdg-desktop-portal-hyprland
	sudo dnf install --assumeyes \
		qt6-qtbase-devel \
		libuuid-devel \
		pipewire-devel \
		sdbus-cpp-devel
	xdph_giturl="https://github.com/hyprwm/xdg-desktop-portal-hyprland"
	check_source_state "xdg-desktop-portal-hyprland" "$RIBYN_HYPR_XDG_DESKTOP_PORTAL_HYPRLAND_GIT_REF"
	if [[ "$SOURCE_STATE" == "source n/a" ]]; then
		info "[$SOURCE_NAME] initialising..."
		init_source "$xdph_giturl"
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && hypr_build)
	elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
		# WARN: cant reuse source_pkg_config_exists so we just do the process manually here
		if [[ -x "/usr/libexec/xdg-desktop-portal-hyprland" ]]; then
			info "$SOURCE_NAME already installed. Skipping."
		else
			# edge case. means its already cloned, but build probaly failed.
			clean_source
			info "[$SOURCE_NAME] installing..."
			(cd "$SOURCE_DEST" && hypr_build)
		fi
	elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
		clean_source
		update_source "$xdph_giturl"
		info "[$SOURCE_NAME] updating..."
		(cd "$SOURCE_DEST" && hypr_build)
	fi

	install_dep "hyprwire" \
		"https://github.com/hyprwm/hyprwire.git" \
		"$RIBYN_HYPR_HYPRWIRE_GIT_REF"

	sudo dnf install --assumeyes \
		iniparser-devel \
		inotify-tools-devel
	install_dep "hyprtoolkit" \
		"https://github.com/hyprwm/hyprtoolkit.git" \
		"$RIBYN_HYPR_HYPRTOOLKIT_GIT_REF"

	hyprland_guiutils_giturl="https://github.com/hyprwm/hyprland-guiutils"
	check_source_state "hyprland-guiutils" "$RIBYN_HYPR_HYPRLAND_GUIUTILS_GIT_REF"
	if [[ "$SOURCE_STATE" == "source n/a" ]]; then
		info "[$SOURCE_NAME] initialising..."
		init_source "$hyprland_guiutils_giturl"
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && hypr_build)
	elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
		# WARN: cant reuse source_pkg_config_exists so we just do the process manually here
		if command -v hyprland-dialog >/dev/null 2>&1 &&
			command -v hyprland-donate-screen >/dev/null 2>&1 &&
			command -v hyprland-run >/dev/null 2>&1 &&
			command -v hyprland-update-screen >/dev/null 2>&1 &&
			command -v hyprland-welcome >/dev/null 2>&1; then
			info "$SOURCE_NAME already installed. Skipping."
		else
			# edge case. means its already cloned, but build probaly failed.
			clean_source
			info "[$SOURCE_NAME] installing..."
			(cd "$SOURCE_DEST" && hypr_build)
		fi
	elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
		clean_source
		update_source "$hyprland_guiutils_giturl"
		info "[$SOURCE_NAME] updating..."
		(cd "$SOURCE_DEST" && hypr_build)
	fi

	sudo dnf install --assumeyes \
		glslang-devel \
		re2-devel \
		muParser-devel \
		libXcursor-devel \
		xcb-util-errors-devel \
		xcb-util-wm-devel \
		readline-devel \
		lua-devel
	function build_hyprland() {
		make release
		sudo make install
	}
	hyprland_giturl="https://github.com/hyprwm/Hyprland"
	check_source_state "hyprland" "$RIBYN_HYPR_HYPRLAND_GIT_REF"
	if [[ "$SOURCE_STATE" == "source n/a" ]]; then
		info "[$SOURCE_NAME] initialising..."
		init_source "$hyprland_giturl"
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && build_hyprland)
	elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
		# WARN: cant reuse source_pkg_config_exists so we just do the process manually here
		if command -v hyprland >/dev/null 2>&1; then
			info "$SOURCE_NAME already installed. Skipping."
		else
			# edge case. means its already cloned, but build probaly failed.
			clean_source
			info "[$SOURCE_NAME] installing..."
			(cd "$SOURCE_DEST" && build_hyprland)
		fi
	elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
		clean_source
		update_source "$hyprland_giturl"
		info "[$SOURCE_NAME] updating..."
		(cd "$SOURCE_DEST" && build_hyprland)
	fi

	# NOTE: copr is also available, but its bloated imho
	# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
else
	error "distro not supported"
fi
