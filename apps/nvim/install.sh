#!/usr/bin/env bash
set -euo pipefail

"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
"$RIBYN_ROOT/apps/nvim/sync.sh"
