#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
info "installing xdg-desktop-portal-termfilechooser"

"$RIBYN_ROOT/lib/xdg-desktop-portal-termfilechooser/build-from-source.sh"
