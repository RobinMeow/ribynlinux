#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		libnotify \
		dunst
elif on_fedora; then
	sudo dnf install --assumeyes \
		libnotify \
		dunst
fi
