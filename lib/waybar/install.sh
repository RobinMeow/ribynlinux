#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing waybar"

mkdir -p "$HOME/.local/share/ribyn/waybar"
first_time_install="$HOME/.local/share/ribyn/waybar/first_time_install"
if [[ ! -f "$first_time_install" ]]; then
	touch "$first_time_install"

	run_on_arch sudo pacman -S --needed --noconfirm \
		ttf-font-awesome \
		waybar

	run_on_fedora sudo dnf install -y \
		fontawesome-fonts \
		waybar
	# fontawesome4-fonts actually but it matches without the
	# version which I think is preffered

	# rebuild font cache
	sudo fc-cache -fv
	warn "[waybar fa icons] might requires a reboot to take effect"
else
	info "[waybar] already installed. skipping."
fi
