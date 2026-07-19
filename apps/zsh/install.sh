#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm zsh
run_on_fedora sudo dnf install -y zsh

"$RIBYN_ROOT/apps/zsh/install-oh-my-zsh.sh"
"$RIBYN_ROOT/apps/zsh/sync.sh"
