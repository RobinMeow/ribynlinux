#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/btop"
cp -r "$RIBYNS_ENV/btop/config/"* "$HOME/.config/btop/"
