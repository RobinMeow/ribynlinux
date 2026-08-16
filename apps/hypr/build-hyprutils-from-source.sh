#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/state/ribyn"
logfile="$HOME/.local/state/ribyn/hypr/hyprutils-build-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

# TODO: add pkg-config to essentials
if pkg-config --exists hyprutils; then
	info "hyprutils already installed. Skipping."
	exit 0
fi

if on_arch; then
	error "hyprutils build from source is not needed on arch. use pacman -S hyprland to install hyprland."
	exit 1
elif on_fedora; then
	sudo dnf install --assumeyes \
		cmake \
		gcc \
		gcc-c++ \
		pixman-devel

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprutils"
		if [[ -d "$dest" ]]; then
			warn "hyprutils repo detected. cleaning for re-build."
			rm -rf "$dest"
		fi

		git clone "https://github.com/hyprwm/hyprutils.git" "$dest"
		cd "$dest"
		git checkout $RIBYN_HYPR_HYPRUTILS_GIT_REF
		cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
		cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
		sudo cmake --install build
	)
else
	error "distro not supported"
fi
