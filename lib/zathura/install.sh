#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing zathura"

if on_arch; then
	sudo pacman -S --needed --noconfirm \
		zathura \
		zathura-pdf-mupdf \
		tesseract-data-eng
elif on_fedora; then
	sudo dnf install -y \
		zathura \
		zathura-pdf-mupdf \
		tesseract-langpack-eng
else
	error "distro not supported"
	exit 1
fi
