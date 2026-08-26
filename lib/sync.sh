#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/rsy.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

info "Syncing from source: $RIBYN_ROOT"

"$RIBYN_ROOT/lib/gtk/sync.sh"
"$RIBYN_ROOT/lib/xdg-desktop-portal/sync.sh"
"$RIBYN_ROOT/lib/qt6ct/sync.sh"
"$RIBYN_ROOT/lib/zsh/sync.sh"
"$RIBYN_ROOT/lib/git/sync.sh"
"$RIBYN_ROOT/lib/bat/sync.sh"
"$RIBYN_ROOT/lib/bin/sync.sh"
"$RIBYN_ROOT/lib/btop/sync.sh"
"$RIBYN_ROOT/lib/godot/sync.sh"
"$RIBYN_ROOT/lib/kitty/sync.sh"
"$RIBYN_ROOT/lib/wezterm/sync.sh"
"$RIBYN_ROOT/lib/nvim/sync.sh"
"$RIBYN_ROOT/lib/vale/sync.sh"
"$RIBYN_ROOT/lib/tmux/sync.sh"
"$RIBYN_ROOT/lib/yazi/sync.sh"
"$RIBYN_ROOT/lib/wiremix/sync.sh"
"$RIBYN_ROOT/lib/mpd/sync.sh"
"$RIBYN_ROOT/lib/rmpc/sync.sh"
"$RIBYN_ROOT/lib/zathura/sync.sh"
"$RIBYN_ROOT/lib/dunst/sync.sh"
"$RIBYN_ROOT/lib/wayscriber/sync.sh"
"$RIBYN_ROOT/lib/i3/sync.sh"
"$RIBYN_ROOT/lib/hypr/sync.sh"
"$RIBYN_ROOT/lib/rofi/sync.sh"
"$RIBYN_ROOT/lib/waybar/sync.sh"
"$RIBYN_ROOT/lib/kde/sync.sh"
"$RIBYN_ROOT/lib/desktop-files/sync.sh"

success "ribynlinux synced"
