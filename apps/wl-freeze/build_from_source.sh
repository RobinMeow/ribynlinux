#!/usr/bin/env bash
set -euo pipefail

# https://github.com/Zerodya/wl-freeze

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	jq \
	psmisc \
	xdotool \
	libnotify

run_on_fedora sudo dnf install -y \
	jq \
	psmisc \
	xdotool \
	libnotify

mkdir -p "$HOME/.local/share/ribyn/"
dest="$HOME/.local/share/ribyn/wl-freeze"
if [[ -d "$dest" ]]; then
	info "wl-freeze is already installed. Skipping."
else
	(
		git clone --depth 1 "https://github.com/Zerodya/wl-freeze" "$dest"
		cd "$dest"

		# make wl-freeze available in the cli as wl-freeze
		# if .local/bin is in your PATH
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
	)
fi
