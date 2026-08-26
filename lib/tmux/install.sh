#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "Installing tmux"

run_on_arch sudo pacman -S --needed --noconfirm \
	tmux

run_on_fedora sudo dnf install -y \
	tmux

TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
mkdir -p "$TMUX_PLUGIN_DIR"

if [[ ! -d "$TMUX_PLUGIN_DIR/catppuccin" ]]; then
	git clone --depth 1 "https://github.com/catppuccin/tmux" "$TMUX_PLUGIN_DIR/catppuccin"
fi

if [[ ! -d "$TMUX_PLUGIN_DIR/tmux-cpu" ]]; then
	git clone --depth 1 "https://github.com/tmux-plugins/tmux-cpu" "$TMUX_PLUGIN_DIR/tmux-cpu"
fi

if [[ ! -d "$TMUX_PLUGIN_DIR/tmux-battery" ]]; then
	git clone --depth 1 "https://github.com/tmux-plugins/tmux-battery" "$TMUX_PLUGIN_DIR/tmux-battery"
fi

if [[ ! -d "$TMUX_PLUGIN_DIR/tmux-yank" ]]; then
	git clone --depth 1 "https://github.com/tmux-plugins/tmux-yank" "$TMUX_PLUGIN_DIR/tmux-yank"
fi
