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
"$RIBYN_ROOT/lib/zsh/install-p10k.sh"
