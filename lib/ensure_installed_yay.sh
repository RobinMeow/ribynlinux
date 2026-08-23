#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_fedora; then
	error "yay is not available on fedora."
	exit 1
fi

if command -v yay >/dev/null 2>&1; then
	info "yay is already installed. skipping."
	exit 0
fi

mkdir -p "$HOME/.local/share/ribyn"
dest="$HOME/.local/share/ribyn/yay"
if [ -d "$dest" ]; then
	warn "yay was already cloned. it will be removed and cloned anew."
	rm -rf "$dest"
fi

info "cloning yay"
git clone "https://aur.archlinux.org/yay.git" "$dest"
info "Building and installing yay..."
(cd "$dest" && makepkg -si --noconfirm)
success "yay installed"
