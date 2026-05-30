#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/yazi"
cp -r "$RIBYNS_ENV/yazi/config/"* "$HOME/.config/yazi/"
