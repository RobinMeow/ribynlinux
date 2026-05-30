#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config/ribyn/zsh"
cp "$RIBYNS_ENV/zsh/p10k.zsh" "$HOME/.config/ribyn/zsh/p10k.zsh"
cp "$RIBYNS_ENV/zsh/zshrc" "$HOME/.zshrc"
