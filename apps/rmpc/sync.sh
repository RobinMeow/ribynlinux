#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/rmpc"
cp -r "$RIBYNS_ENV/apps/rmpc/config/"* "$HOME/.config/rmpc/"
