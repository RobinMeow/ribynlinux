#!/usr/bin/env bash
set -euo pipefail

# install hyprland when running hypr/install.sh and all of its coupled apps:
# hyprlock, hyprpicker, hyprmoncfg
export RIBYN_HYPR_ENABLED=${RIBYN_HYPR_ENABLED:-"yes"}

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
