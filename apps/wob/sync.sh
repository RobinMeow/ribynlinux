#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
ribyn_rsync "$RIBYN_ROOT/apps/wob/wob_volume.sh" "$HOME/.local/bin/wob_volume"
