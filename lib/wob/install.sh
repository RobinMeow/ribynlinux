#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/wob/env.sh"
[[ "$RIBYN_WOB_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing wob"

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		wob
elif on_fedora; then
	sudo dnf install --assumeyes \
		wob
else
	info "distro not supported"
fi

"$RIBYN_ROOT/lib/wob/install-volume-deps.sh"
