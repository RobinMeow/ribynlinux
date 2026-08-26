#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/config.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "Installing zsh"

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

# Spaceship
# WARN: spaceship is alot slower than p10k
# mkdir -p "$HOME/.local/share/ribyn/"
# spaceship_dest="$HOME/.local/share/ribyn/spaceship"
# if [[ -d "$spaceship_dest" ]]; then
# 	info "Spaceship already installed. skipping."
# else
# 	mkdir -p "$HOME/.config/ribyn/zsh/"
# 	# cant use --depth when using tags.
# 	# or at least its more work to get it to work
# 	git clone \
# 		"https://github.com/spaceship-prompt/spaceship-prompt.git" \
# 		"$spaceship_dest"
#
# 	(
# 		cd "$spaceship_dest"
# 		git checkout --detach "$RIBYN_SPACESHIP_GITREV"
# 	)
# fi
