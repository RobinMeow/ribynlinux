#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/utils.sh"

info "Syncing zsh"

mkdir -p "$HOME/.config/ribyn/zsh"

rsync -rlpt \
	"$RIBYN_ROOT/lib/zsh/zshrc" \
	"$HOME/.zshrc"

rsync -rlpt \
	"$RIBYN_ROOT/lib/zsh/zshenv" \
	"$HOME/.zshenv"

rsync -rlpt \
	"$RIBYN_ROOT/lib/zsh/"{aliases,functions,gitrc} \
	"$HOME/.config/ribyn/zsh/"

rsync -rlpt \
	"$RIBYN_ROOT/lib/zsh/starship.toml" \
	"$HOME/.config/starship.toml"

rsync -rlpt \
	"$RIBYN_ROOT/lib/zsh/powerlevel10k/p10k.zsh" \
	"$HOME/.config/ribyn/zsh/"

localdest="$HOME/.config/ribyn/zsh/local.sh"

if [[ -f "$HOME/.zshrc-local.sh" ]]; then
	info "legacy .zshrc-local.sh detected. automatically moved to ~/.config/ribyn/zsh/local.sh"
	mv "$HOME/.zshrc-local.sh" "$localdest"
fi

if [[ ! -f "$localdest" ]]; then
	rsync -rlpt \
		"$RIBYN_ROOT/lib/zsh/local.sh" \
		"$localdest"
fi
