#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm bat

run_on_fedora sudo dnf install -y bat

"$RIBYN_ROOT/apps/bat/sync.sh"
