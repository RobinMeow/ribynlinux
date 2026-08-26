#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "Installing qt6ct"

run_on_arch sudo pacman -S --needed --noconfirm \
	qt6ct

run_on_fedora sudo dnf install -y \
	qt6ct
