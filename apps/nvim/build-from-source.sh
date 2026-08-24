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

function build_and_install() {
	make CMAKE_BUILD_TYPE=$RIBYN_NVIM_BUILD_TYPE
	sudo make install
}

# TODO: check if I can reuse this structure by passing in
# giturl, is_installed function and build_and_install fn
giturl="https://github.com/neovim/neovim"
check_source_state "neovim" "$RIBYN_NVIM_GITREV"
if [[ "$SOURCE_STATE" == "source n/a" ]]; then
	init_source "$giturl"
	info "[$SOURCE_NAME] installing..."
	(cd "$SOURCE_DEST" && build_and_install)
elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
	if command -v nvim >/dev/null 2>&1; then
		info "$SOURCE_NAME already installed. Skipping."
	else
		# edge case. means its already cloned, but build probably failed
		clean_source
		info "[$SOURCE_NAME] installing..."
		(cd "$SOURCE_DEST" && build_and_install)
	fi
elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
	clean_source
	update_source "$giturl"
	info "[$SOURCE_NAME] updating..."
	(cd "$SOURCE_DEST" && build_and_install)
fi

success "neovim build from source"
