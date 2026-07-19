#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm mpd

run_on_fedora "$RIBYN_ROOT/installers/ensure_installed_fedora_rpm.sh"
run_on_fedora sudo dnf install -y mpd

"$RIBYN_ROOT/apps/mpd/sync.sh"
