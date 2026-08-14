#!/usr/bin/env bash
set -euo pipefail

# https://docs.brew.sh/Installation
BREW_PREFIX="/home/linuxbrew/.linuxbrew"

if [[ -d "$BREW_PREFIX" ]]; then
	echo "skipping brew installed (already installed)"
else
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# this is usually in your zshrc but on first time installs, you might use an empty bashrc probably.
	# source this file, to be able to use brew instead of the full path to the bin. e.g.
	# "/home/linuxbrew/.linuxbrew/bin/brew" install yazi
	eval "$("$BREW_PREFIX/bin/brew" shellenv)"
fi
