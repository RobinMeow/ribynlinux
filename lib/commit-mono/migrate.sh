#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/commit-mono/env.sh"
if [[ -d "$RIBYN_COMMIT_MONO_INSTALL_DIR" ]]; then
	warn "Migration: from CommitMono (unpatched) to CommitMono Nerd Font"
	"$RIBYN_ROOT/lib/uninstall-commit-mono.sh"
fi
