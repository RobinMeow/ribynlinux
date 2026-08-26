#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/ribyn/zsh"

rsync -rlpt \
	"$RIBYN_ROOT/apps/zsh/zshrc" \
	"$HOME/.zshrc"

rsync -rlpt \
	"$RIBYN_ROOT/apps/zsh/zshenv" \
	"$HOME/.zshenv"

rsync -rlpt \
	"$RIBYN_ROOT/apps/zsh/"{aliases,functions} \
	"$HOME/.config/ribyn/zsh/"

rsync -rlpt \
	"$RIBYN_ROOT/apps/zsh/starship.toml" \
	"$HOME/.config/starship.toml"

rsync -rlpt \
	"$RIBYN_ROOT/apps/zsh/powerlevel10k/p10k.zsh" \
	"$HOME/.config/ribyn/zsh/"

localdest="$HOME/.config/ribyn/zsh/local.sh"

if [[ -f "$HOME/.zshrc-local.sh" ]]; then
	info "legacy .zshrc-local.sh detected. automatically moved to ~/.config/ribyn/zsh/local.sh"
	mv "$HOME/.zshrc-local.sh" "$localdest"
fi

if [[ ! -f "$localdest" ]]; then
	rsync -rlpt \
		"$RIBYN_ROOT/apps/zsh/local.sh" \
		"$localdest"
fi
