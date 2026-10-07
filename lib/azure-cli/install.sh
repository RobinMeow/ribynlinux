#!/usr/bin/env bash
set -euo pipefail

if command -v az >/dev/null 2>&1; then
	# already installed
	exit 0
fi

source "$RIBYN_ROOT/core/utils.sh"
info "installing azure cli"

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	error "arch azcli not supported"
	exit 1
	# sudo pacman -S --needed --noconfirm \
	# 	bluez \
	# 	bluetui
elif on_fedora; then
	sudo dnf install --assumeyes \
		azure-cli

	az extension add --name azure-devops
fi
