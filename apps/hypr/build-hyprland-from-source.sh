#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/hypr/"
logfile="$HOME/.cache/ribyn/hyprland-build-from-source.log"
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
	xcb-util-wm-devel \
	readline-devel \
	lua-devel \
	libeis-devel

mkdir -p "$HOME/.local/share/ribyn/hypr/"
(
	dest="$HOME/.local/share/ribyn/hyprland"
	if [[ -d "$dest" ]]; then
		info "repo detected. removing for clean re-build."
		rm -rf "$dest"
	fi

	git clone --recurse-submodules "https://github.com/hyprwm/Hyprland" "$dest"
	cd "$dest"
	git checkout $RIBYN_HYPR_HYPRLAND_GIT_REF
	make release
	sudo make install
)
