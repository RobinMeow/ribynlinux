#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

# essential packages are required by many shell scripts
# (like git or rsync) which do not install them themselves

info "Installing essential packages..."

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		base-devel \
		git \
		curl \
		rsync \
		fzf \
		fd \
		cargo
elif on_fedora; then
	sudo dnf install -y \
		@development-tools \
		git \
		curl \
		rsync \
		fzf \
		fd-find \
		cargo
else
	error "distro not supported"
	exit 1
fi

"$RIBYN_ROOT/apps/cargo-bins/sync.sh"
"$RIBYN_ROOT/apps/cargo-bins/install.sh"

success "essential packages installed"
