#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

GODOT_ROOT="$HOME/godot"

"$GODOT_ROOT/modules/mono/build_scripts/build_assemblies.py" --godot-output-dir=./bin
