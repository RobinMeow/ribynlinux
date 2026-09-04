#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "installing kaomoji picker"

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		wl-clipboard \
		rofi \
		jq
elif on_fedora; then
	sudo dnf install --assumeyes \
		wl-clipboard \
		rofi \
		jq
fi
