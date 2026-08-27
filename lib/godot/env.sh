#!/usr/bin/env bash
set -euo pipefail

export RIBYN_GODOT_ENABLED="${RIBYN_GODOT_ENABLED:-"no"}"

# where to clone, compile and build the engine
export RIBYN_GODOT_ROOT="${RIBYN_GODOT_ROOT:-"$HOME/godot"}"

# Only tags are supported, do not use branches or commit hashes
export RIBYN_GODOT_GIT_TAG="${RIBYN_GODOT_GIT_TAG:-"4.7.1-stable"}" # release was 2026/07/13

# the latest major version godot supports (minor and patches do not matter usually)
# https://dotnet.microsoft.com/en-us/download/dotnet
export RIBYN_GODOT_DOTNET_VERSION="${RIBYN_GODOT_DOTNET_VERSION:-"8.0.423"}" # as of 2026/07/21

# syncing godot editr settings (I assume, that the locals ones are more up2date, so I would lose em if I overwrite them)
export RIBYN_GODOT_SYNC_ENABLED="${RIBYN_GODOT_SYNC_ENABLED:-"no"}"

# disable if compile fails with messages to open a ticket for llvm
# yes/no
export RIBYN_GODOT_USE_LLVM="${RIBYN_GODOT_USE_LLVM:-"yes"}"
