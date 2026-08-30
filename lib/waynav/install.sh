#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/lib/waynav/env.sh"
source "$RIBYN_ROOT/core/source-manager.sh"

function build_and_install() {
	if on_arch; then
		sudo pacman -S --needed --noconfirm \
			meson \
			wayland \
			wayland-protocols \
			libxkbcommon \
			cairo
	elif on_fedora; then
		sudo dnf install --assumeyes \
			meson \
			wayland-devel \
			wayland-protocols-devel \
			libxkbcommon-devel \
			cairo-devel
	fi

	(
		cd "$SOURCE_DEST"
		make
		sudo make install
	)
}

export SOURCE_SUBMODULES="no"
giturl="https://github.com/kovetskiy/waynav"
check_source_state "waynav" "$RIBYN_WAYNAV_GITREV"
if [[ "$SOURCE_STATE" == "source n/a" ]]; then
	init_source "$giturl"
	info "[$SOURCE_NAME] installing..."
	build_and_install
elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
	if command -v waynav >/dev/null 2>&1; then
		info "$SOURCE_NAME already installed. Skipping."
	else
		# edge case. means its already cloned, but build probably failed
		clean_source
		info "[$SOURCE_NAME] installing..."
		build_and_install
	fi
elif [[ "$SOURCE_STATE" == "gitrev differs" ]]; then
	clean_source
	update_source "$giturl"
	info "[$SOURCE_NAME] updating..."
	build_and_install
fi
unset SOURCE_SUBMODULES="no"
