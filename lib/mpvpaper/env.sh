#!/usr/bin/env bash
set -euo pipefail

export RIBYN_MPVPAPER_ENABLED=${RIBYN_MPVPAPER_ENABLED:-"yes"}

# TODO: pick latest tag
export RIBYN_MPVPAPER_GITREV=${RIBYN_MPVPAPER_GITREV:-"origin/master"}
