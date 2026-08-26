#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing brave"

if on_arch; then
	"$RIBYN_ROOT/core/ensure-installed-yay.sh"

	yay -Sy --needed --noconfirm \
		brave-bin
elif on_fedora; then

	sudo dnf install -y \
		dnf-plugins-core

	if [[ -f /etc/yum.repos.d/brave-browser.repo ]]; then
		info "Brave repo already setup. skipping."
	else
		info "Adding Brave plugins and config-manager repo"
		repofile="https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"
		sudo dnf config-manager addrepo --from-repofile="$repofile"
	fi

	sudo dnf install -y \
		brave-browser
else
	error "Distro not supported."
	exit 1
fi
