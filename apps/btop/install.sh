#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm btop

run_on_fedora sudo dnf install -y btop

"$RIBYNS_ENV/apps/btop/sync.sh"
