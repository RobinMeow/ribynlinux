#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/rsy.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

info "Syncing from source: $RIBYN_ROOT"

"$RIBYN_ROOT/apps/gtk/sync.sh"
"$RIBYN_ROOT/apps/xdg-desktop-portal/sync.sh"
"$RIBYN_ROOT/apps/qt6ct/sync.sh"
"$RIBYN_ROOT/apps/zsh/sync.sh"
"$RIBYN_ROOT/apps/git/sync.sh"
"$RIBYN_ROOT/apps/bat/sync.sh"
"$RIBYN_ROOT/apps/bin/sync.sh"
"$RIBYN_ROOT/apps/btop/sync.sh"
"$RIBYN_ROOT/apps/godot/sync.sh"
"$RIBYN_ROOT/apps/kitty/sync.sh"
"$RIBYN_ROOT/apps/wezterm/sync.sh"
"$RIBYN_ROOT/apps/nvim/sync.sh"
"$RIBYN_ROOT/apps/vale/sync.sh"
"$RIBYN_ROOT/apps/tmux/sync.sh"
"$RIBYN_ROOT/apps/yazi/sync.sh"
"$RIBYN_ROOT/apps/wiremix/sync.sh"
"$RIBYN_ROOT/apps/mpd/sync.sh"
"$RIBYN_ROOT/apps/rmpc/sync.sh"
"$RIBYN_ROOT/apps/zathura/sync.sh"
"$RIBYN_ROOT/apps/dunst/sync.sh"
"$RIBYN_ROOT/apps/wayscriber/sync.sh"
"$RIBYN_ROOT/apps/i3/sync.sh"
"$RIBYN_ROOT/apps/hypr/sync.sh"
"$RIBYN_ROOT/apps/rofi/sync.sh"
"$RIBYN_ROOT/apps/waybar/sync.sh"
"$RIBYN_ROOT/apps/kde/sync.sh"

# TODO: move desktop files sync to sync from install
# omitted. its in rin, feels more like an install then syncing dotfiles
# info "Syncing desktop files"

success "ribynlinux synced"
