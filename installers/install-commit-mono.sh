#!/usr/bin/env bash
set -euo pipefail

# https://docs.fedoraproject.org/en-US/quick-docs/fonts/#unpackaged
source "$RIBYN_ROOT/lib/run_on_distro.sh"

reinstall=false
for arg in "$@"; do
	if [[ "$arg" == "--reinstall" ]]; then
		reinstall=true
	fi
done

install_dest="$HOME/.local/share/fonts/commit-mono"

if [[ ! -d "$install_dest" ]] || [[ "$reinstall" == true ]]; then
	# coreutils contain cut and xargs
	run_on_fedora sudo dnf install -y unzip grep coreutils curl restorecon fc-cache
	run_on_arch sudo pacman -S --needed --noconfirm unzip grep coreutils curl

	# first curl gets infos of latest, next two pipes retrieve the url, las curl downloads it
	mkdir -p "$HOME/Downloads"
	font_zip="$HOME/Downloads/CommitMono.zip"
	curl https://api.github.com/repos/eigilnikolajsen/commit-mono/releases/latest |
		grep "browser_download_url" |
		cut -d '"' -f 4 |
		xargs -I downloadurl curl --fail --location --show-error --output "$font_zip" "downloadurl"

	mkdir -p "$install_dest"

	# clean previous versions of commit-mono
	rm -rf "${install_dest:?}"/*
	unzip "$font_zip" -d "$install_dest"

	rm "$font_zip"

	# NOTE:fedora uses SELinux, Arch does not
	run_on_fedora sudo restorecon -vFr "$install_dest"

	# update font cache
	fc-cache -f -v
else
	echo "CommitMono is already installed. run '$RIBYN_ROOT/installers/install-commit-mono.sh --reinstall' to reinstall"
fi
