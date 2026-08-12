#!/usr/bin/env bash
set -euo pipefail

# Troubleshooting help:
# where is mason error log :MasonLog
# or `~/.local/state/nvim/mason.log`
#
# It will include infos like "could not find npm to install typescript language server"

. "$RIBYN_ROOT/lib/run_on_distro.sh"

if command -v dotnet >/dev/null 2>&1; then
	echo "[nvim] dotnet already in path."
else
	"$RIBYN_ROOT/installers/dotnet-install.sh" --version latest
fi

# treesitter depends on:
# - tree-sitter-cli
#
# mason depends on :
# - npm
# - go
# - dotnet
# - cargo
# - wget

run_on_arch sudo pacman -S --needed --noconfirm \
	php composer jdk-openjdk julia \
	tree-sitter-cli \
	go \
	cargo \
	wget \
	npm

run_on_fedora sudo dnf install -y \
	tree-sitter-cli \
	golang \
	cargo \
	wget2-wget \
	npm

# INFO: if the checkhealth warnings bother you,
# you can include these to fix some of them
# php composer jdk-openjdk julia
# run_on_arch sudo pacman -S --needed --noconfirm \
# 	php composer jdk-openjdk julia
#
# run_on_fedora sudo dnf install -y \
# 	php composer java-devel julia

"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
"$RIBYN_ROOT/apps/nvim/sync.sh"
