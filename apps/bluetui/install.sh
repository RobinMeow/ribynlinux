#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		bluez \
		bluetui
elif on_fedora; then
	sudo dnf install -y \
		bluez \
		dbus-devel \
		pkgconf-pkg-config

	warn "installing bluetui on fedora seems to crash on first try. just try again."
	mkdir -p "$HOME/.local/share/ribyn/hypr/"
	(
		dest="$HOME/.local/share/ribyn/hypr/bluetui"
		if [[ -d "$dest" ]]; then
			info "bluetui already installed. skipping."
		else
			git clone "https://github.com/pythops/bluetui.git" "$dest"
			cd "$dest"
			git checkout $RIBYN_HYPR_BLUETUI_GIT_REF
			cargo build --release
		fi
	)
fi
