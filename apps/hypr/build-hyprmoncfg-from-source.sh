#!/usr/bin/env bash
set -euo pipefail

# https://github.com/crmne/hyprmoncfg/commits/main/

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	run_on_arch sudo pacman -S --needed --noconfirm \
		go
elif on_fedora; then
	run_on_fedora sudo dnf install -y \
		go

	mkdir -p "$HOME/.local/share/ribyn/"
	dest="$HOME/.local/share/ribyn/hyprmoncfg"
	if [[ -d "$dest" ]]; then
		info "hyprmoncfg is already installed. Skipping."
	else
		(
			mkdir -p "$HOME/.local/bin/"
			git clone --depth 1 "https://github.com/crmne/hyprmoncfg.git" "$dest"
			git checkout $RIBYN_HYPR_HYPRMONCFG_GIT_REF
			cd "$dest"
			go build -o "bin/hyprmoncfg" "./cmd/hyprmoncfg"
			go build -o "bin/hyprmoncfgd" "./cmd/hyprmoncfgd"
			install -Dm755 "bin/hyprmoncfg" "$HOME/.local/bin/hyprmoncfg"
			install -Dm755 "bin/hyprmoncfgd" "$HOME/.local/bin/hyprmoncfgd"
		)
	fi
fi
