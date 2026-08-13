#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	hyprland \
	hyprshutdown \
	hyprpaper \
	hyprpolkitagent \
	xdg-desktop-portal-hyprland \
	mako \
	rofi \
	wireplumber \
	brightnessctl \
	grim slurp swappy \
	hyprpicker \
	qt6ct
# hyprpolkitagent auth ui (type in password, when I need admin privl. via GUI apps)
# xdg-desktop-portal-hyprland (asks for perm. when an app wants to do outside its own window, for security. e.g. screen sharing via discord)
# mako (lightweight desktop notification daemon, for now)
# (wireplumber) wpctl and brightnessctl are used for keybind for multimedia
# keyboard buttons, like the fn keys on a laptop
# grim slurp swappy: screenshot tools that work good together
# qt5ct qt6ct for dark themed qt apps. also required for live switching themes.
# removed qt5ct. apparently I can only choose one of em
# hyprpicker is just nice to have. install standalone cli tool. TODO: requires build from src on fedora

run_on_fedora error "Hyprland on fedora is not set up" exit 1
# requires
# WARN: outdated
# run_on_fedora sudo dnf copr enable -y solopasha/hyprland
# might not be outdated:
# https://copr.fedorainfracloud.org/coprs/nett00n/hyprland/
# officially recommended:
# https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland

# TODO: set up build from suorce I think :)
# hyprshutdown
# xdg-desktop-portal-hyprland \
# run_on_fedora sudo dnf install -y \
# 	hyprland \
# 	hyprpaper \
# 	hyprpolkitagent \
# 	mako \
# 	rofi \
# 	wireplumber \
# 	brightnessctl \
# 	grim slurp swappy \
# 	qt6ct

"$RIBYN_ROOT/apps/hypr/build_hyprmoncfg_from_source.sh"
"$RIBYN_ROOT/apps/hypr/build_hyprlock_from_source.sh"
"$RIBYN_ROOT/apps/hypr/sync.sh"
