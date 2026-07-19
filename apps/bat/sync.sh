#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/bat"
cp -r "$RIBYN_ROOT/apps/bat/config/"* "$HOME/.config/bat/"
