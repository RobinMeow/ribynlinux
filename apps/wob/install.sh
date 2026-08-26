#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	wob

run_on_fedora sudo dnf install -y \
	wob

"$RIBYN_ROOT/apps/wob/install-volume-deps.sh"

# NOTE: replace in favor of binary install
#
# "$RIBYN_ROOT/apps/wob/build-from-source.sh"
