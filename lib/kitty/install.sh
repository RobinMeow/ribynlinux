#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/kitty/env.sh"
if [[ "$RIBYN_KITTY_ENABLED" == "no" ]]; then
	exit 0
fi

source "$RIBYN_ROOT/core/utils.sh"
info "installing kitty"

source "$RIBYN_ROOT/core/run_on_distro.sh"
if on_arch; then
	sudo pacman -S --needed --noconfirm \
		kitty
elif on_fedora; then
	sudo dnf install --assumeyes \
		kitty
fi
