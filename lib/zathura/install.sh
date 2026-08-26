#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/core/run_on_distro.sh"
source "$RIBYN_ROOT/core/utils.sh"
info "installing zathura"

run_on_arch sudo pacman -S --needed --noconfirm \
	zathura \
	zathura-pdf-mupdf \
	tesseract-data-eng

run_on_fedora sudo dnf install -y \
	zathura \
	zathura-pdf-mupdf \
	tesseract-langpack-eng
