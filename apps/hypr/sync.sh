#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/hypr"
cp -r "$RIBYN_ROOT/apps/hypr/config/"* "$HOME/.config/hypr/"
