#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm zsh
run_on_fedora sudo dnf install -y zsh

"$RIBYNS_ENV/apps/zsh/install-oh-my-zsh.sh"
"$RIBYNS_ENV/apps/zsh/sync.sh"
