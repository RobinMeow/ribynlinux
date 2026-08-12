#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	tree-sitter-cli \
	npm
# treesitter plugin depends on tree-sitter-cli
# mason depends on npm

run_on_fedora sudo dnf install -y \
	tree-sitter-cli \
	npm

"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
"$RIBYN_ROOT/apps/nvim/sync.sh"
