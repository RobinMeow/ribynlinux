#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

if [[ ${1:-""} != "--force" ]]; then
	# idempotency

	if [[ -f "$HOME/.local/share/fonts/NerdFonts/CommitMonoNerdFont-Regular.otf" ]]; then
		# font already installed
		info "CommitMono Nerd Font already installed. skipping."
		exit 0
	fi
fi

# install dependencies
source "$RIBYN_ROOT/core/run_on_distro.sh"
if on_arch; then
	sudo pacman -S --needed --noconfirm \
		curl \
		coreutils \
		sed \
		tar
	# coreutils contains: mktemp and wc
elif on_fedora; then
	sudo dnf install \
		curl \
		coreutils \
		sed \
		tar
	# coreutils contains: mktemp and wc
fi

CACHE_DIR="$HOME/.cache/ribyn/nerd-fonts"
mkdir -p "$CACHE_DIR"

install="$CACHE_DIR/install.sh"
curl -s "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh" -o "$install"
chmod u+x "$install"
"$install" install CommitMono

# "$install" install JetBrainsMono
# use "JetBrainsMonoNL Nerd Font Mono" to disable ligiatures
# "$install" install FiraCode
# "$install" install FiraMono
# "$install" install GoogleSansCode

# NOTE: Examples from the gh
# "$install" list
# "$install" install <FontName>
# "$install" install Hack
# "$install" install HeavyData
# "$install" install all
# "$install" install # interactive mode
# VERBOSE=3 "$install" install DaddyTimeMono
# GH_RELEASE_TAG=v3.2.1 "$install" list
