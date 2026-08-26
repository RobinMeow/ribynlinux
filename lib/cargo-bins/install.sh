#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		cargo-binstall
elif on_fedora; then
	if command -v cargo-binstall &>/dev/null || [ -x "/usr/bin/cargo-binstall" ]; then
		info "cargo-binstall already installed. skipping."
		exit 0
	fi

	curl -L --proto '=https' --tlsv1.2 -sSf \
		"https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh" |
		bash
else
	error "distro not supported."
	exit 1
fi
