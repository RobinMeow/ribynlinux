#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/hypr/env.sh"
[[ "$RIBYN_HYPR_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing hypr"

source "$RIBYN_ROOT/core/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		hyprland \
		hyprshutdown \
		hyprpaper \
		hyprpolkitagent \
		xdg-desktop-portal-hyprland \
		wireplumber \
		brightnessctl \
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

	# hyprmoncfg only offers yay for arch
	# so even on arch I prefer build from source
	function build_hyprmoncfg() {
		run_on_arch \
			sudo pacman -S --needed --noconfirm \
			go

		run_on_fedora \
			sudo dnf install --assumeyes \
			go

		go build -o "bin/hyprmoncfg" "./cmd/hyprmoncfg"
		go build -o "bin/hyprmoncfgd" "./cmd/hyprmoncfgd"
		install -Dm755 "bin/hyprmoncfg" "$HOME/.local/bin/hyprmoncfg"
		install -Dm755 "bin/hyprmoncfgd" "$HOME/.local/bin/hyprmoncfgd"
	}

	hypr_install "hyprmoncfg" \
		"https://github.com/crmne/hyprmoncfg.git" \
		"$RIBYN_HYPR_HYPRMONCFG_GITREV" \
		'command -v hyprmoncfg >/dev/null 2>&1 && command -v hyprmoncfgd >/dev/null 2>&1' \
		build_hyprmoncfg

	if [[ "$RIBYN_HYPR_HY3_ENABLED" == "yes" ]]; then
		hypr_install "hy3" \
			"https://github.com/outfoxxed/hy3" \
			"$RIBYN_HYPR_HY3_GITREV" \
			'[[ -f "/usr/lib/libhy3.so" ]]'
	fi
elif on_fedora; then
	"$RIBYN_ROOT/lib/hypr/install-hyribyn-fedora.sh"
else
	exit_with_distro_not_supported_msg
fi
