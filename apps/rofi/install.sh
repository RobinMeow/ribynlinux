#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm rofi
run_on_fedora sudo dnf install -y rofi

"$RIBYN_ROOT/apps/rofi/install.sh"
