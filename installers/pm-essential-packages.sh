#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

# essential packages are required by many shell scripts
# (like git or rsync) which do not install them themselves
# unfortunately run_on_distro depends on awk as a transient dependency
# but awk is a nice programm, so its fine.

info "Installing essential packages..."

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		base-devel \
		git \
		curl \
		rsync \
		fzf \
		fd \
		cargo \
		pkgconf \
		awk
elif on_fedora; then
	sudo dnf install -y \
		@development-tools \
		git \
		tar \
		curl \
		rsync \
		fzf \
		fd-find \
		cargo \
		pkgconf-pkg-config \
		awk

	# NOTE essential if you have intel gpu/onboard
	# and want e.g. firefox to use gpu for video decoding
	# libva-intel-media-driver \
else
	error "distro not supported"
	exit 1
fi

"$RIBYN_ROOT/lib/cargo-bins/sync.sh"
"$RIBYN_ROOT/lib/cargo-bins/install.sh"

success "essential packages installed"
