#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		bluetui
elif on_fedora; then
	# TODO: build from source. its annoying that it is not reliable
	sudo dnf install -y \
		dbus-devel \
		pkgconf-pkg-config

	warn "installing bluetui on fedora seems to crash on first try. just try again."
	cargo install bluetui
fi
