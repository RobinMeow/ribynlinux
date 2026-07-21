#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

info "[Godot] [1/4] checking git repo"
"$RIBYN_ROOT/apps/godot/git_clone.sh"

info "[Godot] [2/4] compile editor"
"$RIBYN_ROOT/apps/godot/compile_editor.sh"

info "[Godot] [3/4] generating glue"
"$RIBYN_ROOT/apps/godot/gen_mono_glue.sh"

info "[Godot] [4/4] build managed libaries"
"$RIBYN_ROOT/apps/godot/build_managed_libs.sh"
