#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/vale"
cp "$RIBYNS_ENV/config/vale/"* "$HOME/.config/vale/"
vale --config "$HOME/.config/vale/vale.ini" sync
