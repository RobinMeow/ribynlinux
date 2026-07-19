#!/usr/bin/env bash
set -euo pipefail

source "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm zathura zathura-pdf-mupdf tesseract-data-eng

run_on_fedora sudo dnf install -y zathura zathura-pdf-mupdf tesseract-langpack-eng

"$RIBYN_ROOT/apps/zathura/sync.sh"
