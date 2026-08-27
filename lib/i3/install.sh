#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/i3/env.sh"
if [[ $RIBYN_I3_ENABLED == "no" ]]; then
	exit 0
fi

source "$RIBYN_ROOT/core/utils.sh"
info "installing i3"

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	error "i3 not setup for arch."
	exit 1
elif on_fedora; then
	sudo dnf install --assumeyes \
		i3
fi
