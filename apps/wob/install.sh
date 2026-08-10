#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

# these are for wob volumne.sh
run_on_arch sudo pacman -S --needed --noconfirm \
	awk \
	wireplumber

run_on_fedora sudo dnf install -y \
	awk \
	wireplumber

"$RIBYN_ROOT/apps/wob/build-from-source.sh"
