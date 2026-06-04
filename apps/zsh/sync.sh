#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/ribyn/zsh"
cp "$RIBYNS_ENV/apps/zsh/p10k.zsh" "$HOME/.config/ribyn/zsh/"
cp "$RIBYNS_ENV/apps/zsh/zshrc" "$HOME/.zshrc"

localdest="$HOME/.config/ribyn/zsh/local.sh"

if [[ -f "$HOME/.zshrc-local.sh" ]]; then
	echo "legacy .zshrc-local.sh detected. automatically moved to ~/.config/ribyn/zsh/local.sh"
	mv "$HOME/.zshrc-local.sh" "$localdest"
fi

if [[ ! -f "$localdest" ]]; then
	cp "$RIBYNS_ENV/apps/zsh/local.sh" "$localdest"
fi
