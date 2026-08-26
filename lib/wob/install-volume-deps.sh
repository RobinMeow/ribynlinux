#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"

# these are for wob volumne.sh
if on_arch; then
	sudo pacman -S --needed --noconfirm \
		awk \
		wireplumber
elif on_fedora; then
	sudo dnf install --assumeyes \
		awk \
		wireplumber
fi

# "$RIBYN_ROOT/lib/wob/build-from-source.sh"
