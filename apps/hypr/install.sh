#!/usr/bin/env bash
set -euo pipefail

# NOTE: SUPER+Q to launch kitty
# hyprctl dispatch exit to forcefully close all apps and hypr

source "$RIBYNS_ENV/lib/utils.sh"
source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm hyprland hyprshutdown

run_on_fedora error "Hyprland on fedora is not set up" exit 1

"$RIBYNS_ENV/apps/hypr/sync.sh"
