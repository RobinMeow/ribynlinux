#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"

RIBYN_GODOT_ROOT="${RIBYN_GODOT_ROOT:-"$HOME/godot"}"
RIBYN_GODOT_GIT_TAG="${RIBYN_GODOT_GIT_TAG:-"4.7.1-stable"}"

if [[ -d "$RIBYN_GODOT_ROOT" ]]; then
	(
		cd "$RIBYN_GODOT_ROOT"

		# NOTE: If the git repo is on a local branch, a detached commit, or anything that isn't a direct exact tag match, git describe --exact-match --tag exits with a non-zero status (failure)
		git_tag=$(git describe --exact-match --tag)

		if [[ "$git_tag" == "$RIBYN_GODOT_GIT_TAG" ]]; then
			info "Godot is already at $RIBYN_GODOT_GIT_TAG in $RIBYN_GODOT_ROOT (Skipping clone)"
			exit 0
		else
			warn "[Godot] git is currently on $git_tag"
			# read -p "wish to fetch and checkout $RIBYN_GODOT_GIT_TAG? [y/N] " -r
			# echo # Move to a new line after the user presses Enter

			if confirm "wish to fetch and checkout $RIBYN_GODOT_GIT_TAG?"; then
				git fetch origin "refs/tags/$RIBYN_GODOT_GIT_TAG:refs/tags/$RIBYN_GODOT_GIT_TAG"
				git checkout "$RIBYN_GODOT_GIT_TAG"
				exit 0
			else
				# the wording "changing" is more accurate than "update", becuase it can be used to downgrade
				info "[Godot] skip change to $RIBYN_GODOT_GIT_TAG"
				exit 2
			fi
		fi
	)
else
	info "[Godot] cloning godotengine/godot"
	git clone --depth 1 --branch "$RIBYN_GODOT_GIT_TAG" git@github.com:godotengine/godot.git "$RIBYN_GODOT_ROOT"
	exit 0
fi
