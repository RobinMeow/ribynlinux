#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm bluetui

run_on_fedora <<'EOF'
	echo "bluetui on fedora is not yet implemented. requires cargo install or another way"
	# cargo install bluetui
EOF
