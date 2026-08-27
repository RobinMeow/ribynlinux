#!/usr/bin/env bash
set -euo pipefail

# https://github.com/catppuccin/cursors (see picture here for available themes and variants)

export RIBYN_CATPPUCCIN_CURSORS_ENABLED=${RIBYN_CATPPUCCIN_CURSORS_ENABLED:-"yes"}

# the latte theme is the only cursor with a white border, which is a great contrast
# to the rest of my dark-themed system. I prefer a cursor which is always easy to find.
export RIBYN_CATPPUCCIN_CURSOR_THEME=${RIBYN_CATPPUCCIN_CURSOR_THEME:-"latte"}

# Variant is the color, but they use their own names, so you'd have to look em up.
export RIBYN_CATPPUCCIN_CURSOR_VARIANT=${RIBYN_CATPPUCCIN_CURSOR_VARIANT:-"mauve"}
