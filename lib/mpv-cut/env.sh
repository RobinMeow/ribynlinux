#!/usr/bin/env bash
set -euo pipefail

export RIBYN_MPVCUT_ENABLED=${RIBYN_MPVCUT_ENABLED:-"no"}
export RIBYN_MPVCUT_GITREV=${RIBYN_MPVCUT_GITREV:-"origin/release"}
