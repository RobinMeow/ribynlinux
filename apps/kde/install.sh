#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"

if [[ "$RIBYN_INSTALL_KDE_ENABLED" == "no" ]]; then
	info "KDE install disabled. skipping."
	exit 0
fi

. "$RIBYN_ROOT/lib/run_on_distro.sh"

# NOTE: not a kde dependecy, but if I do use kde I want flameshot again
# its a nice screenshotting tool. but I have grim/slurp for hypr

run_on_arch sudo pacman -S --needed --noconfirm \
	flameshot

run_on_fedora sudo dnf install -y \
	flameshot
