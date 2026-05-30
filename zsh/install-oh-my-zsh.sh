#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/lib/utils.sh"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	info "Installing Oh My Zsh"
	# Prevent auto-launching zsh after install
	# Respects the following environment variables:
	#   ZDOTDIR - path to Zsh dotfiles directory (default: unset). See [1][2]
	#             [1] https://zsh.sourceforge.io/Doc/Release/Parameters.html#index-ZDOTDIR
	#             [2] https://zsh.sourceforge.io/Doc/Release/Files.html#index-ZDOTDIR_002c-use-of
	#   ZSH     - path to the Oh My Zsh repository folder (default: $HOME/.oh-my-zsh)
	#   REPO    - name of the GitHub repo to install from (default: ohmyzsh/ohmyzsh)
	#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
	#   BRANCH  - branch to check out immediately after install (default: master)
	#
	# Other options:
	#   CHSH                   - 'no' means the installer will not change the default shell (default: yes)
	#   RUNZSH                 - 'no' means the installer will not run zsh after the install (default: yes)
	#   KEEP_ZSHRC             - 'yes' means the installer will not replace an existing .zshrc (default: no)
	#   OVERWRITE_CONFIRMATION - 'no' means the installer will not ask for confirmation to overwrite the existing .zshrc (default: yes)
	CHSH=no RUNZSH=no KEEP_ZSHRC=yes OVERWRITE_CONFIRMATION=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	success "Oh My Zsh installed"
else
	verbose "skipped Oh My Zsh install (already installed)"
fi

# Default ZSH_CUSTOM if not set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
zsh_custom_plugin_dir="$ZSH_CUSTOM/plugins"
mkdir -p $zsh_custom_plugin_dir

# ["<destination-dir>"]="<git url>"
declare -A plugins=(
	["zsh-vi-mode"]="https://github.com/jeffreytse/zsh-vi-mode"
	["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
	["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
	["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
)

for plugin in "${!plugins[@]}"; do
	url="${plugins[$plugin]}"
	dest="$zsh_custom_plugin_dir/$plugin"

	if [[ ! -d "$dest" ]]; then
		info "Cloning $plugin from $url"
		git clone --depth 1 "$url" "$dest"
	fi
done

p10k_dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$p10k_dest" ]]; then
	info "Cloning powerlevel10k from $url"
	git clone --depth 1 "https://github.com/romkatv/powerlevel10k.git" "$p10k_dest"
fi
