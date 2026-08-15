#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hypr/hyprutils-build-from-source.log"
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
		pixman-devel

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
else
	error "distro not supported"
fi
