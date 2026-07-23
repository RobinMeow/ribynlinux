#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$RIBYN_ROOT/.backup/godot"
echo "Backing up old godot files in $RIBYN_ROOT/.backup/godot"
cp "$HOME/.config/godot/editor_settings-4.7.tres" "$RIBYN_ROOT/.backup/godot"

cp "$RIBYN_ROOT/apps/godot/config/editor_settings-4.7.tres" "$HOME/.config/godot/editor_settings-4.7.tres"
cp "$RIBYN_ROOT/apps/godot/config/editor_layouts.cfg" "$HOME/.config/godot/editor_layouts.cfg"
