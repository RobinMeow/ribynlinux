#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.config/gtk-3.0/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/gtk/config/" \
	"$HOME/.config/gtk-3.0/"

mkdir -p "$HOME/.config/gtk-4.0/"
rsync -rlpt \
	"$RIBYN_ROOT/apps/gtk/config/" \
	"$HOME/.config/gtk-4.0/"

# Set GTK theme and color scheme via gsettings
# https://wiki.archlinux.org/title/Dark_mode_switching
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
