#!/usr/bin/env bash
set -euo pipefail

# kde config files are usually directly in .config
mkdir -p "$HOME/.config"
cp "$RIBYN_ROOT/apps/kde/kwalletrc" "$HOME/.config/kwalletrc"
cp "$RIBYN_ROOT/apps/kde/kscreenlockerrc" "$HOME/.config/kscreenlockerrc"
