#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/mpv-cut/env.sh"
[[ "$RIBYN_MPVCUT_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing mpv-cut"

source "$RIBYN_ROOT/core/run_on_distro.sh"
if on_arch; then
	sudo pacman -S --needed --noconfirm \
		mpv
elif on_fedora; then
	sudo dnf install --assumeyes \
		mpv
fi

SOURCERER_DEST="$HOME/.config/mpv/scripts" source "$RIBYN_ROOT/core/sourcerer.sh"

function mpv-cut_installed() {
	# no install, its just a git clone and git update
	# im fine with having this auto updated
	return 1
}

function mpv-cut_build_and_install() {
	# its just a git repo. the source code is the
	# full plugin. no build, no installation.
	return 0
}

check_source_state \
	"mpv-cut" \
	"$RIBYN_MPVCUT_GITREV"

source_git "https://github.com/familyfriendlymikey/mpv-cut"
