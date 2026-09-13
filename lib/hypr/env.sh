#!/usr/bin/env bash
set -euo pipefail

# install hyprland when running hypr/install.sh and all of its coupled apps:
# hyprlock, hyprpicker, hyprmoncfg
export RIBYN_HYPR_ENABLED=${RIBYN_HYPR_ENABLED:-"yes"}

# export RIBYN_HYRIBYN_GITREV=${RIBYN_HYRIBYN_GITREV:-"hl0.56.0"}
export RIBYN_HYRIBYN_GITREV=${RIBYN_HYRIBYN_GITREV:-"origin/dev"}

# disabled, and not recommended to use, until hyprland fixes the issue
# of plugins not loading at bootstrap time, without reload.
# this particular plugin causes 3 reloads. all 3 should not be
# required. i do not know which reload is caused by the plugin
# or the plugin system.
export RIBYN_HYPR_HY3_ENABLED=${RIBYN_HYPR_HY3_ENABLED:-"no"}

# uses hyprpaper by default. set 1440p or 1080p to use mpvpaper default
# set to 'default' to use hyprpaper again.
export RIBYN_HYPR_MPVPAPER_RESOLUTION=${RIBYN_HYPR_MPVPAPER_RESOLUTION:-"default"}
