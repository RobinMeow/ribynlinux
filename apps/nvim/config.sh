#!/usr/bin/env bash
set -euo pipefail

# builds neovim from source instead of using the package manager to install
# the binaries. binaries are recoomended. Use build from source
# if you want to use Release build type, which aggressivly pushes for
# performance. Builds are not guaranteed to work, and often requires a re-run.
export RIBYN_NVIM_BUILD_FROM_SOURCE=${RIBYN_NVIM_BUILD_FROM_SOURCE:-"no"}

# requires RIBYN_NVIM_BUILD_FROM_SOURCE to be set to "yes"
# 'master' for latest development state
# 'stable' for latest stable release
export RIBYN_NVIM_GITREV=${RIBYN_NVIM_GIT_REF:-"stable"}

# requires RIBYN_NVIM_BUILD_FROM_SOURCE to be set to "yes"
# neovim build: https://github.com/neovim/neovim/blob/master/BUILD.md
# sorted by slowest runtime to fastest, and fastest build time to slowest (runtime optimizations take longer)
# Debug: Full debug information; few optimizations. Use this for development to get meaningful output from debuggers like GDB or LLDB. This is the default if CMAKE_BUILD_TYPE is not specified.
# RelWithDebverbose: <release with debug verbose> didnt see a description in the github
# RelWithDebInfo: meaning "Release With Debug Info" Enables many optimizations and adds enough debug info so that when Neovim ever crashes, you can still get a backtrace.
# Release: Full compiler optimizations and no debug information. Expect the best performance from this build type. Often used by package maintainers.
export RIBYN_NVIM_BUILD_TYPE=${RIBYN_NVIM_BUILD_TYPE:-"Release"}
