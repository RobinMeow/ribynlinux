#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/bat"
cp -r "$RIBYNS_ENV/apps/bat/config/"* "$HOME/.config/bat/"
