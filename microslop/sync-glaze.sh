#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$RIBYN_ROOT/core/detect_win_user.sh"
	detect_win_user
	mkdir -p "$WINDOWS_HOME/.glzr/glazewm"
	"$RIBYN_ROOT/microslop/glaze.yaml" "$WINDOWS_HOME/.glzr/glazewm/config.yaml"
fi
