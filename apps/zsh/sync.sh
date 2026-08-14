#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/ribyn/zsh"

ribyn_rsync \
	"$RIBYN_ROOT/apps/zsh/powerlevel10k/p10k.zsh" \
	"$HOME/.config/ribyn/zsh/"

ribyn_rsync \
	"$RIBYN_ROOT/apps/zsh/zshrc" \
	"$HOME/.zshrc"

localdest="$HOME/.config/ribyn/zsh/local.sh"

if [[ -f "$HOME/.zshrc-local.sh" ]]; then
	info "legacy .zshrc-local.sh detected. automatically moved to ~/.config/ribyn/zsh/local.sh"
	mv "$HOME/.zshrc-local.sh" "$localdest"
fi

if [[ ! -f "$localdest" ]]; then
	cp "$RIBYN_ROOT/apps/zsh/local.sh" "$localdest"
fi
