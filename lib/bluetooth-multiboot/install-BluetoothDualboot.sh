#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing bt-dualboot"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		python \
		chntpw
elif on_fedora; then
	sudo dnf install --assumeyes \
		python3 \
		python3-pip \
		chntpw
else
	error "distro not supported."
	exit 1
fi

# NOTE: sudo - application requires read-only access to bluetooth
# devices configuration files which is inaccessible for regular user.
sudo pip install "git+https://github.com/Valllent/BluetoothDualBoot.git"

# WARN: sudo pip install bt-dualboot
# would install https://github.com/x2es/bt-dualboot
# which has issue
# INFO: sudo pip uninstall bt-dualboot
# to remove it again

info "run $RIBYN_ROOT/lib/bt-dualboot/sync.sh to sync windows paired devices to this linux instance."
