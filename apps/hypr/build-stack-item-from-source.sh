#!/usr/bin/env bash
set -euo pipefail

name=$1
giturl=$2
gitref=$3

mkdir -p "$HOME/.local/state/ribyn/"
logfile="$HOME/.local/state/ribyn/$name-build-from-source.log"
# Append to file and print to terminal simultaneously
# use --append flag if you want to append, instead of override
exec > >(tee "$logfile") 2>&1

. "$RIBYN_ROOT/lib/utils.sh"

mkdir -p "$HOME/.local/share/ribyn/"
(
	dest="$HOME/.local/share/ribyn/$name"
	if [[ -d "$dest" ]]; then
		warn "$name repo detected. removing for clean for rebuild."
		rm -rf "$dest"
	fi

	git clone "$giturl" "$dest"
	cd "$dest"
	git checkout "$gitref"
	# WARN: installs into /usr
	# so avoid using the package manager to install these
	# can cause conflicts.
	# will prevent juggling systemd/env vars
	# to excpose the /usr/local paths etc..
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

	# NOTE: consider -1 core, to prevent segementation fails ? if it happens again
	cmake --build ./build --config Release --target all -j"$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
	sudo cmake --install build
)
