#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/waybar"
cp -r "$RIBYN_ROOT/apps/config/waybar/"* "$HOME/.config/waybar/"
