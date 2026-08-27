#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "installing zsh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		zsh \
		starship
elif on_fedora; then
	sudo dnf install --assumeyes \
		zsh

	# startship is slightly slower.
	# but in total alot faster becuase it does not rely on instant promp
	cargobin starship
fi

"$RIBYN_ROOT/lib/zsh/oh-my-zsh/install.sh"

# Powerlevel10k
p10k_dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$p10k_dest" ]]; then
	info "Cloning powerlevel10k"
	git clone --depth 1 "https://github.com/romkatv/powerlevel10k.git" "$p10k_dest"
fi
