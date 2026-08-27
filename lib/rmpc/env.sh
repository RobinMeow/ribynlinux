#!/usr/bin/env bash
set -euo pipefail

export RIBYN_RMPC_ENABLED=${RIBYN_RMPC_ENABLED:-"yes"}

# Fedora only. arch uses pacman
# possible values:
# "install" will use cargo to build from source
# "binstall" will install the binaries only
# binstall is recommended to avoid segmentation errors
# or to reduce total disc size. use build from source for slow internet
# (unless your cpu is also slow, then it doesnt not matter)
export RIBYN_RMPC_INSTALL_METHOD=${RIBYN_RMPC_INSTALL_METHOD:-"binstall"}
