#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

source "$RIBYN_ROOT/lib/run_on_distro.sh"

RIBYN_ROOT_LOG_INFO=true info "Installing gadget packages..."

run_on_arch <<'EOF'
	sudo pacman -S --needed --noconfirm \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

run_on_fedora <<'EOF'
	sudo dnf install -y \
		cmatrix \
		cowsay \
		fortune-mod \
		sl \
		lolcat \
		figlet \
		toilet
EOF

RIBYN_ROOT_LOG_INFO=true success "Gadget packages installed"
