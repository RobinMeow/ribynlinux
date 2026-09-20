#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing virtualization"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		qemu-desktop libvirt virt-manager dnsmasq
elif on_fedora; then
	sudo dnf install --assumeyes \
		@virtualization
else
	error "distro not supported."
	exit 1
fi
