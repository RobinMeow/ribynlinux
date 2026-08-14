#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		rmpc \
		mpd \
		extra/timidity++
elif on_fedora; then
	sudo dnf install -y \
		mpd \
		timidity++ \
		cargo

	# https://rmpc.mierak.dev/installation/#using-cargo
	cargo install --locked \
		rmpc
fi
