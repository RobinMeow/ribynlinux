#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm vale

run_on_fedora sudo dnf copr enable -y mczernek/vale
run_on_fedora sudo dnf install -y vale

"$RIBYN_ROOT/apps/vale/sync.sh"
