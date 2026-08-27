#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/zsh/env.sh"
[[ "$RIBYN_P10K_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
info "installing powerlevel10k"

# Powerlevel10k
p10k_dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$p10k_dest" ]]; then
	info "cloning powerlevel10k"
	git clone --depth 1 "https://github.com/romkatv/powerlevel10k.git" "$p10k_dest"
fi
