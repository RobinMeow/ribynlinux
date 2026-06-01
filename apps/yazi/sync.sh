#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/yazi"
cp -r "$RIBYNS_ENV/apps/yazi/config/"* "$HOME/.config/yazi/"
