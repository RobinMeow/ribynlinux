#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

info "Installing gadget packages..."

run_on_arch sudo pacman -S --needed --noconfirm \
	cmatrix \
	cowsay \
	fortune-mod \
	sl \
	lolcat \
	figlet \
	toilet

run_on_fedora sudo dnf install -y \
	cmatrix \
	cowsay \
	fortune-mod \
	sl \
	lolcat \
	figlet \
	toilet

success "Gadget packages installed"
