#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/lib/firefox/env.sh"
info "installing firefox"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		firefox
elif on_fedora; then
	sudo dnf install -y \
		firefox
else
	error "distro not supported."
	exit 1
fi

if [[ "$RIBYN_FIREFOX_SET_DEFAULT_BROWSER" == "yes" ]]; then
	default_browser=$(xdg-settings get default-web-browser)
	if [[ "$default_browser" != "org.mozilla.firefox.desktop" ]]; then
		xdg-settings set default-web-browser "org.mozilla.firefox.desktop"
	fi
fi
