#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	firefox

run_on_fedora sudo dnf install -y \
	firefox
