#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing rofi"

run_on_arch sudo pacman -S --needed --noconfirm \
	rofi

run_on_fedora sudo dnf install -y \
	rofi
