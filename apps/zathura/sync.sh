#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/zathura"
cp -r "$RIBYN_ROOT/apps/zathura/config/"* "$HOME/.config/zathura/"
