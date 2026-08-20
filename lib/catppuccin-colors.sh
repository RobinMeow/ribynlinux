#!/usr/bin/env bash
set -euo pipefail

# Catppuccin Mocha 8-bit Color Palette
# https://github.com/catppuccin/catppuccin
# These are approximations of the Catppuccin Mocha theme using 8-bit colors
CATSURFACE0="\033[38;5;235m" # #313244 - Very dark gray (backgrounds)
CATSURFACE1="\033[38;5;239m" # #45475a - Dark gray
CATSURFACE2="\033[38;5;243m" # #585b70 - Medium dark gray
CATOVERLAY0="\033[38;5;246m" # #6c7086 - Medium gray
CATOVERLAY1="\033[38;5;248m" # #7f849c - Light gray
CATOVERLAY2="\033[38;5;250m" # #9399b2 - Lighter gray
CATTEXT="\033[38;5;231m"     # #cdd6f4 - Light text
CATSUBTEXT1="\033[38;5;188m" # #bac2de - Subtext (lighter)
CATSUBTEXT0="\033[38;5;246m" # #a6adc8 - Subtext (darker)
CATRED="\033[38;5;203m"      # #f38ba8 - Red/Error
CATORANGE="\033[38;5;215m"   # #fab387 - Orange/Warning
CATYELLOW="\033[38;5;221m"   # #f9e2af - Yellow
CATGREEN="\033[38;5;114m"    # #a6e3a1 - Green/Success
CATCYAN="\033[38;5;115m"     # #94e2d5 - Cyan
CATBLUE="\033[38;5;109m"     # #89b4fa - Blue/Info
CATMAGENTA="\033[38;5;139m"  # #cba6f7 - Magenta/Verbose
CATLAVENDER="\033[38;5;183m" # #b4befe - Lavender
NC="\033[0m"                 # No Color
