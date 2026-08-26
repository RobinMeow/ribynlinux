#!/usr/bin/env bash
set -euo pipefail

# https://github.com/Zerodya/wl-freeze

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		jq \
		psmisc \
		xdotool \
		libnotify
elif on_fedora; then
	sudo dnf install --assumeyes \
		jq \
		psmisc \
		xdotool \
		libnotify
fi

source "$RIBYN_ROOT/core/source-manager.sh"
export RIBYN_WL_FREEZE_GITREV=${RIBYN_WL_FREEZE_GITREV:-"v2.1.0"}

function build_and_install() {
	# make wl-freeze available in the cli as wl-freeze
	# if .local/bin is in your PATH
	mkdir -p "$HOME/.local/bin/"
	dest_bin="$HOME/.local/bin/wl-freeze"
	if [[ -f "$dest_bin" ]]; then
		info "wl-freeze: symlink for PATH already exist. skipping."
	else
		ln -s "$(pwd)/wl-freeze" "$dest_bin"
	fi

	dest_comp="/usr/share/zsh/site-functions/"
	if [[ -f "$dest_comp/_wl-freeze" ]]; then
		info "wl-freeze: symlink for autocompletions already exist. skipping."
	else
		sudo ln -s "$(pwd)/completions/zsh/_wl-freeze" "$dest_comp/_wl-freeze"
	fi
}

giturl="https://github.com/Zerodya/wl-freeze"
check_source_state "wl-freeze" "$RIBYN_WL_FREEZE_GITREV"
if [[ "$SOURCE_STATE" == "source n/a" ]]; then
	init_source "$giturl"
	info "[$SOURCE_NAME] installing..."
	(cd "$SOURCE_DEST" && build_and_install)
elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
	if command -v wl-freeze >/dev/null 2>&1; then
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
