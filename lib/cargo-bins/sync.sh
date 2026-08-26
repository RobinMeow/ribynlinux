#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

mkdir -p "$HOME/.cargo/"
rsync -rlpt \
	"$RIBYN_ROOT/lib/cargo-bins/config/binstall.toml" \
	"$HOME/.cargo/binstall.toml"
