#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hypr/hyprwire-build-from-source.log"
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
		pugixml-devel

	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/hyprwire"
		if [[ -d "$dest" ]]; then
			info "hyprwire already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprwire.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRWIRE_GIT_REF
			# WARN: they had no build installations on their readme
			# so I just copied one of the others, most of em are the same
			cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
			cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
			sudo cmake --install build
		fi
	)
else
	error "distro not supported"
fi
