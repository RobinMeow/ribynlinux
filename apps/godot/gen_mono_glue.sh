#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

godot_bin="$HOME/godot/bin/godot.linuxbsd.editor.x86_64.llvm.mono"

if [[ ! -f "$godot_bin" ]]; then
	error "Godot binary not found to generate glue: $godot_bin"
	error "You might simply be on a different architecture, or try to build a different target."
	error "You can manually generate it using: <godotbin> --headless --generate-mono-glue modules/mono/glue"
	exit 1
fi

"$godot_bin" --headless --generate-mono-glue modules/mono/glue
