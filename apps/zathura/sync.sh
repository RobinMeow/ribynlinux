#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/zathura"
cp -r "$RIBYNS_ENV/apps/zathura/config/"* "$HOME/.config/zathura/"
