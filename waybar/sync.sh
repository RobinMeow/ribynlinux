#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/waybar"
cp -r "$RIBYNS_ENV/config/waybar/"* "$HOME/.config/waybar/"
