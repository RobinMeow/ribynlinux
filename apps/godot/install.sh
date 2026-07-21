#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

warn "[Godot] install not supported. manually clone the repo for the version you desire and call the $RIBYN_ROOT/apps/godot/build-from-source.sh from within the cloned repo"
warn "[Godot] sync skipped. Manually run the sync, when godot is installed."

# "$RIBYN_ROOT/apps/godot/sync.sh"
