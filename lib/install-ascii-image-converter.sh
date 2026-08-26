#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/ensure-installed-homebrew.sh"
brew install --no-ask \
	TheZoraiz/ascii-image-converter/ascii-image-converter
