#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "Installing screenshot tools"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		grim \
		slurp \
		swappy
elif on_fedora; then
	sudo dnf install -y \
		grim \
		slurp \
		swappy
fi
