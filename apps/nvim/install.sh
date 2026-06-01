#!/usr/bin/env bash
set -euo pipefail

"$RIBYNS_ENV/apps/nvim/build-from-source.sh"
"$RIBYNS_ENV/apps/nvim/sync.sh"
