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

	# neovim build: https://github.com/neovim/neovim/blob/master/BUILD.md
	# sorted by slowest runtime to fastest, and fastest build time to slowest (runtime optimizations take longer)
	# Debug: Full debug information; few optimizations. Use this for development to get meaningful output from debuggers like GDB or LLDB. This is the default if CMAKE_BUILD_TYPE is not specified.
	# RelWithDebverbose: <release with debug verbose> didnt see a description in the github
	# RelWithDebInfo: meaning "Release With Debug Info" Enables many optimizations and adds enough debug info so that when Neovim ever crashes, you can still get a backtrace.
	# Release: Full compiler optimizations and no debug information. Expect the best performance from this build type. Often used by package maintainers.
	export RIBYN_NVIM_BUILD_TYPE=${RIBYN_NVIM_BUILD_TYPE:-"Release"}

	# not support by my build from source script. probably a small change
	# `-Doptimize=ReleaseFast` (Zig). is this only for webassembly?
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

# HYPRLAND
{
	# install hyprland when running hypr/install.sh and all of its coupled apps:
	# hyprlock, hyprpicker, hyprmoncfg
	export RIBYN_HYPR_INSTALL_ENABLED=${RIBYN_HYPR_INSTALL_ENABLED:-"yes"}

	# NOTE: the following env variables have no effect if INSTALL_ENABLED is set to "no"
	# assign git commits and/or tags to build from source from for reach app
	# git repos are in "$HOME/.local/share/ribyn/hypr/<appname>"

	# * 2db328f (HEAD -> main, tag: v0.14.1, origin/main, origin/HEAD) VERSION: bump to 0.14.1 Vaxry (2 days ago)
	export RIBYN_HYPR_HYPRUTILS_GIT_REF=${RIBYN_HYPR_HYPRUTILS_GIT_REF:-"v0.14.1"}

	# * 62e62c1 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * b863271 (tag: v0.4.6) version: bump to 0.4.6 Vaxry (4 months ago)
	export RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF=${RIBYN_HYPR_HYPRWAYLAND_SCANNER_GIT_REF:-"v0.4.6"}

	# * f3d1804 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * a79fb21 (tag: v0.14.0) version: bump to 0.14.0 Vaxry (3 weeks ago)
	export RIBYN_HYPR_AQUAMARINE_GIT_REF=${RIBYN_HYPR_AQUAMARINE_GIT_REF:-"v0.14.0"}

	# * 9508458 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * 3a1c1b2 (tag: v0.6.8) version: bump to 0.6.8 Vaxry (7 months ago)
	export RIBYN_HYPR_HYPRLANG_GIT_REF=${RIBYN_HYPR_HYPRLANG_GIT_REF:-"v0.6.8"}

	# * 7c895c4 (HEAD -> main, origin/main, origin/HEAD) flake.lock: update Mihai Fufezan (4 days ago)
	# * 482d4b7 (tag: v0.5.1) version: bump to 0.5.1 Vaxry (4 months ago)
	export RIBYN_HYPR_HYPRGRAPHICS_GIT_REF=${RIBYN_HYPR_HYPRGRAPHICS_GIT_REF:-"v0.5.1"}

	# * 6d43ce84 (HEAD -> main, origin/main, origin/HEAD) input/seat: check HID caps directly for focus enters (#15841) GitHub (3 days ago)
	# * 36b2e0cf (tag: v0.56.0) version: bump to 0.56.0 Vaxry (4 weeks ago)
	export RIBYN_HYPR_HYPRLAND_GIT_REF=${RIBYN_HYPR_HYPRLAND_GIT_REF:-"v0.56.0"}

	export RIBYN_HYPR_HYPRWIRE_GIT_REF=${RIBYN_HYPR_HYPRWIRE_GIT_REF:-"v0.3.1"} # 4 months ago

	export RIBYN_HYPR_HYPRSHUTDOWN_GIT_REF=${RIBYN_HYPR_HYPRSHUTDOWN_GIT_REF:-"v0.1.1"}

	export RIBYN_HYPR_HYPRTOOLKIT_GIT_REF=${RIBYN_HYPR_HYPRTOOLKIT_GIT_REF:-"v0.5.4"}
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

# KDE
{
	# whether or not to install the KDE desktop environment
	# and sync default config (e.g. disabled kwallet)
	export RIBYN_INSTALL_KDE_ENABLED=${RIBYN_INSTALL_KDE_ENABLED:-"no"}
	export RIBYN_SYNC_KDE_ENABLED=${RIBYN_SYNC_KDE_ENABLED:-"no"}
}

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
