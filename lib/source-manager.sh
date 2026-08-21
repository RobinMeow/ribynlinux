#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/share/ribyn/"
SOURCE="$HOME/.local/share/ribyn/"

# WARN: source-manager.sh expect the SOURCE_NAME to be equal to the SOURCE_DEST
# I think it would still work when not. but would be more clean
# also expects the name to match the pkg-config value if used.

# TODO: allow "latest tag", "latest commit" etc. for config.sh

function check_source_state() {
	export SOURCE_NAME=$1
	export SOURCE_GITREV=$2
	export SOURCE_DEST="$SOURCE/$SOURCE_NAME"

	# quick and dirty, fetch everything, so we dont have to bother with origin/checks
	git -C "$SOURCE_DEST" fetch --all --tags --prune --jobs=10

	if [[ -d "$SOURCE_DEST" ]]; then
		requested_commit=$(git -C "$SOURCE_DEST" rev-parse "$SOURCE_GITREV^{commit}")
		HEAD=$(git -C "$SOURCE_DEST" rev-parse "HEAD^{commit}")
		if [[ "$requested_commit" == "$HEAD" ]]; then
			export SOURCE_STATE="gitrev equals"
		else
			export SOURCE_STATE="gitrev differs"
		fi
	else
		export SOURCE_STATE="source n/a"
	fi
}

function clean_source() {
	# NOTE: has to be called after check_source_state
	# in order for SOURCE_DEST to be set

	# -d recurse into directories
	# -x remove all untracked files (ignoring gitignore rules)

	(
		cd "$SOURCE_DEST"
		# moving staged modifcations to unstaged
		git reset .
		git submodule foreach --recursive git reset .

		# removing unstaged modification
		git checkout .
		git submodule foreach --recursive git checkout .

		# removing build and other cache files
		git clean -fdx
		git submodule foreach --recursive git clean -fdx
	)
}

function init_source() {
	giturl=$1

	if [[ "${SOURCE_STATE:-"unset"}" == "unset" ]]; then
		. "$RIBYN_ROOT/lib/utils.sh"
		error "incorrect use of init_source. call check_source_state before initilasing."
		exit 1
	fi

	if [[ "$SOURCE_STATE" != "source n/a" ]]; then
		. "$RIBYN_ROOT/lib/utils.sh"
		error "source already exists. cannot initialize."
		exit 1
	fi

	git clone "$giturl" "$SOURCE_DEST"
	(
		cd "$SOURCE_DEST"
		git checkout --detach "$SOURCE_GITREV"
		git submodule update --init --recursive
	)
}

function update_source() {
	if [[ "${SOURCE_STATE:-"unset"}" == "unset" ]]; then
		. "$RIBYN_ROOT/lib/utils.sh"
		error "incorrect use of update_source. call check_source_state before updating."
		exit 1
	fi

	if [[ "$SOURCE_STATE" == "source n/a" ]]; then
		. "$RIBYN_ROOT/lib/utils.sh"
		error "source does not exist. cannot update."
		exit 1
	elif [[ "$SOURCE_STATE" == "gitrev equals" ]]; then
		. "$RIBYN_ROOT/lib/utils.sh"
		error "source is already at requested gitrev. no reason to update."
		exit 1
	fi

	(
		cd "$SOURCE_DEST"
		git checkout --detach "$SOURCE_GITREV"
		git submodule update --init --recursive
	)
}

function source_pkg_config_exists() {
	pkg-config --exists "$SOURCE_NAME"
}
