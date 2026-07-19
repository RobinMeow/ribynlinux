#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm btop

run_on_fedora sudo dnf install -y btop

"$RIBYN_ROOT/apps/btop/sync.sh"
