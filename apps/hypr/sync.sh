#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/hypr"
cp -r "$RIBYNS_ENV/apps/hypr/config/"* "$HOME/.config/hypr/"
