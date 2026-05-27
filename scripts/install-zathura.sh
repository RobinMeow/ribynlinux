#!/usr/bin/env bash
set -euo pipefail

source "$RIBYNS_ENV/scripts/utils.sh"
source "$RIBYNS_ENV/scripts/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm zathura zathura-pdf-mupdf tesseract-data-eng

run_on_fedora sudo dnf install -y zathura zathura-pdf-mupdf tesseract-langpack-eng

mkdir -p "$HOME/.config/zathura"
cp -r "$RIBYNS_ENV/config/zathura/"* "$HOME/.config/zathura/"
