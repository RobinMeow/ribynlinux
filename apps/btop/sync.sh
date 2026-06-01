#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/btop"
cp -r "$RIBYNS_ENV/apps/btop/config/"* "$HOME/.config/btop/"
