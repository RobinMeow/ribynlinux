#!/usr/bin/env bash
set -euo pipefail

export RIBYN_MPVPAPER_ENABLED=${RIBYN_MPVPAPER_ENABLED:-"yes"}

# WARN: does not use the v prefix as the others
export RIBYN_MPVPAPER_GITREV=${RIBYN_MPVPAPER_GITREV:-"1.9"}
