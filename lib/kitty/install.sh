#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "Installing kitty"

run_on_arch sudo pacman -S --needed --noconfirm \
	kitty

run_on_fedora sudo dnf install -y \
	kitty
