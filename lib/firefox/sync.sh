#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/firefox/env.sh"
[[ "$RIBYN_FIREFOX_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "syncing firefox"

# Enable nullglob to safely handle non-matching globs under 'set -u'
shopt -s nullglob
profiles=("$HOME/.config/mozilla/firefox"/*.ribyn)
shopt -u nullglob

if [[ ${#profiles[@]} -eq 0 ]]; then
	error "no Firefox profile directory found. make sure to run firefox ones before launching."
	exit 1
fi

for profile in "${profiles[@]}"; do
	if [[ -d "${profile}" ]]; then
		info "syncing config to $profile"
		cat \
			"$RIBYN_ROOT/lib/firefox/less-breakage-betterfox.js" \
			"$RIBYN_ROOT/lib/firefox/ribyn.js" \
			>"$profile/user.js"
	fi
done

# Windows

source "$RIBYN_ROOT/core/detect_env.sh"
detect_env

if [[ "$OS_TYPE" == "wsl" ]]; then
	source "$RIBYN_ROOT/core/detect_win_user.sh"
	detect_win_user
	# use betterfox as default, then apply my own

	info "validating firefox profiles"
	# Enable nullglob to safely handle non-matching globs under 'set -u'
	shopt -s nullglob
	win_profiles=("$WINDOWS_HOME/AppData/Roaming/Mozilla/Firefox/Profiles"/*.{ribyn,robin})

	if [[ ! ${#win_profiles[@]} -eq 2 ]]; then
		error "profile named robin and ribyn are required. make sure to run firefox once, and create a profile before launching."
		exit 1
	fi
	shopt -u nullglob

	info "syncing windows firefox profile"
	shopt -s nullglob
	ribyn_dirs=("$WINDOWS_HOME/AppData/Roaming/Mozilla/Firefox/Profiles"/*.ribyn)
	shopt -u nullglob
	ribyn_dir="${ribyn_dirs[0]}"
	if [[ -d "$ribyn_dir" ]]; then
		info "syncing windows firefox profile $ribyn_dir"
		cat \
			"$RIBYN_ROOT/lib/firefox/betterfox-154.0-user.js" \
			"$RIBYN_ROOT/lib/firefox/ribyn.js" \
			>"$ribyn_dir/user.js"
	fi

	shopt -s nullglob
	robin_dirs=("$WINDOWS_HOME/AppData/Roaming/Mozilla/Firefox/Profiles"/*.robin)
	shopt -u nullglob
	robin_dir="${robin_dirs[0]}"
	if [[ -d "$robin_dir" ]]; then
		info "syncing windows firefox profile $robin_dir"
		cat \
			"$RIBYN_ROOT/lib/firefox/betterfox-154.0-user.js" \
			"$RIBYN_ROOT/lib/firefox/ribyn.js" \
			>"$robin_dir/user.js"
	fi
fi
