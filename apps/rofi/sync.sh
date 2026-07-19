#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/rofi"
cp -r "$RIBYN_ROOT/apps/rofi/config/"* "$HOME/.config/rofi/"
