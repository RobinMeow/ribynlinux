#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		wezterm
elif on_fedora; then
	sudo dnf copr enable -y wezfurlong/wezterm-nightly

	sudo dnf install -y \
		wezterm
fi
