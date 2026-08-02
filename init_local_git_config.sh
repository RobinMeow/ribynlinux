#!/usr/bin/env bash
set -euo pipefail

# TODO: prompt confirm with the info this scripts only works when cloned by gh
# or let select 1/2 for gh or cb initial clone

(
	cd "$RIBYN_ROOT"
	git remote rename origin gh
	git remote add cb ssh://git@codeberg.org/Ribyn/ribynlinux.git
	git config remotes.all "gh cb"
)
