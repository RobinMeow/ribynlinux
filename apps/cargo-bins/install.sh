#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S cargo-binstall
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
