#!/usr/bin/env bash
set -euo pipefail

# Troubleshooting help:
# open mason error log file in neovim :MasonLog
# or `~/.local/state/nvim/mason.log`
#
# It will include infos like "could not find npm to install typescript language server"

source "$RIBYN_ROOT/lib/nvim/env.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing nvim"

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
		npm \
		dotnet-sdk \
		quickshell

	sudo pacman -S --needed --noconfirm \
		qt6-base \
		qt6-declarative

	if [[ "$RIBYN_NVIM_BUILD_FROM_SOURCE" == "yes" ]]; then
		"$RIBYN_ROOT/lib/nvim/build-from-source.sh"
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
		npm \
		"dotnet-sdk-10.0" \
		quickshell

	# qt qml and c++ development. the essentials
	sudo dnf install --assumeyes \
		qt6-qtbase-devel \
		qt6-qtdeclarative-devel
	# sudo dnf in -y "qt6-*-devel" to pull in everything,
	# but its bloated with stuff I won't ever need.
	# Like a chromiu browser engine.

	if [[ "$RIBYN_NVIM_BUILD_FROM_SOURCE" == "yes" ]]; then
		"$RIBYN_ROOT/lib/nvim/build-from-source.sh"
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
