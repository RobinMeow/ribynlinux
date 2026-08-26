#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		vale
elif on_fedora; then
	sudo dnf copr enable -y mczernek/vale
	sudo dnf install -y \
		vale
else
	errro "Distro not supported."
fi
