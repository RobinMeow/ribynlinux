#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/yazi"
cp -r "$RIBYN_ROOT/apps/yazi/config/"* "$HOME/.config/yazi/"
