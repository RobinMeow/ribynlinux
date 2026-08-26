#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		mpd
elif on_fedora; then
	"$RIBYN_ROOT/core/ensure-installed-fedora-rpm.sh"
	sudo dnf install -y \
		mpd
fi
