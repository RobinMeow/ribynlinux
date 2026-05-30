#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm waybar
run_on_fedora sudo dnf install -y waybar

"$RIBYNS_ENV/waybar/sync.sh"
