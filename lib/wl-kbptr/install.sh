#!/usr/bin/env bash
set -euo pipefail

# https://github.com/moverest/wl-kbptr

source "$RIBYN_ROOT/lib/wl-kbptr/env.sh"
if [[ "$RIBYN_WL_KBPTR_ENABLED" == "no" ]]; then
	exit 0
fi

source "$RIBYN_ROOT/core/utils.sh"
info "installing wl-kbptr"

source "$RIBYN_ROOT/core/run_on_distro.sh"
if on_arch; then
	"$RIBYN_ROOT/core/ensure-installed-yay.sh"
	yay -S --needed --noconfirm \
		wl-kbptr \
		wlrctl
elif on_fedora; then
	sudo dnf install --assumeyes \
		wl-kbptr \
		wlrctl
fi
