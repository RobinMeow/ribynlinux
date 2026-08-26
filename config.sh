#!/bin/bash
set -euo pipefail

# TODO: move config values to their respective file

# RMPC
{
	# Fedora only. arch uses pacman
	# possible values:
	# "install" will use cargo to build from source
	# "binstall" will install the binaries only
	# binstall is recommended to avoid segmentation errors
	# or to reduce total disc size. use build from source for slow internet
	# (unless your cpu is also slow, then it doesnt not matter)
	export RIBYN_RMPC_INSTALL_METHOD=${RIBYN_NVIM_GITREV:-"binstall"}
}

# SPACESHIP
# {
# 	export RIBYN_SPACESHIP_GITREV=${RIBYN_SPACESHIP_GITREV:-"v4.22.5"}
# }

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
	# TODO:remove install short name
	export RIBYN_HYPR_INSTALL_ENABLED=${RIBYN_HYPR_INSTALL_ENABLED:-"yes"}

	# NOTE: the following env variables have no effect if INSTALL_ENABLED is set to "no"
	# assign git commits and/or tags to build from source from for reach app
	# git repos are in "$HOME/.local/share/ribyn/hypr/<appname>"

	# * 2db328f (HEAD -> main, tag: v0.14.1, origin/main, origin/HEAD) VERSION: bump to 0.14.1 Vaxry (2 days ago)
	export RIBYN_HYPR_HYPRUTILS_GITREV=${RIBYN_HYPR_HYPRUTILS_GITREV:-"v0.14.1"}

	# * 62e62c1 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * b863271 (tag: v0.4.6) version: bump to 0.4.6 Vaxry (4 months ago)
	export RIBYN_HYPR_HYPRWAYLAND_SCANNER_GITREV=${RIBYN_HYPR_HYPRWAYLAND_SCANNER_GITREV:-"v0.4.6"}

	# * f3d1804 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * a79fb21 (tag: v0.14.0) version: bump to 0.14.0 Vaxry (3 weeks ago)
	export RIBYN_HYPR_AQUAMARINE_GITREV=${RIBYN_HYPR_AQUAMARINE_GITREV:-"v0.14.0"}

	# * 9508458 (HEAD -> main, origin/main, origin/HEAD) nix: gcc 15 -> 16 Mihai Fufezan (4 days ago)
	# * 3a1c1b2 (tag: v0.6.8) version: bump to 0.6.8 Vaxry (7 months ago)
	export RIBYN_HYPR_HYPRLANG_GITREV=${RIBYN_HYPR_HYPRLANG_GITREV:-"v0.6.8"}

	export RIBYN_HYPR_HYPRCURSOR_GITREV=${RIBYN_HYPR_HYPRCURSOR_GITREV:-"v0.1.13"}

	# * 7c895c4 (HEAD -> main, origin/main, origin/HEAD) flake.lock: update Mihai Fufezan (4 days ago)
	# * 482d4b7 (tag: v0.5.1) version: bump to 0.5.1 Vaxry (4 months ago)
	export RIBYN_HYPR_HYPRGRAPHICS_GITREV=${RIBYN_HYPR_HYPRGRAPHICS_GITREV:-"v0.5.1"}

	# * 6d43ce84 (HEAD -> main, origin/main, origin/HEAD) input/seat: check HID caps directly for focus enters (#15841) GitHub (3 days ago)
	# * 36b2e0cf (tag: v0.56.0) version: bump to 0.56.0 Vaxry (4 weeks ago)
	export RIBYN_HYPR_HYPRLAND_GITREV=${RIBYN_HYPR_HYPRLAND_GITREV:-"v0.56.0"}

	export RIBYN_HYPR_HYPRWIRE_GITREV=${RIBYN_HYPR_HYPRWIRE_GITREV:-"v0.3.1"} # 4 months ago
	export RIBYN_HYPR_HYPRLAND_GUIUTILS_GITREV=${RIBYN_HYPR_HYPRLAND_GUIUTILS_GITREV:-"v0.2.2"}

	# one commit after v0.7.0 they swapped to camke, so I can reuse my build script :)
	export RIBYN_HYPR_HYPRLAND_PROTOCOLS_GITREV=${RIBYN_HYPR_HYPRLAND_PROTOCOLS_GITREV:-"3f3860b869014c00e8b9e0528c7b4ddc335c21ab"}
	export RIBYN_HYPR_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV=${RIBYN_HYPR_XDG_DESKTOP_PORTAL_HYPRLAND_GITREV:-"v1.4.1"}

	# these are additional apps to hypr, based on hypr. but hypr does not depend on them itself
	export RIBYN_HYPR_HYPRTOOLKIT_GITREV=${RIBYN_HYPR_HYPRTOOLKIT_GITREV:-"v0.5.4"}
	export RIBYN_HYPR_HYPRPOLKITAGENT_GITREV=${RIBYN_HYPR_HYPRPOLKITAGENT_GITREV:-"v0.1.3"}
	export RIBYN_HYPR_HYPRSHUTDOWN_GITREV=${RIBYN_HYPR_HYPRSHUTDOWN_GITREV:-"v0.1.1"}
	export RIBYN_HYPR_HYPRPAPER_GITREV=${RIBYN_HYPR_HYPRPAPER_GITREV:-"v0.8.4"}
	export RIBYN_HYPR_HYPRLOCK_GITREV=${RIBYN_HYPR_HYPRLOCK_GITREV:-"v0.9.6"}
	export RIBYN_HYPR_HYPRPICKER_GITREV=${RIBYN_HYPR_HYPRPICKER_GITREV:-"v0.4.7"}
	export RIBYN_HYPR_HYPRMONCFG_GITREV=${RIBYN_HYPR_HYPRMONCFG_GITREV:-"v1.13.0"}
}

# MPVPAPER
{
	export RIBYN_MPVPAPER_GITREV=${RIBYN_MPVPAPER_GITREV:-"origin/master"}
}

# i3
{
	export RIBYN_I3_ENABLED=${RIBYN_I3_ENABLED:-"no"}
}

# KITTY
{
	# whether or not to use a dark gray solid background instead
	# of a transparent background
	export RIBYN_KITTY_USE_SOLID_BG=${RIBYN_KITTY_USE_SOLID_BG:-"no"}
}

# BLUETUI
{
	export RIBYN_HYPR_BLUETUI_GITREV=${RIBYN_HYPR_BLUETUI_GITREV:-"v0.8.1"}
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
