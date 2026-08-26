#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing mpd"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		mpd
elif on_fedora; then
	"$RIBYN_ROOT/core/ensure-installed-fedora-rpm.sh"
	sudo dnf install -y \
		mpd
fi
