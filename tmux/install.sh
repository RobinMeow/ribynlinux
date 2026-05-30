#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm tmux
run_on_fedora sudo dnf install -y tmux

# TMUX Plugins
TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
mkdir -p "$TMUX_PLUGIN_DIR"

# ["<destination-dir>"]="<git url>"
declare -A plugins=(
	["catppuccin"]="https://github.com/catppuccin/tmux"
	["tmux-cpu"]="https://github.com/tmux-plugins/tmux-cpu"
	["tmux-battery"]="https://github.com/tmux-plugins/tmux-battery"
	["tmux-yank"]="https://github.com/tmux-plugins/tmux-yank"
)

for plugin in "${!plugins[@]}"; do
	url="${plugins[$plugin]}"
	dest="$TMUX_PLUGIN_DIR/$plugin"

	if [[ ! -d "$dest" ]]; then
		git clone --depth 1 "$url" "$dest"
	fi
done

"$RIBYNS_ENV/tmux/sync.sh"
