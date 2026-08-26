#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/qt6ct/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/qt6ct/config/" \
	"$HOME/.config/qt6ct/"
