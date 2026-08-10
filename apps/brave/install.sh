#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

# arch
run_on_arch "$RIBYN_ROOT/lib/ensure_installed_yay.sh"
run_on_arch yay -Sy --needed --noconfirm \
	brave-bin

# fedora
run_on_fedora sudo dnf install -y \
	dnf-plugins-core

repofile="https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"
run_on_fedora sudo dnf config-manager addrepo --from-repofile="$repofile"

run_on_fedora sudo dnf install -y \
	brave-browser
