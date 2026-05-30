#!/bin/bash
set -euo pipefail

# these config values are my personal perference and can
# deviate from the default values used within the scripts
#
# if you want to override values locally (per machine) use zshrc-local

# anything you can call git checkout on.
# usually 'master' branch or 'stable' tag
export RIBYN_NVIM_GIT_REF=${RIBYN_NVIM_GIT_REF:-stable}

# whether or not to fetch the latest commits before checking out the BUILD_REF
export RIBYN_NVIM_GIT_FETCH=${RIBYN_NVIM_GIT_FETCH:-false}

export RIBYN_WEZTERM_CLEAN_ON_SYNC=${RIBYN_WEZTERM_CLEAN_ON_SYNC:-false}
