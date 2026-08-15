#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/config.sh"

if [[ "$RIBYN_HYPR_INSTALL_ENABLED" == "no" ]]; then
	info "hypr install disabled in config. skipping."
	exit 0
fi

. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
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
# hyprpicker is just nice to have. install standalone cli tool.
elif on_fedora; then
	# NOTE: copr available
	# https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
	"$RIBYN_ROOT/apps/hypr/build-stack-from-source.sh"

	# mako is available in dnf
	# mako \

	run_on_fedora sudo dnf install -y \
		rofi \
		wireplumber \
		brightnessctl \
		grim slurp swappy \
		qt6ct

	"$RIBYN_ROOT/apps/hypr/build-hyprpicker-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprtoolkit-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprshutdown-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprpaper-from-source.sh"
fi

"$RIBYN_ROOT/apps/hypr/build-hyprmoncfg-from-source.sh"
"$RIBYN_ROOT/apps/hypr/build-hyprlock-from-source.sh"
