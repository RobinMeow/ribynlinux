#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

if [[ ${RIBYN_GADGET_PACKAGES_ENABLED:-"no"} == "no" ]]; then
	info "gadget packages disabled. skipping."
	exit 0
fi

source "$RIBYN_ROOT/core/run_on_distro.sh"

info "installing gadget packages"

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
