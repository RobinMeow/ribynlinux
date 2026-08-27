#!/usr/bin/env bash
set -euo pipefail

# whether or not to install the KDE desktop environment
# and sync default config (e.g. disabled kwallet)
export RIBYN_INSTALL_KDE_ENABLED=${RIBYN_INSTALL_KDE_ENABLED:-"no"}
export RIBYN_SYNC_KDE_ENABLED=${RIBYN_SYNC_KDE_ENABLED:-"no"}
