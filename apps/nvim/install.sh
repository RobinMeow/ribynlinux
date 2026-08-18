#!/usr/bin/env bash
set -euo pipefail

# Troubleshooting help:
# open mason error log file in neovim :MasonLog
# or `~/.local/state/nvim/mason.log`
#
# It will include infos like "could not find npm to install typescript language server"

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

# treesitter depends on (since 0.12 nvim depends on it itself now)
# - tree-sitter-cli

# mason depends on :
# - npm
# - go
# - dotnet (just for csharpier install)
# - cargo
# - wget

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		php composer jdk-openjdk julia \
		tree-sitter-cli \
		go \
		cargo \
		wget \
		npm

	if [[ "$RIBYN_NVIM_BUILD_FROM_SOURCE" == "yes" ]]; then
		"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
	else
		sudo pacman -S --needed --noconfirm \
			neovim
	fi
elif on_fedora; then
	sudo dnf install --assumeyes \
		tree-sitter-cli \
		golang \
		cargo \
		wget2-wget \
		npm

	if [[ "$RIBYN_NVIM_BUILD_FROM_SOURCE" == "yes" ]]; then
		"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
	else
		sudo dnf install --assumeyes \
			neovim
	fi
fi

# INFO: if the checkhealth warnings bother you,
# you can include these to fix some of them
#
# run_on_arch sudo pacman -S --needed --noconfirm \
# 	php composer jdk-openjdk julia
#
# run_on_fedora sudo dnf install -y \
# 	php composer java-devel julia
