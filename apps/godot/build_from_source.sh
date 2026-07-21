#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

# GODOT_ROOT="$HOME/godot"
# TODO: git clone etc..

info "[Godot] compile editor"
"$RIBYN_ROOT/apps/godot/compile_editor.sh"

info "[Godot] generating glue"
"$RIBYN_ROOT/apps/godot/gen_mono_glue.sh"

info "[Godot] build managed libaries"
"$RIBYN_ROOT/apps/godot/build_managed_libs.sh"
