#!/usr/bin/env bash
set -euo pipefail

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$RIBYN_ROOT/kde/kwalletrc" "$HOME/.config/kwalletrc"
cp "$RIBYN_ROOT/kde/kscreenlockerrc" "$HOME/.config/kscreenlockerrc"
