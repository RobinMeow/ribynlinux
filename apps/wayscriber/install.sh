#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"

# https://github.com/devmobasa/wayscriber#from-source

if on_arch; then
	"$RIBYN_ROOT/core/ensure_installed_yay.sh"
	yay -S --needed --noconfirm \
		wayscriber-bin

	# # Optional GUI configurator
	# yay -S wayscriber-configurator
elif on_fedora; then
	cat <<'EOF' | sudo tee /etc/yum.repos.d/wayscriber.repo
[wayscriber]
name=Wayscriber Repo
baseurl=https://wayscriber.com/rpm
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://wayscriber.com/rpm/RPM-GPG-KEY-wayscriber.asc
EOF
	sudo dnf clean all
	sudo dnf install wayscriber

	# Optional GUI configurator
	# sudo dnf install wayscriber-configurator
fi
