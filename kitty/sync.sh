#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/kitty"
cp -r "$RIBYNS_ENV/kitty/config/"* "$HOME/.config/kitty/"
