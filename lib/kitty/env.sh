#!/usr/bin/env bash
set -euo pipefail

export RIBYN_KITTY_ENABLED=${RIBYN_KITTY_ENABLED:-"yes"}

# whether or not to use a dark gray solid background instead
# of a transparent background
export RIBYN_KITTY_USE_SOLID_BG=${RIBYN_KITTY_USE_SOLID_BG:-"no"}
