#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"
source "$RIBYN_ROOT/config.sh"

(
	cd "$RIBYN_GODOT_ROOT"
	"$RIBYN_GODOT_ROOT/modules/mono/build_scripts/build_assemblies.py" --godot-output-dir=./bin
)
