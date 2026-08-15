#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

# https://docs.brew.sh/Installation
BREW_PREFIX="/home/linuxbrew/.linuxbrew"

if [[ -d "$BREW_PREFIX" ]]; then
	echo "skipping brew installed (already installed)"

	if ! command -v brew >/dev/null 2>&1; then
		# first time install / rerunning the script can happen here
		eval "$("$BREW_PREFIX/bin/brew" shellenv)"
	fi
else
	warn "hypocrites request sudo permission just to remove it again after calling their bin, just so their own script can remain \"secure\"."
	sudo --validate

	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# this is usually in your zshrc but on first time installs, you might use an empty bashrc probably.
	# source this file, to be able to use brew instead of the full path to the bin. e.g.
	# "/home/linuxbrew/.linuxbrew/bin/brew" install yazi
	eval "$("$BREW_PREFIX/bin/brew" shellenv)"
fi
