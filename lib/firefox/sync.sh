#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "syncing firefox"

# Enable nullglob to safely handle non-matching globs under 'set -u'
shopt -s nullglob
profiles=("$HOME/.config/mozilla/firefox"/*.default*)
shopt -u nullglob

if [[ ${#profiles[@]} -eq 0 ]]; then
	error "no Firefox profile directory found. make sure to run firefox ones before launching."
	exit 1
fi

for profile in "${profiles[@]}"; do
	if [[ -d "${profile}" ]]; then
		info "syncing config to $profile"
		rsync -rlpt \
			"$RIBYN_ROOT/lib/firefox/config/profiledir/"* \
			"$profile"
	fi
done
