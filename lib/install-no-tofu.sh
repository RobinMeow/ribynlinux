#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Installing no tofu"

source "$RIBYN_ROOT/core/run_on_distro.sh"

mkdir -p "$HOME/.local/share/ribyn/no-tofu"

# TODO: find a better check for whether or not noto sans is installed
first_time_install="$HOME/.local/share/ribyn/no-tofu/first-time-install"
if [[ ! -f "$first_time_install" ]]; then
	touch "$first_time_install"

	run_on_arch sudo pacman -S --needed --noconfirm \
		noto-fonts \
		noto-fonts-{cjk,emoji,extra}

	run_on_fedora sudo dnf install -y \
		google-noto-fonts-*

	# rebuild font cache
	sudo fc-cache -fv
	warn "[no tofu] might requires a reboot to take effect"
else
	info "[no tofu] already installed. skipping."
fi
