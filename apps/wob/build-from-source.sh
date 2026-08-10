#!/usr/bin/env bash
set -euo pipefail

. "$RIBYN_ROOT/lib/utils.sh"
. "$RIBYN_ROOT/config.sh"
. "$RIBYN_ROOT/lib/run_on_distro.sh"

run_on_arch sudo pacman -S --needed --noconfirm \
	meson \
	ninja \
	libinih \
	wayland \
	extra/wayland-protocols
# depends on wayland-protocols

run_on_fedora sudo dnf install -y \
	meson \
	ninja \
	inih-devel \
	wayland-devel \
	wayland-protocols-devel

dest="$HOME/.local/share/ribyn"
mkdir -p "$dest"

function build() {
	rm -rf "$dest/wob/build"
	meson setup build
	ninja -C build
	sudo ninja -C build install
}

(
	if [[ -d "$dest/wob" ]]; then
		if [[ "$RIBYN_WOB_AUTO_UPDATE" == "yes" ]]; then
			cd "$dest/wob"
			branch="$(git branch --show-current)"
			git fetch --depth 1 origin "$branch"
			commit_hash_before_checkout=$(git rev-parse HEAD)
			git reset --hard "origin/$branch"
			if [[ $commit_hash_before_checkout != $(git rev-parse HEAD) ]]; then
				build
			else
				verbose "Commit unchanged. No auto update needed."
			fi
		else
			warn "Skipping wob auto update."
		fi
	else
		git clone --depth 1 "https://github.com/francma/wob.git" "$dest/wob"
		cd "$dest/wob"
		build
	fi
)
