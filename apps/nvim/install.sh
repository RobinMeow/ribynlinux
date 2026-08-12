#!/usr/bin/env bash
set -euo pipefail

# Troubleshooting help:
# open mason error log file in neovim :MasonLog
# or `~/.local/state/nvim/mason.log`
#
# It will include infos like "could not find npm to install typescript language server"

. "$RIBYN_ROOT/lib/run_on_distro.sh"
. "$RIBYN_ROOT/lib/utils.sh"

syntax_highlighted_dotnet_exports() {
	KW="\033[35m"  # Magenta for the keyword (export)
	VAR="\033[36m" # Cyan for the variable names
	STR="\033[33m" # Yellow for the string values
	NC="\033[0m"   # Reset
	printf "${KW}export${NC} ${VAR}PATH${NC}=${STR}\"\$HOME/.dotnet:\$HOME/.dotnet/tools:\$PATH\"${NC}\n"
	printf "${KW}export${NC} ${VAR}DOTNET_ROOT${NC}=${STR}\"\$HOME/.dotnet\"${NC}\n"
	printf "${KW}export${NC} ${VAR}DOTNET_ROOT_X64${NC}=${STR}\"\$HOME/.dotnet\"${NC}\n"
}

# slop slop sloppyty slop slap
if command -v dotnet >/dev/null 2>&1; then
	info "[nvim] dotnet already in PATH."
else
	if command -v "$HOME/.dotnet/dotnet" >/dev/null 2>&1; then
		warn "[nvim] dotnet already installed but not in PATH. run these or make sure to include them in your zshrc/bashrc:"
		info '[nvim] prepend to have wsl dotnet installs take preceedence over slop, or vice versa.'
		syntax_highlighted_dotnet_exports
		warn '[nvim] dotnet is optional, csharpier will not work. You can do the above steps at any time later and use nvim without csharpier.'
		press_any_to_continue
	else
		info "[nvim] installing dotnet latest"
		"$RIBYN_ROOT/installers/dotnet-install.sh" --version latest
		warn "[nvim] run these or make sure to include them in your zshrc/bashrc:"
		info '[nvim] prepend to have wsl dotnet installs take preceedence over slop, or vice versa.'
		syntax_highlighted_dotnet_exports
		warn '[nvim] dotnet is optional, csharpier will not work. You can do the above steps at any time later and use nvim without csharpier.'
		press_any_to_continue
	fi
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
#
# run_on_arch sudo pacman -S --needed --noconfirm \
# 	php composer jdk-openjdk julia
#
# run_on_fedora sudo dnf install -y \
# 	php composer java-devel julia

"$RIBYN_ROOT/apps/nvim/build-from-source.sh"
"$RIBYN_ROOT/apps/nvim/sync.sh"
