#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/kde/env.sh"
[[ "$RIBYN_INSTALL_KDE_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing kde"

source "$RIBYN_ROOT/core/run_on_distro.sh"

# NOTE: not a kde dependecy, but if I do use kde I want flameshot again
# its a nice screenshotting tool. but I have grim/slurp for hypr

run_on_arch sudo pacman -S --needed --noconfirm \
	flameshot

run_on_fedora sudo dnf install -y \
	flameshot
