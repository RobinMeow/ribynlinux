#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYNS_ENV/rmpc/config/"* "$HOME/.config/rmpc/"
