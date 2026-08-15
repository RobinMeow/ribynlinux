#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hypr/hyprwayland-scanner-build-from-source.log"
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
		dest="$HOME/.local/share/ribyn/hypr/hyprwayland-scanner"
		if [[ -d "$dest" ]]; then
			info "hyprwayland-scanner already installed. skipping."
		else
			git clone "https://github.com/hyprwm/hyprwayland-scanner.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF
			cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
			cmake --build build -j "$(nproc)"
			sudo cmake --install build
		fi
	)
else
	error "distro not supported"
fi
