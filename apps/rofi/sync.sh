#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/rofi"
cp -r "$RIBYNS_ENV/apps/rofi/config/"* "$HOME/.config/rofi/"
