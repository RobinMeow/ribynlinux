#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.cargo/"
ribyn_rsync \
	"$RIBYN_ROOT/apps/cargo-bins/config/binstall.toml" \
	"$HOME/.cargo/binstall.toml"
