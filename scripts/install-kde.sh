#!/usr/bin/env bash
set -euo pipefail

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$RIBYNS_ENV/config/kwalletrc" "$HOME/.config/kwalletrc"
