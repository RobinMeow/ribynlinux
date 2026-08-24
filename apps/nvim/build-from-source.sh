#!/bin/bash
set -euo pipefail

source "$RIBYN_ROOT/apps/nvim/config.sh"
source "$RIBYN_ROOT/lib/utils.sh"

# NOTE: use this before building,
# if I have issue and git clean -fdx is not enough
# sudo make clean distclean

if on_arch; then
	sudo pacman -S --noconfirm --needed \
		base-devel \
		cmake \
		unzip \
		ninja \
		curl
elif on_fedora; then
	sudo dnf --assumeyes install \
		ninja-build \
		cmake \
		gcc \
		make \
		unzip \
		gettext \
		curl
fi

function neovim_build_and_install() {
	make CMAKE_BUILD_TYPE="$RIBYN_NVIM_BUILD_TYPE"
	sudo make install
}
function neovim_installed() {
	command -v nvim >/dev/null 2>&1
}
source "$RIBYN_ROOT/lib/source-manager.sh"
check_source_state "neovim" "$RIBYN_NVIM_GITREV"
source_git "https://github.com/neovim/neovim"

success "neovim build from source"
