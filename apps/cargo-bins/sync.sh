#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.cargo/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/cargo-bins/config/binstall.toml" \
	"$HOME/.cargo/binstall.toml"
