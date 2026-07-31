#!/usr/bin/env bash
set -euo pipefail

"$RIBYN_ROOT/lib/ensure_installed_homebrew.sh"

# WARN: brew is not available in PATH on first time install
"/home/linuxbrew/.linuxbrew/bin/brew" install --no-ask TheZoraiz/ascii-image-converter/ascii-image-converter
