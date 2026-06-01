#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/utils.sh"
source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm kitty
run_on_fedora sudo dnf install -y kitty

"$RIBYNS_ENV/apps/kitty/sync.sh"

# NOTE: wsl is not as fast as native.
# so im using a throttled kitty perf
source "$RIBYNS_ENV/lib/detect_env.sh"
detect_env
if [[ "$OS_TYPE" == "wsl" ]]; then
	cat >>"$HOME/.config/kitty/kitty.conf" <<EOF

# WSL Specific Changes
font_size 11
repaint_delay 100
input_delay 5
sync_to_monitor no
EOF

	info "Kitty: WSL specific config has been appended."
fi
