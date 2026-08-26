#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "Syncing wiremix"

mkdir -p "$HOME/.config/wiremix/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/wiremix/config/"* \
	"$HOME/.config/wiremix/"
