#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm bat

run_on_fedora sudo dnf install -y bat

"$RIBYNS_ENV/apps/bat/sync.sh"
