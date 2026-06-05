#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/utils.sh"
source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm kitty
run_on_fedora sudo dnf install -y kitty

"$RIBYNS_ENV/apps/kitty/sync.sh"
