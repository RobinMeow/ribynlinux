#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/rsy.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

info "Syncing from source: $RIBYN_ROOT"

info "Syncing gtk"
"$RIBYN_ROOT/apps/gtk/sync.sh"

info "Syncing xdg-desktop-portal"
"$RIBYN_ROOT/apps/xdg-desktop-portal/sync.sh"

info "Syncing qt6ct"
"$RIBYN_ROOT/apps/qt6ct/sync.sh"

info "Syncing zsh"
"$RIBYN_ROOT/apps/zsh/sync.sh"

info "Syncing git"
"$RIBYN_ROOT/apps/git/sync.sh"

info "Syncing bat"
"$RIBYN_ROOT/apps/bat/sync.sh"

"$RIBYN_ROOT/apps/bin/sync.sh"

info "Syncing btop"
"$RIBYN_ROOT/apps/btop/sync.sh"

info "Syncing godot"
"$RIBYN_ROOT/apps/godot/sync.sh"

info "Syncing kitty"
"$RIBYN_ROOT/apps/kitty/sync.sh"

info "Syncing wezterm"
"$RIBYN_ROOT/apps/wezterm/sync.sh"

info "Syncing nvim"
"$RIBYN_ROOT/apps/nvim/sync.sh"

info "Syncing vale"
"$RIBYN_ROOT/apps/vale/sync.sh"

info "Syncing tmux"
"$RIBYN_ROOT/apps/tmux/sync.sh"

info "Syncing yazi"
"$RIBYN_ROOT/apps/yazi/sync.sh"

info "Syncing wiremix"
"$RIBYN_ROOT/apps/wiremix/sync.sh"

info "Syncing mpd"
"$RIBYN_ROOT/apps/mpd/sync.sh"

# TODO: move infos to each script
info "Syncing rmpc"
"$RIBYN_ROOT/apps/rmpc/sync.sh"

info "Syncing zathura"
"$RIBYN_ROOT/apps/zathura/sync.sh"

info "Syncing dunst"
"$RIBYN_ROOT/apps/dunst/sync.sh"

info "Syncing wayscriber"
"$RIBYN_ROOT/apps/wayscriber/sync.sh"

info "Syncing i3"
"$RIBYN_ROOT/apps/i3/sync.sh"

info "Syncing hypr"
"$RIBYN_ROOT/apps/hypr/sync.sh"

info "Syncing rofi"
"$RIBYN_ROOT/apps/rofi/sync.sh"

info "Syncing waybar"
"$RIBYN_ROOT/apps/waybar/sync.sh"

info "Syncing kde"
"$RIBYN_ROOT/apps/kde/sync.sh"

# omitted. its in rin, feels more like an install then syncing dotfiles
# info "Syncing desktop files"

success "ribynlinux synced"
