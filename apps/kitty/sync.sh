#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/kitty"
cp -r "$RIBYN_ROOT/apps/kitty/config/"* "$HOME/.config/kitty/"

. "$RIBYN_ROOT/lib/utils.sh"
warn "Kitty: WSL specific config is disabled."

. "$RIBYN_ROOT/lib/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	cat >>"$HOME/.config/kitty/kitty.conf" <<EOF

# WSL Specific Changes
background_image $HOME/.config/kitty/background.png
background_opacity 0
background_image_layout scaled
# darken the bg
background black
background_tint 0.99

# WARN: comment in to throttle rendering to save a bit of performance
# font_size 11
# repaint_delay 100
# input_delay 5
# sync_to_monitor no
EOF

	info "Kitty: WSL specific config has been appended."
fi
