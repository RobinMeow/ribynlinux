#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/btop"
cp -r "$RIBYN_ROOT/apps/btop/config/"* "$HOME/.config/btop/"
