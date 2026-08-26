#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing wiremix"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		wiremix
elif on_fedora; then
	sudo dnf install --assumeyes \
		wiremix
fi
