#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "installing no tofu"

source "$RIBYN_ROOT/core/run_on_distro.sh"

mkdir -p "$HOME/.local/share/ribyn/no-tofu"

run_on_arch sudo pacman -S --needed --noconfirm \
	noto-fonts \
	noto-fonts-{cjk,emoji,extra}

run_on_fedora sudo dnf install -y \
	google-noto-fonts-*

# rebuild font cache
sudo fc-cache
