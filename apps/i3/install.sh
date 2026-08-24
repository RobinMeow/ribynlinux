#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

if [[ $RIBYN_I3_ENABLED == "no" ]]; then
	info "i3 disabled. skipping."
	exit 0
fi

if on_arch; then
	error "i3 not setup for arch."
	exit 1
elif on_fedora; then
	sudo dnf install --assumeyes \
		i3
fi
