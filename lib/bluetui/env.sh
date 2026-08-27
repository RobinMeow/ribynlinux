#!/usr/bin/env bash
set -euo pipefail

export RIBYN_BLUETUI_ENABLED=${RIBYN_BLUETUI_ENABLED:-"yes"}

# no longer in use in favor of cargo-binstall
# export RIBYN_BLUETUI_GITREV=${RIBYN_BLUETUI_GITREV:-"v0.8.1"}
