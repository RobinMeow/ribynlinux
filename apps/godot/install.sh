#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/config.sh"

git_clone_exit=0
("$RIBYN_ROOT/apps/godot/git_clone.sh") || git_clone_exit=$?

if [[ "$git_clone_exit" -eq 2 ]]; then
	info "[Godot] Git clone/checkout was skipped (exit 2). Skipping install."
	exit 0
fi

"$RIBYN_ROOT/apps/godot/build_from_source.sh"

if [[ "$RIBYN_GODOT_SYNC_ENABLED" == "yes" ]]; then
	info "[Godot] syncing editor preferences"
	"$RIBYN_ROOT/apps/godot/sync.sh"
else
	warn "[Godot] skipped sync"
fi
