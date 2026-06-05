#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/kitty"
cp -r "$RIBYNS_ENV/apps/kitty/config/"* "$HOME/.config/kitty/"

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
