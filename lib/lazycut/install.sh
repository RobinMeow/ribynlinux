#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/lazycut/env.sh"
[[ "$RIBYN_LAZYCUT_ENABLED" == "no" ]] && exit 0

source "$RIBYN_ROOT/core/utils.sh"
source "$RIBYN_ROOT/core/run_on_distro.sh"
info "installing lazycut"

if on_arch; then
	# pipewire-jack, to prevent choosing between
	# jack2 and pipewire-jack if not already installed
	sudo pacman -S --needed --noconfirm \
		go \
		pipewire-jack \
		ffmpeg \
		chafa

	go install "github.com/ozemin/lazycut@latest"
elif on_fedora; then
	sudo dnf install --assumeyes \
		golang \
		ffmpeg \
		chafa \
		chafa-devel

	go install "github.com/ozemin/lazycut@latest"

	# if the normal install fails, I can try to use this env
	# apparently this env will allow go to auto update for this
	# install if it needs to. Newer versions are backwards compatible
	# GOTOOLCHAIN=auto go install "github.com/ozemin/lazycut@latest"
fi
