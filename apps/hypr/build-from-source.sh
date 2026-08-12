#!/usr/bin/env bash
set -euo pipefail

# NOTE: wip
# https://wiki.hypr.land/Getting-Started/Installation/#cmake-recommended

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch echo "ERROR: Use pacman on archlinux to install hyperland."
run_on_arch echo "use: pacman -S hyprland"
run_on_arch exit 1

# Building Hyprland on Fedora HOWTO #284 https://github.com/hyprwm/Hyprland/discussions/284

git clone --recursive https://github.com/hyprwm/Hyprland "$RIBYN_ROOT/apps/hyprland"
cd "$RIBYN_ROOT/apps/hyprland"

# NOTE: using cmake (recommended)

run_on_fedora sudo dnf install -y cmake
make all && sudo make install

# NOTE: using ninja
# run_on_fedora sudo dnf install -y ninja-build cmake meson gcc-c++ libxcb-devel libX11-devel pixman-devel wayland-protocols-devel cairo-devel pango-devel
# meson _build
# ninja -C _build
# sudo ninja -C _build install

# At this point, Hyprland will be installed. However, on my system at least, I needed to install the Hyprland.desktop session file somewhere that gdm could find it, because it appears gdm doesn't look in /usr/local/share/wayland-sessions:
# sudo cp /usr/local/share/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions

mkdir -p "$HOME/.config/hypr"
if [[ -f "$HOME/.config/hypr/hyprland.conf" ]]; then
	info "Not using example hyperland.conf (.config/hypr/hyperland.conf already exists)"
else
	cp example/hyprland.conf ~/.config/hypr
	info "Using example hyprland.conf"
fi

# copr is also available
# lionheartp/Hyprland https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland
