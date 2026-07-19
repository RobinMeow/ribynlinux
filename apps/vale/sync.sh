#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/vale"
cp "$RIBYN_ROOT/apps/vale/config/"* "$HOME/.config/vale/"
vale --config "$HOME/.config/vale/vale.ini" sync
