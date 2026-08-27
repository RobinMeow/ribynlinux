#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/godot/env.sh"
[[ "$RIBYN_GODOT_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "syncing godot"

if [[ "$RIBYN_GODOT_SYNC_ENABLED" == "yes" ]]; then
	info "[Godot] syncing editor preferences"
	mkdir -p "$RIBYN_ROOT/.backup/godot"
	echo "Backing up old godot files in $RIBYN_ROOT/.backup/godot"
	cp "$HOME/.config/godot/editor_settings-4.7.tres" "$RIBYN_ROOT/.backup/godot"

	cp "$RIBYN_ROOT/lib/godot/config/editor_settings-4.7.tres" "$HOME/.config/godot/editor_settings-4.7.tres"
	cp "$RIBYN_ROOT/lib/godot/config/editor_layouts.cfg" "$HOME/.config/godot/editor_layouts.cfg"
else
	warn "[Godot] skipped sync"
fi
