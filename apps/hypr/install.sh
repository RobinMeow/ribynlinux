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
		rofi \
		wireplumber \
		brightnessctl \
		grim slurp swappy \
		hyprpicker \
		hyprlock \
		qt6ct
# hyprpolkitagent auth ui (type in password, when I need admin privl. via GUI apps)
# xdg-desktop-portal-hyprland (asks for perm. when an app wants to do outside its own window, for security. e.g. screen sharing via discord)
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

	sudo dnf install -y \
		rofi \
		wireplumber \
		brightnessctl \
		grim slurp swappy \
		qt6ct

	install_dep "hyprshutdown" \
		"https://github.com/hyprwm/hyprshutdown.git" \
		"$RIBYN_HYPR_HYPRSHUTDOWN_GIT_REF"
	# "$RIBYN_ROOT/apps/hypr/build-hyprshutdown-from-source.sh"

	success "hyprshut down installed using the source manager"
	exit 0
	"$RIBYN_ROOT/apps/hypr/build-hyprpaper-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprpicker-from-source.sh"
	"$RIBYN_ROOT/apps/hypr/build-hyprlock-from-source.sh"
fi

# hyprmoncfg only offers yay for arch
"$RIBYN_ROOT/apps/hypr/build-hyprmoncfg-from-source.sh"
