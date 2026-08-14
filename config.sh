#!/bin/bash
set -euo pipefail

# these config values are my personal perference and can
# deviate from the default values used within the scripts
#
# if you want to override values locally (per machine) use your zshrc local
# located in ~/.config/ribyn/zsh/local.sh

# NEOVIM
{
	# anything you can call git checkout on.
	# usually 'master' branch or 'stable' tag
	export RIBYN_NVIM_GIT_REF=${RIBYN_NVIM_GIT_REF:-"stable"}

	# whether or not to fetch the latest commits before checking out the BUILD_REF
	export RIBYN_NVIM_GIT_FETCH=${RIBYN_NVIM_GIT_FETCH:-"no"}
}

# GODOT
{
	# where to clone, compile and build the engine
	export RIBYN_GODOT_ROOT="${RIBYN_GODOT_ROOT:-"$HOME/godot"}"

	# Only tags are supported, do not use branches or commit hashes
	export RIBYN_GODOT_GIT_TAG="${RIBYN_GODOT_GIT_TAG:-"4.7.1-stable"}" # release was 2026/07/13

	# the latest major version godot supports (minor and patches do not matter usually)
	# https://dotnet.microsoft.com/en-us/download/dotnet
	export RIBYN_GODOT_DOTNET_VERSION="${RIBYN_GODOT_DOTNET_VERSION:-"8.0.423"}" # as of 2026/07/21

	# syncing godot editr settings (I assume, that the locals ones are more up2date, so I would lose em if I overwrite them)
	export RIBYN_GODOT_SYNC_ENABLED="${RIBYN_GODOT_SYNC_ENABLED:-"no"}"

	# disable if compile fails with messages to open a ticket for llvm
	# yes/no
	export RIBYN_GODOT_USE_LLVM="${RIBYN_GODOT_USE_LLVM:-"yes"}"
}

# WOB (progress bar for wayland)
{
	export RIBYN_WOB_AUTO_UPDATE=${RIBYN_WOB_AUTO_UPDATE:-"yes"}
}

# CATPPUCCIN CURSOR
{
	# https://github.com/catppuccin/cursors (see picture here for available themes and variants)

	# the latte theme is the only cursor with a white border, which is a great contrast
	# to the rest of my dark-themed system. I prefer a cursor which is always easy to find.
	export RIBYN_CATPPUCCIN_CURSOR_THEME=${RIBYN_CATPPUCCIN_CURSOR_THEME:-"latte"}

	# Variant is the color, but they use their own names, so you'd have to look em up.
	export RIBYN_CATPPUCCIN_CURSOR_VARIANT=${RIBYN_CATPPUCCIN_CURSOR_VARIANT:-"mauve"}
}

# XCURSOR
{
	# the directory name of the cursor theme located in "$HOME/.icons"
	export XCURSOR_THEME=${XCURSOR_THEME:-"catppuccin-latte-mauve-cursors"}
	# WARN: do not mistake with hyprland cursor themes. xcursor and hyprcursor
	# are both set in hyprland.lua to make sure hyprland knows about those env vars
}

# KITTY
{
	# whether or not to use a dark gray solid background instead
	# of a transparent background
	export RIBYN_KITTY_USE_SOLID_BG=${RIBYN_KITTY_USE_SOLID_BG:-"no"}
}

# WEZTERM
{
	# yes/no (yes will clean everything. mostly relevant for the motions)
	export RIBYN_WEZTERM_CLEAN_ON_SYNC=${RIBYN_WEZTERM_CLEAN_ON_SYNC:-"no"}

	# set to "no" if you test in docker, which doesnt have /mnt/c/Users
	# mounted causing detect_win_user to fail. so wezterm cant sync the config.
	# when skipped, will normally sync to linux home
	export RIBYN_SKIP_DETECT_SLOP_USER=${RIBYN_SKIP_DETECT_SLOP_USER:-"no"}
}

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
