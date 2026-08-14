#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

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
