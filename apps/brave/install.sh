#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

if on_arch; then
	"$RIBYN_ROOT/lib/ensure_installed_yay.sh"

	yay -Sy --needed --noconfirm \
		brave-bin
elif on_fedora; then

	sudo dnf install -y \
		dnf-plugins-core

	if [[ -f /etc/yum.repos.d/brave-browser.repo ]]; then
		info "Brave repo already setup. skipping."
	else
		info "Adding Brave plugins and config-manager repo"
		sudo dnf config-manager addrepo --from-repofile="$repofile"
	fi

	sudo dnf install -y \
		brave-browser
else
	error "Distro not supported."
	exit 1
fi
