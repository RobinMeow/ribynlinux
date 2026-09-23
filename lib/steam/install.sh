#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/steam/env.sh"
[[ "$RIBYN_STEAM_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "installing steam"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		steam

	warn "steam installation on arch is not fully automated"
	warn "check the arch wiki for more installation steps"
	warn "https://wiki.archlinux.org/title/Steam"
	# https://wiki.archlinux.org/title/Steam
elif on_fedora; then
	sudo dnf install -y \
		steam
fi
