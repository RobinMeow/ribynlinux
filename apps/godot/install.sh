#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/core/utils.sh"

git_clone_exit=0
("$RIBYN_ROOT/apps/godot/git_clone.sh") || git_clone_exit=$?

if [[ "$git_clone_exit" -eq 2 ]]; then
	info "[Godot] Git clone/checkout was skipped (exit 2). Skipping install."
	exit 0
fi

"$RIBYN_ROOT/apps/godot/build-from-source.sh"
