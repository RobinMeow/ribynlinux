#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.cache/ribyn/"
logfile="$HOME/.cache/ribyn/rin.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"

info "Installing from source: $RIBYN_ROOT"
info "Installing essential packages"
"$RIBYN_ROOT/installers/pm-essential-packages.sh"

# WARN: uses brew. and brew resets sudo timestamp.
# means we have to re-prompt our pw. I'd rather do it earlier
# than later so I can afk after.
info "Installing yazi"
"$RIBYN_ROOT/lib/yazi/install.sh"

info "Installing core packages"
"$RIBYN_ROOT/scripts/pm-core.sh"

info "Installing zsh"
"$RIBYN_ROOT/lib/zsh/install.sh"

info "Installing no tofu"
"$RIBYN_ROOT/installers/no_tofu.sh"

info "Installing catppuccin cursors"
"$RIBYN_ROOT/installers/install_catppuccin_cursors.sh"

info "Installing qt6ct"
"$RIBYN_ROOT/lib/qt6ct/install.sh"

info "Installing CommitMono"
"$RIBYN_ROOT/installers/install-commit-mono.sh"

info "Installing brave"
"$RIBYN_ROOT/lib/brave/install.sh"

info "Installing firefox"
"$RIBYN_ROOT/lib/firefox/install.sh"

info "Installing bat"
"$RIBYN_ROOT/lib/bat/install.sh"

info "Installing btop"
"$RIBYN_ROOT/lib/btop/install.sh"

info "Installing kitty"
"$RIBYN_ROOT/lib/kitty/install.sh"

info "Installing wezterm"
"$RIBYN_ROOT/lib/wezterm/install.sh"

info "Installing nvim"
"$RIBYN_ROOT/lib/nvim/install.sh"

info "Installing vale"
"$RIBYN_ROOT/lib/vale/install.sh"

info "Installing tmux"
"$RIBYN_ROOT/lib/tmux/install.sh"

info "Installing wiremix"
"$RIBYN_ROOT/lib/wiremix/install.sh"

info "Installing mpd"
"$RIBYN_ROOT/lib/mpd/install.sh"

info "Installing rmpc"
"$RIBYN_ROOT/lib/rmpc/install.sh"

info "Installing zathura"
"$RIBYN_ROOT/lib/zathura/install.sh"

info "Installing bluetui"
"$RIBYN_ROOT/lib/bluetui/install.sh"

info "Installing rofi"
"$RIBYN_ROOT/lib/rofi/install.sh"

info "Installing screenshot tools"
"$RIBYN_ROOT/lib/wayland/install-screenshot-tools.sh"

info "Installing wl-freeze"
"$RIBYN_ROOT/lib/wl-freeze/install.sh"

info "Installing waybar"
"$RIBYN_ROOT/lib/waybar/install.sh"

info "Installing wayscriber"
"$RIBYN_ROOT/lib/wayscriber/install.sh"

info "Installing dunst"
"$RIBYN_ROOT/lib/dunst/install.sh"

info "Installing mpvpaper"
"$RIBYN_ROOT/lib/mpvpaper/install.sh"

info "Installing wob"
"$RIBYN_ROOT/lib/wob/install.sh"

info "Installing i3"
"$RIBYN_ROOT/lib/i3/install.sh"

info "Installing hypr"
"$RIBYN_ROOT/lib/hypr/install.sh"

info "Installing kde"
"$RIBYN_ROOT/lib/kde/install.sh"

info "Installing xdg-desktop-portal-termfilechooser"
"$RIBYN_ROOT/lib/xdg-desktop-portal-termfilechooser/build-from-source.sh"

info "Syncing desktop files"
"$RIBYN_ROOT/desktop-files/install.sh"

for arg in "$@"; do
	# TODO: move these out into config.sh
	if [[ "$arg" == "--gadgets" ]]; then
		info "Installing gadgets"
		"$RIBYN_ROOT/scripts/pm-gadgets.sh"
	fi
done

success "ribynliniux installed"
