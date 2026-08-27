#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

info "installing essential packages"

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
		gawk
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
		gawk

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
