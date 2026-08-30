#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/lib/dotool/env.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		go \
		libxkbcommon \
		scdoc
elif on_fedora; then
	sudo dnf install --assumeyes \
		go \
		libxkbcommon-devel \
		scdoc
fi

source "$RIBYN_ROOT/core/source-manager.sh"
export RIBYN_DOTOOL_GITREV=${RIBYN_DOTOOL_GITREV:-"v1.6"}
function build_and_install() {
	(
		cd "$SOURCE_DEST" || (error "$SOURCE_DEST not found for cd." && exit 1)
		./build.sh && sudo ./build.sh install # Requires go and scdoc
	)
}

giturl="https://git.sr.ht/~geb/dotool"
check_source_state "dotool" "$RIBYN_DOTOOL_GITREV"
if [[ "$SOURCE_STATE" == "source n/a" ]]; then
	init_source "$giturl"
	info "[$SOURCE_NAME] installing..."
	build_and_install
elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
	# TODO: is dotool a bin once installed?
	if command -v dotool >/dev/null 2>&1; then
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

# TODO:
# Add user to necessary groups
sudo usermod -aG video $USER
sudo usermod -aG input $USER
# Reboot for changes to take effect
