#!/usr/bin/env bash
set -euo pipefail

# https://github.com/hyprwm/hyprpicker

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch echo "use pacman -S hyprpicker instead." && exit 1

run_on_fedora sudo dnf install -y \
	cmake \
	pkgconf-pkg-config \
	pango \
	cairo \
	wayland-devel \
	wayland-protocols-devel \
	hyprutils \
	libxkbcommon-devel

mkdir -p "$HOME/.local/share/ribyn/"
dest="$HOME/.local/share/ribyn/hyprpicker"
if [[ -d "$dest" ]]; then
	info "hyprpicker is already installed. Skipping."
else
	(
		git clone --depth 1 "https://github.com/hyprwm/hyprpicker" "$dest"
		cd "$dest"

		# build
		cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
		cmake --build ./build --config Release --target hyprpicker -j"$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"

		# install
		sudo cmake --install ./build
	)
fi
