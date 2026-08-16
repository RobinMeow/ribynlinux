#!/usr/bin/env bash
set -euo pipefail

# https://github.com/crmne/hyprmoncfg/commits/main/

. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		go
elif on_fedora; then
	sudo dnf install -y \
		go
else
	error "distro not supported"
	exit 1
fi

if [[ -x "$HOME/.local/bin/hyprmoncfg" && -x "$HOME/.local/bin/hyprmoncfgd" ]]; then
	info "hyprmoncfg and hyprmoncfgd are already installed. Skipping."
	exit 0
fi

dest="$HOME/.local/share/ribyn/hyprmoncfg"

if [[ -d "$dest" ]]; then
	warn "existing git repo detected. cleaning for clean re-build."
	rm -rf "$dest"
fi

mkdir -p "$HOME/.local/share/ribyn/"
git clone "https://github.com/crmne/hyprmoncfg.git" "$dest"

mkdir -p "$HOME/.local/bin/"
(
	cd "$dest"
	git checkout --detach "$RIBYN_HYPR_HYPRMONCFG_GIT_REF"
	go build -o "bin/hyprmoncfg" "./cmd/hyprmoncfg"
	go build -o "bin/hyprmoncfgd" "./cmd/hyprmoncfgd"
	install -Dm755 "bin/hyprmoncfg" "$HOME/.local/bin/hyprmoncfg"
	install -Dm755 "bin/hyprmoncfgd" "$HOME/.local/bin/hyprmoncfgd"
)
