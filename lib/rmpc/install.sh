#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/rmpc/env.sh"
[[ "$RIBYN_RMPC_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "installing rmpc"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		rmpc \
		mpd \
		extra/timidity++
elif on_fedora; then
	sudo dnf install -y \
		mpd \
		cargo

	# NOTE:consider trying to lower lto to make install more
	# likely to succeed
	# --config 'profile.release.lto="thin"'

	if [[ "$RIBYN_RMPC_INSTALL_METHOD" == "install" ]]; then
		sudo dnf install -y \
			timidity++

		# https://rmpc.mierak.dev/installation/#using-cargo
		cargo install --locked \
			rmpc
	else
		cargobin rmpc
	fi
fi
