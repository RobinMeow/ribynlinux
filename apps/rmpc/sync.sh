#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYN_ROOT/apps/rmpc/config/"* "$HOME/.config/rmpc/"
