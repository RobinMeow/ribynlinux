#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		mpd
elif on_fedora; then
	"$RIBYN_ROOT/installers/ensure_installed_fedora_rpm.sh"
	sudo dnf install -y \
		mpd
fi
