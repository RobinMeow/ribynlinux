#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing bluetui"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		bluez \
		bluetui
elif on_fedora; then
	sudo dnf install -y \
		cargo \
		bluez \
		dbus-devel \
		pkgconf-pkg-config

	# bluez is not a build dependency
	# its the backend used to power bluetooth in general
	# bluetui is just a UI client, so I don't need to remember
	# cli commands I'd have to lookup once or twice per year

	cargo install bluetui \
		--config 'profile.release.lto="thin"'

	# WARN: lto = fat consistently fails
	# (which is the default, in bluetui's release configuration)
	# it fails on first try, succeeds on the 2nd. also consitently.
	# tho, shucks for my automation-CI-like scripts

	# warn "installing bluetui on fedora seems to crash on first try. just try again."
	# cargo install bluetui
	# build from source has the same issue
	# mkdir -p "$HOME/.local/share/ribyn/hypr/"
	# (
	# 	dest="$HOME/.local/share/ribyn/hypr/bluetui"
	# 	if [[ -d "$dest" ]]; then
	# 		info "bluetui already installed. skipping."
	# 	else
	# 		git clone "https://github.com/pythops/bluetui.git" "$dest"
	# 		cd "$dest"
	# 		git checkout $RIBYN_HYPR_BLUETUI_GIT_REF
	# 		cargo build --release
	# 	fi
	# )
fi
