#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/commit-mono/env.sh"

rm -rf "$RIBYN_COMMIT_MONO_INSTALL_DIR"

# rebuild font cache
fc-cache -fv
